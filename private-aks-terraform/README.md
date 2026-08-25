# New Private AKS - Bharat Production

This standalone Terraform project creates a NEW private AKS cluster while reusing the existing:
- Resource Group: automation-prod-rg
- VNet: bharat-prod-vnet
- ACR: Bharatprodacr

It does NOT manage or recreate the existing public AKS, Jump VM, or Bastion.

## New resources
- Subnet: private-aks-subnet (10.10.4.0/24)
- AKS: bharat-prod-aks-private
- AcrPull role assignment for the new AKS kubelet identity

## Existing subnet layout
- 10.10.0.0/24 -> snet-eastus-4
- 10.10.1.0/24 -> aks-subnet / existing public AKS
- 10.10.2.0/24 -> jumpvm-subnet / Jump VM
- 10.10.3.0/26 -> AzureBastionSubnet / Bastion
- 10.10.4.0/24 -> new private AKS

## Commands

terraform init
terraform fmt
terraform validate
terraform plan

Do NOT apply until the plan has been reviewed.

After creation, test from the Jump VM:

az aks get-credentials \
  --resource-group automation-prod-rg \
  --name bharat-prod-aks-private \
  --overwrite-existing

kubectl get nodes

Check private status:

az aks show \
  --resource-group automation-prod-rg \
  --name bharat-prod-aks-private \
  --query "{name:name,privateCluster:apiServerAccessProfile.enablePrivateCluster,privateFQDN:privateFQDN}" \
  -o json

IMPORTANT:
- Verify 10.10.4.0/24 is still unused before apply.
- Verify Kubernetes version 1.33.7 is currently supported for a NEW AKS cluster in East US before apply.
- Review terraform plan carefully.
- Do not commit secrets, storage keys, service principal secrets, or private SSH keys.
- This project intentionally has no backend configuration; state is local unless you add a backend later.
