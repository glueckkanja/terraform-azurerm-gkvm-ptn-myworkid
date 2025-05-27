terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  subscription_id                 = var.subscription_id
  use_oidc                        = true
  features {}
}

data "azurerm_client_config" "current" {}

module "myworkid" {
  source = "git::https://github.com/glueckkanja/terraform-azurerm-gkvm-ptn-myworkid.git?ref=v0.1.0"

  api_name                                         = var.api_name
  dismiss_user_risk_auth_context_id                = var.dismiss_user_risk_auth_context_id
  generate_tap_auth_context_id                     = var.generate_tap_auth_context_id
  reset_password_auth_context_id                   = var.reset_password_auth_context_id
  subscription_id                                  = var.subscription_id
  tenant_id                                        = data.azurerm_client_config.current.tenant_id
  allow_credential_operations_for_privileged_users = var.allow_credential_operations_for_privileged_users
  backend_access_group_names                       = var.backend_access_group_names
  backend_application_object_id                    = var.backend_application_object_id
  backend_appreg_name                              = var.backend_appreg_name
  backend_graph_permissions                        = var.backend_graph_permissions
  backend_service_principal_object_id              = var.backend_service_principal_object_id
  create_aad_objects                               = var.create_aad_objects
  create_log_analytics_workspace                   = var.create_log_analytics_workspace
  create_resource_group                            = var.create_resource_group
  custom_domains                                   = var.custom_domains
  dev_redirect_url                                 = var.dev_redirect_url
  diagnostic_settings                              = var.diagnostic_settings
  enable_auto_update                               = var.enable_auto_update
  enable_telemetry                                 = var.enable_telemetry
  frontend_application_object_id                   = var.frontend_application_object_id
  frontend_appreg_name                             = var.frontend_appreg_name
  frontend_service_principal_object_id             = var.frontend_service_principal_object_id
  insights_retention                               = var.insights_retention
  insights_sku                                     = var.insights_sku
  insights_type                                    = var.insights_type
  is_dev                                           = var.is_dev
  kv_purge_protection_enabled                      = var.kv_purge_protection_enabled
  kv_sku_name                                      = var.kv_sku_name
  kv_soft_delete_retention_days                    = var.kv_soft_delete_retention_days
  lock                                             = var.lock
  resource_group_name                              = var.resource_group_name
  resource_location                                = var.resource_location
  role_assignments                                 = var.role_assignments
  service_plan_os_type                             = var.service_plan_os_type
  service_plan_sku                                 = var.service_plan_sku
  skip_actions_requiring_global_admin              = var.skip_actions_requiring_global_admin
  skip_creation_backend_access_groups              = var.skip_creation_backend_access_groups
  tags                                             = var.tags
  verified_id_decentralized_identifier_secret_name = var.verified_id_decentralized_identifier_secret_name
  verified_id_jwt_signing_key_secret_name          = var.verified_id_jwt_signing_key_secret_name
  verified_id_verify_security_attribute            = var.verified_id_verify_security_attribute
  verified_id_verify_security_attribute_set        = var.verified_id_verify_security_attribute_set
  web_app_client_affinity_enabled                  = var.web_app_client_affinity_enabled
  web_app_https_only                               = var.web_app_https_only
  workspace_id                                     = var.workspace_id
}
