###############################################################
## Mandatory connection settings. Provide your OCI settings
###############################################################

#tenancy_ocid = "<Replace with your oci tenancy OCID>"
#user_ocid = "<Replace with your oci user OCID>"
#fingerprint = "<Replace with your pem public key fingerprint>"
#private_key_path = "<Replace with Path to your pem private key>"
#compartment_ocid = "<Replace with your oci compartment OCID>"
#region = "<Replace with your region name, e.g: eu-frankfurt-1>"


###############################################################
## Custom settings. Uncomment and change to your own values
## to override default settings.
###############################################################

## VCN values
#vcn_name="vcn-oke"
#cidr_vcn="10.0.0.0/16"
#vcn_dns_label="oke"
#private_subnet="true"

## Subnet workers
#subnet_workers_ad1_name="worker-1"
#subnet_workers_ad2_name="worker-2"
#subnet_workers_ad3_name="worker-3"
#subnet_workers_ad1_dns="worker1"
#subnet_workers_ad2_dns="worker2"
#subnet_workers_ad3_dns="worker3"
#cidr_subnet_workers_ad1="10.0.10.0/24"
#cidr_subnet_workers_ad2="10.0.11.0/24"
#cidr_subnet_workers_ad3="10.0.12.0/24"


## Subnet Loadbalancers (lb)
#subnet_lb_ad1_name="loadbalancer-1"
#subnet_lb_ad2_name="loadbalancer-2"
#subnet_lb_ad1_dns="loadbalancer1"
#subnet_lb_ad2_dns="loadbalancer2"
#cidr_subnet_lb_ad1="10.0.20.0/24"
#cidr_subnet_lb_ad2="10.0.21.0/24"

## Subnet Bastian
#subnet_bastian_name="bastian"
#subnet_bastian_dns="bastian"
#cidr_subnet_bastian="10.0.31.0/24"


## Internet Gateway
#ig_name="oke-gateway"

## Route table
#rt_lb_display_name="oke-lb-routetable"
#rt_worker_display_name="oke-worker-routetable"
#rt_bastian_display_name="oke-bastian-routetable"

## DHCP Options
#dhcp_options_display_name="oke-dhcp-options"
#nat_display_name="oke-nat-gateway"

## Security Lists
#sl_worker_name="workers"
#sl_lb_name="loaderbalancers"
#sl_bastian_name="bastian"


# Security List ICMP options
#sl_ingress_icmp_options_type="3"
#sl_ingress_icmp_options_code="4"
