#!/bin/bash

# Watch for changes in src/ and auto-commit
# Uses fswatch to monitor file changes

PROJECT_ROOT="/Users/lshsa2/code/pluto-notebooks"
WATCH_DIR="$PROJECT_ROOT/src"

echo "Starting file watcher for auto-commits..."
echo "Watching: $WATCH_DIR"
echo "Press Ctrl+C to stop"

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "ERROR: fswatch is not installed"
    echo "Install with: brew install fswatch"
    exit 1
fi

# Change to project directory
cd "$PROJECT_ROOT" || exit 1

# Watch for changes and trigger auto-commit
fswatch -o "$WATCH_DIR" | while read -r num_changes
do
    echo "$(date): Detected $num_changes changes in $WATCH_DIR"
    
    # Run auto-commit script
    julia --project scripts/auto_commit.jl
    
    # Optional: Push to remote (uncomment if desired)
    # echo "Pushing to remote..."
    # git push origin main
done