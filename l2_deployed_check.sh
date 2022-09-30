## Check Caddy Status
if ps aux | grep -v grep | grep 'sudo caddy run';
then
    echo "Caddy status Check: Running";
else
    echo "Caddy status Check: Failed, Please run Caddy"
    exit 0
fi
## Check Docker Status
if sudo docker ps --filter status=running --format "{{.Image}}" | grep -q 'delphinus-node'; 
then
    echo "Docker status Check: Running";
else
    echo "Docker status Check: Failed, Please run Docker image"
    exit 0
fi
## Check MongoDB Status
if ps aux | grep mongo | grep -v grep | grep -q 'mongod';
then
    echo "MongoDB status Check: Running";
else
    echo "MongoDB status Check: Failed, Please run MongoDB"
    exit 0
fi
## Check Monitor Status
Networks=("ropsten" "bsctestnet" "cronostestnet" "rolluxtestnet")
for network in ${Networks[@]}; do
  if ps aux | grep -v grep | grep "bash run_l1monitor.sh $network"
    then
        echo "$network monitor status check: Running";
    else
        echo "$network monitor status check: Not Running";
        exit 0
    fi
done

echo "L2 has been successfully deployed"