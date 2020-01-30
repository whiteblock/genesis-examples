import os
import sys
import networkx as nx

def usage():
  print("usage: python topo.py <seed> <nodes> <degree> <output>")
  print("\t<seed> [int]: the seed to be used to generate a deterministic pseudo-randomly generated connected graph.")
  print("\t<nodes> [int]: the number of nodes in the network to generate a peering topology for.")
  print("\t<degree> [int]: the degree of connectivity that will determine how densely/loosely connected the network will be.")
  print("\t<output> [bool]: output of peer topology as file(s) for each node.")
  exit(1)

def strToBool(v):
  return v.lower() in ("yes", "true", "t", "1")

try:
  sys.argv[1]
except:
  print("ERROR: Please provide the seed")
  usage()

try:
  sys.argv[2]
except:
  print("ERROR: Please provide the number of nodes")
  usage()

try:
  sys.argv[3]
except:
  print("ERROR: Please provide the degree of connectivity")
  usage()

output=bool(False)
try:
  output=strToBool(sys.argv[4])
except:
  pass

seed=int(sys.argv[1])
nodes=int(sys.argv[2])
degree=int(sys.argv[3])

ba=nx.barabasi_albert_graph(nodes, degree, seed)
sp=dict(nx.all_pairs_shortest_path(ba))

out="{"
for i in range(0, nodes):
   l=[n for n in ba.neighbors(i)]
   cont=",".join(map(str,l))
   out+="\""+str(i)+"\""
   out+=":["
   out+=str(cont)
   out+="]"
   if i != nodes-1:
      out+=","
out+="}"

print(out)

if output==True:
  cwd=os.getcwd()
  dir=cwd+"/topology/"

  if os.path.isdir(dir):
  #  print("deleting directory")
    filelist = [ f for f in os.listdir(dir) if f.endswith(".txt") ]
    for f in filelist:
        os.remove(os.path.join(dir, f))
  else:
    os.mkdir("topology")

  for i in range(0, nodes):
     f=open(dir+"peers_"+str(i)+".txt",'w')
     f.write(cont)
     f.close()
