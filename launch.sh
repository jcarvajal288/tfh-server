uptime=$1
lobby_type=$2

lobby_types[0]="paprikalobby"
lobby_types[1]="velvetlobby"
lobby_types[2]="arizonalobby2"

case $lobby_type in
  paprika)
    echo setting lobby to paprika
    sed -i "s/velvetlobby/${lobby_types[0]}/" ./data/server.cfg
    ;;
  velvet)
    echo setting lobby to velvet
    # config is set to velvet by default
    ;;
  arizona)
    echo setting lobby to arizona
    sed -i "s/velvetlobby/${lobby_types[2]}/" ./data/server.cfg
    ;;
  random)
    echo setting lobby to random...
    num_lobbies=${#lobby_types[@]}
    index=$(($RANDOM % $num_lobbies))
    lobby_type=${lobby_types[$index]}
    echo randomized lobby type is $lobby_type
    sed -i "s/velvetlobby/$lobby_type/" ./data/server.cfg
    ;;
  *)
    echo WARNING: unrecognized lobby type $lobby_type - keeping default velvet lobby
    ;;
esac

docker-compose up &
sleep $uptime
docker-compose down
