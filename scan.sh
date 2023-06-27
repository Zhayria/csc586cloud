#!/bin/bash

# Specify the path to the auth.log file
LOG_FILE="/var/log/auth.log"

# Specify the path to the unauthorized.log file
UNAUTHORIZED_LOG="/var/webserver_log/unauthorized.log"

# Use grep to filter out unauthorized/failed SSH access entries
FAILED_LOGS=$(grep "Failed password" "$LOG_FILE")

# Check if any unauthorized/failed SSH access entries are found
if [[ -n "$FAILED_LOGS" ]]; then
    echo "Unauthorized/failed SSH access detected:"
    echo "$FAILED_LOGS"

    # Loop through each line of unauthorized logs
    while IFS= read -r line; do
        # Extract the IP address from the log entry
        IP_ADDRESS=$(echo "$line" | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")

        # Use geoiplookup to get the country of origin
        COUNTRY=$(geoiplookup "$IP_ADDRESS" | awk -F ', ' '{print $2}')

        # Get the current date
        DATE=$(date "+%Y-%m-%d %H:%M:%S")

        # Append the IP address, country, and date to unauthorized.log
        echo "$IP_ADDRESS $COUNTRY $DATE" >> "$UNAUTHORIZED_LOG"
    done <<< "$FAILED_LOGS"
else
    echo "No unauthorized/failed SSH access detected."
fi
