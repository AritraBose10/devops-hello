#!/usr/bin/env bash
# Instructor setup for the Kubernetes demo. Run inside a GitHub Codespace:
#   bash k8s-demo.sh
# Installs kind and kubectl, creates a local cluster, builds the image and runs 3 replicas.
set -euo pipefail

if ! command -v kind >/dev/null; then
  curl -sSLo kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-amd64
  chmod +x kind && sudo mv kind /usr/local/bin/kind
fi
if ! command -v kubectl >/dev/null; then
  curl -sSLo kubectl https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl
  chmod +x kubectl && sudo mv kubectl /usr/local/bin/kubectl
fi

kind get clusters | grep -qx demo || kind create cluster --name demo

docker build -t hello:v1 .
kind load docker-image hello:v1 --name demo

kubectl create deployment hello --image=hello:v1 --replicas=3 --port=8080 --dry-run=client -o yaml | kubectl apply -f -
kubectl expose deployment hello --port=80 --target-port=8080 --dry-run=client -o yaml | kubectl apply -f -
kubectl rollout status deployment/hello
kubectl get pods -o wide
echo "Ready. In class: kubectl port-forward svc/hello 8080:80"
