#!/bin/bash
kubectl create argocd
kubectl label namespace default istio-injection=enabled

helm install -n argocd argocd ./argo-cd

kubectl apply -f argocd-core-projects.yaml
kubectl apply -f argocd-core-apps.yaml

sleep 90

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | echo