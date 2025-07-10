output "sql_server_id" {
  description = "The ID of the SQL Server."
  value       = module.sql_server.resource.id
}

output "sql_server_fqdn" {
  description = "The fully qualified domain name of the SQL Server."
  value       = module.sql_server.resource.fully_qualified_domain_name
}
