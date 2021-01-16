resource "azurerm_app_service" "asfc" {
  for_each            = local.map_asfc
  name                = each.value.asfc_name
  location            = each.key
  resource_group_name = each.value.asfc_rsgr
  app_service_plan_id = var.asfc_aspl_id[each.key]
  https_only          = local.asfc_https_only

  site_config {
    always_on                 = local.asfc_always_on
    http2_enabled             = local.asfc_http2_enabled
    ftps_state                = local.asfc_ftps_state
    linux_fx_version          = local.asfc_linux_fx_version    
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = local.asfc_websites_enable_app_service_storage
    DOCKER_REGISTRY_SERVER_URL      = local.asfc_docker_registry_server_url
    #DOCKER_REGISTRY_SERVER_USERNAME = local.asfc_docker_registry_server_username
    #DOCKER_REGISTRY_SERVER_PASSWORD = local.asfc_docker_registry_server_password
  }
  
}