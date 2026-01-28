# Azure Resource Deployment

This directory contains Terraform configuration for one-click deployment of all Azure resources needed for the AI Agent Hackathon.

## 🚀 Quick Start (One-Click Deployment)

### Option 1: Using the Deploy Script (Recommended)

```bash
cd terraform
./deploy.sh
```

The script will:
- ✅ Check prerequisites (Azure CLI, Terraform)
- ✅ Authenticate to Azure
- ✅ Create terraform.tfvars with your subscription
- ✅ Initialize Terraform
- ✅ Deploy all resources
- ✅ Generate azure-resources.md with configuration
- ✅ Display Azure DevOps setup instructions

**Time:** ~10-15 minutes

### Option 2: Using Azure Developer CLI (azd)

```bash
# From repository root
azd auth login
azd up
```

**Time:** ~10-15 minutes

### Option 3: Manual Terraform

```bash
cd terraform

# 1. Create configuration
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your subscription ID

# 2. Deploy
terraform init
terraform plan
terraform apply

# 3. View outputs
terraform output azure_devops_setup_instructions
```

## 📦 What Gets Created

For each environment (dev, test, prod):

| Resource | Purpose | Example Name |
|----------|---------|--------------|
| Resource Group | Container for all resources | `aiagent-a1b2c3-dev-rg` |
| Azure OpenAI | GPT-4o model deployment | `aiagent-a1b2c3-dev-openai` |
| Azure AI Hub | AI Foundry workspace | `aiagent-a1b2c3-dev-aihub` |
| Application Insights | Monitoring and telemetry | `aiagent-a1b2c3-dev-appinsights` |
| Key Vault | Secrets management | `aiagent-a1b2c3-dev-kv` |
| Storage Account | AI Hub storage | `aiagenta1b2c3devsa` |
| Log Analytics | Centralized logging | `aiagent-a1b2c3-dev-law` |

**Total:** 21 resources (7 per environment × 3 environments)

## 🔒 Unique Naming

All resources include a unique 6-character suffix (e.g., `a1b2c3`) to avoid naming conflicts when multiple students deploy simultaneously.

**Format:** `{prefix}-{unique_suffix}-{environment}-{resource_type}`

## 🔑 Prerequisites

1. **Azure CLI** - [Install](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
   ```bash
   az --version  # Verify installation
   az login      # Authenticate
   ```

2. **Terraform** - [Install](https://www.terraform.io/downloads)
   ```bash
   terraform --version  # Verify installation (need >= 1.0)
   ```

3. **Azure Subscription** with permissions to create:
   - Resource Groups
   - Cognitive Services (OpenAI)
   - Machine Learning Workspaces
   - Key Vaults
   - Storage Accounts

## ⚙️ Configuration

### Variables

Edit `terraform.tfvars` to customize:

```hcl
subscription_id = "your-subscription-id"  # REQUIRED
location        = "eastus"                # Azure region
resource_prefix = "aiagent"               # Short prefix (max 10 chars)
environments    = ["dev", "test", "prod"] # Environments to create
```

### Advanced Configuration

See `variables.tf` for all available options:
- OpenAI SKU
- GPT-4o model version
- Custom tags
- And more

## 📋 Outputs

After deployment, Terraform provides:

- ✅ Resource Group names and IDs
- ✅ Azure OpenAI endpoints and keys
- ✅ AI Hub workspace IDs
- ✅ Application Insights connection strings
- ✅ Key Vault URIs
- ✅ **Azure DevOps configuration instructions**

View outputs anytime:
```bash
terraform output                                  # All outputs
terraform output azure_devops_setup_instructions  # Setup guide
terraform output -json openai_endpoints           # JSON format
```

## 🔄 Management

### Update Resources

```bash
# Make changes to .tf files or terraform.tfvars
terraform plan   # Preview changes
terraform apply  # Apply changes
```

### Destroy Resources

```bash
terraform destroy  # Remove all resources
```

**Warning:** This deletes all data. Use with caution!

### Check Status

```bash
terraform show           # Current state
terraform state list     # List all resources
```

## 🐛 Troubleshooting

### Error: "Subscription not found"

```bash
az account list --output table  # List subscriptions
az account set --subscription "YOUR-SUBSCRIPTION-ID"
```

### Error: "Resource names must be unique"

The random suffix should prevent this, but if it occurs:
- Change `resource_prefix` in terraform.tfvars
- Run `terraform apply` again

### Error: "Insufficient permissions"

Ensure your Azure account has:
- Contributor role on the subscription
- Ability to create service principals (if needed)

### Error: "OpenAI quota exceeded"

Azure OpenAI has regional quotas. Try:
- Different region (change `location` in terraform.tfvars)
- Request quota increase via Azure portal

### Error: "Key based authentication is not permitted on this storage account"

This error occurs when Azure policies restrict key-based authentication. The fix:
- The Terraform configuration now explicitly enables `shared_access_key_enabled = true` for storage accounts
- If you see this error with existing resources, run `terraform destroy` and `terraform apply` again
- The configuration creates new storage accounts with proper authentication settings

## 📚 Files

- `main.tf` - Main resource definitions
- `variables.tf` - Input variable declarations
- `outputs.tf` - Output definitions with setup instructions
- `terraform.tfvars.example` - Template for configuration
- `deploy.sh` - One-click deployment script
- `README.md` - This file

## 🎓 Learning Resources

- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure OpenAI Service](https://learn.microsoft.com/en-us/azure/ai-services/openai/)
- [Azure Machine Learning](https://learn.microsoft.com/en-us/azure/machine-learning/)

## 💡 Tips

1. **Keep terraform.tfvars secure** - Contains subscription ID
2. **Use version control** - Commit .tf files, not .tfvars
3. **Review plan before apply** - Always check what will change
4. **Document your changes** - Update azure-resources.md after deployment

## 🆘 Support

If you encounter issues:
1. Check troubleshooting section above
2. Review Terraform error messages
3. Verify Azure CLI authentication: `az account show`
4. Check Azure portal for resource creation status

## ✅ Next Steps

After successful deployment:

1. **Save the outputs** - Terraform displays critical configuration info
2. **Create azure-resources.md** - Document your deployment
3. **Configure Azure DevOps** - Follow setup instructions from outputs
4. **Continue to Step 2** - Azure DevOps configuration in the hackathon

---

**Ready to deploy?** Run `./deploy.sh` and follow the prompts! 🚀
