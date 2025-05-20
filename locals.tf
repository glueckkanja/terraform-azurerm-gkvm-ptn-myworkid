locals {
  allow_credential_operations_for_privileged_users = var.allow_credential_operations_for_privileged_users
  api_name                                         = var.api_name
  backend_access_groups_map = {
    "CreateTAP" = {
      group_name = var.backend_access_group_names.create_tap
      app_role   = local.create_tap_app_role_name
    }
    "DismissUserRisk" = {
      group_name = var.backend_access_group_names.dismiss_user_risk
      app_role   = local.dismiss_user_risk_app_role_name
    }
    "PasswordReset" = {
      group_name = var.backend_access_group_names.password_reset
      app_role   = local.password_reset_app_role_name
    }
    "ValidateIdentity" = {
      group_name = var.backend_access_group_names.validate_identity
      app_role   = local.validate_identity_app_role_name
    }
  }
  backend_app_role_ids          = var.create_aad_objects ? azuread_application.backend[0].app_role_ids : data.azuread_service_principal.backend[0].app_role_ids
  backend_application_client_id = var.create_aad_objects ? azuread_application.backend[0].client_id : data.azuread_application.backend[0].client_id
  backend_application_id        = var.create_aad_objects ? azuread_application.backend[0].id : data.azuread_application.backend[0].id
  backend_appreg_name           = var.backend_appreg_name
  # Permissions necessary for the backend managed identity
  backend_graph_permissions           = coalescelist(var.backend_graph_permissions, ["IdentityRiskyUser.ReadWrite.All", "CustomSecAttributeAssignment.ReadWrite.All"])
  backend_oauth2_permission_scope_ids = var.create_aad_objects ? azuread_application.backend[0].oauth2_permission_scope_ids.Access : data.azuread_service_principal.backend[0].oauth2_permission_scope_ids.Access
  backend_service_principal_id        = var.create_aad_objects ? azuread_service_principal.backend[0].object_id : data.azuread_service_principal.backend[0].object_id
  base_access_groups_map              = { for k, v in local.backend_access_groups_map : k => v if !var.skip_creation_backend_access_groups && !var.skip_actions_requiring_global_admin }
  create_aad_objects                  = var.create_aad_objects
  create_tap_app_role_name            = "MyWorkID.CreateTAP"
  custom_domains                      = var.custom_domains
  dismiss_user_risk_app_role_name     = "MyWorkID.DismissUserRisk"
  ## Web App App Settings
  dismiss_user_risk_auth_context_id = var.dismiss_user_risk_auth_context_id
  enable_auto_update                = var.enable_auto_update
  frontend_application_client_id    = var.create_aad_objects ? azuread_application_registration.frontend[0].client_id : data.azuread_application.frontend[0].client_id
  frontend_application_id           = var.create_aad_objects ? azuread_application_registration.frontend[0].id : data.azuread_application.frontend[0].id
  ## App Registration Options
  frontend_appreg_name = var.frontend_appreg_name
  # settings that change if in dev
  frontend_dev_redirect_uris    = var.is_dev ? var.dev_redirect_url : []
  frontend_service_principal_id = var.create_aad_objects ? azuread_service_principal.frontend[0].object_id : data.azuread_service_principal.frontend[0].object_id
  generate_tap_auth_context_id  = var.generate_tap_auth_context_id
  insights_retention            = var.insights_retention
  ## Application Insights Options
  insights_sku  = var.insights_sku
  insights_type = var.insights_type
  # Helper properties
  is_custom_domain_configured = length(local.custom_domains) > 0
  kv_purge_protection_enabled = var.kv_purge_protection_enabled
  kv_sku_name                 = var.kv_sku_name
  ## Key Vault Options
  kv_soft_delete_retention_days      = var.kv_soft_delete_retention_days
  latest_binaries_url                = "https://github.com/glueckkanja/MyWorkID/releases/latest/download/binaries.zip"
  password_reset_app_role_name       = "MyWorkID.PasswordReset"
  reset_password_auth_context_id     = var.reset_password_auth_context_id
  resource_group_name                = var.create_resource_group ? azurerm_resource_group.main[0].name : var.resource_group_name
  resource_location                  = var.resource_location
  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"
  service_plan_sku                   = var.service_plan_sku
  ## Service Plan Options
  service_plan_type                   = var.service_plan_os_type
  skip_actions_requiring_global_admin = var.skip_actions_requiring_global_admin
  subscription_id                     = var.subscription_id
  # MyWorkID
  tenant_id                       = var.tenant_id
  validate_identity_app_role_name = "MyWorkID.ValidateIdentity"
  # Static variables
  verified_id_create_presentation_request_uri      = "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/createPresentationRequest"
  verified_id_decentralized_identifier_secret_name = var.verified_id_decentralized_identifier_secret_name
  verified_id_jwt_signing_key_secret_name          = var.verified_id_jwt_signing_key_secret_name
  verified_id_verify_security_attribute            = var.verified_id_verify_security_attribute
  verified_id_verify_security_attribute_set        = var.verified_id_verify_security_attribute_set
  web_app_client_affinity_enabled                  = var.web_app_client_affinity_enabled
  ## Web App Options
  web_app_https_only = var.web_app_https_only
  workspace_id       = var.create_log_analytics_workspace ? azurerm_log_analytics_workspace.backend_application_insights[0].id : var.workspace_id
}
