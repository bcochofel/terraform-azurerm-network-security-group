provider "azurerm" {
  features {}
}

module "rg" {
  source  = "bcochofel/resource-group/azurerm"
  version = "1.4.0"

  name     = "rg-nsg-basic-example"
  location = "North Europe"
}

module "nsg" {
  source = "../.."

  name                = "nsg-basic-example"
  resource_group_name = module.rg.name

  depends_on = [module.rg]
}
