<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-avm-template

This is a template repo for Terraform Azure Verified Modules.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (~> 3.1)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.19)

- <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) (~> 0.3)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.5)

- <a name="requirement_time"></a> [time](#requirement\_time) (~> 0.12)

## Resources

The following resources are used by this module:

- [azuread_app_role_assignment.backend_access](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/app_role_assignment) (resource)
- [azuread_app_role_assignment.backend_managed_identity](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/app_role_assignment) (resource)
- [azuread_app_role_assignment.verifiable_credentials](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/app_role_assignment) (resource)
- [azuread_application.backend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) (resource)
- [azuread_application_api_access.frontend_backend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_api_access) (resource)
- [azuread_application_api_access.frontend_graph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_api_access) (resource)
- [azuread_application_identifier_uri.backend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_identifier_uri) (resource)
- [azuread_application_owner.frontend_current_user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_owner) (resource)
- [azuread_application_redirect_uris.frontend_backend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_redirect_uris) (resource)
- [azuread_application_registration.frontend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_registration) (resource)
- [azuread_directory_role.authentication_administrator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role) (resource)
- [azuread_directory_role_assignment.backend_managed_identity_authentication_administrator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) (resource)
- [azuread_group.backend_access](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) (resource)
- [azuread_service_principal.backend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) (resource)
- [azuread_service_principal.frontend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) (resource)
- [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) (resource)
- [azuread_service_principal.verifiable_credentials_service_request](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) (resource)
- [azuread_service_principal_delegated_permission_grant.frontend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_delegated_permission_grant) (resource)
- [azuread_service_principal_delegated_permission_grant.frontend_backend_access](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_delegated_permission_grant) (resource)
- [azurerm_application_insights.backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) (resource)
- [azurerm_key_vault.backend_secrets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) (resource)
- [azurerm_linux_web_app.backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) (resource)
- [azurerm_log_analytics_workspace.backend_application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) (resource)
- [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) (resource)
- [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [azurerm_role_assignment.backend_key_vault_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_service_plan.backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) (resource)
- [modtm_telemetry.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/resources/telemetry) (resource)
- [random_uuid.telemetry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) (resource)
- [time_sleep.wait_30_seconds_after_user_assigned_identity_creation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) (resource)
- [azuread_application.backend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) (data source)
- [azuread_application.frontend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) (data source)
- [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids) (data source)
- [azuread_client_config.current_user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) (data source)
- [azuread_group.backend_access](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) (data source)
- [azuread_service_principal.backend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) (data source)
- [azuread_service_principal.frontend](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) (data source)
- [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) (data source)
- [azurerm_client_config.telemetry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [modtm_module_source.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/data-sources/module_source) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_api_name"></a> [api\_name](#input\_api\_name)

Description: Name of the AppService that hosts the api. Note this has to be globally unique.

Type: `string`

### <a name="input_dismiss_user_risk_auth_context_id"></a> [dismiss\_user\_risk\_auth\_context\_id](#input\_dismiss\_user\_risk\_auth\_context\_id)

Description: AuthContext Id configured that is challenged for the dismissUser action.

Type: `string`

### <a name="input_generate_tap_auth_context_id"></a> [generate\_tap\_auth\_context\_id](#input\_generate\_tap\_auth\_context\_id)

Description: AuthContext Id configured that is challenged for the generateTAP action.

Type: `string`

### <a name="input_reset_password_auth_context_id"></a> [reset\_password\_auth\_context\_id](#input\_reset\_password\_auth\_context\_id)

Description: AuthContext Id configured that is challenged for the resetPassword action.

Type: `string`

### <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id)

Description: The ID of the Subscription where the Resources should be deployed.

Type: `string`

### <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id)

Description: The ID of the Tenant where the Entra Objects should be deployed.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_allow_credential_operations_for_privileged_users"></a> [allow\_credential\_operations\_for\_privileged\_users](#input\_allow\_credential\_operations\_for\_privileged\_users)

Description: Allow credential operations for privileged users. If set to true, users with privileged roles (e.g. Global Admin or User Admin) can perform credential operations like create TAP and reset password.

Type: `bool`

Default: `false`

### <a name="input_backend_access_group_names"></a> [backend\_access\_group\_names](#input\_backend\_access\_group\_names)

Description: Values for the backend access group names. Only relevant if skip\_creation\_backend\_access\_groups is set to false.

Type:

```hcl
object({
    create_tap        = optional(string, "sec - MyWorkID - Create TAP")
    dismiss_user_risk = optional(string, "sec - MyWorkID - Dismiss User Risk")
    password_reset    = optional(string, "sec - MyWorkID - Password Reset")
    validate_identity = optional(string, "sec - MyWorkID - Validate Identity")
  })
```

Default: `{}`

### <a name="input_backend_application_id"></a> [backend\_application\_id](#input\_backend\_application\_id)

Description: Application ID of the backend AppRegistration. Required if create\_aad\_objects is set to false.

Type: `string`

Default: `"MyWorkID-backend-id"`

### <a name="input_backend_appreg_name"></a> [backend\_appreg\_name](#input\_backend\_appreg\_name)

Description: Name of the AppRegistration that is used by the backend.

Type: `string`

Default: `"ar-MyWorkID-backend"`

### <a name="input_backend_graph_permissions"></a> [backend\_graph\_permissions](#input\_backend\_graph\_permissions)

Description: List of permissions to assign to the backend AppRegistration.

Type: `list(string)`

Default: `[]`

### <a name="input_backend_service_principal_id"></a> [backend\_service\_principal\_id](#input\_backend\_service\_principal\_id)

Description: Service Principal ID of the backend AppRegistration. Required if create\_aad\_objects is set to false.

Type: `string`

Default: `"MyWorkID-backend-spn-id"`

### <a name="input_create_aad_objects"></a> [create\_aad\_objects](#input\_create\_aad\_objects)

Description: Create the AAD objects (App Registrations, Service Principals, etc.)

Type: `bool`

Default: `true`

### <a name="input_create_log_analytics_workspace"></a> [create\_log\_analytics\_workspace](#input\_create\_log\_analytics\_workspace)

Description: Create a new log analytics workspace for the resources. If set to false, the log analytics workspace must already exist and workspace\_id must be provided.

Type: `bool`

Default: `true`

### <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group)

Description: Create a new resource group for the resources. If set to false, the resource group must already exist and resource\_group\_name must be provided.

Type: `bool`

Default: `true`

### <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains)

Description: OPTIONAL: List of custom domains for MyWorkID. Must be configured at a later time. NOTE: If specified the VerifiedId callbacks will always use the first domain in the list.

Type: `list(string)`

Default: `[]`

### <a name="input_dev_redirect_url"></a> [dev\_redirect\_url](#input\_dev\_redirect\_url)

Description: List of Redirect URIs added to the frontend Application in case of dev-mode being activated.

Type: `set(string)`

Default: `[]`

### <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings)

Description: A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

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

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_enable_auto_update"></a> [enable\_auto\_update](#input\_enable\_auto\_update)

Description: Decides wether the backend should be updated automatically. If set to false the backend will not be updated automatically. If set to true the backend will be updated automatically. NOTE: If this ever was set to false a change to true will result in the backend being recreated automatically.

Type: `bool`

Default: `true`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see <https://aka.ms/avm/telemetryinfo>.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_frontend_application_id"></a> [frontend\_application\_id](#input\_frontend\_application\_id)

Description: Application ID of the frontend AppRegistration. Required if create\_aad\_objects is set to false.

Type: `string`

Default: `"MyWorkID-frontend-id"`

### <a name="input_frontend_appreg_name"></a> [frontend\_appreg\_name](#input\_frontend\_appreg\_name)

Description: Name of the AppRegistration that is used by the frontend.

Type: `string`

Default: `"ar-MyWorkID-frontend"`

### <a name="input_frontend_service_principal_id"></a> [frontend\_service\_principal\_id](#input\_frontend\_service\_principal\_id)

Description: Service Principal ID of the frontend AppRegistration. Required if create\_aad\_objects is set to false.

Type: `string`

Default: `"MyWorkID-frontend-spn-id"`

### <a name="input_insights_retention"></a> [insights\_retention](#input\_insights\_retention)

Description: The retention period of the application insights.

Type: `number`

Default: `30`

### <a name="input_insights_sku"></a> [insights\_sku](#input\_insights\_sku)

Description: The SKU of the application insights.

Type: `string`

Default: `"PerGB2018"`

### <a name="input_insights_type"></a> [insights\_type](#input\_insights\_type)

Description: The type of the application insights.

Type: `string`

Default: `"web"`

### <a name="input_is_dev"></a> [is\_dev](#input\_is\_dev)

Description: Additional option to activate the dev-mode of the module.

Type: `bool`

Default: `false`

### <a name="input_kv_purge_protection_enabled"></a> [kv\_purge\_protection\_enabled](#input\_kv\_purge\_protection\_enabled)

Description: Enable purge protection for the key vault. This setting is only available for key vaults with soft delete enabled.

Type: `bool`

Default: `false`

### <a name="input_kv_sku_name"></a> [kv\_sku\_name](#input\_kv\_sku\_name)

Description: The SKU name of the key vault. Possible values are 'standard' and 'premium'.

Type: `string`

Default: `"standard"`

### <a name="input_kv_soft_delete_retention_days"></a> [kv\_soft\_delete\_retention\_days](#input\_kv\_soft\_delete\_retention\_days)

Description: The number of days to retain soft-deleted secrets in the key vault.

Type: `number`

Default: `7`

### <a name="input_lock"></a> [lock](#input\_lock)

Description: Controls the Resource Lock configuration for this resource. The following properties can be specified:

- `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
- `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.

Type:

```hcl
object({
    kind = string
    name = optional(string, null)
  })
```

Default: `null`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The name of the resource group which will be created, if `create_resource_group` is set to true. The name of an existing resource group which should be used to deploy the resources, if `create_resource_group` is set to false.

Type: `string`

Default: `"rg-MyWorkID"`

### <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location)

Description: Azure region where the resource should be deployed.

Type: `string`

Default: `"westeurope"`

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description: A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_service_plan_os_type"></a> [service\_plan\_os\_type](#input\_service\_plan\_os\_type)

Description: The OS type of the service plan.

Type: `string`

Default: `"Linux"`

### <a name="input_service_plan_sku"></a> [service\_plan\_sku](#input\_service\_plan\_sku)

Description: The SKU of the service plan.

Type: `string`

Default: `"B1"`

### <a name="input_skip_actions_requiring_global_admin"></a> [skip\_actions\_requiring\_global\_admin](#input\_skip\_actions\_requiring\_global\_admin)

Description: Skip actions that require global admin permissions. If set to true you will have to set some settings, like the permission grants, manually. NOTE: If this ever was set to false a change to true will result in the previously set permissions being removed.

Type: `bool`

Default: `false`

### <a name="input_skip_creation_backend_access_groups"></a> [skip\_creation\_backend\_access\_groups](#input\_skip\_creation\_backend\_access\_groups)

Description: Value to determine if the backend access groups should be created automatically or if this action should be skipped.

Type: `bool`

Default: `false`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) Tags of the resource.

Type: `map(string)`

Default: `null`

### <a name="input_verified_id_decentralized_identifier_secret_name"></a> [verified\_id\_decentralized\_identifier\_secret\_name](#input\_verified\_id\_decentralized\_identifier\_secret\_name)

Description: KeyVault secret name for the Decentralized identifier of the tenant (https://learn.microsoft.com/en-us/entra/verified-id/verifiable-credentials-configure-verifier#gather-tenant-details-to-set-up-your-sample-application).

Type: `string`

Default: `"VerifiedId-DecentralizedIdentifier"`

### <a name="input_verified_id_jwt_signing_key_secret_name"></a> [verified\_id\_jwt\_signing\_key\_secret\_name](#input\_verified\_id\_jwt\_signing\_key\_secret\_name)

Description: KeyVault secret name for the signing key of the jwt used int the verifiedId callbacks.

Type: `string`

Default: `"VerifiedId-JwtSigningKey"`

### <a name="input_verified_id_verify_security_attribute"></a> [verified\_id\_verify\_security\_attribute](#input\_verified\_id\_verify\_security\_attribute)

Description: The name of the custom security attribute where the last verified date should be stored.

Type: `string`

Default: `"lastVerifiedFaceCheck"`

### <a name="input_verified_id_verify_security_attribute_set"></a> [verified\_id\_verify\_security\_attribute\_set](#input\_verified\_id\_verify\_security\_attribute\_set)

Description: The name of the custom security attribute set where the last verified date should be stored.

Type: `string`

Default: `"MyWorkID"`

### <a name="input_web_app_client_affinity_enabled"></a> [web\_app\_client\_affinity\_enabled](#input\_web\_app\_client\_affinity\_enabled)

Description: Enable client affinity for the web app.

Type: `bool`

Default: `false`

### <a name="input_web_app_https_only"></a> [web\_app\_https\_only](#input\_web\_app\_https\_only)

Description: Enforce HTTPS for the web app.

Type: `bool`

Default: `true`

### <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id)

Description: The ID of an existing log analytics workspace which should be used to monitor the resources, if `create_log_analytics_workspace` is set to false.

Type: `string`

Default: `"log-MyWorkID"`

## Outputs

The following outputs are exported:

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: The ID of Linux Web App

### <a name="output_update_commands"></a> [update\_commands](#output\_update\_commands)

Description: The AZ CLI command to update the Web App.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->