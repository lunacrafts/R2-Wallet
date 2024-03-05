#!/bin/bash

# Service name in the docker-compose file
SERVICE_NAME="r2_wallet"

# Function to execute a command in the service with a specified shell
execute_in_service_with_shell() {
    local shell=$1
    echo "Attempting to use $shell..."
    docker-compose exec $SERVICE_NAME $shell -c "mkdir -p /var/lib/wallet && cd /var/lib/wallet && /usr/local/bin/cli_wallet"
}

# Function to determine the shell path based on the operating system
determine_shell_path() {
    local os_type=$1
    if [[ "$os_type" == "Windows" ]]; then
        echo "//bin//sh"
    else
        echo "/bin/sh"
    fi
}

# Function to check the operating system
check_os() {
    case "$(uname -s)" in
        Linux*|Darwin*) echo "Unix";;
        CYGWIN*|MINGW32*|MSYS*|MINGW*) echo "Windows";;
        *) echo "Unknown";;
    esac
}

# Main script execution starts here
OS_TYPE=$(check_os)

# Determine the shell path based on the operating system
SHELL_PATH=$(determine_shell_path $OS_TYPE)

# Check if the docker-compose service is running
if docker-compose ps | grep -q $SERVICE_NAME; then
    echo "Attaching to the $SERVICE_NAME service..."
    # First try with determined shell path
    if ! execute_in_service_with_shell "$SHELL_PATH"; then
        echo "$SHELL_PATH failed, trying /bin/bash..."
        # If the first attempt fails, then try with /bin/bash
        execute_in_service_with_shell "/bin/bash"
    fi
else
    echo "Service $SERVICE_NAME is not running."
fi
