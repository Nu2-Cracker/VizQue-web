#!/bin/zsh

docker-compose up --build -d
docker-compose exec -w /prj/server/app/nimlibs nimslogic  sh -c 'nim c --threads:on --app:lib --out:nowtime.so nowtime' && \
docker-compose exec -w /prj/server/app/nimlibs nimslogic  sh -c 'nim c --threads:on --app:lib --out:vizque.so vizque' && \
docker-compose exec front sh -c  'npm install'
docker-compose exec nimslogic  sh -c 'figlet Dev-Env && figlet Completed.'


#実行後

#
<<COMMENTOUT
nimslogicコンテナに入る

docker exec -it nim bash

COMMENTOUT






#ubicorn 起動
<< COMMENTOUT

docker exec -it fastapi sh -c  'python main.py'

COMMENTOUT

#開発用サーバー起動
<< COMMENTOUT

docker exec -it graphdisplay sh -c  'npm run start'

COMMENTOUT

