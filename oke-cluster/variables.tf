###############################################################
## Variables definition - VCN
###############################################################
variable "vcn_name" {
  default="vcn-oke"
}

variable "private_subnet" {
  default = "true"
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

# Subnet bastisan
variable "subnet_bastion_name" {
  default = "bastion"
}

# bastion config
variable "bastion_ssh_public_key" {}

variable "bastion_name" {
  default = "bastion"
}

variable "bastion_shape" {
  default = "VM.Standard2.1"
}

variable "bastion_ad" {
  default = "1"
}

variable "bastion_boot_vol_size" {
  default = "60"
}

variable "instance_image_ocid" {
  type = "map"

  //See https://docs.cloud.oracle.com/iaas/images/
  //Oracle provided image "Oracle-Linux-7.6-2019.02.20-0"
  default = {
    ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaa7ac57wwwhputaufcbf633ojir6scqa4yv6iaqtn3u64wisqd3jjq"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaacss7qgb6vhojblgcklnmcbchhei6wgqisqmdciu3l4spmroipghq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaannaquxy7rrbrbngpaqp427mv426rlalgihxwdjrz3fr2iiaxah5a"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa527xpybx2azyhcz2oyk6f4lsvokyujajo73zuxnnhcnp7p24pgva"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaarruepdlahln5fah4lvm7tsf4was3wdx75vfs6vljdke65imbqnhq"
  }
}


## Variable definition - OKE

variable "cluster_kubernetes_version" {
  default = "v1.12.6"
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
  default = "v1.12.6"
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