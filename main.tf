
locals {
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-oke-node-pool"
  }
  merged_freeform_tags = merge(var.freeform_tags, local.default_freeform_tags)
  ADs = [
    // Iterate through data.oci_identity_availability_domains.ad and create a list containing AD names
    for i in data.oci_identity_availability_domains.ad.availability_domains : i.name
  ]
}

# This resource provides the Node Pool resource in Oracle Cloud Infrastructure Container Engine service.
resource "oci_containerengine_node_pool" "main" {
  #Required
  cluster_id     = var.cluster_id
  compartment_id = var.compartment_id
  name           = var.node_pool_name
  node_shape     = var.node_pool_shape

  #Optional
  defined_tags       = var.defined_tags
  freeform_tags      = local.merged_freeform_tags
  kubernetes_version = var.node_pool_kubernetes_version
  ssh_public_key     = var.ssh_public_key

  node_shape_config {
    #Optional
    memory_in_gbs = var.shape_memory
    ocpus         = var.shape_ocpus
  }

  node_config_details {
    dynamic "placement_configs" {
      for_each = range(var.placement_configs)

      content {
        availability_domain = can(placement_configs.key) ? element(local.ADs, placement_configs.key) : element(local.ADs, 0)
        subnet_id           = var.subnet_id
      }
    }
    #Required
    size          = var.node_pool_size
    defined_tags  = var.defined_tags
    freeform_tags = local.merged_freeform_tags
  }

  node_source_details {
    image_id    = var.node_pool_image_id
    source_type = "IMAGE"
  }
}