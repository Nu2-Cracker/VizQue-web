FROM  nimlang/nim:1.4.4

RUN apt update && apt upgrade -y

#必要なモジュールをインストール
RUN apt install -y git curl build-essential  vim
RUN apt-get update && \
  apt-get install -y python3 libpython3.7 python-numpy python3-numpy

RUN nimble install nimpy -y

RUN mkdir /prj && mkdir -p /prj/server

WORKDIR /prj/server