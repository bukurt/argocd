# Self Managed Argo CD - App of Everything

# Introduction
This project aims to install a self-managed Argo CD using the App of App pattern. Full instructions and explanation can be found in the Medium article [Self Managed Argo CD — App Of Everything](https://medium.com/devopsturkiye/self-managed-argo-cd-app-of-everything-a226eb100cf0).

# Modifications
- Insecure flag on ArgoCD Chart to allow run locally without HTTPS.
- Namespace Management Project.
- Kong as Ingress and Istio as Service Mesh.

# How to install
```sh
cd argocd-install

# If you are running locally, create a cluster before with minikube.
# minikube start

./install.sh values.(cloud/local).yaml

# If you are running locally, enable the tunnel.
# minikube tunnel
```