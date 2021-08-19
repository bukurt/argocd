# Self Managed Argo CD - App of Everything

Installation:

$ cd argocd-install

$ helm install argocd ./argo-cd \\
    --namespace=argocd \\
    --create-namespace \\
    -f values-override.yaml
