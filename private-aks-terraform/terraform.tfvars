subscription_id = "774hsdgnhdf"

resource_group_name = "abc-prod-rg"

location = "East US"

vnet_name = "abc-prod-vnet"

# Existing subnets:
# 10.10.0.0/24 -> snet-eastus-4
# 10.10.1.0/24 -> existing public AKS
# 10.10.2.0/24 -> Jump VM
# 10.10.3.0/26 -> Bastion
#
# New subnet:
# 10.10.4.0/24 -> private AKS

aks_subnet_name = "private-aks-subnet"

aks_subnet_prefix = [
  "10.10.4.0/24"
]

acr_name = "Abcprodacr"

aks_name = "abc-prod-aks-private"

dns_prefix = "abcpordaksprivate"

kubernetes_version = "1.33.7"

node_count = 2

vm_size = "Standard_b2ms_v3"

# Different from existing AKS
service_cidr = "10.1.0.0/16"

dns_service_ip = "10.1.0.10"

pod_cidr = "10.245.0.0/16"

tags = {
  Environment = "Production"
  Project     = "Clouds"
  ManagedBy   = "Terraform"
}