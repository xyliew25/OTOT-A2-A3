#!/bin/sh

# Create cluster
kind create cluster --name kind-1 --config k8s/kind/cluster-config.yaml

# Create deployment
kubectl apply -f k8s/manifests/k8s/backend-deployment.yaml
kubectl wait --for=condition=ready pod -l app=backend --timeout=300s

# Create service
kubectl apply -f k8s/manifests/k8s/backend-service.yaml

# Create ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait -n ingress-nginx --for=condition=ready pod -l app.kubernetes.io/component=controller --timeout=300s

# Create ingress
kubectl apply -f k8s/manifests/k8s/backend-ingress.yaml
