locals {
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-oke-cluster"
  }
  merged_freeform_tags = merge(var.freeform_tags, local.default_freeform_tags)
}

module "node_pool" {
  source = "git@github.com:andresmonteal/terraform-oci-oke-node-pool.git?ref=v0.1.0"

  for_each = var.node_pool

  cluster_id      = oci_containerengine_cluster.main.id
  tenancy_ocid    = var.tenancy_ocid
  compartment_id  = var.compartment_id
  node_pool_name  = each.key
  node_pool_shape = each.value["shape"]

  defined_tags                 = var.defined_tags
  node_pool_kubernetes_version = var.cluster_kubernetes_version
  ssh_public_key               = base64decode(data.oci_secrets_secretbundle.bundle[each.key].secret_bundle_content.0.content)

  shape_memory = each.value["memory"]
  shape_ocpus  = each.value["ocpu"]

  subnet_id = data.oci_core_subnets.subnets[each.key].subnets[0].id

  placement_configs = each.value["placement_configs"]
  node_pool_size    = each.value["size"]

  node_pool_image_id = each.value["image_id"]
}