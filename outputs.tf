output "resource_id" {
  description = "The ID of Linux Web App"
  value       = azurerm_linux_web_app.backend
}

output "update_commands" {
  description = "The AZ CLI command to update the Web App."
  value       = "az webapp deploy -g '${local.resource_group_name}' -n '${azurerm_linux_web_app.backend.name}' --src-path binaries.zip \naz webapp restart --resource-group '${local.resource_group_name}' --name '${azurerm_linux_web_app.backend.name}'"
}
