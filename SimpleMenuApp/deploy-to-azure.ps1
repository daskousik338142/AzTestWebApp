# Azure Deployment Script for Simple Menu Application (PowerShell)
# Make sure you have Azure CLI installed and are logged in: az login

# Configuration
$RESOURCE_GROUP = "SimpleMenuAppRG"
$APP_SERVICE_PLAN = "SimpleMenuAppPlan"
$WEB_APP_NAME = "simplemenuapp-$(Get-Random -Maximum 9999)"  # Generates unique name
$LOCATION = "East US"
$SKU = "B1"  # Basic tier - change to F1 for free tier

Write-Host "Starting deployment of Simple Menu Application to Azure..." -ForegroundColor Green
Write-Host "Web App Name: $WEB_APP_NAME" -ForegroundColor Yellow

# Create resource group
Write-Host "Creating resource group: $RESOURCE_GROUP" -ForegroundColor Cyan
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create App Service plan  
Write-Host "Creating App Service plan: $APP_SERVICE_PLAN" -ForegroundColor Cyan
az appservice plan create `
    --name $APP_SERVICE_PLAN `
    --resource-group $RESOURCE_GROUP `
    --sku $SKU `
    --location $LOCATION

# Create web app with .NET 9 runtime
Write-Host "Creating web app: $WEB_APP_NAME" -ForegroundColor Cyan
az webapp create `
    --resource-group $RESOURCE_GROUP `
    --plan $APP_SERVICE_PLAN `
    --name $WEB_APP_NAME `
    --runtime "DOTNETCORE:9.0"

# Build and publish the application
Write-Host "Building and publishing application..." -ForegroundColor Cyan
dotnet publish -c Release -o ./publish

# Create deployment package
Write-Host "Creating deployment package..." -ForegroundColor Cyan
Compress-Archive -Path ./publish/* -DestinationPath ./deploy.zip -Force

# Deploy to Azure
Write-Host "Deploying to Azure App Service..." -ForegroundColor Cyan
az webapp deploy `
    --resource-group $RESOURCE_GROUP `
    --name $WEB_APP_NAME `
    --src-path deploy.zip `
    --type zip

# Get the URL
$APP_URL = "https://$WEB_APP_NAME.azurewebsites.net"

Write-Host ""
Write-Host "Deployment completed!" -ForegroundColor Green
Write-Host "Your application is available at: $APP_URL" -ForegroundColor Yellow
Write-Host ""
Write-Host "To delete the resources later, run:" -ForegroundColor Cyan
Write-Host "az group delete --name $RESOURCE_GROUP --yes --no-wait" -ForegroundColor White

# Open the application in browser
Write-Host "Opening application in browser..." -ForegroundColor Green
Start-Process $APP_URL