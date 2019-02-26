###############################################################
## AD information
###############################################################

data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.compartment_ocid}"
}

###############################################################
## VCN Resource definitions
###############################################################

resource "oci_core_vcn" "oke_vcn" {
  cidr_block = "${var.cidr_vcn}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.vcn_name}"
  dns_label = "${var.vcn_dns_label}"
}

resource "oci_core_internet_gateway" "oke_gateway" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.ig_name}"
  vcn_id = "${oci_core_vcn.oke_vcn.id}"
}

resource "oci_core_default_route_table" "default_routetable" {
  manage_default_resource_id = "${oci_core_vcn.oke_vcn.default_route_table_id}"
  display_name               = "${var.dhcp_options_display_name}"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.oke_gateway.id}"
  }
}

resource "oci_core_default_dhcp_options" "default_dhcp_options" {
  manage_default_resource_id = "${oci_core_vcn.oke_vcn.default_dhcp_options_id}"
  display_name               = "${var.rt_display_name}"

  options {
    type = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
}

resource "oci_core_security_list" "sl_workers" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.sl_worker_name}"
  vcn_id = "${oci_core_vcn.oke_vcn.id}"

  egress_security_rules = [
    {
      stateless = "true"
      protocol = "all"
      destination = "${var.cidr_subnet_workers_ad1}"
    },
    {
      stateless = "true"
      protocol = "all"
      destination = "${var.cidr_subnet_workers_ad2}"
    },
    {
      stateless = "true"
      protocol = "all"
      destination = "${var.cidr_subnet_workers_ad3}"
    },
    {
      protocol = "all"
      destination = "0.0.0.0/0"
    }
  ]
  ingress_security_rules = [
    {
      stateless = "true"
      protocol = "all"
      source = "${var.cidr_subnet_workers_ad1}"
    },
    {
      stateless = "true"
      protocol = "all"
      source = "${var.cidr_subnet_workers_ad2}"
    },
    {
      stateless = "true"
      protocol = "all"
      source = "${var.cidr_subnet_workers_ad3}"
    },
    {
      protocol = "1"
      source = "0.0.0.0/0"
      icmp_options {
        #Required
        type = "${var.sl_ingress_icmp_options_type}"

        #Optional
        code = "${var.sl_ingress_icmp_options_code}"
      }
    },
    {
      protocol = "6"
      source = "${var.sl_workers_ingress_ssh_cidr1}"
      tcp_options {
        "max" = 22
        "min" = 22
      }
    },
    {
      protocol = "6"
      source = "${var.sl_workers_ingress_ssh_cidr2}"
      tcp_options {
        "max" = 22
        "min" = 22
      }
    },
    {
      protocol = "6"
      source = "0.0.0.0/0"
      tcp_options {
        "max" = 22
        "min" = 22
      }
    },
    {
      protocol = "6"
      source = "130.35.0.0/16"
      tcp_options {
        "max" = 22
        "min" = 22
      }
    },
    {
      protocol = "6"
      source = "134.70.0.0/17"
      tcp_options {
        "max" = 22
        "min" = 22
      }
    },
    {
      protocol = "6"
      source = "138.1.0.0/16"
      tcp_options {
        "max" = 22
        "min" = 22
      }
    },
    {
      protocol = "6"
      source = "140.91.0.0/17"
      tcp_options {
        "max" = 22
        "min" = 22
      }
    },
    {
      protocol = "6"
      source = "147.154.0.0/16"
      tcp_options {
        "max" = 22
        "min" = 22
      }
    },
    {
      protocol = "6"
      source = "192.29.0.0/16"
      tcp_options {
        "max" = 22
        "min" = 22
      }
    }
  ]
}

resource "oci_core_security_list" "sl_lb" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.sl_lb_name}"
  vcn_id = "${oci_core_vcn.oke_vcn.id}"
  egress_security_rules = [
    {
      stateless = "true"
      destination = "0.0.0.0/0"
      protocol = "6"
    }
  ]
  ingress_security_rules = [
    {
      stateless = "true"
      protocol = "6"
      source = "0.0.0.0/0"
    }
  ]
}


resource "oci_core_subnet" "workers_ad1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${var.cidr_subnet_workers_ad1}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.oke_vcn.id}"
  display_name        = "${var.subnet_workers_ad1_name}"
  security_list_ids   = ["${oci_core_security_list.sl_workers.id}"]
  route_table_id      = "${oci_core_default_route_table.default_routetable.id}"
  dhcp_options_id     = "${oci_core_default_dhcp_options.default_dhcp_options.id}"
  dns_label           = "${var.subnet_workers_ad1_dns}"
}


resource "oci_core_subnet" "workers_ad2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${var.cidr_subnet_workers_ad2}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.oke_vcn.id}"
  display_name        = "${var.subnet_workers_ad2_name}"
  security_list_ids   = ["${oci_core_security_list.sl_workers.id}"]
  route_table_id      = "${oci_core_default_route_table.default_routetable.id}"
  dhcp_options_id     = "${oci_core_default_dhcp_options.default_dhcp_options.id}"
  dns_label           = "${var.subnet_workers_ad2_dns}"
}

resource "oci_core_subnet" "workers_ad3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "${var.cidr_subnet_workers_ad3}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.oke_vcn.id}"
  display_name        = "${var.subnet_workers_ad3_name}"
  security_list_ids   = ["${oci_core_security_list.sl_workers.id}"]
  route_table_id      = "${oci_core_default_route_table.default_routetable.id}"
  dhcp_options_id     = "${oci_core_default_dhcp_options.default_dhcp_options.id}"
  dns_label           = "${var.subnet_workers_ad3_dns}"
}

resource "oci_core_subnet" "loadbalancers_ad1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${var.cidr_subnet_lb_ad1}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.oke_vcn.id}"
  display_name        = "${var.subnet_lb_ad1_name}"
  security_list_ids   = ["${oci_core_security_list.sl_lb.id}"]
  route_table_id      = "${oci_core_default_route_table.default_routetable.id}"
  dhcp_options_id     = "${oci_core_default_dhcp_options.default_dhcp_options.id}"
  dns_label           = "${var.subnet_lb_ad1_dns}"
}

resource "oci_core_subnet" "loadbalancers_ad2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${var.cidr_subnet_lb_ad2}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.oke_vcn.id}"
  display_name        = "${var.subnet_lb_ad2_name}"
  security_list_ids   = ["${oci_core_security_list.sl_lb.id}"]
  route_table_id      = "${oci_core_default_route_table.default_routetable.id}"
  dhcp_options_id     = "${oci_core_default_dhcp_options.default_dhcp_options.id}"
  dns_label           = "${var.subnet_lb_ad2_dns}"
}

