provider azurerm {
    features {}
    version = "~> 2.16"
}

# Load Kubernetes and Helm provider, using the data of the existing AKS cluster to authenticate
data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aksname
  resource_group_name = var.aksrgname
}

provider "kubernetes" {
  load_config_file       = "false"
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
  username               = data.azurerm_kubernetes_cluster.aks.kube_config.0.username
  password               = data.azurerm_kubernetes_cluster.aks.kube_config.0.password
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
}

# Deploy Consul via Helm
resource "helm_release" "consul" {
  repository = "https://helm.releases.hashicorp.com"
  name       = "consul-omegamadlab"
  chart      = "consul"

  values = [
      "${file("consul-config.yaml")}",
      "${file("consul-federation.yaml")}"
    ]
}

# Create a service on K8S
resource "kubernetes_service" "public_ip" {
  metadata {
    name = "azure-load-balancer"
    annotations = {
      "service.beta.kubernetes.io/azure-load-balancer-resource-group" = data.azurerm_kubernetes_cluster.aks.node_resource_group
    }
  }
  spec {
    selector = {
      app       = "consul"
      component = "mesh-gateway"
    }
    session_affinity = "ClientIP"
    port {
      port        = 8302
      target_port = 80
    }

    type = "LoadBalancer"
  }
}