#!/bin/zsh

docker-compose up --build -d
# nim c -o:output_vizque vizque.nim
docker-compose exec vizque_web bash
# npm install; nohup npm run start &
# exit


