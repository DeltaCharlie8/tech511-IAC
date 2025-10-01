# Infrastructure as Code (IaC)

- [Infrastructure as Code (IaC)](#infrastructure-as-code-iac)
  - [What problem needs solving](#what-problem-needs-solving)
  - [What have we automated so far?](#what-have-we-automated-so-far)
  - [Solving the problem](#solving-the-problem)
    - [What is IaC?](#what-is-iac)
    - [Benefits of IaC](#benefits-of-iac)
    - [Where/when to use it](#wherewhen-to-use-it)
    - [Tools available for IaC/Types of tools](#tools-available-for-iactypes-of-tools)
- [Terraform](#terraform)
    - [Installing Terraform (Windows)](#installing-terraform-windows)
- [Ansible](#ansible)

## What problem needs solving
- Still manually provisioning the servers

  What do we mean by provisioning?
  - the process of setting up and configuring servers

## What have we automated so far?
- VMs
  - creation of VMs? No, other than auto scaling group
  - creation of the infrastructure they live in (e.g. VNet)? No
  - Setup and configuration of software on VMs? Yes, how?
    - bash scripts
    - user data
    - AMIs

## Solving the problem
Infrastructure as Code (IaC) can do the provisioning of :
- the infrastructure itself (servers)
- configure the servers i.e installing the correcgt software and configuring settings

### What is IaC?
- a way to manage and provision computers through a machine-readable definition of the infrastructure.
- Usually you codify WHAT you want (declarative), not HOW you want it done (imperative).

### Benefits of IaC
- speed and simplicity
  - reduce the time to deploy infrastructure
  - you simply describe the end state and the tool works out the rest
- consistency and accuracy
  - avoid human error trying to create/maintain the same infrastructure
- version control
  - easily keep track of the different versions of the infrastructure
- scalability 
  - very easy to scale or duplicate the structure (includnig for different environments)

### Where/when to use it
- use your best judgement - will automating the infrastructure be worth the investment in time?

### Tools available for IaC/Types of tools
Two types of IaC:
  1. Configuration management tools - best for installing/configuring software
     - chef
     - puppet
     - ansible
  2. Orchestration tools - best for managing infrastructure e.g VMs, security groups, route tables
     - cloudFormation (AWS)
     - Terraform
     - Arm/Bicep templates (Azure)
     - Ansbile (can do this, but not recommended for orchestration)

<br>

# [Terraform](terraform)

### Installing Terraform (Windows)
1. open your PowerShell as administrator
2. run this command to see if Chocolatey is installed
```
choco -v
```
3. once installed, run this command to install Terraform
```
choco install terraform -y
```
4. verify the installation by checking the version
```
terraform -version
```
5. you should see something like:
```
Terraform v1.13.3
```
6. run the command again in your gitbash to confirm that terraform can be used anywhere on your pc

**Please note: if using VS Code, add the terraform extension (official one by Hashicorp)**

# [Ansible](ansible)