resource_group = {
  rg1 = {
    name     = "rg-tinki"
    location = "East US"
  }

  rg2 = {
    name     = "rg-rinki"
    location = "West US"
  }

  rg3 = {
    name     = "rg-chinki"
    location = "West US"
  }
}


virtual_network = {
  vnet = {
    name                = "dlink"
    location            = "eastus"
    resource_group_name = "rg-tinki"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  frontend_sub = {
    name                 = "frontend-sub"
    resource_group_name  = "rg-tinki"
    virtual_network_name = "dlink"
    address_prefixes     = ["10.0.1.0/24"]
  }

  backend_sub = {
    name                 = "backend-sub"
    resource_group_name  = "rg-tinki"
    virtual_network_name = "dlink"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

key_vaults = {
  kv1 = {
    name                        = "kv-devops-tinki-12345"
    location                    = "East US"
    resource_group_name         = "rg-tinki"
    sku_name                    = "standard"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    enabled_for_disk_encryption = true
  }
}

nsgs = {
  nsg_frontend = {
    name                = "nsg-frontend"
    location            = "East US"
    resource_group_name = "rg-tinki"
    security_rules = [
      {
        name                       = "HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg_backend = {
    name                = "nsg-backend"
    location            = "East US"
    resource_group_name = "rg-tinki"
    security_rules = [
      {
        name                       = "SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

public_ips = {
  frontend_pip = {
    name                = "pip-frontend"
    location            = "East US"
    resource_group_name = "rg-tinki"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  backend_pip = {
    name                = "pip-backend"
    location            = "East US"
    resource_group_name = "rg-tinki"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

virtual_machines = {
  frontend_vm = {
    nic_name             = "nic-frontend"
    vm_name              = "vm-frontend"
    public_ip_name       = "pip-frontend"
    location             = "East US"
    resource_group_name  = "rg-tinki"
    virtual_network_name = "dlink"
    subnet_name          = "frontend-sub"
    size                 = "Standard_F2"
    admin_username       = "adminuser"
    admin_password       = "P@ssw0rd1234!"
  }

  backend_vm = {
    nic_name             = "nic-backend"
    vm_name              = "vm-backend"
    public_ip_name       = "pip-backend"
    location             = "East US"
    resource_group_name  = "rg-tinki"
    virtual_network_name = "dlink"
    subnet_name          = "backend-sub"
    size                 = "Standard_F2"
    admin_username       = "adminuser"
    admin_password       = "P@ssw0rd1234!"
  }
}