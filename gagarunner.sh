#!/bin/bash

# Step 1: Download and unzip
curl -o apphub-linux-amd64.tar.gz https://assets.coreservice.io/public/package/60/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz
tar -zxf apphub-linux-amd64.tar.gz
rm -f apphub-linux-amd64.tar.gz
cd ./apphub-linux-amd64

# Step 2: Remove existing service and install new service
sudo ./apphub service remove
sudo ./apphub service install

# Step 3: Start service
sudo ./apphub service start

# Step 4: Check app status in a loop
while true; do
  status=$(./apphub status | grep gaganode | grep RUNNING)
  if [ -n "$status" ]; then
    echo "gaganode is running"
    break
  else
    echo "gaganode is not running, checking again in 3 seconds..."
    sleep 3
  fi
done

# Step 5: Set token
sudo ./apps/gaganode/gaganode config set --token=rbekjeaittfpvjhs78135f6cf9c835b9

# Step 6: Restart app
./apphub restart

echo "Script completed successfully"
