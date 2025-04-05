provider "azurerm" {
  features {}
  subscription_id = "070c4cac-c20e-4008-9a23-a47c92d17f7e"
}

resource "azurerm_resource_group" "rgas" {
  name     = "rg-integrated-terraform"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "khush_app_service_plan"
  location            = azurerm_resource_group.rgas.location
  resource_group_name = azurerm_resource_group.rgas.name

  sku {
    tier = "Basic"
    size = "S1"
  }
}

resource "azurerm_app_service" "my-app_service" {
  name                = "webapijenkins56373"
  location            = azurerm_resource_group.rgas.location
  resource_group_name = azurerm_resource_group.rgas.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id


  site_config {
    dotnet_framework_version = "v6.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
