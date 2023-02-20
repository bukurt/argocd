#!/bin/bash
namespaces=("kong-istio" "argocd" "monitoring" "istio-system")

helm repo add kong https://charts.konghq.com
helm repo add argocd https://argoproj.github.io/argo-helm
helm repo update

for namespace in "${namespace[@]}"; do  
    kubectl create $namespace
    kubectl label namespace istio-injection=enabled
done

helm install -n kong-istio kong-istio kong/kong
helm install -n argocd argocd ./argo-cd

kubectl apply -f argocd-core-projects.yaml
kubectl apply -f argocd-core-apps.yaml

sleep 90

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | echo