output "resource_id" {
  description = "The resource ID of the Linux Web App."
  value       = azurerm_linux_web_app.backend.id

  # The whole resource object was returned here previously, which exported
  # sensitive attributes such as site_credential and is rejected outright by
  # newer Terraform and OpenTofu.
}

output "update_commands" {
  description = "The AZ CLI command to update the Web App."
  value       = "az webapp deploy -g '${local.resource_group_name}' -n '${azurerm_linux_web_app.backend.name}' --src-path binaries.zip \naz webapp restart --resource-group '${local.resource_group_name}' --name '${azurerm_linux_web_app.backend.name}'"
}
