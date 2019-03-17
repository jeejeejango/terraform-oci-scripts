###############################################################
## Variables definition - VCN
###############################################################
variable "vcn_name" {
  default = "vcn-oke"
}
variable "vcn_dns_label" {
  default = "oke"
}
variable "cidr_vcn" {
  default = "10.0.0.0/16"
}

variable "private_subnet" {
  default = "true"
}

# CIDRs for worker subnets
variable "cidr_subnet_workers_ad1" {
  default = "10.0.10.0/24"
}
variable "cidr_subnet_workers_ad2" {
  default = "10.0.11.0/24"
}
variable "cidr_subnet_workers_ad3" {
  default = "10.0.12.0/24"
}

# CIDRs for Loadbalancers subnets
variable "cidr_subnet_lb_ad1" {
  default = "10.0.20.0/24"
}
variable "cidr_subnet_lb_ad2" {
  default = "10.0.21.0/24"
}

# CIDRs for Bastian subnet
variable "cidr_subnet_bastian" {
  default = "10.0.31.0/24"
}

# Internet Gateway
variable "ig_name" {
  default = "oke-gateway"
}

# Route table
variable "rt_lb_display_name" {
  default = "oke-lb-routetable"
}

variable "rt_worker_display_name" {
  default = "oke-worker-routetable"
}

variable "rt_bastian_display_name" {
  default = "oke-bastian-routetable"
}

# DHCP options
variable "dhcp_options_display_name" {
  default = "oke-dhcp-options"
}

# NAT
variable "nat_display_name" {
  default = "oke-nat-gateway"
}

# Subnet workers
variable "subnet_workers_ad1_name" {
  default = "worker-1"
}
variable "subnet_workers_ad2_name" {
  default = "worker-2"
}
variable "subnet_workers_ad3_name" {
  default = "worker-3"
}
variable "subnet_workers_ad1_dns" {
  default = "worker1"
}
variable "subnet_workers_ad2_dns" {
  default = "worker2"
}
variable "subnet_workers_ad3_dns" {
  default = "worker3"
}

# Subnet Loadbalancers (lbrs)
variable "subnet_lb_ad1_name" {
  default = "loadbalancer-1"
}
variable "subnet_lb_ad2_name" {
  default = "loadbalancer-2"
}
variable "subnet_lb_ad1_dns" {
  default = "loadbalancer1"
}
variable "subnet_lb_ad2_dns" {
  default = "loadbalancer2"
}

# Subnet Loadbalancers (lbrs)
variable "subnet_bastian_dns" {
  default = "bastian"
}
variable "subnet_bastian_name" {
  default = "bastian"
}

# Security List names
variable "sl_worker_name" {
  default = "workers"
}
variable "sl_lb_name" {
  default = "loaderbalancers"
}
variable "sl_bastian_name" {
  default = "bastian"
}


# Security List ICMP options
variable "sl_ingress_icmp_options_type" {
  default = "3"
}
variable "sl_ingress_icmp_options_code" {
  default = "4"
}

# Security List SSH ingress hosts.
variable "sl_workers_ingress_ssh_cidr1" {
  default = "130.35.0.0/16"
}
variable "sl_workers_ingress_ssh_cidr2" {
  default = "138.1.0.0/17"
}
