# Terraform

This contains most of the general documenation for how we use Terraform at MIT Libraries. For information regarding the legacy Terraform use, see [legacy-terraform](/deploy/legacy-terraform).

## Getting Started

All new Terraform work should be using version 1.0.x. We use Terraform Cloud for both remote state and remote execution. This means that for all future Terraform work, you'll need to configure your GitHub access, your AWS Access (see [AWS 2.0](/deploy/aws-2.0)), your Terraform Cloud access (see **Terraform Cloud** section below), and install the latest version of the Terraform 1.0 CLI (see **Terraform CLI (local)** section below).

## GitHub

As part of your onboarding, you created a GitHub account and were invited to join the MIT Libraries GitHub Organization. Your initial privileges in GitHub are limited until you have completed the onboarding process.

Our Terraform code is spread across multiple, targeted repositories, generally one Terraform repository per application with a few Terraform repositories that manage the core infrastructure in our AWS Accounts. The [mitlib-tfc-mgmt][https://github.com/MITLibraries/mitlib-tfc-mgmt] Terraform repository  manages all the other Terraform repositories (_one ring to rule them all?_). If you need an additional Terraform repository for new application-specific infrastructure, there is a process to add the necessary information to the management repository to create the necessary bits in GitHub (and Terraform Cloud).

## Terraform Cloud

There is a single [Terraform Cloud Organization for MIT Libraries](https://app.terraform.io/app/MITLibraries). As part of your onboarding, your kerb was linked to this organization. You will need to configure access to that organization for your workstation so that you can run speculative plans for your Terraform code. See the [Terraform Cloud CLI Login](https://learn.hashicorp.com/tutorials/terraform/cloud-login?in=terraform/0-13) Getting Started article from HashiCorp for a walkthrough and see the [CLI Configuration](https://www.terraform.io/docs/cli/config/config-file.html) page in the full Terraform Cloud documentation site for details.

All of our Terraform repositories are linked to Terraform Cloud workspaces (this is all managed by the repository referenced in the preceding section). Generally, once the Terraform repository is created and the Terraform Cloud workspace is created and linked, there are no other changes needed to the Terraform Cloud workspace save one: it is required that you manually trigger the first `terraform plan` through the Terraform Cloud workspace console. For more details on how we are using Terraform Cloud, see the [Terraform Cloud and GitHub](https://mitlibraries.atlassian.net/wiki/spaces/IN/pages/2893381658/USE%3A+Terraform+Cloud+and+GitHub) article in the InfraEng secure KB.

## Terraform CLI (local)

Even though we are using Terraform Cloud, you will still need a local copy of the Terraform CLI. We are currently building Terraform code compatible with Terraform 1.0. You will likely need older versions of the Terraform CLI to manage some of our legacy Terraform code. There are multiple tools for managing your Terraform CLI, and no one really cares which one you use. As long as you can fully control your version of Terraform and easily switch between versions.

### Version Managers for Terraform

**asdf**: [asdf](https://github.com/asdf-vm/asdf) This is a version manager for many cli tools, not just Terraform.

**tfenv**: [tfenv](https://github.com/tfutils/tfenv) This is a version manager specific to Terraform, modeled after `rbenv`.

## Modules

The InfraEng team no longer supports any internally managed modules. Instead, if we are building infrastructure that needs the simplification a module provides, we will rely on 3rd party, open-source modules. The default is to build our infrastructure without modules and only shift to a module if it is too difficult to do it otherwise.

## Variables

The managed Terraform repositories and Terraform Cloud workspaces have a pre-configured short list of variables. Those variables point to a hierarchy of values that can be stored in AWS SSM Parameter Store, and that is where we will manage all Terraform inputs and outputs (both for other Terraform code and for dependent applications). In very rare cases, the engineer can include an additional variable that will be stored in the workspace variable store in Terraform cloud. As a result, we no longer use local `.tfvars` files.

## Repositories in detail

The Terraform 1.0 repositories are private by default. Any Terraform repository can be made public by request, but this will trigger a detailed security review before the visibility settings can be changed. Please see [this InfraEng Decision document](https://mitlibraries.atlassian.net/wiki/spaces/IN/pages/2907865138).

The Terraform 1.0 repositories are targeted: one repo per application infrastructure. This is documented in [this Decision document](https://mitlibraries.atlassian.net/wiki/spaces/IN/pages/2899935256/Decision+004%3A+Use+small+repos+for+Terraform+code+instead+of+a+mono-repo).

The Terraform 1.0 repositories serve multiple deployment environments: one repo builds both stage and prod infrastructure. See this [Decision document](https://mitlibraries.atlassian.net/wiki/spaces/IN/pages/2901278721) as well as [this one](https://mitlibraries.atlassian.net/wiki/spaces/IN/pages/2900656132/Decision+010%3A+Core+Infrastructure+repos+will+have+three+long-running+branches%3A+dev%2C+stage%2C+and+main).

The Terraform 1.0 repositories are managed with a simplified version of Git Flow (instead of GitHub Flow). Details of how this will work is documented in [Simplified Git Flow for InfraEng](https://mitlibraries.atlassian.net/wiki/spaces/IN/pages/2920480769/Simplified+Git+Flow+For+InfraEng). The source of this model can be found in the [Simplified Git Flow](https://medium.com/goodtogoat/simplified-git-flow-5dc37ba76ea8) post on [medium.com](https://medium.com).
