# terraform-azurerm-network-security-group

Terraform module to create Azure Network Security Group.

This module is inspired on the work from [this](https://github.com/Azure/terraform-azurerm-network-security-group) repository.

## Usage

```hcl:examples/basic/main.tf
provider "azurerm" {
  features {}
}

module "rg" {
  source  = "bcochofel/resource-group/azurerm"
  version = "1.2.0"

  name     = "rg-nsg-basic-example"
  location = "North Europe"
}

module "nsg" {
  source = "../.."

  name                = "nsg-basic-example"
  resource_group_name = module.rg.name

  depends_on = [module.rg]
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name      | Version    |
| --------- | ---------- |
| terraform | >= 0.12.20 |
| azurerm   | >= 2.41.0  |

## Providers

| Name    | Version   |
| ------- | --------- |
| azurerm | >= 2.41.0 |

## Inputs

| Name                  | Description                                                                                                             | Type          | Default | Required |
| --------------------- | ----------------------------------------------------------------------------------------------------------------------- | ------------- | ------- | :------: |
| name                  | The name of the network security group.<br>Changing this forces a new resource to be created.                           | `string`      | n/a     |   yes    |
| resource\_group\_name | The name of the resource group in which to create the network security group.<br>The Resource Group must already exist. | `string`      | n/a     |   yes    |
| tags                  | A mapping of tags which should be assigned to Resources.                                                                | `map(string)` | `{}`    |    no    |

## Outputs

| Name                  | Description                                                                 |
| --------------------- | --------------------------------------------------------------------------- |
| id                    | The network security group id.                                              |
| location              | The location/region where the network security group is created.            |
| name                  | The network security group name.                                            |
| resource\_group\_name | The name of the resource group where the network security group is created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Run tests

```bash
cd test/
go test -v
```

## References

* [Azure Network Security Group Overview](https://docs.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
* [Terraform azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)
* [Terraform azurerm_network_security_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule)
