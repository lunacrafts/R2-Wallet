Run docker container

`docker-compose up`

Open docker container

`docker exec -it b2e3b7...28174 /bin/sh`

Run entrypoint (from docker container) and synchronize wallet

`/usr/local/bin/entrypoint.sh`

Run wallet

`/usr/local/bin/cli_wallet`
