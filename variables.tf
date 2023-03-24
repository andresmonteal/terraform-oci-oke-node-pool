variable "tenancy_ocid" {
  description = "(Required) The OCID of the root compartment."
  type        = string
}

variable "compartment_id" {
  description = "(Required) The OCID of the compartment in which to create the cluster."
  type        = string
}

variable "cluster_id" {
  description = "The OCID of the cluster to which this node pool is attached."
  type        = string
}

variable "node_pool_name" {
  description = "(Required) (Updatable) The name of the node pool. Avoid entering confidential information."
  type        = string
}

variable "node_pool_shape" {
  description = "(Required) (Updatable) The name of the node shape of the nodes in the node pool."
  type        = string
}

# optional
variable "freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace."
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace."
  type        = map(string)
  default     = {}
}

variable "node_pool_kubernetes_version" {
  description = "(Optional) (Updatable) The version of Kubernetes to install on the nodes in the node pool."
  type        = string
  default     = null
}

variable "ssh_public_key" {
  description = "(Optional) (Updatable) The SSH public key on each node in the node pool on launch."
  type        = string
  default     = null
}

variable "shape_memory" {
  description = "(Optional) (Updatable) The total amount of memory available to each node, in gigabytes."
  type        = string
  default     = null
}

variable "shape_ocpus" {
  description = "(Optional) (Updatable) The total number of OCPUs available to each node in the node pool. See here for details."
  type        = string
  default     = null
}

variable "placement_configs" {
  description = "The placement configurations for the node pool. Provide one placement configuration for each availability domain in which you intend to launch a node."
  type        = number
  default     = 1
}

variable "node_pool_size" {
  description = "(Required) (Updatable) The number of nodes that should be in the node pool."
  type        = string
  default     = null
}

variable "node_pool_image_id" {
  description = "(Required) (Updatable) The OCID of the image used to boot the node."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "(Required) The OCID of the compartment in which to create the cluster."
  type        = string
}