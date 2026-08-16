module "rg" {
  source = "../Child_Module/azurerm_resource_group"

  resource_group = var.resource_group
}

module "virtual_network" {
  source          = "../Child_Module/azurerm_virtual_network"
  depends_on      = [module.rg]
  virtual_network = var.virtual_network
}

module "subnet" {
  source     = "../Child_Module/azurerm_subnet"
  depends_on = [module.rg, module.virtual_network]
  subnet     = var.subnets
}

module "key_vault" {
  source     = "../Child_Module/azurerm_KeyVault"
  depends_on = [module.rg]
  key_vaults = var.key_vaults
}

module "nsg" {
  source     = "../Child_Module/azurerm_network_securitygroup"
  depends_on = [module.rg]
  nsgs       = var.nsgs
}

module "public_ip" {
  source     = "../Child_Module/azurerm_public_ip"
  depends_on = [module.rg]
  public_ips = var.public_ips
}

module "virtual_machine" {
  source           = "../Child_Module/azurerm_virtual_machine"
  depends_on       = [module.rg, module.virtual_network, module.subnet, module.public_ip]
  virtual_machines = var.virtual_machines
}