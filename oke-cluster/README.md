# Terraform script for  Oracle Container Engine (OKE) configuration
This script allow you configure the OKE cluster and the node pool. You can also use 
OKE web console to create or update the cluster and node pool. If you need to 
quickly provision the OKE, then you can use this script.

## Setup
1. Please refer to the Terraform setup [here](https://github.com/jeejeejango/terraform-oci-scripts)
2. Download or clone the script 
3. Prepare the OKE VCN, or use the Terraform script [here](https://github.com/jeejeejango/terraform-oci-scripts/tree/master/oke-vcn)

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
node_pool_ssh_public_key            | None (required)         | The public ssh key to access node pool compute instance

#### Optional Input Variables:
The configuration has a lot of default values that you can customize. Update the config file and comment out any lines 
with values you would like to chabnge.  If no values are changed you will configure your network according to the 
values shown below. 

##### Existing VCN and subnet parameters 
name                                | default                 | description
------------------------------------|-------------------------|------------
vcn_name                            | vcn-oke                 | Name of the VCN network

##### Worker subnets 
name                                | default                 | description
------------------------------------|-------------------------|------------
subnet_workers_ad1_name             | workers_1               | Name of the workers subnet in ad1
subnet_workers_ad2_name             | workers_2               | Name of the workers subnet in ad2
subnet_workers_ad3_name             | workers_3               | Name of the workers subnet in ad3

##### Loadbalancer subnets 
name                                | default                 | description
------------------------------------|-------------------------|------------
subnet_lb_ad1_name                  | lb_1                    | Name of the lb subnet in ad1
subnet_lb_ad2_name                  | lb_2                    | Name of the lb subnet in ad2

#### Kubernetes Cluster
name                                                    | default                 | description
--------------------------------------------------------|-------------------------|------------
cluster_kubernetes_version                              | v1.11.1                 | Kubernetes version supported in OKE
cluster_name                                            | oke_cluster             | Name of the OKE cluster
cluster_options_add_ons_is_kubernetes_dashboard_enabled | true                    | Enable Kubernetes Dashboard
cluster_options_add_ons_is_tiller_enabled               | true                    | Enable Helm Tiller
cluster_options_kubernetes_network_config_pods_cidr     | 10.1.0.0/16             | 
cluster_options_kubernetes_network_config_services_cidr | 10.2.0.0/16             | 

#### OKE Node Pool
name                                | default                 | description
------------------------------------|-------------------------|------------
node_pool_initial_node_labels_key   | key                     | Key to tag the node pool
node_pool_initial_node_labels_value | value                   | Value to for the key tag
node_pool_kubernetes_version        | v1.11.1                 | Kubernetes version supported in OKE
node_pool_name                      | oke_pool                | Name of the node pool
node_pool_node_image_name           | Oracle-Linux-7.5        | Image name of the node pool compute
node_pool_node_shape                | VM.Standard1.1          | Shape of the the node pool compute
node_pool_quantity_per_subnet       | 1                       | Number of compute instance per Availability Domain

#### Kubernetes Config
name                                | default                 | description
------------------------------------|-------------------------|------------
cluster_kube_config_expiration      | 2592000                 | Expiration time to wait for the config
cluster_kube_config_token_version   | 1.0.0                   | Token version
cluster_kube_config_filename        | config                  | File name of the Kubernetes config

### Deploying the OKE
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

Execute the actual plan for OKE deployment :
```bash
terraform apply
```

If you are using a custom config filename, you will need to add the -var-file 
parameter:
```bash
terraform plan -var-file=<sample_filename>.tfvars
```

### Deleting the OKE
You can delete the provisioned OKE using:
```bash
terraform destroy
```

## Reference
* [OCI Provider](https://github.com/terraform-providers/terraform-provider-oci/tree/master/docs/examples/container_engine) 
OKE examples