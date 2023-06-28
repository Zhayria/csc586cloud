#!/bin/bash

LOG_FILE="/var/webserver_monitor/unauthorized.log"
ADMIN_EMAIL="admin@example.com"

# Check if there are new entries in the log file
if [ -s "$LOG_FILE" ]; then
    SUBJECT="New Unauthorized Access Detected"
    MESSAGE=$(cat "$LOG_FILE")
else
    SUBJECT="No Unauthorized Access"
    MESSAGE="No unauthorized access detected."
fi

# Send email to admin
echo "$MESSAGE" | mail -s "$SUBJECT" "$ADMIN_EMAIL"
