# Terraform Outputs - All required information for Azure DevOps pipeline configuration

output "unique_suffix" {
  description = "Unique suffix used for all resource names"
  value       = random_string.unique_suffix.result
}

output "resource_prefix_full" {
  description = "Full resource prefix including unique suffix"
  value       = local.resource_prefix
}

output "resource_groups" {
  description = "Created resource groups per environment"
  value = {
    for env, rg in azurerm_resource_group.hackathon :
    env => {
      name     = rg.name
      location = rg.location
      id       = rg.id
    }
  }
}

# =============================================================================
# Service Principal Outputs - Use these to create Azure DevOps Service Connections
# =============================================================================

output "service_principal_app_ids" {
  description = "Application (client) IDs for Azure DevOps service connections"
  value = {
    for env, app in azuread_application.ado_sp :
    env => app.client_id
  }
}

output "service_principal_object_ids" {
  description = "Service Principal object IDs"
  value = {
    for env, sp in azuread_service_principal.ado_sp :
    env => sp.object_id
  }
}

output "service_principal_names" {
  description = "Service Principal display names"
  value = {
    for env, app in azuread_application.ado_sp :
    env => app.display_name
  }
}

# =============================================================================
# Azure AI Foundry Outputs
# =============================================================================

output "openai_endpoints" {
  description = "Azure AI Foundry OpenAI endpoints for each environment"
  value = {
    for env, foundry in azapi_resource.ai_foundry :
    env => "https://${local.resource_prefix}-${env}.openai.azure.com/"
  }
}

output "ai_foundry_endpoints" {
  description = "Azure AI Foundry (services.ai.azure.com) endpoints for each environment"
  value = {
    for env, foundry in azapi_resource.ai_foundry :
    env => "https://${local.resource_prefix}-${env}.services.ai.azure.com"
  }
}

output "openai_keys" {
  description = "Azure AI Services keys - retrieve manually with: az cognitiveservices account keys list"
  value       = "Run: az cognitiveservices account keys list --name <ai-services-name> --resource-group <rg-name>"
}

output "openai_deployment_name" {
  description = "Name of the GPT-4o deployment"
  value       = var.gpt4o_deployment_name
}

output "ai_foundry_ids" {
  description = "Azure AI Foundry resource IDs for each environment"
  value = {
    for env, foundry in azapi_resource.ai_foundry :
    env => foundry.id
  }
}

output "ai_foundry_project_ids" {
  description = "Azure AI Foundry Project resource IDs for each environment"
  value = {
    for env, project in azapi_resource.ai_foundry_project :
    env => project.id
  }
}

# AI Foundry Project endpoints - this is what the Python code needs
# Format: https://<customSubDomainName>.services.ai.azure.com/api/projects/<project-name>
output "ai_project_endpoints" {
  description = "Azure AI Foundry Project endpoints for each environment (use these in AZURE_AI_PROJECT_ENDPOINT)"
  value = {
    for env, project in azapi_resource.ai_foundry_project :
    env => "https://${local.resource_prefix}-${env}.services.ai.azure.com/api/projects/${project.name}"
  }
}

output "application_insights_keys" {
  description = "Application Insights instrumentation keys"
  value = {
    for env, ai in azurerm_application_insights.hackathon :
    env => ai.instrumentation_key
  }
  sensitive = true
}

output "application_insights_connection_strings" {
  description = "Application Insights connection strings"
  value = {
    for env, ai in azurerm_application_insights.hackathon :
    env => ai.connection_string
  }
  sensitive = true
}

output "key_vault_uris" {
  description = "Key Vault URIs for each environment"
  value = {
    for env, kv in azurerm_key_vault.hackathon :
    env => kv.vault_uri
  }
}

output "subscription_id" {
  description = "Azure subscription ID"
  value       = var.subscription_id
  sensitive   = true
}

output "tenant_id" {
  description = "Azure tenant ID"
  value       = data.azurerm_client_config.current.tenant_id
  sensitive   = true
}

output "environments" {
  description = "List of environments created"
  value       = var.environments
}

# Instructions for configuring Azure DevOps
output "azure_devops_setup_instructions" {
  description = "Next steps for configuring Azure DevOps"
  value = <<-EOT
  
  ╔════════════════════════════════════════════════════════════════╗
  ║  Azure AI Foundry Resources Created Successfully!              ║
  ║  Unique Suffix: ${random_string.unique_suffix.result}                                           ║
  ╚════════════════════════════════════════════════════════════════╝
  
  🔐 SERVICE PRINCIPALS CREATED (use for Azure DevOps Service Connections):
  
     DEV:  App ID = ${azuread_application.ado_sp["dev"].client_id}
           Name   = ${azuread_application.ado_sp["dev"].display_name}
     
     TEST: App ID = ${azuread_application.ado_sp["test"].client_id}
           Name   = ${azuread_application.ado_sp["test"].display_name}
     
     PROD: App ID = ${azuread_application.ado_sp["prod"].client_id}
           Name   = ${azuread_application.ado_sp["prod"].display_name}
  
  📋 NEXT STEPS - Configure Azure DevOps:
  
  1. Create Service Connections using the Service Principals above:
     - Go to Project Settings → Service Connections
     - Create "Azure Resource Manager" → "Service principal (manual)"
     - Use the App IDs above with Workload Identity Federation
     - Name them: AZURE_SERVICE_CONNECTION_DEV, AZURE_SERVICE_CONNECTION_TEST, AZURE_SERVICE_CONNECTION_PROD
  
  2. Create Variable Groups with the following values:
  
     Variable Group: agent-dev-vars
     ─────────────────────────────────────────────────────
     AZURE_OPENAI_ENDPOINT_DEV = https://${local.resource_prefix}-dev.openai.azure.com/
     AZURE_OPENAI_DEPLOYMENT_DEV = ${var.gpt4o_deployment_name}
     AZURE_OPENAI_API_VERSION_DEV = 2025-01-01-preview
     AZURE_AI_PROJECT_DEV = ${azapi_resource.ai_foundry_project["dev"].id}
     AZURE_AI_PROJECT_ENDPOINT_DEV = https://${local.resource_prefix}-dev.services.ai.azure.com/api/projects/${local.resource_prefix}-dev-project
     AZURE_AI_MODEL_DEPLOYMENT_NAME = ${var.gpt4o_deployment_name}
     
     Variable Group: agent-test-vars
     ─────────────────────────────────────────────────────
     AZURE_OPENAI_ENDPOINT_TEST = https://${local.resource_prefix}-test.openai.azure.com/
     AZURE_OPENAI_DEPLOYMENT_TEST = ${var.gpt4o_deployment_name}
     AZURE_OPENAI_API_VERSION_TEST = 2025-01-01-preview
     AZURE_AI_PROJECT_TEST = ${azapi_resource.ai_foundry_project["test"].id}
     AZURE_AI_PROJECT_ENDPOINT_TEST = https://${local.resource_prefix}-test.services.ai.azure.com/api/projects/${local.resource_prefix}-test-project
     AZURE_AI_MODEL_DEPLOYMENT_NAME = ${var.gpt4o_deployment_name}
     
     Variable Group: agent-prod-vars
     ─────────────────────────────────────────────────────
     AZURE_OPENAI_ENDPOINT_PROD = https://${local.resource_prefix}-prod.openai.azure.com/
     AZURE_OPENAI_DEPLOYMENT_PROD = ${var.gpt4o_deployment_name}
     AZURE_OPENAI_API_VERSION_PROD = 2025-01-01-preview
     AZURE_AI_PROJECT_PROD = ${azapi_resource.ai_foundry_project["prod"].id}
     AZURE_AI_PROJECT_ENDPOINT_PROD = https://${local.resource_prefix}-prod.services.ai.azure.com/api/projects/${local.resource_prefix}-prod-project
     AZURE_AI_MODEL_DEPLOYMENT_NAME = ${var.gpt4o_deployment_name}
  
  3. Add sensitive keys as secret variables in each variable group:
     - Run: az cognitiveservices account keys list --name ${local.resource_prefix}-dev-aifoundry --resource-group ${local.resource_prefix}-dev-rg
     - Add AZURE_OPENAI_KEY_DEV, AZURE_OPENAI_KEY_TEST, AZURE_OPENAI_KEY_PROD
  
  4. Continue to Step 2 of the hackathon!
  
  EOT
}
