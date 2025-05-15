resource "azurerm_resource_group" "main" {
  count = var.create_resource_group ? 1 : 0

  name     = var.resource_group_name
  location = local.resource_location

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create app service plan for backend API
resource "azurerm_service_plan" "backend" {
  name                = "asp-${local.api_name}"
  location            = local.resource_location
  resource_group_name = local.resource_group_name
  os_type             = local.service_plan_type
  sku_name            = local.service_plan_sku

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_log_analytics_workspace" "backend_application_insights" {
  count = var.create_log_analytics_workspace ? 1 : 0

  name                = "wsp-${local.api_name}"
  location            = local.resource_location
  resource_group_name = local.resource_group_name
  sku                 = local.insights_sku
  retention_in_days   = local.insights_retention

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_application_insights" "backend" {
  name                = "ai-${local.api_name}"
  location            = local.resource_location
  resource_group_name = local.resource_group_name
  workspace_id        = local.workspace_id
  application_type    = local.insights_type

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_linux_web_app" "backend" {
  name                    = local.api_name
  location                = local.resource_location
  resource_group_name     = local.resource_group_name
  service_plan_id         = azurerm_service_plan.backend.id
  https_only              = local.web_app_https_only
  client_affinity_enabled = local.web_app_client_affinity_enabled

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
    minimum_tls_version = "1.2"
    always_on           = true
  }

  app_settings = {
    AppFunctions__DismissUserRisk              = local.dismiss_user_risk_auth_context_id
    AppFunctions__GenerateTap                  = local.generate_tap_auth_context_id
    AppFunctions__ResetPassword                = local.reset_password_auth_context_id
    AzureAd__ClientId                          = local.backend_application_client_id
    AzureAd__TenantId                          = data.azuread_client_config.current_user.tenant_id
    AzureAd__Instance                          = "https://login.microsoftonline.com/"
    Frontend__FrontendClientId                 = local.frontend_application_client_id
    Frontend__BackendClientId                  = local.backend_application_client_id
    Frontend__TenantId                         = data.azuread_client_config.current_user.tenant_id
    WEBSITE_RUN_FROM_PACKAGE                   = local.enable_auto_update ? local.latest_binaries_url : "1"
    APPLICATIONINSIGHTS_CONNECTION_STRING      = azurerm_application_insights.backend.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3"          #https://learn.microsoft.com/en-us/azure/azure-monitor/app/azure-web-apps-net-core?tabs=Windows%2Cwindows#application-settings-definitions
    XDT_MicrosoftApplicationInsights_Mode      = "recommended" #https://learn.microsoft.com/en-us/azure/azure-monitor/app/azure-web-apps-net-core?tabs=Windows%2Cwindows#application-settings-definitions
    VerifiedId__JwtSigningKey                  = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.backend_secrets.name};SecretName=${local.verified_id_jwt_signing_key_secret_name})"
    VerifiedId__DecentralizedIdentifier        = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.backend_secrets.name};SecretName=${local.verified_id_decentralized_identifier_secret_name})"
    VerifiedId__TargetSecurityAttributeSet     = local.verified_id_verify_security_attribute_set
    VerifiedId__TargetSecurityAttribute        = local.verified_id_verify_security_attribute
    VerifiedId__BackendUrl                     = local.is_custom_domain_configured ? "https://${local.custom_domains[0]}" : "https://${local.api_name}.azurewebsites.net"
    VerifiedId__CreatePresentationRequestUri   = local.verified_id_create_presentation_request_uri
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Key vault
resource "azurerm_key_vault" "backend_secrets" {
  name                        = substr("kv-${local.api_name}", 0, 24)
  location                    = local.resource_location
  resource_group_name         = local.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = local.tenant_id
  soft_delete_retention_days  = local.kv_soft_delete_retention_days
  purge_protection_enabled    = local.kv_purge_protection_enabled
  enable_rbac_authorization   = true
  sku_name                    = local.kv_sku_name

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "backend_key_vault_access" {
  depends_on           = [time_sleep.wait_30_seconds_after_user_assigned_identity_creation]
  scope                = azurerm_key_vault.backend_secrets.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_web_app.backend.identity[0].principal_id
}

# AVM
resource "azurerm_role_assignment" "this" {
  for_each = var.role_assignments

  principal_id                           = each.value.principal_id
  scope                                  = azurerm_linux_web_app.backend.id
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  principal_type                         = each.value.principal_type
  role_definition_id                     = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? each.value.role_definition_id_or_name : null
  role_definition_name                   = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? null : each.value.role_definition_id_or_name
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}

resource "azurerm_management_lock" "this" {
  count = var.lock != null ? 1 : 0

  lock_level = var.lock.kind
  name       = coalesce(var.lock.name, "lock-${var.lock.kind}")
  scope      = format("/subscriptions/%s/resourceGroups/%s", local.subscription_id, local.resource_group_name)
  notes      = var.lock.kind == "CanNotDelete" ? "Cannot delete the resource or its child resources." : "Cannot delete or modify the resource or its child resources."
}


resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = var.diagnostic_settings

  name                           = each.value.name != null ? each.value.name : "diag-${local.api_name}"
  target_resource_id             = azurerm_linux_web_app.backend.id
  eventhub_authorization_rule_id = each.value.event_hub_authorization_rule_resource_id
  eventhub_name                  = each.value.event_hub_name
  log_analytics_destination_type = each.value.log_analytics_destination_type
  log_analytics_workspace_id     = each.value.workspace_resource_id
  partner_solution_id            = each.value.marketplace_partner_resource_id
  storage_account_id             = each.value.storage_account_resource_id

  dynamic "enabled_log" {
    for_each = each.value.log_categories

    content {
      category = enabled_log.value
    }
  }
  dynamic "enabled_log" {
    for_each = each.value.log_groups

    content {
      category_group = enabled_log.value
    }
  }
  dynamic "metric" {
    for_each = each.value.metric_categories

    content {
      category = metric.value
    }
  }
}
