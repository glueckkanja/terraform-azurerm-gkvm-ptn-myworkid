data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}

data "azuread_client_config" "current_user" {}

data "azuread_application" "frontend" {
  count = local.create_aad_objects ? 0 : 1

  object_id = var.frontend_application_object_id
}

data "azuread_service_principal" "frontend" {
  count = local.create_aad_objects ? 0 : 1

  object_id = var.frontend_service_principal_object_id
}

data "azuread_application" "backend" {
  count = local.create_aad_objects ? 0 : 1

  object_id = var.backend_application_object_id
}

data "azuread_service_principal" "backend" {
  count = local.create_aad_objects ? 0 : 1

  object_id = var.backend_service_principal_object_id
}

data "azuread_group" "backend_access" {
  for_each = { for group, config in local.backend_access_groups_map : group => config if !local.create_aad_objects }

  display_name = each.value.group_name
}
