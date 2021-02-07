variable "resource_group_name" {
  description = <<EOT
The name of the resource group in which to create the network security group.
The Resource Group must already exist.
EOT
  type        = string
}

variable "tags" {
  description = "A mapping of tags which should be assigned to Resources."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = <<EOT
The name of the network security group.
Changing this forces a new resource to be created.
EOT
  type        = string
}
