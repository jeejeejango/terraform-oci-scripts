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

# Internet Gateway
variable "ig_name" {
  default = "gateway-oke"
}

# Route table
variable "rt_display_name" {
  default = "routetable-oke"
}

# Subnet workers
variable "subnet_workers_ad1_name" {
  default = "workers-1"
}
variable "subnet_workers_ad2_name" {
  default = "workers-2"
}
variable "subnet_workers_ad3_name" {
  default = "workers-3"
}

# Subnet Loadbalancers (lbrs)
variable "subnet_lb_ad1_name" {
  default = "loadbalancers-1"
}

variable "subnet_lb_ad2_name" {
  default = "loadbalancers-2"
}

# Security List names
variable "sl_worker_name" {
  default = "workers"
}
variable "sl_lb_name" {
  default = "loaderbalancers"
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
