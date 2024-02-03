#!/bin/bash

# Service name in the docker-compose file
SERVICE_NAME="r2_wallet"

# Function to execute a command in the service with a specified shell
execute_in_service_with_shell() {
    local shell=$1
    echo "Attempting to use $shell..."
    docker-compose exec $SERVICE_NAME $shell -c "mkdir -p /var/lib/wallet && cd /var/lib/wallet && /usr/local/bin/cli_wallet"
}

# Check if the docker-compose service is running
if docker-compose ps | grep -q $SERVICE_NAME; then
    echo "Attaching to the $SERVICE_NAME service..."
    # First try with /bin/sh
    if ! execute_in_service_with_shell "/bin/sh"; then
        echo "/bin/sh failed, trying /bin/bash..."
        # If /bin/sh fails, then try with /bin/bash
        execute_in_service_with_shell "/bin/bash"
    fi
else
    echo "Service $SERVICE_NAME is not running."
fi
