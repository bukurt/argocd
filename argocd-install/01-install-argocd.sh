#!/bin/bash
DIRNAME=`dirname $0`

if [ -z ${ARGOCD_NS+x} ];then
  ARGOCD_NS='argocd'
fi

if [ -z ${1+x} ]; then
  VALUES_FILE="${DIRNAME}/argo-cd/values.yaml"
  echo "INFO: Using default values file './argo-cd/values.yaml'"
else
  if [ -f $1 ]; then
    echo "INFO: Using values file $1"
    VALUES_FILE=$1
  else
    echo "ERROR: No file exist $1"
    exit 1
  fi
fi

echo "INFO: Argocd will be installed on $ARGOCD_NS namespace with values file $VALUES_FILE"
echo -n "Do you want to proceed? [y/n]: "
read ans
if [ "$ans" == "y" ]; then
  helm upgrade --install argocd ./argo-cd \
    --namespace=$ARGOCD_NS \
    --create-namespace \
    -f $VALUES_FILE
else
  echo "INFO: Exit without any action"
  exit 0
fi
