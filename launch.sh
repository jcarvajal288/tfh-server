server_name=$1
uptime=$2
lobby_type=$3
max_players=$4
passcode=$5

lobby_types[0]="paprikalobby"
lobby_types[1]="velvetlobby"
lobby_types[2]="arizonalobby2"
lobby_types[3]="oleanderlobby"

echo setting server name to ${server_name}...
sed -i "s/test_server/$server_name/" ./data/serverV3.cfg

case $lobby_type in
  paprika)
    echo setting lobby to paprika
    sed -i "s/velvetlobby/${lobby_types[0]}/" ./data/serverV3.cfg
    ;;
  velvet)
    echo setting lobby to velvet
    # config is set to velvet by default
    ;;
  arizona)
    echo setting lobby to arizona
    sed -i "s/velvetlobby/${lobby_types[2]}/" ./data/serverV3.cfg
    ;;
  oleander)
    echo setting lobby to oleander
    sed -i "s/velvetlobby/${lobby_types[3]}/" ./data/serverV3.cfg
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

echo setting max player count to ${max_players}...
sed -i "s/maxPlayers = 20/maxPlayers = ${max_players}/" ./data/server.cfg

echo setting passcode to ${passcode}...
sed -i "s/pass_code/${passcode}/" ./data/server.cfg

docker-compose up &
echo keeping server up for $uptime seconds...
sleep $uptime
docker-compose down
