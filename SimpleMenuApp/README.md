# Simple Menu Application

A simple ASP.NET Core MVC application with navigation menu and welcome message, designed for Azure deployment.

## Features

- **Responsive Design**: Built with Bootstrap for mobile-friendly interface
- **Navigation Menu**: Easy-to-use menu with Home, About, Services, and Contact pages  
- **Welcome Message**: Dynamic welcome message with current date/time
- **Clean UI**: Modern design with Font Awesome icons
- **Azure Ready**: Configured for deployment to Azure App Service

## Local Development

### Prerequisites
- .NET 9.0 SDK
- Visual Studio Code or Visual Studio

### Running Locally
```bash
cd SimpleMenuApp
dotnet restore
dotnet build
dotnet run
```

The application will be available at `http://localhost:5228`

## Azure Deployment

This application is configured for deployment to Azure App Service.

### Option 1: Azure Portal Deployment
1. Create an Azure App Service instance
2. Choose .NET 9.0 runtime stack
3. Deploy using ZIP file or Git integration

### Option 2: Azure CLI Deployment
```bash
# Create resource group
az group create --name SimpleMenuAppRG --location "East US"

# Create App Service plan
az appservice plan create --name SimpleMenuAppPlan --resource-group SimpleMenuAppRG --sku B1 --is-linux

# Create web app
az webapp create --resource-group SimpleMenuAppRG --plan SimpleMenuAppPlan --name your-unique-app-name --runtime "DOTNETCORE:9.0"

# Deploy from local Git repository
az webapp deployment source config-local-git --name your-unique-app-name --resource-group SimpleMenuAppRG
```

### Option 3: Visual Studio Code Azure Extension
1. Install the Azure App Service extension
2. Sign in to your Azure account
3. Right-click the project folder and select "Deploy to Web App"
4. Follow the prompts to create or select an Azure resource

## Project Structure

```
SimpleMenuApp/
├── Controllers/
│   └── HomeController.cs          # Main controller with menu actions
├── Views/
│   ├── Home/
│   │   ├── Index.cshtml           # Welcome page
│   │   ├── About.cshtml           # About page
│   │   ├── Services.cshtml        # Services page
│   │   ├── Contact.cshtml         # Contact page
│   │   └── Privacy.cshtml         # Privacy page
│   └── Shared/
│       └── _Layout.cshtml         # Main layout with navigation
├── wwwroot/
│   └── css/
│       └── site.css               # Custom styles
├── Program.cs                     # Application startup
├── web.config                     # IIS configuration for Azure
└── README.md                      # This file
```

## Configuration

The application uses standard ASP.NET Core configuration:
- `appsettings.json` - Base configuration
- `appsettings.Development.json` - Development-specific settings
- Azure App Service will automatically use production settings

## Technologies Used

- ASP.NET Core 9.0 MVC
- Bootstrap 5.3
- Font Awesome 6.0
- Entity Framework Core (ready for database integration)

## License

This is a sample application for educational and demonstration purposes.