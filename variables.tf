variable application_code {
    description = "Código de aplicación a desplegar."
    type = string
}

variable resource_correlative {
    description = "Especifica el número correlativo asignado al recurso."
    type = string
    default = "01"
}

variable base_correlative {
    description = "Especifica el numero correlativo asignado a la infraestructura base."
    type = string
    default = "01"
}

variable environment {
    description = "Especifica el ambiente en el que se desplegará la aplicación."
    type = string    
}

variable container_type {
    description = "Especifica el numero correlativo asignado a la infraestructura base."
    type = string
    default = "docker"
}

variable location {
    description = "Código de la región a desplegar."
    type = list(string)
}

variable container_image {
    description = "Especifica el nombre de la imagen desplegar."
    type = string
}

/*variable asfc_aspl_tier {
  description = "Nivel de App Service Plan creado por el modulo ASPL."
  type        = string
}*/

variable asfc_aspl_id {
  description = "ID del App Service Plan creado por el módulo ASPL."
  type        = map
}


locals {
  rsgr_code = "rsgr"
  asfc_code = "asfc"
  
  map_container_types = {
    COMPOSE = true
    DOCKER  = true
    KUBE    = true
  }

  map_locations_code = {
    eu2 = "eastus2"
    cus = "centralus"
  }

  container_type = upper(var.container_type)
  check_supported_container_types = local.map_container_types[local.container_type]
  asfc_linux_fx_version = format("%s%s%s",local.container_type,"|",var.container_image)

  map_asfc = {
    for region in var.location :
    local.map_locations_code[lower(region)] => {
      asfc_name = format("%s%s%s%s%s", lower(local.asfc_code), lower(region), lower(var.application_code), lower(var.environment), var.resource_correlative),
      asfc_rsgr = format("%s%s%s%s%s", upper(local.rsgr_code), upper(region), upper(var.application_code), upper(var.environment), var.base_correlative)
    }
  }

  asfc_always_on = true
  asfc_https_only = true
  asfc_http2_enabled = true
  asfc_ftps_state = "Disabled"
  
  asfc_websites_enable_app_service_storage = false
  asfc_docker_registry_server_url = "https://index.docker.io"
  #asfc_docker_registry_server_username = ""
  #asfc_docker_registry_server_password = ""  

}