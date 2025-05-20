# MYWORKID_GENERAL_OPTIONS
subscription_id                = "99f3ac34-3b27-4667-918c-c6953312cea8"
resource_location              = "westeurope"
create_resource_group          = true
resource_group_name            = "myworkid-weu"
create_log_analytics_workspace = true
# workspace_id = ""
api_name                                         = "myworkid-dekr"
create_aad_objects                               = true
skip_actions_requiring_global_admin              = false
allow_credential_operations_for_privileged_users = false

# AVM_GENERAL_OPTIONS
diagnostic_settings = null
enable_telemetry    = false
lock = {
  kind = "CanNotDelete"
  name = null
}
role_assignments = null

# MYWORKID_SERVICE_PLAN
# service_plan_os_type = "Linux"
# service_plan_sku = "B1"

# MYWORKID_APPLICATION_INSIGHTS
# insights_sku = "PerGB2018"
# insights_retention = 30
# insights_type = "web"

# MYWORKID_WEB_APP
# web_app_https_only = true
# web_app_client_affinity_enabled = false

# MYWORKID_WEB_APP_APP_SETTINGS
dismiss_user_risk_auth_context_id = ""
generate_tap_auth_context_id      = ""
reset_password_auth_context_id    = ""
# enable_auto_update = true
# verified_id_jwt_signing_key_secret_name = "VerifiedId-JwtSigningKey"
# verified_id_decentralized_identifier_secret_name = "VerifiedId-DecentralizedIdentifier"
# verified_id_verify_security_attribute_set = "MyWorkID"
# verified_id_verify_security_attribute = "lastVerifiedFaceCheck"
# custom_domains = []

# MYWORKID_KEY_VAULT
# kv_soft_delete_retention_days = 7
# kv_purge_protection_enabled = false
# kv_sku_name = "standard"

# MYWORKID_APP_REGISTRATIONS
frontend_appreg_name = "ar-MyWorkID-frontend"
# frontend_application_id = ""
# frontend_service_principal_id = ""
backend_appreg_name = "ar-MyWorkID-backend"
# backend_application_id = ""
# backend_service_principal_id = "
# backend_graph_permissions = []

# MYWORKID_BACKEND_ACCESS_GROUPS
backend_access_group_names = {
  "create_tap"        = "sec - MyWorkID - Create TAP"
  "dismiss_user_risk" = "sec - MyWorkID - Dismiss User Risk"
  "password_reset"    = "sec - MyWorkID - Password Reset"
  "validate_identity" = "sec - MyWorkID - Validate Identity"
}
# skip_creation_backend_access_groups = false

# MYWORKID_DEV
# is_dev = false
# dev_redirect_url = []

tags = {
  "environment" = "dev"
  "landingzone" = "90_appzones"
  "workload"    = "myworkid"
}
