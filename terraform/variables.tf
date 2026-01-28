variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "resource_prefix" {
  description = "Prefix for resource names (will be combined with unique suffix)"
  type        = string
  default     = "aiagent"
  
  validation {
    condition     = length(var.resource_prefix) <= 10
    error_message = "Resource prefix must be 10 characters or less to allow for unique suffixes."
  }
}

variable "environments" {
  description = "List of environments to create (dev, test, prod)"
  type        = list(string)
  default     = ["dev", "test", "prod"]
  
  validation {
    condition     = length(var.environments) > 0 && length(var.environments) <= 3
    error_message = "Must specify at least one environment, maximum three."
  }
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "openai_sku" {
  description = "SKU for Azure OpenAI service"
  type        = string
  default     = "S0"
}

variable "gpt4o_deployment_name" {
  description = "Name for the GPT-4o deployment"
  type        = string
  default     = "gpt-4o"
}

variable "gpt4o_model_version" {
  description = "Version of GPT-4o model to deploy"
  type        = string
  default     = "2024-05-13"
}
