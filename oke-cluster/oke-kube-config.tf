data "oci_containerengine_cluster_kube_config" "oke_config" {
  #Required
  cluster_id = "${oci_containerengine_cluster.oke_cluster.id}"

  #Optional
  expiration    = "${var.cluster_kube_config_expiration}"
  token_version = "${var.cluster_kube_config_token_version}"
}

resource "local_file" "test_cluster_kube_config_file" {
  content  = "${data.oci_containerengine_cluster_kube_config.oke_config.content}"
  filename = "${path.module}/${var.cluster_name}_${var.cluster_kube_config_filename}"
}
