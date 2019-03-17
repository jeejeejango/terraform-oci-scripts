data "oci_identity_availability_domain" "ad" {
  compartment_id = "${var.tenancy_ocid}"
  ad_number      = "${var.bastian_ad}"
}

data "oci_core_subnets" "bastian_ad" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${lookup(data.oci_core_vcns.oke_vcn.virtual_networks[0], "id")}"
  display_name = "${var.subnet_bastian_name}"
  count = "${var.private_subnet == "true" ? 1 : 0}"
}


resource "oci_core_instance" "bastian_instance" {
  count               = "${var.private_subnet == "true" ? 1 : 0}"
  depends_on          = ["data.oci_core_subnets.bastian_ad"]
  availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.bastian_name}"
  shape               = "${var.bastian_shape}"

  create_vnic_details {
    subnet_id        = "${lookup(data.oci_core_subnets.bastian_ad.subnets[0], "id")}"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = "${var.instance_image_ocid[var.region]}"

    # Apply this to set the size of the boot volume that's created for this instance.
    # Otherwise, the default boot volume size of the image is used.
    # This should only be specified when source_type is set to "image".
    boot_volume_size_in_gbs = "${var.bastian_boot_vol_size}"
  }

  # Apply the following flag only if you wish to preserve the attached boot volume upon destroying this instance
  # Setting this and destroying the instance will result in a boot volume that should be managed outside of this config.
  # When changing this value, make sure to run 'terraform apply' so that it takes effect before the resource is destroyed.
  #preserve_boot_volume = true

  metadata {
    ssh_authorized_keys = "${var.bastian_ssh_public_key}"
  }

}
