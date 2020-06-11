FROM ethereum/client-go:alltools-latest
RUN apk add npm tmux
RUN npm install -g truffle --unsafe-perm 
RUN mkdir -p /geth
WORKDIR /contract
RUN truffle init -y
CMD ["truffle"]
