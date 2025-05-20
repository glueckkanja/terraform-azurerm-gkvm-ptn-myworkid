# MYWORKID_GENERAL_OPTIONS
subscription_id     = "99f3ac34-3b27-4667-918c-c6953312cea8"
resource_location   = "westeurope"
resource_group_name = "myworkid-weu"
api_name            = "myworkid-dekr"

# AVM_GENERAL_OPTIONS
lock = {
  kind = "CanNotDelete"
  name = "Lock-MyWorkID"
}

# MYWORKID_WEB_APP_APP_SETTINGS
dismiss_user_risk_auth_context_id = ""
generate_tap_auth_context_id      = ""
reset_password_auth_context_id    = ""
enable_auto_update                = true

# MYWORKID_APP_REGISTRATIONS
frontend_appreg_name = "ar-MyWorkID-frontend"
backend_appreg_name  = "ar-MyWorkID-backend"

tags = {
  "environment" = "dev"
  "landingzone" = "90_appzones"
  "workload"    = "myworkid"
}
