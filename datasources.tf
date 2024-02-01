data "oci_identity_availability_domains" "ad" {
  compartment_id = var.tenancy_ocid
}

data "oci_identity_compartments" "network" {
  count = var.network_cmp == null ? 0 : 1
  #Required
  compartment_id            = var.tenancy_ocid
  access_level              = "ANY"
  compartment_id_in_subtree = true

  #Optional
  filter {
    name   = "state"
    values = ["ACTIVE"]
  }

  filter {
    name   = "name"
    values = [var.network_cmp]
  }
}

data "oci_core_subnets" "subnet" {
  count = var.subnet == null ? 0 : 1
  #Required
  compartment_id = local.network_cmp_id

  #Optional
  display_name = var.subnet
}