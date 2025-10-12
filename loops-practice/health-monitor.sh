#!/bin/bash

# --- VARIABLES ---
LOG_FILE="monitor_log.txt"       # String variable for the log file name
THRESHOLD_DISK=80                # Numeric variable for the disk usage threshold (in %)
ERROR_STRING="CRITICAL FAILURE"  # String variable for the specific error to search for

echo "[$(date +%Y-%m-%d\ %H:%M:%S)] INFO: Script execution started." > "$LOG_FILE"
# Append several lines to the log file
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] WARNING: High temperature detected on CPU core 3." >> "$LOG_FILE"
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] INFO: User 'admin' logged in successfully." >> "$LOG_FILE"
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] ERROR: Failed to write cache data. Retrying..." >> "$LOG_FILE"
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] INFO: System check for background services complete." >> "$LOG_FILE"
echo "[$(date +%Y-05-15\ 10:00:00)] $ERROR_STRING: RAID array failed synchronization." >> "$LOG_FILE"
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] INFO: Disk check finished." >> "$LOG_FILE"
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] ERROR: Permission denied for file access." >> "$LOG_FILE"
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $ERROR_STRING: Memory allocation overflow." >> "$LOG_FILE"


function check_system_health() {
    echo "Checking Disk Usage..."
    # Command to get disk usage %
    # ... df/awk/cut commands ...
    local CURRENT_DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

    echo "Current Disk Usage: $CURRENT_DISK_USAGE%"

    if [[ $CURRENT_DISK_USAGE -gt $THRESHOLD_DISK ]]; then
        echo "ALERT: Root disk usage is at $CURRENT_DISK_USAGE%, which is above the $THRESHOLD_DISK% threshold!"
    else
        echo "INFO: Root disk usage is nominal at $CURRENT_DISK_USAGE%."
    fi
}

function analyze_logs() {
    echo "--- Initiating Log Analysis ---"
    local error_count=0

    echo "Searching for the error string: '$ERROR_STRING' in '$LOG_FILE'..."
    echo "---"

    while IFS= read -r line; do
        if [[ "$line" == *"$ERROR_STRING"* ]]; then
            # Increment the counter
            ((error_count++))
            # Print the error line
            echo "MATCH FOUND: $line"
        fi
    done < "$LOG_FILE"

    echo "---"
    echo "SUMMARY: A total of $error_count entries matching '$ERROR_STRING' were found."
    echo "--- Log Analysis Complete ---"
}

check_system_health # This line runs the function you just created
analyze_logs
