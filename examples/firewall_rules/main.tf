provider "azurerm" {
  features {}
}

module "rg" {
  source  = "bcochofel/resource-group/azurerm"
  version = "1.2.0"

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
      name     = "HTTPS"
      priority = "501"
    }
  ]

  depends_on = [module.rg]
}
