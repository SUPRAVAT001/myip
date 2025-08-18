#!/bin/bash

set -e

echo "[INFO] Checking Minikube status..."
if ! minikube status &>/dev/null; then
    echo "[ERROR] Minikube is not running. Start it first using ./start-minikube.sh"
    exit 1
fi

echo "[INFO] Setting kubectl context to Minikube..."
kubectl config use-context minikube &>/dev/null || {
    echo "[ERROR] Failed to switch kubectl context to minikube"
    exit 1
}

echo "[INFO] Getting Minikube IP..."
MINIKUBE_IP=$(minikube ip 2>/dev/null)

if [ -z "$MINIKUBE_IP" ]; then
    echo "[ERROR] Could not get Minikube IP"
    exit 1
fi

echo "[INFO] Fetching NodePort for service..."
NODE_PORT=$(kubectl get svc myapp-service -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null)

if [ -z "$NODE_PORT" ]; then
    echo "[ERROR] Could not find NodePort. Make sure the service is deployed."
    exit 1
fi

APP_URL="http://$MINIKUBE_IP:$NODE_PORT"
echo "[INFO] Checking health at $APP_URL ..."

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL")

if [ "$HTTP_STATUS" == "200" ]; then
    echo "[SUCCESS] Application is healthy and responding with HTTP 200"
else
    echo "[WARNING] Application health check failed. HTTP status: $HTTP_STATUS"
fi
