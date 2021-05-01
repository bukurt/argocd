# Self Managed Argo CD - App of Everything

Intallaiton
helm install argocd ./argo-cd \
  --namespace=argocd \
  --create-namespace \
  -f values-override.yaml
