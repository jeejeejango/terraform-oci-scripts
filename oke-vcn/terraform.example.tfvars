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

## Subnet workers
#subnet_workers_ad1_name="workers-1"
#subnet_workers_ad2_name="workers-2"
#subnet_workers_ad3_name="workers-3"
#cidr_subnet_workers_ad1="10.0.10.0/24"
#cidr_subnet_workers_ad2="10.0.11.0/24"
#cidr_subnet_workers_ad3="10.0.12.0/24"


## Subnet Loadbalancers (lb)
#subnet_lbrs_ad1_name="loadbalancers-1"
#subnet_lbrs_ad2_name="loadbalancers-2"
#cidr_subnet_lbrs_ad1="10.0.20.0/24"
#cidr_subnet_lbrs_ad2="10.0.21.0/24"


## Internet Gateway
#ig_name="gateway-oke"

## Route table
#rt_display_name="routetable-oke"

## Security Lists
# sl_worker_name="workers"
# sl_lbr_name="loaderbalancers"



# Security List ICMP options
#sl_ingress_icmp_options_type="3"
#sl_ingress_icmp_options_code="4"
