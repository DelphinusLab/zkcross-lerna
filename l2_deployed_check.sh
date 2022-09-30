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
# Check L1 Monitor Status
node packages/monitors/src/tools/l1MonitorRunningStatus/l1_monitor_status_checking.js

## Check L2 Monitor Status
if ps aux | grep -v grep | grep "bash run_l2monitor.sh"
then
    echo "L2 monitor status check: Running";
else
    echo "L2 monitor status check: Not Running";
    exit 0
fi

echo "L2 has been successfully deployed"