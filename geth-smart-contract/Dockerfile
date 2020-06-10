FROM node:13.12.0-alpine
RUN npm install -g truffle --unsafe-perm 
WORKDIR /contract
RUN truffle init -y
CMD ["truffle"]
