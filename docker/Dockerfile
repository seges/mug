FROM dockerfile/nodejs

RUN useradd -m -s /bin/bash developer

RUN apt-get update && apt-get install -y mc

RUN npm install -g gulp webpack webpack-dev-server
RUN npm install -g rx
