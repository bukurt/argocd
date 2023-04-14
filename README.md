# Self Managed Argo CD - App of Everything

# Introduction
This project aims to install a self-managed Argo CD using the App of App pattern. Full instructions and explanation can be found in the Medium article [Self Managed Argo CD — App Of Everything](https://medium.com/devopsturkiye/self-managed-argo-cd-app-of-everything-a226eb100cf0).

# Modifications
- Using a more recent version of ArgoCD Helm Chart.
- Adding core files for apps and projects since the more recent versions of ArgoCD Charts don't accept those parameters in values.yaml.
- Namespace Management Project.
- Kong as Ingress and Istio as Service Mesh.

# How to install
1. Modify the values.yaml inside argocd-install/argo-cd
2. Run the installation script.

```sh
cd argocd-install

# If you are running locally, create a cluster before with minikube.
minikube start --memory 8192 --cpus 2
minikube addons enable metrics-server

./install.sh

# If you are running locally, enable the tunnel.
minikube tunnel

# And to enable the metric-server
```