data "azurerm_client_config" "current" {}

data "azurerm_subnet" "sql_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

module "naming" {
  source  = "Azure/naming/azurerm"
  
}

module "sql_server" {
  source  = "Azure/avm-res-sql-server/azurerm"
  version = "0.1.5"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_version      = var.server_version
  databases           = local.databases
  azuread_administrator = {
    azuread_authentication_only = true
    login_username              = var.login_username
    object_id                   = data.azurerm_client_config.current.object_id
    tenant_id                   = data.azurerm_client_config.current.tenant_id
  }

  private_endpoints = {
    primary = {
      name               = var.private_endpoint_name
      subnet_resource_id = data.azurerm_subnet.sql_subnet.id
      subresource_name   = "sqlServer"
    }
  }
  enable_telemetry = false
}


locals {
  databases = {
    for db_name, db in var.databases : db_name => {
      name                        = db.name
      create_mode                 = db.create_mode
      collation                   = db.collation
      license_type                = db.serverless ? null : "LicenseIncluded"
      max_size_gb                 = db.max_size_gb
      zone_redundant              = lookup(db, "zone_redundant", true)
      sku_name                    = lookup(db, "sku_name", "GP_S_Gen5_2")
      min_capacity                = db.min_capacity
      auto_pause_delay_in_minutes = db.auto_pause_delay_in_minutes

      short_term_retention_policy = {
        retention_days           = db.short_term_retention_policy.retention_days
        backup_interval_in_hours = db.short_term_retention_policy.backup_interval_in_hours
      }

      long_term_retention_policy = lookup(db, "long_term_retention_policy", null)
    }
  }
}
