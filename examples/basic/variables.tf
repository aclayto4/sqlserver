variable "serverless" {
  description = "Indicates whether the database should be serverless."
  type        = bool
  default     = true
}

variable "zone_redundant" {
  description = "Indicates whether the database should be zone redundant."
  type        = bool
  default     = true
}

variable "sku_name" {
  description = "The SKU name for the database."
  type        = string
  default     = "GP_S_Gen5_2"
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "name" {
  description = "The name of the SQL server."
  type        = string
}

variable "location" {
  description = "The location for the resources."
  type        = string
}

variable "server_version" {
  description = "The version of the SQL server."
  type        = string
}

variable "login_username" {
  description = "The username for the SQL server."
  type        = string
}

variable "private_endpoint_name" {
  description = "The name of the private endpoint."
  type        = string
}

variable "database_name" {
  description = "The name of the database."
  type        = string
}