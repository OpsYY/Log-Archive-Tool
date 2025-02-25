#!/bin/bash

# Check if log directory argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR="$1"

# Check if the directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

# Create an archive directory if it doesn't exist
ARCHIVE_DIR="/var/log/archived_logs"
mkdir -p "$ARCHIVE_DIR"

# Generate timestamp for archive name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

# Compress logs
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" .

# Log the archive creation
echo "$TIMESTAMP - Archived $LOG_DIR to $ARCHIVE_DIR/$ARCHIVE_NAME" >> /var/log/log_archive.log

# Output success message
echo "Logs archived successfully: $ARCHIVE_DIR/$ARCHIVE_NAME"
