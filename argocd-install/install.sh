#!/bin/bash
helm repo add kong https://charts.konghq.com
helm repo update

istioctl install --set profile=minimal -y

kubectl create namespace kong-istio
kubectl create namespace argocd

kubectl label namespace kong-istio istio-injection=enabled
kubectl label namespace argocd istio-injection=enabled

helm install -n kong-istio kong-istio kong/kong
helm install argocd ./argo-cd --namespace=argocd

kubectl apply -f argocd-core-projects.yaml
kubectl apply -f argocd-core-apps.yaml
kubectl apply -f argocd-ingress.yaml

sleep 30

kubectl -n argocd get secrets argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d