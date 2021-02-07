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

variable "predefined_rules" {
  description = "Predefined rules"
  type        = any
  default     = []
}

# Custom security rules
# [priority, direction, access, protocol, source_port_range, destination_port_range, description]"
# All the fields are required.
variable "custom_rules" {
  description = <<EOT
Security rules for the network security group using this format:
  name = [
    priority,
    direction,
    access,
    protocol,
    source_port_range,
    destination_port_range,
    source_address_prefix,
    destination_address_prefix,
    description
  ]
EOT
  type        = any
  default     = []
}

variable "rules" {
  description = <<EOT
Standard set of predefined rules using this format:
  name = [
    direction,
    access,
    protocol,
    source_port_range,
    destination_port_range,
    description
  ]

This variable is used to set the predefined rules.
EOT
  type        = map(any)

  default = {
    #FTP
    FTP = ["Inbound", "Allow", "TCP", "*", "21", "FTP"]

    #HTTP
    HTTP = ["Inbound", "Allow", "TCP", "*", "80", "HTTP"]

    #HTTPS
    HTTPS = ["Inbound", "Allow", "TCP", "*", "443", "HTTPS"]

    #RDP
    RDP = ["Inbound", "Allow", "TCP", "*", "3389", "RDP"]

    #SSH
    SSH = ["Inbound", "Allow", "TCP", "*", "22", "SSH"]

    #WinRM
    WinRM = ["Inbound", "Allow", "TCP", "*", "5986", "WinRM"]
  }
}
