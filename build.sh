#!/bin/sh

set -e

git fetch origin

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})

if [ "$LOCAL" = "$REMOTE" ]; then
    echo "No changes detected. Build not needed."
    exit 0
fi

echo "Changes detected. Pulling latest and running build..."
git pull

sh ./install.sh
sh ./config.sh
