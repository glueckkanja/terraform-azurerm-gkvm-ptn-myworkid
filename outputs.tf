output "update_commands" {
  value = "az webapp deploy -g '${local.resource_group_name}' -n '${azurerm_linux_web_app.backend.name}' --src-path binaries.zip \naz webapp restart --resource-group '${local.resource_group_name}' --name '${azurerm_linux_web_app.backend.name}'"
}
