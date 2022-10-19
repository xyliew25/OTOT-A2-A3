#!/bin/sh

# Create metrics server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml 
kubectl -nkube-system edit deploy/metrics-server
# add a flag --kubelet-insecure-tls to deployment.spec.containers[].args[]
kubectl -nkube-system rollout restart deploy/metrics-server

# Create hpa
kubectl apply -f k8s/manifests/k8s/backend-hpa.yaml

# Create zone aware deployment
kubectl apply -f k8s/manifests/k8s/backend-deployment-zone-aware.yaml
