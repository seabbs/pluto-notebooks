#!/bin/bash
# PlutoPages Service Management Script

PLIST_PATH="$HOME/Library/LaunchAgents/co.samabbott.pluto-notebooks.plist"
SERVICE_NAME="co.samabbott.pluto-notebooks"

case "$1" in
    start)
        echo "Starting PlutoPages service..."
        launchctl load -w "$PLIST_PATH"
        ;;
    stop)
        echo "Stopping PlutoPages service..."
        launchctl unload -w "$PLIST_PATH"
        ;;
    restart)
        echo "Restarting PlutoPages service..."
        launchctl unload -w "$PLIST_PATH"
        sleep 2
        launchctl load -w "$PLIST_PATH"
        ;;
    status)
        echo "Checking service status..."
        launchctl list | grep "$SERVICE_NAME" || echo "Service not running"
        ;;
    logs)
        echo "Showing recent logs..."
        tail -n 50 /Users/lshsa2/code/pluto-notebooks/logs/stdout.log
        ;;
    errors)
        echo "Showing recent errors..."
        tail -n 50 /Users/lshsa2/code/pluto-notebooks/logs/stderr.log
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status|logs|errors}"
        exit 1
        ;;
esac