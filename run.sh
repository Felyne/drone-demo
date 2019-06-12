gitea_server=http://192.168.40.131:3333
server_host=192.168.41.34:8090
server_protocol=http
server_port=8090

container_name=drone
docker stop ${container_name} && docker rm ${container_name}

docker run \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --volume=/var/lib/drone:/data \
  --env=DRONE_GITEA_SERVER=${gitea_server} \
  --env=DRONE_GIT_ALWAYS_AUTH=false \
  --env=DRONE_RUNNER_CAPACITY=2 \
  --env=DRONE_SERVER_HOST=${server_host} \
  --env=DRONE_SERVER_PROTO=${server_protocol} \
  --env=DRONE_TLS_AUTOCERT=false \
  --env=DRONE_LOGS_DEBUG=true \
  --env=DRONE_LOGS_PRETTY=false \
  --env=DRONE_LOGS_COLOR=true \
  --publish=${server_port}:80 \
  --restart=always \
  --detach=true \
  --name=${container_name} \
  drone/drone:1.2.1
