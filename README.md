# terraform-azurerm-network-security-group

Terraform module to create Azure Network Security Group.
This module also validates the name according to the Azure Resource naming restrictions.

This module is inspired on the work from [this](https://github.com/Azure/terraform-azurerm-network-security-group) repository.

## Usage

```hcl:examples/firewall_rules/main.tf
provider "azurerm" {
  features {}
}

module "rg" {
  source  = "bcochofel/resource-group/azurerm"
  version = "1.4.0"

  name     = "rg-nsg-firewall-rules-example"
  location = "North Europe"
}

module "nsg" {
  source = "../.."

  name                = "nsg-firewall-rules-example"
  resource_group_name = module.rg.name

  predefined_rules = [
    {
      name     = "SSH"
      priority = "500"
    },
    {
      name = "HTTPS"
    }
  ]

  custom_rules = [
    {
      name                   = "myssh"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "22"
      source_address_prefix  = "10.151.0.0/24"
      description            = "description-myssh"
    },
    {
      name                    = "myhttp"
      priority                = 200
      direction               = "Inbound"
      access                  = "Allow"
      protocol                = "tcp"
      source_port_range       = "*"
      destination_port_range  = "8080"
      source_address_prefixes = ["10.151.0.0/24", "10.151.1.0/24"]
      description             = "description-http"
    },
  ]

  depends_on = [module.rg]
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| azurerm | >= 2.41.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.41.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) |
| [azurerm_network_security_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| custom\_rules | Security rules for the network security group using this format:<br>  name = [<br>    priority,<br>    direction,<br>    access,<br>    protocol,<br>    source\_port\_range,<br>    destination\_port\_range,<br>    source\_address\_prefix,<br>    destination\_address\_prefix,<br>    description<br>  ] | `any` | `[]` | no |
| destination\_address\_prefix | Destination address prefix to be applied to all predefined rules<br>list(string) only allowed one element (CIDR, `*`, source IP range or Tags)<br>Example ["10.0.3.0/24"] or ["VirtualNetwork"] | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| destination\_address\_prefixes | Destination address prefix to be applied to all predefined rules<br>Example ["10.0.3.0/32","10.0.3.128/32"] | `list(string)` | `null` | no |
| name | The name of the network security group.<br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| predefined\_rules | Predefined rules | `any` | `[]` | no |
| resource\_group\_name | The name of the resource group in which to create the network security group.<br>The Resource Group must already exist. | `string` | n/a | yes |
| rules | Standard set of predefined rules using this format:<br>  name = [<br>    direction,<br>    access,<br>    protocol,<br>    source\_port\_range,<br>    destination\_port\_range,<br>    description<br>  ]<br><br>This variable is used to set the predefined rules. | `map(any)` | <pre>{<br>  "FTP": [<br>    "Inbound",<br>    "Allow",<br>    "TCP",<br>    "*",<br>    "21",<br>    "FTP"<br>  ],<br>  "HTTP": [<br>    "Inbound",<br>    "Allow",<br>    "TCP",<br>    "*",<br>    "80",<br>    "HTTP"<br>  ],<br>  "HTTPS": [<br>    "Inbound",<br>    "Allow",<br>    "TCP",<br>    "*",<br>    "443",<br>    "HTTPS"<br>  ],<br>  "RDP": [<br>    "Inbound",<br>    "Allow",<br>    "TCP",<br>    "*",<br>    "3389",<br>    "RDP"<br>  ],<br>  "SSH": [<br>    "Inbound",<br>    "Allow",<br>    "TCP",<br>    "*",<br>    "22",<br>    "SSH"<br>  ],<br>  "WinRM": [<br>    "Inbound",<br>    "Allow",<br>    "TCP",<br>    "*",<br>    "5986",<br>    "WinRM"<br>  ]<br>}</pre> | no |
| source\_address\_prefix | Source address prefix to be applied to all predefined rules<br>list(string) only allowed one element (CIDR, `*`, source IP range or Tags)<br>Example ["10.0.3.0/24"] or ["VirtualNetwork"] | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| source\_address\_prefixes | Destination address prefix to be applied to all predefined rules<br>Example ["10.0.3.0/32","10.0.3.128/32"] | `list(string)` | `null` | no |
| tags | A mapping of tags which should be assigned to Resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| firewall\_rules | Firewall Rules in this NSG. |
| id | The network security group id. |
| location | The location/region where the network security group is created. |
| name | The network security group name. |
| resource\_group\_name | The name of the resource group where the network security group is created. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Run tests

```bash
cd test/
go test -v
```

## pre-commit hooks

This repository uses [pre-commit](https://pre-commit.com/).

To install execute:

```bash
pre-commit install --install-hooks -t commit-msg
```

To run the hooks you need to install:

* [terraform](https://github.com/hashicorp/terraform)
* [terraform-docs](https://github.com/terraform-docs/terraform-docs)
* [TFLint](https://github.com/terraform-linters/tflint)
* [TFSec](https://github.com/tfsec/tfsec)
* [checkov](https://github.com/bridgecrewio/checkov)

## References

* [Azure Resource naming restrictions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)
* [Azure Network Security Group Overview](https://docs.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
* [Terraform azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)
* [Terraform azurerm_network_security_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule)
