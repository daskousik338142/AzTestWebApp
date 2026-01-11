#!/bin/bash

# Azure Deployment Script for Simple Menu Application
# Make sure you have Azure CLI installed and are logged in: az login

# Configuration
RESOURCE_GROUP="SimpleMenuAppRG"
APP_SERVICE_PLAN="SimpleMenuAppPlan"
WEB_APP_NAME="simplemenuapp-$(openssl rand -hex 4)"  # Generates unique name
LOCATION="East US"
SKU="B1"  # Basic tier - change to F1 for free tier

echo "Starting deployment of Simple Menu Application to Azure..."
echo "Web App Name: $WEB_APP_NAME"

# Create resource group
echo "Creating resource group: $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location "$LOCATION"

# Create App Service plan
echo "Creating App Service plan: $APP_SERVICE_PLAN"
az appservice plan create \
    --name $APP_SERVICE_PLAN \
    --resource-group $RESOURCE_GROUP \
    --sku $SKU \
    --location "$LOCATION"

# Create web app with .NET 9 runtime
echo "Creating web app: $WEB_APP_NAME"
az webapp create \
    --resource-group $RESOURCE_GROUP \
    --plan $APP_SERVICE_PLAN \
    --name $WEB_APP_NAME \
    --runtime "DOTNETCORE:9.0"

# Build and publish the application
echo "Building and publishing application..."
dotnet publish -c Release -o ./publish

# Create deployment package
echo "Creating deployment package..."
cd publish
zip -r ../deploy.zip .
cd ..

# Deploy to Azure
echo "Deploying to Azure App Service..."
az webapp deploy \
    --resource-group $RESOURCE_GROUP \
    --name $WEB_APP_NAME \
    --src-path deploy.zip \
    --type zip

# Get the URL
APP_URL="https://$WEB_APP_NAME.azurewebsites.net"
echo ""
echo "Deployment completed!"
echo "Your application is available at: $APP_URL"
echo ""
echo "To delete the resources later, run:"
echo "az group delete --name $RESOURCE_GROUP --yes --no-wait"