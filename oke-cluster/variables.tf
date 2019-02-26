###############################################################
## Variables definition - VCN
###############################################################
variable "vcn_name" {
  default="vcn-oke"
}

# Subnet workers
variable "subnet_workers_ad1_name" {
  default="worker-1"
}
variable "subnet_workers_ad2_name" {
  default="worker-2"
}
variable "subnet_workers_ad3_name" {
  default="worker-3"
}

# Subnet Loadbalancers (lbrs)
variable "subnet_lb_ad1_name" {
  default="loadbalancer-1"
}

variable "subnet_lb_ad2_name" {
  default="loadbalancer-2"
}


## Variable definition - OKE

variable "cluster_kubernetes_version" {
  default = "v1.11.5"
}

variable "cluster_name" {
  default = "oke_cluster"
}

variable "availability_domain" {
  default = 3
}

variable "cluster_options_add_ons_is_kubernetes_dashboard_enabled" {
  default = true
}

variable "cluster_options_add_ons_is_tiller_enabled" {
  default = false
}

variable "cluster_options_kubernetes_network_config_pods_cidr" {
  default = "10.244.0.0/16"
}

variable "cluster_options_kubernetes_network_config_services_cidr" {
  default = "10.96.0.0/16"
}

variable "node_pool_initial_node_labels_key" {
  default = "key"
}

variable "node_pool_initial_node_labels_value" {
  default = "value"
}

variable "node_pool_kubernetes_version" {
  default = "v1.11.5"
}

variable "node_pool_name" {
  default = "oke_pool"
}

variable "node_pool_node_image_name" {
  default = "Oracle-Linux-7.5"
}

variable "node_pool_node_shape" {
  default = "VM.Standard2.2"
}

variable "node_pool_quantity_per_subnet" {
  default = 1
}

variable "node_pool_ssh_public_key" {}

variable "cluster_kube_config_expiration" {
  default = 2592000
}

variable "cluster_kube_config_token_version" {
  default = "1.0.0"
}

variable "cluster_kube_config_filename" {
  default = "config"
}