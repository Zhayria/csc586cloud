#!/bin/bash

LOG_FILE="/var/webserver_monitor/unauthorized.log"
ADMIN_EMAIL="zhayriaw80@gmail.com"

# Check if there are new entries in the log file
if [ -s "$LOG_FILE" ]; then
    SUBJECT="New Unauthorized Access Detected"
    MESSAGE=$(cat "$LOG_FILE")
else
    SUBJECT="Unauthorized Access"
    MESSAGE="Unauthorized access detected."
fi

# Send email 
echo "$MESSAGE" | mail -s "$SUBJECT" "$ADMIN_EMAIL"
