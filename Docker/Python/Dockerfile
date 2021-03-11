FROM python:3.8.8

RUN apt update && apt upgrade -y


#必要なモジュールをインストール
RUN apt install -y git curl build-essential  vim

RUN pip install fastapi[all]

RUN mkdir /prj && mkdir -p /prj/server

WORKDIR /prj/server

EXPOSE 8353