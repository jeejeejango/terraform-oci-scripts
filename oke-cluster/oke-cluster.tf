data "oci_core_vcns" "oke_vcn" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.vcn_name}"
}

data "oci_core_subnets" "workers_ad1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${lookup(data.oci_core_vcns.oke_vcn.virtual_networks[0], "id")}"

  display_name = "${var.subnet_workers_ad1_name}"
}

data "oci_core_subnets" "workers_ad2" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${lookup(data.oci_core_vcns.oke_vcn.virtual_networks[0], "id")}"

  display_name = "${var.subnet_workers_ad2_name}"
}

data "oci_core_subnets" "workers_ad3" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${lookup(data.oci_core_vcns.oke_vcn.virtual_networks[0], "id")}"

  display_name = "${var.subnet_workers_ad3_name}"
}

data "oci_core_subnets" "lb_ad1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${lookup(data.oci_core_vcns.oke_vcn.virtual_networks[0], "id")}"

  display_name = "${var.subnet_lb_ad1_name}"
}

data "oci_core_subnets" "lb_ad2" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${lookup(data.oci_core_vcns.oke_vcn.virtual_networks[0], "id")}"

  display_name = "${var.subnet_lb_ad2_name}"
}


resource "oci_containerengine_cluster" "oke_cluster" {
  #Required
  compartment_id     = "${var.compartment_ocid}"
  kubernetes_version = "${var.cluster_kubernetes_version}"
  name               = "${var.cluster_name}"
  vcn_id             = "${lookup(data.oci_core_vcns.oke_vcn.virtual_networks[0], "id")}"

  #Optional
  options {
    service_lb_subnet_ids = ["${lookup(data.oci_core_subnets.lb_ad1.subnets[0], "id")}", "${lookup(data.oci_core_subnets.lb_ad2.subnets[0], "id")}"]

    #Optional
    add_ons {
      #Optional
      is_kubernetes_dashboard_enabled = "${var.cluster_options_add_ons_is_kubernetes_dashboard_enabled}"
      is_tiller_enabled               = "${var.cluster_options_add_ons_is_tiller_enabled}"
    }

    kubernetes_network_config {
      #Optional
      pods_cidr     = "${var.cluster_options_kubernetes_network_config_pods_cidr}"
      services_cidr = "${var.cluster_options_kubernetes_network_config_services_cidr}"
    }
  }
}

resource "oci_containerengine_node_pool" "oke_node_pool" {
  #Required
  cluster_id         = "${oci_containerengine_cluster.oke_cluster.id}"
  compartment_id     = "${var.compartment_ocid}"
  kubernetes_version = "${var.node_pool_kubernetes_version}"
  name               = "${var.node_pool_name}"
  node_image_name    = "${var.node_pool_node_image_name}"
  node_shape         = "${var.node_pool_node_shape}"
  subnet_ids         = ["${lookup(data.oci_core_subnets.workers_ad1.subnets[0], "id")}", "${lookup(data.oci_core_subnets.workers_ad2.subnets[0], "id")}", "${lookup(data.oci_core_subnets.workers_ad3.subnets[0], "id")}"]

  #Optional
  initial_node_labels {
    #Optional
    key   = "${var.node_pool_initial_node_labels_key}"
    value = "${var.node_pool_initial_node_labels_value}"
  }

  quantity_per_subnet = "${var.node_pool_quantity_per_subnet}"
  ssh_public_key      = "${var.node_pool_ssh_public_key}"
}

output "cluster" {
  value = {
    id                 = "${oci_containerengine_cluster.oke_cluster.id}"
    kubernetes_version = "${oci_containerengine_cluster.oke_cluster.kubernetes_version}"
    name               = "${oci_containerengine_cluster.oke_cluster.name}"
  }
}

output "node_pool" {
  value = {
    id                 = "${oci_containerengine_node_pool.oke_node_pool.id}"
    kubernetes_version = "${oci_containerengine_node_pool.oke_node_pool.kubernetes_version}"
    name               = "${oci_containerengine_node_pool.oke_node_pool.name}"
    subnet_ids         = "${oci_containerengine_node_pool.oke_node_pool.subnet_ids}"
  }
}

