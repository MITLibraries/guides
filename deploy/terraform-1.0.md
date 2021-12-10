# Terraform

This contains most of the general documenation for how we use Terraform at MIT Libraries. For information regarding the legacy Terraform use, see [legacy-terraform](./legacy-terraform.rst).

## Getting Started

All new Terraform work should be using version 1.0.x. We use Terraform Cloud for both remote state and remote execution. This means that for all future Terraform work, you'll need to configure your GitHub access, your AWS Access (see [AWS 2.0](/aws-2.0.md)), your Terraform Cloud access (see below), and install the latest version of the Terraform 1.0 CLI (see below).

## GitHub

As part of your onboarding, you created a GitHub account and were invited to join the MIT Libraries GitHub Organization. Your initial privileges in GitHub are limited until you have completed the onboarding process.

Our Terraform code is spread across multiple, targeted repositories, generally one Terraform repository per application with a few Terraform repositories that manage the core infrastructure in our AWS Accounts. There is a Terraform repository that manages all the other Terraform repositories (one ring to rule them all?). If you need an additional Terraform repository for new application-specific infrastructure, there is a process to add the necessary information to the master repository to create the necessary bits in Gith (and Terraform Cloud).

## Terraform Cloud

There is a single Terraform Cloud Organization for MIT Libraries. As part of your onboarding, your kerb was linked to this organization. You will need to configure access to that organization for your workstation so that you can run speculative plans for your Terraform code.

All of our Terraform repositories are linked to Terraform Cloud workspaces (this is all managed by the repository referenced in the preceding section). Generally, once the Terraform repository is created and the Terraform Cloud workspace is created and linked, there are no other changes needed to the Terraform Cloud workspace save one: it is required that you manually trigger the first `terraform plan` through the Terraform Cloud workspace console.

## Terraform CLI (local)

Even though we are using Terraform Cloud, you will still need a local copy of the Terraform CLI. We are currently building Terraform code compatible with Terraform 1.0. You will likely need older versions of the Terraform CLI to manage some of our legacy Terraform code. There are multiple tools for managing your Terraform CLI, and no one really cares which one you use. As long as you can fully control your version of Terraform and easily switch between versions.

### Version Managers for Terraform

**asdf**: [asdf](https://github.com/asdf-vm/asdf)

**tfenv**: [tfenv](https://github.com/tfutils/tfenv)

## Modules

The InfraEng team no longer supports any internally managed modules. Instead, if we are building infrastructure that needs the simplification a module provides, we will rely on 3rd party, open-source modules. The default is to build our infrastructure without modules and only shift to a module if it is too difficult to do it otherwise.

## Variables

The managed Terraform repositories and Terraform Cloud workspaces have a pre-configured short list of variables. Those variables point to a hierarchy of values that can be stored in AWS SSM Parameter Store, and that is where we will manage all Terraform inputs and outputs (both for other Terraform code and for dependent applications). In very rare cases, the engineer can include an additional variable that will be stored in the workspace variable store in Terraform cloud. As a result, we no longer use local `.tfvars` files.

## Repositories in detail

The Terraform 1.0 repositories are private by default. Any Terraform repository can be made public by request, but this will trigger a detailed security review before the visibility settings can be changed.

The Terraform 1.0 repositories are targeted: one repo per application infrastructure.

The Terraform 1.0 repositories serve multiple deployment environments: one repo builds both stage and prod infrastructure.

The Terraform 1.0 repositories are managed with a simplified version of Git Flow (instead of GitHub Flow). That is, we maintain multiple long-running branches in our Terraform repositories. Branch protection rules are in place on all the long-running branches.
