#!/bin/bash -xe

COMMAND=whiteblock
WAIT_TIME=3m

NODES=10
VAL_DIV=2

# number of validators
VAL=5

# number of accounts to create
ACCOUNTS=1000

BPS=10
RTS=10
BANDWIDTH=1000
DELAY=0
LIMIT=1000
LOSS=0
TPS=50
START_OFFSET=30
END_OFFSET=80
BN_RANGE=100
START_TPS=180
END_TPS=250
TPS_DELTA=20

deploy() {
    $COMMAND -b pantheon -i hyperledger/besu:1.3.6-SNAPSHOT build -n $NODES -o "gasLimit=0x1fffffffffffff" -o "initBalance=1000000000000000000000000" -o "consensus=ibft" -o "blockPeriodSeconds=$BPS" -o "accounts=$ACCOUNTS" -o "orion=false" -o "requesttimeoutseconds=$RTS" -v $VAL
}

run_experiment() {

    exp_dir="exp_${NODES}_${VAL}_${ACCOUNTS}_${BPS}_${RTS}_${BANDWIDTH}_${DELAY}_${LIMIT}_${LOSS}_${TPS}"
    echo "$exp_dir"
    mkdir "$exp_dir"
    cd "$exp_dir"
    deploy

    for tps in $(seq $START_TPS $TPS_DELTA $END_TPS); do
        TPS=$tps

        start_bn=$(wb get block number)

        $COMMAND netconfig all -d $DELAY -b $BANDWIDTH -m $LIMIT -l $LOSS
        $COMMAND tx start stream --tps $TPS -v 1

        sleep 1m
        bn=$(wb get block number)
        echo "start block number = $start_bn, tps=$TPS"
        while [ $(($bn-$start_bn)) -lt $BN_RANGE ]
        do
            #echo "run = $(($bn-$start_bn))"
            bn=$(wb get block number)
        done
        sleep 1m
        echo "current block number = $(wb get block number)"
        date >>log.txt
        echo "tps=$TPS" >>log.txt
        echo "stats collection: $(($start_bn+$START_OFFSET)) $(($start_bn+$END_OFFSET))"
        wb get stats block "$(($start_bn+$START_OFFSET))" "$(($start_bn+$END_OFFSET))" >>log.json

        wb tx stop
        wb netconfig clear
    done

    wb export
    $COMMAND done
    cd ..

}

main_dir=$(date)
main_dir_NOWHITESPACE="$(echo "${main_dir}" | tr -d '[:space:]')"
echo "$main_dir_NOWHITESPACE"
mkdir "$main_dir_NOWHITESPACE"
cd "$main_dir_NOWHITESPACE"

for nodes in $(seq 10 10 110); do
    NODES=$nodes
    for vals in $(seq 5 5 15); do
       VAL=$vals
       run_experiment
    done
done
