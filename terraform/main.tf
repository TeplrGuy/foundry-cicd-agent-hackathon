# Complete Terraform configuration for Azure AI Agent Hackathon
# This creates all required resources for deploying AI agents across environments
# Uses azapi provider for Azure AI Foundry (AI Hub + AI Project) resources

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.12"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {
    cognitive_account {
      purge_soft_delete_on_destroy = true
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.subscription_id

  # Use Azure AD authentication for storage accounts instead of key-based auth
  # This is required when Azure Policy blocks key-based authentication
  storage_use_azuread = true
}

provider "azapi" {
  subscription_id = var.subscription_id
}

provider "azuread" {
  # Uses the same credentials as azurerm
}

# Generate a unique suffix for resource names to avoid conflicts between students
resource "random_string" "unique_suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
  lower   = true
}

locals {
  # Unique prefix for all resources
  resource_prefix = "${var.resource_prefix}-${random_string.unique_suffix.result}"

  # Common tags for all resources
  common_tags = merge(var.tags, {
    ManagedBy = "Terraform"
    Project   = "AI-Agent-Hackathon"
    UniqueId  = random_string.unique_suffix.result
  })
}

# Resource Groups for each environment
resource "azurerm_resource_group" "hackathon" {
  for_each = toset(var.environments)

  name     = "${local.resource_prefix}-${each.key}-rg"
  location = var.location

  tags = merge(local.common_tags, {
    Environment = each.key
  })
}

# Azure AI Foundry resource for each environment (provides services.ai.azure.com endpoint)
# Using azapi provider with 2025-06-01 API for proper AI Foundry support
resource "azapi_resource" "ai_foundry" {
  for_each = toset(var.environments)

  type                      = "Microsoft.CognitiveServices/accounts@2025-06-01"
  name                      = "${local.resource_prefix}-${each.key}-aifoundry"
  location                  = var.location
  parent_id                 = azurerm_resource_group.hackathon[each.key].id
  schema_validation_enabled = false

  body = jsonencode({
    kind = "AIServices"
    sku = {
      name = var.openai_sku
    }
    identity = {
      type = "SystemAssigned"
    }
    properties = {
      # Support both Entra ID and API Key authentication
      disableLocalAuth = false

      # Enable AI Foundry project management - this creates the services.ai.azure.com endpoint
      allowProjectManagement = true

      # Custom subdomain name for DNS - required for services.ai.azure.com endpoint
      customSubDomainName = "${local.resource_prefix}-${each.key}"

      publicNetworkAccess = "Enabled"
    }
  })

  tags = merge(local.common_tags, {
    Environment = each.key
  })

  response_export_values = ["properties.endpoint", "properties.endpoints"]
}

# Deploy GPT-4o model to each AI Foundry instance
resource "azapi_resource" "gpt4o_deployment" {
  for_each = toset(var.environments)

  type      = "Microsoft.CognitiveServices/accounts/deployments@2023-05-01"
  name      = var.gpt4o_deployment_name
  parent_id = azapi_resource.ai_foundry[each.key].id

  body = jsonencode({
    sku = {
      name     = "GlobalStandard"
      capacity = 1
    }
    properties = {
      model = {
        format  = "OpenAI"
        name    = "gpt-4o"
        version = var.gpt4o_model_version
      }
    }
  })

  depends_on = [azapi_resource.ai_foundry]
}

# Application Insights for monitoring
resource "azurerm_application_insights" "hackathon" {
  for_each = toset(var.environments)

  name                = "${local.resource_prefix}-${each.key}-appinsights"
  location            = var.location
  resource_group_name = azurerm_resource_group.hackathon[each.key].name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.hackathon[each.key].id

  tags = merge(local.common_tags, {
    Environment = each.key
  })
}

# Log Analytics Workspace for Application Insights
resource "azurerm_log_analytics_workspace" "hackathon" {
  for_each = toset(var.environments)

  name                = "${local.resource_prefix}-${each.key}-law"
  location            = var.location
  resource_group_name = azurerm_resource_group.hackathon[each.key].name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = merge(local.common_tags, {
    Environment = each.key
  })
}

# Azure AI Foundry Project (child of AI Foundry account)
# Uses Microsoft.CognitiveServices/accounts/projects resource type
resource "azapi_resource" "ai_foundry_project" {
  for_each = toset(var.environments)

  type                      = "Microsoft.CognitiveServices/accounts/projects@2025-06-01"
  name                      = "${local.resource_prefix}-${each.key}-project"
  parent_id                 = azapi_resource.ai_foundry[each.key].id
  location                  = var.location
  schema_validation_enabled = false

  body = jsonencode({
    sku = {
      name = "S0"
    }
    identity = {
      type = "SystemAssigned"
    }
    properties = {
      displayName = "${local.resource_prefix}-${each.key}-project"
      description = "AI Project for ${each.key} environment - Hackathon"
    }
  })

  tags = merge(local.common_tags, {
    Environment = each.key
  })

  depends_on = [
    azapi_resource.ai_foundry,
    azapi_resource.gpt4o_deployment
  ]
}

# =============================================================================
# Service Principals for Azure DevOps - Auto-created per environment
# =============================================================================

# Create Azure AD Application for each environment
resource "azuread_application" "ado_sp" {
  for_each = toset(var.environments)

  display_name = "${local.resource_prefix}-${each.key}-ado-sp"
  owners       = [data.azurerm_client_config.current.object_id]

  tags = ["hackathon", "azure-devops", each.key]
}

# Create Service Principal for each application
resource "azuread_service_principal" "ado_sp" {
  for_each = toset(var.environments)

  client_id = azuread_application.ado_sp[each.key].client_id
  owners    = [data.azurerm_client_config.current.object_id]

  tags = ["hackathon", "azure-devops", each.key]
}

# Assign Contributor role on subscription for each SP
resource "azurerm_role_assignment" "sp_contributor" {
  for_each = toset(var.environments)

  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.ado_sp[each.key].object_id
  principal_type       = "ServicePrincipal"
}

# Assign Azure AI Developer role to service principals on AI Foundry account
resource "azurerm_role_assignment" "sp_ai_developer_foundry" {
  for_each = toset(var.environments)

  scope                = azapi_resource.ai_foundry[each.key].id
  role_definition_name = "Azure AI Developer"
  principal_id         = azuread_service_principal.ado_sp[each.key].object_id
  principal_type       = "ServicePrincipal"

  depends_on = [
    azapi_resource.ai_foundry
  ]
}

# Assign Cognitive Services Contributor role on AI Foundry account
resource "azurerm_role_assignment" "sp_cognitive_contributor_foundry" {
  for_each = toset(var.environments)

  scope                = azapi_resource.ai_foundry[each.key].id
  role_definition_name = "Cognitive Services Contributor"
  principal_id         = azuread_service_principal.ado_sp[each.key].object_id
  principal_type       = "ServicePrincipal"

  depends_on = [
    azapi_resource.ai_foundry
  ]
}

# Assign Azure AI Developer role on AI Foundry Project
resource "azurerm_role_assignment" "sp_ai_developer_project" {
  for_each = toset(var.environments)

  scope                = azapi_resource.ai_foundry_project[each.key].id
  role_definition_name = "Azure AI Developer"
  principal_id         = azuread_service_principal.ado_sp[each.key].object_id
  principal_type       = "ServicePrincipal"

  depends_on = [
    azapi_resource.ai_foundry_project
  ]
}

# Assign Cognitive Services Contributor role on AI Foundry Project
resource "azurerm_role_assignment" "sp_cognitive_contributor_project" {
  for_each = toset(var.environments)

  scope                = azapi_resource.ai_foundry_project[each.key].id
  role_definition_name = "Cognitive Services Contributor"
  principal_id         = azuread_service_principal.ado_sp[each.key].object_id
  principal_type       = "ServicePrincipal"

  depends_on = [
    azapi_resource.ai_foundry_project
  ]
}

# Assign Cognitive Services User role on AI Foundry account (for data plane access)
resource "azurerm_role_assignment" "sp_cognitive_user_foundry" {
  for_each = toset(var.environments)

  scope                = azapi_resource.ai_foundry[each.key].id
  role_definition_name = "Cognitive Services User"
  principal_id         = azuread_service_principal.ado_sp[each.key].object_id
  principal_type       = "ServicePrincipal"

  depends_on = [
    azapi_resource.ai_foundry
  ]
}

# Key Vault for secrets management (still useful for storing secrets)
resource "azurerm_key_vault" "hackathon" {
  for_each = toset(var.environments)

  name                       = "${substr(local.resource_prefix, 0, 17)}-${each.key}-kv" # Key Vault names limited to 24 chars
  location                   = var.location
  resource_group_name        = azurerm_resource_group.hackathon[each.key].name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  tags = merge(local.common_tags, {
    Environment = each.key
  })
}

# Storage Account for AI Hub
resource "azurerm_storage_account" "hackathon" {
  for_each = toset(var.environments)

  name                     = "${replace(local.resource_prefix, "-", "")}${each.key}sa" # Storage account names: no hyphens, lowercase
  location                 = var.location
  resource_group_name      = azurerm_resource_group.hackathon[each.key].name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Disable key-based authentication to comply with Azure Policy
  # Azure AD authentication will be used instead
  shared_access_key_enabled = false

  # Disable public access and enable Azure AD authentication
  allow_nested_items_to_be_public = false
  default_to_oauth_authentication = true

  tags = merge(local.common_tags, {
    Environment = each.key
  })
}

# Data source for current Azure client configuration
data "azurerm_client_config" "current" {}

# Note: Azure ML automatically creates the necessary role assignments
# for the AI Hub managed identity to access storage accounts.
# No manual role assignments are needed.

# Role assignments for current user to access storage (needed for Terraform operations)
resource "azurerm_role_assignment" "current_user_storage_blob_data_contributor" {
  for_each = toset(var.environments)

  scope                = azurerm_storage_account.hackathon[each.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
