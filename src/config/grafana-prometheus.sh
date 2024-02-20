#!/bin/bash

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update

aws --version

aws eks update-kubeconfig --name eks-prod

kubectl get pods

kubectl get namespaces
  
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
  
## Install EKS ctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  
sudo mv /tmp/eksctl /usr/local/bin
  
eksctl create addon --name aws-ebs-csi-driver --cluster eks-prod --service-account-role-arn arn:aws:iam::975050195533:role/LabRole_EBS_CSI_DriverRole --force
  
## install helm 3 cli
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
  
## runnig helm 
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  
helm repo update
  
helm repo list
  
kubectl create namespace prometheus
  
cd ../../infrastructure/charts
  
helm install prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2" \
    --set server.persistentVolume.storageClass="gp2" \
    --values prometheus/values.yaml
	
	
kubectl get all -n prometheus

kubectl port-forward deployment/prometheus-server 9090:9090 -n prometheus

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

kubectl create namespace grafana
	
helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword='grafana' \
    --values grafana/values.yaml \
    --set service.type=LoadBalancer
	
kubectl get all -n grafana

kubectl get svc grafana -n grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

kubectl get svc -n grafana