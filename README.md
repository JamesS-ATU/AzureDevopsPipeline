# Azure DevOps Pipeline Project

## Overview

This repository demonstrates the implementation of a complete DevOps workflow using Azure DevOps. The project showcases how source code, infrastructure, testing, and deployment processes can be automated using Continuous Integration (CI), Continuous Deployment (CD), and Infrastructure as Code (IaC).

The solution combines Source code repositories(GitHub/Azure Github), Azure Pipelines, Release Pipelines, automated testing, and Bicep templates to deliver a reliable and repeatable deployment process.

## Technologies Used

- GitHub/Azure Github
- Azure Pipelines (YAML)
- Bicep (Infrastructure as Code)
- Automated Testing

## Continuous Integration (CI)

[View CI Pipeline](./azure-pipelines.yml)

The CI pipeline define in the YAML pipeline defines the Continuous Integration (CI) process as code. It automates source code retrieval, application build, automated testing, artefact creation, and deployment preparation. Storing the pipeline in source control ensures consistency, versioning, and repeatability across environments.

- Retrieving source code from Azure Repos
- Restoring project dependencies
- Building the application
- Running automated unit tests
- Publishing test results
- Creating deployment artefacts
- Publishing artefacts for deployment
- Deploys infrastructure and application resources using source-controlled definitions

This ensures code quality is verified before any deployment activities take place.

## Continuous Deployment (CD)

## Infrastructure as Code

[View Bicep IaC](./bicep/main.bicep)

Infrastructure provisioning is managed using Bicep templates.

The Bicep template implement Infrastructure as Code (IaC) by defining Azure resources programmatically. The templates are used by the deployment pipeline to provision and configure the Azure resources automatically, ensuring that environments are deployed consistently and can be recreated when required.

## Conclusion

This project demonstrates how Azure DevOps can be used to implement as a complete Devops ecosystem for version control, automated testing, Continuous Integration, Continuous Deployment, and Infrastructure as Code into a single without the overhead of multiple different applications for each stage of the pipeline