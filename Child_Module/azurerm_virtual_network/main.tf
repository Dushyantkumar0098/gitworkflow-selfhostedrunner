resource "azurerm_virtual_network" "vnet1" {
  for_each            = var.virtual_network
  name                = each.value.name
  location            = each.value.location
  resource_group_name = lookup(each.value, "resource_group_name", lookup(each.value, "resource_group", null))
  address_space       = each.value.address_space
}
