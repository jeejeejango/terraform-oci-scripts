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
######################terr#########################################

#vcn_name="vcn-oke"
#subnet_workers_ad1_name = "worker-1"
#subnet_workers_ad2_name="worker-2"
#subnet_workers_ad3_name="worker-3"
#subnet_lb_ad1_name="loadbalancer-1"
#subnet_lb_ad2_name="loadbalancer-2"

#node_pool_ssh_public_key = ""

#cluster_kubernetes_version = "v1.11.5"
#cluster_name = "oke_cluster"

#availability_domain = "3"

#cluster_options_add_ons_is_kubernetes_dashboard_enabled = true
#cluster_options_add_ons_is_tiller_enabled = false
#cluster_options_kubernetes_network_config_pods_cidr = "10.244.0.0/16"
#cluster_options_kubernetes_network_config_services_cidr = "10.96.0.0/16"

#node_pool_initial_node_labels_key = "key"
#node_pool_initial_node_labels_value = "value"
#node_pool_kubernetes_version = "v1.11.5"
#node_pool_name = "oke_pool"
#node_pool_node_image_name = "Oracle-Linux-7.5"
#node_pool_node_shape = "VM.Standard1.1"
#node_pool_quantity_per_subnet = 1

#cluster_kube_config_expiration = 2592000
#cluster_kube_config_token_version = "1.0.0"
#cluster_kube_config_filename = "config"
