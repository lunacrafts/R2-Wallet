1. Run docker container

`docker-compose up`

2. Open docker container

`docker exec -it $docker_container_id /bin/sh`

3. Run entrypoint (from docker container) and synchronize wallet

`/usr/local/bin/entrypoint.sh`

4. Run wallet

`/usr/local/bin/cli_wallet`
