#!/bin/bash

# Service name in the docker-compose file
SERVICE_NAME="r_squared_core"

# Check if the docker-compose service is running
if docker-compose ps | grep -q $SERVICE_NAME; then
    echo "Attaching to the $SERVICE_NAME service..."
    docker-compose exec $SERVICE_NAME /bin/sh -c "mkdir -p /var/lib/wallet && cd /var/lib/wallet && /usr/local/bin/cli_wallet"
else
    echo "Service $SERVICE_NAME is not running."
fi
