FROM node:10.23.2

RUN apt update && apt upgrade -y


#必要なモジュールをインストール
RUN apt install -y git curl build-essential  vim

RUN npm i -g  npm@5.10.0

RUN mkdir /prj && mkdir -p /prj/front

WORKDIR /prj/front

EXPOSE 5555