#!/bin/bash

echo "[INFO] Starting Minikube cluster..."
minikube start --driver=docker

echo "[INFO] Switching kubectl context to Minikube..."
kubectl config use-context minikube

echo "[SUCCESS] Minikube started successfully."
