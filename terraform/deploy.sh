#!/bin/bash
# One-Click Deployment Script for Azure AI Agent Hackathon
# This script deploys all required Azure resources with unique naming

set -e  # Exit on error

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  Azure AI Agent Hackathon - Resource Deployment               ║"
echo "║  One-Click Setup for Multi-Environment AI Agent Deployment    ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Check prerequisites
echo "🔍 Checking prerequisites..."

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "❌ Azure CLI is not installed. Please install it first:"
    echo "   https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Terraform is not installed. Please install it first:"
    echo "   https://www.terraform.io/downloads"
    exit 1
fi

echo "✅ Prerequisites check passed"
echo ""

# Check Azure CLI login
echo "🔐 Checking Azure authentication..."
if ! az account show &> /dev/null; then
    echo "⚠️  Not logged in to Azure. Running 'az login'..."
    az login
fi

# Get subscription ID
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
echo "✅ Authenticated to Azure"
echo "   Subscription ID: $SUBSCRIPTION_ID"
echo ""

# Create or update terraform.tfvars if it doesn't exist
if [ ! -f terraform.tfvars ]; then
    echo "📝 Creating terraform.tfvars from template..."
    if [ -f terraform.tfvars.example ]; then
        cp terraform.tfvars.example terraform.tfvars
        # Replace the subscription ID placeholder
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            sed -i '' "s/YOUR-SUBSCRIPTION-ID-HERE/$SUBSCRIPTION_ID/g" terraform.tfvars
        else
            # Linux
            sed -i "s/YOUR-SUBSCRIPTION-ID-HERE/$SUBSCRIPTION_ID/g" terraform.tfvars
        fi
        echo "✅ Created terraform.tfvars with your subscription ID"
    else
        echo "❌ terraform.tfvars.example not found"
        exit 1
    fi
else
    echo "✅ Using existing terraform.tfvars"
fi
echo ""

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init
echo ""

# Plan deployment
echo "📋 Planning deployment..."
echo "   This will show what resources will be created..."
echo ""
terraform plan -out=tfplan
echo ""

# Ask for confirmation
read -p "🚀 Deploy these resources? (yes/no): " confirmation
if [ "$confirmation" != "yes" ]; then
    echo "❌ Deployment cancelled"
    exit 0
fi
echo ""

# Apply Terraform configuration
echo "🚀 Deploying Azure resources..."
echo "   This may take 10-15 minutes..."
echo ""
terraform apply tfplan
echo ""

# Show outputs
echo "✅ Deployment complete!"
echo ""
echo "📋 Displaying configuration outputs..."
terraform output azure_devops_setup_instructions
echo ""

# Save outputs to file
echo "💾 Saving configuration to azure-resources.md..."
cat > ../azure-resources.md << 'EOF'
# Azure Resources Created

## Deployment Information

**Date:** $(date)
**Unique Suffix:** $(terraform output -raw unique_suffix)
**Resource Prefix:** $(terraform output -raw resource_prefix_full)

## Resource Groups

EOF

terraform output -json resource_groups | jq -r 'to_entries[] | "- **\(.key)**: \(.value.name) (Location: \(.value.location))"' >> ../azure-resources.md

cat >> ../azure-resources.md << 'EOF'

## Azure OpenAI Endpoints

EOF

terraform output -json openai_endpoints | jq -r 'to_entries[] | "- **\(.key)**: \(.value)"' >> ../azure-resources.md

cat >> ../azure-resources.md << 'EOF'

## Next Steps

1. ✅ Resources deployed successfully
2. 📋 Configure Azure DevOps service connections
3. 📋 Create variable groups in Azure DevOps
4. 🚀 Continue to Step 2 of the hackathon!

See the output above for detailed Azure DevOps configuration instructions.
EOF

echo "✅ Configuration saved to azure-resources.md"
echo ""

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  🎉 SUCCESS! Resources deployed successfully!                  ║"
echo "║                                                                ║"
echo "║  Next: Configure Azure DevOps using the instructions above    ║"
echo "║  File: azure-resources.md has been created for reference      ║"
echo "╚════════════════════════════════════════════════════════════════╝"
