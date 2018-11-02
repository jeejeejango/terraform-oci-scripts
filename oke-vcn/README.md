# Terraform script for Virtual Cloud Network (VCN) configuration for Oracle Container Engine (OKE)
This script allow you configure the VCN required for OKE as required in the 
documentation [here](https://docs.cloud.oracle.com/iaas/Content/ContEng/Concepts/contengnetworkconfigexample.htm).
OKE web console is now able to create a default OKE's VCN. If you need to customize
the VCN, then you can use this script.

## Setup
1. Please refer to the Terraform setup [here](https://github.com/jeejeejango/terraform-oci-scripts)
2. Download or clone the script 

## Quick Start
After downloading the script, you will need update the configuration as shown below.


### Customize the configuration
The configuration is keep in [terraform.example.tfvars](terraform.example.tfvars).
You will need to copy this file to make your own configuration:
* copy file as terraform.tfvars
* copy file as <sample_filename>.tfvars and execute using
 -var=file=<sample_filename>.tfvars
 
#### Mandatory Input Variables:
The first section in the config file contains the mandatory variables you need to connect to 
your oci instance.  Uncomment the lines and replace the values with your specific settings. 
Check the documentation for [Required Keys and OCID](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#Other)
for how to obtain the necessary values.

name                                | default                 | description
------------------------------------|-------------------------|-----------------
tenancy_ocid                        | None (required)         | Tenancy's OCI OCID
compartment_ocid                    | None (required)         | Compartment's OCI OCID
user_ocid                           | None (required)         | Users's OCI OCID
fingerprint                         | None (required)         | Fingerprint of the OCI user's public key
private_key_path                    | None (required)         | Private key file path of the OCI user's private key
region                              | None (required)         | String value of region to create resources

#### Optional Input Variables:
The configuration has a lot of default values that you can customize. Update the config file and comment out any lines 
with values you would like to chabnge.  If no values are changed you will configure your network according to the 
values shown below. 

##### VCN parameters 
name                                | default                 | description
------------------------------------|-------------------------|------------
vcn_name                            | vcn-oke                 | Name of the VCN network
vcn_dns_label                       | oke                     | Dns name of the VCN network
cidr_vcn                            | 10.0.0.0/16             | CIDR of the VCN network

##### Worker subnets 
name                                | default                 | description
------------------------------------|-------------------------|------------
subnet_workers_ad1_name             | workers_1               | Name of the workers subnet in ad1
subnet_workers_ad2_name             | workers_2               | Name of the workers subnet in ad2
subnet_workers_ad3_name             | workers_3               | Name of the workers subnet in ad3
cidr_subnet_workers_ad1             | 10.0.10.0/24            | CIDR for workers subnet in ad1
cidr_subnet_workers_ad2             | 10.0.11.0/24            | CIDR for workers subnet in ad2
cidr_subnet_workers_ad3             | 10.0.12.0/24            | CIDR for workers subnet in ad3

##### Loadbalancer subnets 
name                                | default                 | description
------------------------------------|-------------------------|------------
subnet_lb_ad1_name                  | lb_1                    | Name of the lb subnet in ad1
subnet_lb_ad2_name                  | lb_2                    | Name of the lb subnet in ad2
cidr_subnet_lb_ad1                  | 10.0.20.0/24            | CIDR for lb subnet in ad1
cidr_subnet_lb_ad2                  | 10.0.21.0/24            | CIDR for lb subnet in ad2

##### Internet Gateway                                          
name                                | default                 | CIDR for workers subnet in ad3description
------------------------------------|-------------------------|------------
ig_name                             | gateway-o               | Name of the Internet gateway

##### Routetable
name                                | default                 | description
------------------------------------|-------------------------|------------
rt_display_name                     | routeable-oke           | Name of the routetable

##### Security Lists
name                                | default                 | description
------------------------------------|-------------------------|------------
sl_worker_name                      | workers                 | Name of the worker security list
sl_lbr_name                         | loadbalancers           | Name of the lbr security list
 
 
### Deploying the VCN
You will need to run the following commands from the directory where you download and setup the 
configuration file.

Initialize the Terraform and plugin:
```bash
terraform init
```

View the plan to be executed:
```bash
terraform plan
```

Execute the actual plan for VCN deployment :
```bash
terraform apply
```

If you are using a custom config filename, you will need to add the -var-file 
parameter:
```bash
terraform plan -var-file=<sample_filename>.tfvars
```

If there is no existing resource, you will see the following output:
```bash
Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

```

### Deleting the VCN
You can delete the provisioned VCN using:
```bash
terraform destroy
```

## Reference
* [peranders](https://github.com/peranders/tf-oke-vcn) tf-oke-vcn example
* [OCI Provider](https://github.com/terraform-providers/terraform-provider-oci/tree/master/docs/examples/networking) 
vcn examples