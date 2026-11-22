param location string = 'westeurope'
param keyVaultName string = 'kv-eTimeTrial'
param cosmosEndpoint string=''
param acrName string
param webAppName string

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: acrName
}

resource appPlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: '${webAppName}-plan'
  location: location

  kind: 'linux'

  sku: {
    name: 'B1'
    tier: 'Basic'
  }

  properties: {
    reserved: true
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${webAppName}-appi'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}


resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location

  identity: {
    type: 'SystemAssigned'
  }

  properties: {
    serverFarmId: appPlan.id

    siteConfig: {
      linuxFxVersion: 'DOCKER|${acr.properties.loginServer}/etimetrial-web:latest'
      acrUseManagedIdentityCreds: true
    }
  }
}

resource webAppSettings 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: webApp
  name: 'appsettings'

  properties: {
    ASPNETCORE_ENVIRONMENT: 'Production'

    WEBSITES_PORT: '8080'

    AzureAd__TenantId: '8f3c88c1-8477-49a2-a4a3-388052b55f75'
    AzureAd__FrontendClientId: '2c84ea02-7314-4bd8-aa9e-20d37c53388e'
    AzureAd__FrontendClientSecret: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/eTimeTrialFrontendClientSecret/)'
    AzureAd__CallbackPath: '/signin-oidc'

    CosmosDb__Endpoint: cosmosEndpoint
    CosmosDb__Key: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/CosmosDBKey/)'
    CosmosDb__DatabaseName: 'RaceDb'
    CosmosDb__ContainerName: 'Races'

    APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsights.properties.ConnectionString

    ApplicationInsights__ConnectionString: applicationInsights.properties.ConnectionString
  }
}


