#!/bin/bash

# Service name in the docker-compose file
SERVICE_NAME="r2_wallet"

# Check if the docker-compose service is running
if docker-compose ps | grep -q $SERVICE_NAME; then
    echo "Attaching to the $SERVICE_NAME service..."
    if ! docker-compose exec $SERVICE_NAME /bin/sh -c "cd /var/lib/rsquared && /bin/sh"; then
        docker-compose exec $SERVICE_NAME /bin/bash -c "cd /var/lib/rsquared && /bin/bash"
    fi
else
    echo "Service $SERVICE_NAME is not running."
fi
