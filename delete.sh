docker stop nim fastapi graphdisplay
docker rm nim fastapi graphdisplay
docker rmi nim/1.4.4  python/3.8.8 reactapp nimlang/nim:1.4.4 node:10.23.2 python:3.8.8
docker network rm vizque-web_default
rm -rf ./front/node_modules