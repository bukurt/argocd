# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

install-infra: ## Install Basic Infra
	echo "Install Docker"
	sudo apt-get update
	sudo apt-get install curl
	curl -fsSL https://get.docker.com/ | sh
	sudo usermod -aG docker $USER
	echo "Install kubectl"
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	echo "Install Kind"
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
	chmod +x ./kind
	sudo mv ./kind /usr/local/bin/kind

create-cluster: ## Create a local cluster with kind
	kind create cluster --name argocd --config ./kind/kind-cluster.yaml

install-argocd: ## Install ArgoCD
	kind create cluster --name argocd --config ./kind/kind-cluster.yaml
	helm install argocd ./argocd-install/argo-cd --namespace=argocd --create-namespace -f ./argocd-install/values-override.yaml
	sleep 60
	kubectl -n argocd get secrets argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
	kubectl -n argocd port-forward service/argocd-server 8080:80

get-admin-password: ## Show the admin password
	kubectl -n argocd get secrets argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d

argo-port-forward: ## Argo port-forward
	kubectl -n argocd port-forward service/argocd-server 8080:80

show-argo-pods: ## Show ArgoCD Pods
	kubectl -n argocd get pods

destroy: ## Remove cluster
	kind delete cluster --name argocd


