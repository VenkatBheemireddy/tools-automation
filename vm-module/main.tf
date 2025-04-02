resource "azurerm_public_ip" "main" {
  name                = "${var.component}-ip"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.component}-nic"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.component}-nsg"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"  # Port-22 must be opened
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = var.component
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8200"  #var.port  # This code is to open port 8200
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_dns_a_record" "private" {
  name                = "${var.component}-internal"
  zone_name           = "azdevopsv82.online"
  resource_group_name = data.azurerm_resource_group.main.name
  ttl                 = 10
  records             = [azurerm_network_interface.main.private_ip_address]
}

resource "azurerm_dns_a_record" "public" {
  name                = var.component
  zone_name           = "azdevopsv82.online"
  resource_group_name = data.azurerm_resource_group.main.name
  ttl                 = 300
  records             = [azurerm_public_ip.main.ip_address]
  #target_resource_id  = azurerm_public_ip.main.id
}

resource "azurerm_virtual_machine" "main" {
  depends_on            = [azurerm_network_interface_security_group_association.main, azurerm_dns_a_record.private, azurerm_dns_a_record.public]
  name                  = var.component
  location              = data.azurerm_resource_group.main.location
  resource_group_name   = data.azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_B2s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disk automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = "/subscriptions/9af0e83a-d3ee-4c3c-a244-3274a3457024/resourceGroups/project-setup-1/providers/Microsoft.Compute/galleries/CustomPractice/images/CustomImage"
  }

  storage_os_disk {
    name              = var.component
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.component
    admin_username = var.ssh_username
    admin_password = var.ssh_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}