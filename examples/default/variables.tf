## Flags
variable "api_name" {
  type        = string
  description = "Name of the AppService that hosts the api. Note this has to be globally unique."
}

## Web App App Settings
variable "dismiss_user_risk_auth_context_id" {
  type        = string
  description = "AuthContext Id configured that is challenged for the dismissUser action"
}

variable "generate_tap_auth_context_id" {
  type        = string
  description = "AuthContext Id configured that is challenged for the generateTAP action"
}

variable "reset_password_auth_context_id" {
  type        = string
  description = "AuthContext Id configured that is challenged for the resetPassword action"
}

# MyWorkID
## General
variable "subscription_id" {
  type = string
}

variable "allow_credential_operations_for_privileged_users" {
  type        = bool
  default     = false
  description = "Allow credential operations for privileged users. If set to true, users with privileged roles (e.g. Global Admin or User Admin) can perform credential operations like create TAP and reset password"
}

## Backend Access Groups
variable "backend_access_group_names" {
  type = object({
    create_tap        = optional(string, "sec - MyWorkID - Create TAP")
    dismiss_user_risk = optional(string, "sec - MyWorkID - Dismiss User Risk")
    password_reset    = optional(string, "sec - MyWorkID - Password Reset")
    validate_identity = optional(string, "sec - MyWorkID - Validate Identity")
  })
  default     = {}
  description = "Values for the backend access group names. Only relevant if skip_creation_backend_access_groups = false"
}

variable "backend_application_id" {
  type        = string
  default     = "MyWorkID-backend-id"
  description = "Application ID of the backend AppRegistration. Required if create_aad_objects is set to false."
}

variable "backend_appreg_name" {
  type        = string
  default     = "ar-MyWorkID-backend"
  description = "Name of the AppRegistration that is used by the backend"
}

variable "backend_graph_permissions" {
  type        = list(string)
  default     = []
  description = "List of permissions to assign to the backend AppRegistration."
}

variable "backend_service_principal_id" {
  type        = string
  default     = "MyWorkID-backend-spn-id"
  description = "Service Principal ID of the backend AppRegistration. Required if create_aad_objects is set to false."
}

variable "create_aad_objects" {
  type        = bool
  default     = true
  description = "Create the AAD objects (App Registrations, Service Principals, etc.)"
}

variable "create_log_analytics_workspace" {
  type        = bool
  default     = true
  description = "Create a new log analytics workspace for the resources. If set to false, the log analytics workspace must already exist and workspace_id must be provided."
}

variable "create_resource_group" {
  type        = bool
  default     = true
  description = "Create a new resource group for the resources. If set to false, the resource group must already exist and resource_group_name must be provided."
}

variable "custom_domains" {
  type        = list(string)
  default     = []
  description = "OPTIONAL: List of custom domains for MyWorkID. Must be configured at a later time. NOTE: If specified the VerifiedId callbacks will always use the first domain in the list."
}

variable "dev_redirect_url" {
  type    = set(string)
  default = []
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.
DESCRIPTION  
  nullable    = false

  validation {
    condition     = alltrue([for _, v in var.diagnostic_settings : contains(["Dedicated", "AzureDiagnostics"], v.log_analytics_destination_type)])
    error_message = "Log analytics destination type must be one of: 'Dedicated', 'AzureDiagnostics'."
  }
  validation {
    condition = alltrue(
      [
        for _, v in var.diagnostic_settings :
        v.workspace_resource_id != null || v.storage_account_resource_id != null || v.event_hub_authorization_rule_resource_id != null || v.marketplace_partner_resource_id != null
      ]
    )
    error_message = "At least one of `workspace_resource_id`, `storage_account_resource_id`, `marketplace_partner_resource_id`, or `event_hub_authorization_rule_resource_id`, must be set."
  }
}

variable "enable_auto_update" {
  type        = bool
  default     = true
  description = "Decides wether the backend should be updated automatically. If set to false the backend will not be updated automatically. If set to true the backend will be updated automatically. NOTE: If this ever was set to false a change to true will result in the backend being recreated automatically"
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "frontend_application_id" {
  type        = string
  default     = "MyWorkID-frontend-id"
  description = "Application ID of the frontend AppRegistration. Required if create_aad_objects is set to false."
}

## AppRegistrations
variable "frontend_appreg_name" {
  type        = string
  default     = "ar-MyWorkID-frontend"
  description = "Name of the AppRegistration that is used by the frontend"
}

variable "frontend_service_principal_id" {
  type        = string
  default     = "MyWorkID-frontend-spn-id"
  description = "Service Principal ID of the frontend AppRegistration. Required if create_aad_objects is set to false."
}

variable "insights_retention" {
  type        = number
  default     = 30
  description = "The retention period of the application insights."
}

## Application Insights
variable "insights_sku" {
  type        = string
  default     = "PerGB2018"
  description = "The SKU of the application insights."
}

variable "insights_type" {
  type        = string
  default     = "web"
  description = "The type of the application insights."
}

## Dev
variable "is_dev" {
  type    = bool
  default = false
}

variable "kv_purge_protection_enabled" {
  type        = bool
  default     = false
  description = "Enable purge protection for the key vault. This setting is only available for key vaults with soft delete enabled."
}

variable "kv_sku_name" {
  type        = string
  default     = "standard"
  description = "The SKU name of the key vault. Possible values are 'standard' and 'premium'."
}

## Key Vault
variable "kv_soft_delete_retention_days" {
  type        = number
  default     = 7
  description = "The number of days to retain soft-deleted secrets in the key vault."
}

variable "lock" {
  type = object({
    kind = string
    name = optional(string, null)
  })
  default     = null
  description = <<DESCRIPTION
Controls the Resource Lock configuration for this resource. The following properties can be specified:

- `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
- `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.
DESCRIPTION

  validation {
    condition     = var.lock != null ? contains(["CanNotDelete", "ReadOnly"], var.lock.kind) : true
    error_message = "The lock level must be one of: 'None', 'CanNotDelete', or 'ReadOnly'."
  }
}

variable "resource_group_name" {
  type    = string
  default = "rg-MyWorkID"
}

variable "resource_location" {
  type    = string
  default = "westeurope"
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
DESCRIPTION
  nullable    = false
}

## Service Plan
variable "service_plan_os_type" {
  type        = string
  default     = "Linux"
  description = "The OS type of the service plan."
}

variable "service_plan_sku" {
  type        = string
  default     = "B1"
  description = "The SKU of the service plan."
}

variable "skip_actions_requiring_global_admin" {
  type        = bool
  default     = false
  description = "Skip actions that require global admin permissions. If set to true you will have to set some settings, like the permission grants, manually. NOTE: If this ever was set to false a change to true will result in the previously set permissions being removed"
}

variable "skip_creation_backend_access_groups" {
  type        = bool
  default     = false
  description = "Value to determine if the backend access groups should be created automatically or if this action should be skipped"
}

# tflint-ignore: terraform_unused_declarations
variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

variable "verified_id_decentralized_identifier_secret_name" {
  type        = string
  default     = "VerifiedId-DecentralizedIdentifier"
  description = "KeyVault secret name for the Decentralized identifier of the tenant (https://learn.microsoft.com/en-us/entra/verified-id/verifiable-credentials-configure-verifier#gather-tenant-details-to-set-up-your-sample-application)"
}

variable "verified_id_jwt_signing_key_secret_name" {
  type        = string
  default     = "VerifiedId-JwtSigningKey"
  description = "KeyVault secret name for the signing key of the jwt used int the verifiedId callbacks"
}

variable "verified_id_verify_security_attribute" {
  type        = string
  default     = "lastVerifiedFaceCheck"
  description = "The name of the custom security attribute where the last verified date should be stored."
}

variable "verified_id_verify_security_attribute_set" {
  type        = string
  default     = "MyWorkID"
  description = "The name of the custom security attribute set where the last verified date should be stored."
}

variable "web_app_client_affinity_enabled" {
  type        = bool
  default     = false
  description = "Enable client affinity for the web app."
}

## Web App
variable "web_app_https_only" {
  type        = bool
  default     = true
  description = "Enforce HTTPS for the web app."
}

variable "workspace_id" {
  type    = string
  default = "log-MyWorkID"
}
