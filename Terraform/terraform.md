# Intro to Terraform

- [Intro to Terraform](#intro-to-terraform)
  - [what is Terraform, what is it used for](#what-is-terraform-what-is-it-used-for)
  - [Why use Terraform, what are the benefits](#why-use-terraform-what-are-the-benefits)
  - [Alternatives to Terraform](#alternatives-to-terraform)
  - [Who is using Terraform in the industry](#who-is-using-terraform-in-the-industry)
      - [Tech Companies and Startups:](#tech-companies-and-startups)
      - [Financial Institutions (regulated industry):](#financial-institutions-regulated-industry)
      - [Cloud Providers and SaaS Platforms:](#cloud-providers-and-saas-platforms)
      - [Media and Entertainment:](#media-and-entertainment)
      - [Healthcare (regulated industry) and Life Sciences:](#healthcare-regulated-industry-and-life-sciences)
      - [Telecommunications:](#telecommunications)
      - [Retail and E-Commerce:](#retail-and-e-commerce)
      - [Gaming Industry:](#gaming-industry)
      - [Government and Public Sector:](#government-and-public-sector)
      - [Consulting and Cloud Services:](#consulting-and-cloud-services)
      - [Education and Research Institutions:](#education-and-research-institutions)
  - [In IaC, what is orchestration?](#in-iac-what-is-orchestration)
  - [How does Terraform act as the orchestrator?](#how-does-terraform-act-as-the-orchestrator)
  - [Best practice supplying AWS credentials to Terraform](#best-practice-supplying-aws-credentials-to-terraform)
    - [How should AWS credentials never be passed to Terraform?](#how-should-aws-credentials-never-be-passed-to-terraform)
  - [Why use Terraform for different environments (e.g. production, testing etc)](#why-use-terraform-for-different-environments-eg-production-testing-etc)
  - [How Terraform Works](#how-terraform-works)
  - [Configuration drift](#configuration-drift)


## what is Terraform, what is it used for
- Orchestration tool
- best for infrastructure provisioning
- originally inspired by AWS CloudFormation
- Sees infrastructure as immutable (not changeable)
    - in order to change the data, it has to be reassigned/ recreated completely
    - Compare this to configuration Management tool which usually see infrastructure as mutable or reusuable
  - Code in Hashicorp configuration language (HCL)
    - good for human and machine readability
    - HCL can be converted to JSON vice versa


## Why use Terraform, what are the benefits
- Easy to use
- sort-of open source
  - since 2023 uses the business source licence (BSL) meaning that Terraform can be used privately and commercially for free, but not for any competing product.
  - some organistations are now moving towards using OpenTofu
    - community driven, linux foundation, fork of Terraform under an open surce licence
- declarative
  - about the destination, you say what you want at the end
- cloud-agnostic - can use different cloud providers
  - to support a cloud provider, you need to first download the provider (as a plug-in)
  - each cloud vendor maintains it's own provider
  - expressive and extendable, because it supports many providers and plug-ins, if Terraform doesn't have it, you can create your own custom plug-in

## Alternatives to Terraform
- Pulumi (similar but not declarative)
- AWS CloudFormation, GCP Deployment Manager, Azure Resource Manager (using ARM templates)
  - cloud specific products

## Who is using Terraform in the industry
#### Tech Companies and Startups:
- Uber 
- Spotify 
- Airbnb 
- Coinbase
#### Financial Institutions (regulated industry):
- JPMorgan Chase 
- Goldman Sachs 
- Capital One
#### Cloud Providers and SaaS Platforms:
- AWS 
- Google Cloud
- Salesforce
#### Media and Entertainment:
- The New York Times
- Netflix
#### Healthcare (regulated industry) and Life Sciences:
- Philips 
- Cerner
#### Telecommunications:
- Verizon
- T-Mobile
#### Retail and E-Commerce:
- Walmart 
- Target
#### Gaming Industry:
- Electronic Arts (EA) 
- Riot Games (they make/run League of Legends)
#### Government and Public Sector:
- UK Government Digital Service (GDS) 
- NASA
#### Consulting and Cloud Services:
- Accenture,
- Deloitte
#### Education and Research Institutions:
- Harvard University
- MIT

## In IaC, what is orchestration?
- The process of automating and managing the entire lifecycle of infrastructure resource
## How does Terraform act as the orchestrator?
- Takes care of order in which to create/modify/destroy etc
- can be used with multiple cloud providers at the same time

## Best practice supplying AWS credentials to Terraform
Looks for credentials in this order:

  1. Environment variables: `AWS_ACCESS_KEY_ID` (okay for local use and restircted to one user)
  2. Terraform variables - you can set the credentials in your code
     - should never do this because we NEVER hard-code credentials
  3. AWS CLI when you run `aws config` (good way of doing it)
  4. If using Terraform on a EC2 instance we can give it an IAM role, giving it permissions to do certain things on AWS (best practice but not possible on your local machine)
     - list virtual machines
     - create virtual machines

### How should AWS credentials never be passed to Terraform?
- NEVER hard-code them and they can never end up on a public Git repo

## Why use Terraform for different environments (e.g. production, testing etc)
Examples
- Testing environment
  - quickly create infrastructure for testing purposes that mirrors production and close it down when finished
- consistency between environments reducing bugs caused by environment discrepancies

## How Terraform Works
insert diagram and explanation here*

## Configuration drift
something that happens over time where the configurations of separate machines slowly change, making them no longer identical.

This can be fixed using configuration mangement tools like Ansible.
- it can go and check the software and detect if the changes in software does not align within the machines and rectifies this.

If its anything to do with infrastructure alignment - use an orchestration tool
If its anything to do with software alignment - use a configuration management tool