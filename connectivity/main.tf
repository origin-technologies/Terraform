##################################################################################
# RESOURCES
##################################################################################

resource "azurerm_resource_group" "sst_resource_group" {    
  name = "rg-${var.name}-${var.environment}" 
  location = var.region  
  tags = local.common_tags
}   
resource "azurerm_application_insights" "sst_appinsights" {
  name                = "ai-${var.name}-${var.environment}-001" 
  location            = azurerm_resource_group.sst_resource_group.location
  resource_group_name = azurerm_resource_group.sst_resource_group.name
  application_type    = "web"
  tags = local.common_tags
}
resource "azurerm_service_plan" "sst_app_service_plan" {  
  name                = "asp-${var.name}-${var.environment}-001"  
  location            = azurerm_resource_group.sst_resource_group.location  
  resource_group_name = azurerm_resource_group.sst_resource_group.name  
  os_type             = "Linux"
  sku_name            = "P1v2"
  tags = local.common_tags
}  
resource "azurerm_app_service" "sst_app_service" {  
  name                = "was-${var.name}-${var.environment}-001"  
  location            = azurerm_resource_group.sst_resource_group.location
  resource_group_name = azurerm_resource_group.sst_resource_group.name  
  app_service_plan_id = azurerm_service_plan.sst_app_service_plan.id  
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"              = 1
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.sst_appinsights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.sst_appinsights.connection_string
  }
  tags = local.common_tags
} 
# resource "azurerm_communication_service" "sst_communication_service" {
#   name                = "acs-${var.name}-${var.environment}-001"
#   resource_group_name = azurerm_resource_group.sst_resource_group.name
#   data_location       = "Europe" // [Asia Pacific Australia Europe UK United States]
#   tags = local.common_tags
# }



resource "azurerm_network_security_group" "sst_network" {
  name                = "nsg-${var.name}-${var.environment}-001"
  location            = azurerm_resource_group.sst_resource_group.location
  resource_group_name = azurerm_resource_group.sst_resource_group.name  
}
resource "azurerm_virtual_network" "example" {
  name                = "net-${var.name}-${var.environment}-001"
  location            = azurerm_resource_group.sst_resource_group.location
  resource_group_name = azurerm_resource_group.sst_resource_group.name  
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  subnet {
    name           = "management"
    address_prefix = "10.0.1.0/24"
  }
  subnet {
    name           = "security"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.sst_network.id
  }
  tags = local.common_tags
}