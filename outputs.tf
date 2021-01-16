output "asfc_name" {
  description = "Nombre del recurso desplegado"
  value       = { for region in keys(azurerm_app_service.asfc) : region => azurerm_app_service.asfc[region].name }
}

output "asfc_id" {
  description = "Mapa con los nombres de los App Service Plan aprovisionados"
  value = { for region in keys(azurerm_app_service.asfc) : region => azurerm_app_service.asfc[region].id }
}

output "asfc_image" {
  description = "Imagen ingestada en el recurso"
  value       = var.container_image
}
