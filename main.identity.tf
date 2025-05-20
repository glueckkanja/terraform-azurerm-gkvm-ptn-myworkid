resource "azuread_app_role_assignment" "backend_managed_identity" {
  for_each = local.skip_actions_requiring_global_admin ? toset([]) : toset(local.backend_graph_permissions)

  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids[each.key]
  principal_object_id = azurerm_linux_web_app.backend.identity[0].principal_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}

# Necessary for the backend to be able to create taps and change the password of users - The password cannot be changed for users with some privilaged permissions - if it is desired to change the password of users with these permissions, the backend must have higher roles - for more info see https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/privileged-roles-permissions?tabs=admin-center#who-can-reset-passwords and https://learn.microsoft.com/en-us/entra/identity/authentication/howto-authentication-temporary-access-pass#create-a-temporary-access-pass
resource "azuread_directory_role" "authentication_administrator" {
  count = local.skip_actions_requiring_global_admin ? 0 : 1

  display_name = local.allow_credential_operations_for_privileged_users ? "Privileged Authentication Administrator" : "Authentication Administrator"
}

resource "time_sleep" "wait_30_seconds_after_user_assigned_identity_creation" {
  create_duration = "30s"

  depends_on = [azurerm_linux_web_app.backend]
}

resource "azuread_directory_role_assignment" "backend_managed_identity_authentication_administrator" {
  count = local.skip_actions_requiring_global_admin ? 0 : 1

  principal_object_id = azurerm_linux_web_app.backend.identity[0].principal_id
  role_id             = azuread_directory_role.authentication_administrator[0].template_id

  depends_on = [time_sleep.wait_30_seconds_after_user_assigned_identity_creation]
}

resource "azuread_service_principal" "verifiable_credentials_service_request" {
  count = local.skip_actions_requiring_global_admin ? 0 : 1

  client_id    = "3db474b9-6a0c-4840-96ac-1fceb342124f"
  use_existing = true
}

resource "azuread_app_role_assignment" "verifiable_credentials" {
  for_each = local.skip_actions_requiring_global_admin ? toset([]) : toset(["VerifiableCredential.Create.All"])

  app_role_id         = "949ebb93-18f8-41b4-b677-c2bfea940027" # VerifiableCredential.Create.All
  principal_object_id = azurerm_linux_web_app.backend.identity[0].principal_id
  resource_object_id  = azuread_service_principal.verifiable_credentials_service_request[0].object_id
}

resource "azuread_service_principal_delegated_permission_grant" "frontend_backend_access" {
  count = local.skip_actions_requiring_global_admin ? 0 : 1

  claim_values                         = ["openid", "Access"]
  resource_service_principal_object_id = local.backend_service_principal_id
  service_principal_object_id          = local.frontend_service_principal_id
}

# Backend App Registration
resource "azuread_application" "backend" {
  count = local.create_aad_objects ? 1 : 0

  display_name     = local.backend_appreg_name
  owners           = [data.azuread_client_config.current_user.object_id]
  sign_in_audience = "AzureADMyOrg"

  api {
    oauth2_permission_scope {
      id                         = "7e119516-7dd5-4cc0-a906-5f1a9cfd5801"
      admin_consent_description  = "Access To MyWorkID backend"
      admin_consent_display_name = "Access"
      enabled                    = true
      type                       = "Admin"
      value                      = "Access"
    }
  }
  app_role {
    allowed_member_types = ["User"]
    description          = "Allows user to Create a temporary access token"
    display_name         = local.create_tap_app_role_name
    id                   = "16f5de80-8ee7-46e3-8bfe-7de7af6164ed"
    enabled              = true
    value                = local.create_tap_app_role_name
  }
  app_role {
    allowed_member_types = ["User"]
    description          = "Allows user to Dismiss its User Risk"
    display_name         = local.dismiss_user_risk_app_role_name
    id                   = "9262ab98-6c08-4e32-bae3-4c12d4ce2463"
    enabled              = true
    value                = local.dismiss_user_risk_app_role_name
  }
  app_role {
    allowed_member_types = ["User"]
    description          = "Allows user to Reset its password"
    display_name         = local.password_reset_app_role_name
    id                   = "13c4693c-84f1-43b4-85a2-5e51d41753ed"
    enabled              = true
    value                = local.password_reset_app_role_name
  }
  app_role {
    allowed_member_types = ["User"]
    description          = "Allows user to Validate its Identity by VerifiedId"
    display_name         = local.validate_identity_app_role_name
    id                   = "eeacf7de-5c05-4e21-a2be-a4d8e3435237"
    enabled              = true
    value                = local.validate_identity_app_role_name
  }

  lifecycle {
    ignore_changes = [
      identifier_uris, #Necessary due to azuread_application_identifier_uri.backend
      tags
    ]
  }
}

resource "azuread_service_principal" "backend" {
  count = local.create_aad_objects ? 1 : 0

  client_id = local.backend_application_client_id
  owners    = [data.azuread_client_config.current_user.object_id]
}

resource "azuread_application_identifier_uri" "backend" {
  application_id = local.backend_application_id
  identifier_uri = "api://${local.backend_application_client_id}"
}

# Frontend App Registration Start
# azuread_application_registration is used due to azuread_application_redirect_uris being incompatible with azuread_application - azuread_application_redirect_uris.frontend_backend necessary as it creates a circle with azurerm_linux_web_app.backend
resource "azuread_application_registration" "frontend" {
  count = local.create_aad_objects ? 1 : 0

  display_name                   = local.frontend_appreg_name
  requested_access_token_version = 2
  sign_in_audience               = "AzureADMyOrg"
}

resource "azuread_application_api_access" "frontend_backend" {
  api_client_id  = local.backend_application_client_id
  application_id = local.frontend_application_id
  scope_ids = [
    local.backend_oauth2_permission_scope_ids,
  ]
}

resource "azuread_application_api_access" "frontend_graph" {
  api_client_id  = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
  application_id = local.frontend_application_id
  scope_ids = [
    data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"],
  ]
}

resource "azuread_application_owner" "frontend_current_user" {
  application_id  = local.frontend_application_id
  owner_object_id = data.azuread_client_config.current_user.object_id
}

resource "azuread_application_redirect_uris" "frontend_backend" {
  application_id = local.frontend_application_id
  redirect_uris = setunion(
    formatlist("https://%s/", local.custom_domains),
    ["https://${azurerm_linux_web_app.backend.default_hostname}/"],
    local.frontend_dev_redirect_uris,
  )
  type = "SPA"
}
# Frontend App Registration End

resource "azuread_service_principal" "frontend" {
  count = local.create_aad_objects ? 1 : 0

  client_id = local.frontend_application_client_id
  owners    = [data.azuread_client_config.current_user.object_id]
}

resource "azuread_service_principal" "msgraph" {
  count = local.skip_actions_requiring_global_admin ? 0 : 1

  client_id    = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing = true
}

resource "azuread_service_principal_delegated_permission_grant" "frontend" {
  count = local.skip_actions_requiring_global_admin ? 0 : 1

  claim_values                         = ["User.Read"]
  resource_service_principal_object_id = azuread_service_principal.msgraph[0].object_id
  service_principal_object_id          = local.frontend_service_principal_id
}

# Backend Access Groups
resource "azuread_group" "backend_access" {
  for_each = { for group, config in local.base_access_groups_map : group => config if local.create_aad_objects }

  display_name     = each.value.group_name
  description      = "Access group for MyWorkID backend permission ${each.value.app_role}"
  security_enabled = true
}

resource "azuread_app_role_assignment" "backend_access" {
  for_each = local.base_access_groups_map

  app_role_id         = local.backend_app_role_ids[each.value.app_role]
  principal_object_id = local.create_aad_objects ? azuread_group.backend_access[each.key].object_id : data.azuread_group.backend_access[each.key].object_id
  resource_object_id  = local.backend_service_principal_id
}
