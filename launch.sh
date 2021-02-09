uptime=$1
docker-compose up &
sleep $uptime
docker-compose down
