FROM node:10 AS node

RUN mkdir /home/app
RUN mkdir /tmp/bpmn-js
WORKDIR /tmp/bpmn-js

COPY app/ ./app
COPY resources/ ./resources
COPY package.json .
COPY package-lock.json .
COPY webpack.config.js .

RUN npm install -g http-server \
    && npm install \
    && npm run build \
    && cp -r ./public/* /home/app/

FROM node

WORKDIR /home/app

EXPOSE 8080
CMD http-server