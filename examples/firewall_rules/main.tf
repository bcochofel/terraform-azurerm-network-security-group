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
