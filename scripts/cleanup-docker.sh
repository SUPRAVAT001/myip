#!/bin/bash

echo "[INFO] Stopping running containers..."
docker ps -q | xargs -r docker stop

echo "[INFO] Removing stopped containers..."
docker container prune -f

echo "[INFO] Removing dangling images..."
docker image prune -f

echo "[INFO] Docker cleanup complete."

