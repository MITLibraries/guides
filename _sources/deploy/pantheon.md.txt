# Pantheon

The MIT Libraries have made the choice to migrate many PHP-based websites to the [Pantheon](https://pantheon.io/) platform.

## Multidev workflow

For newer websites built with WordPress or Drupal 8 / 9, the preferred workflow is to use [Build Tools](https://pantheon.io/docs/guides/build-tools/). This process is meant to closely resemble the experience of working with Heroku. Using local tooling such as [Composer](https://getcomposer.org/), the [WordPress CLI](https://developer.wordpress.org/cli/commands/), or [Drush](https://www.drush.org/latest/), the developer makes changes and commits them to a new branch. These changes are then pushed to a repository on the MIT Libraries' GitHub, which is deployed via CircleCI to a review application. The Pantheon term for this workflow is [Multidev](https://pantheon.io/docs/multidev).

While it is possible to run a local version of the application under this workflow, this is currently more complex than it should be. The TL;DR is to set up the review app by pushing a branch to GitHub first, then clone the resulting Multidev environment using Localenv. **Care should be taken when attempting to push local changes back to GitHub. The git branch and git remotes should be monitored closely.**

Once these changes have been reviewed and approved, and the Dev environment is redeployed, the [WebOps workflow](#webops-workflow) below is followed to move the new code into production.

## Legacy workflow

For older sites based on Drupal 7 - which need ongoing updates but don't undergo active development - the preferred workflow is one using [Localdev](https://pantheon.io/docs/guides/localdev) and Composer but does not use multidev environments.

These sites use Pantheon's own git infrastructure as their code repository, and developers push changes directly to the Dev environment. Local copies of the site can be created by Localdev.

Once changes have been approved in Dev, the [WebOps workflow](#webops-workflow) is used for promoting updates from Dev, through Test, and into the Live environments.

## WebOps workflow

Once updates are approved and present in a site's Dev environment, the pipeline for moving these changes into production is covered by Pantheon's [WebOps workflow](https://pantheon.io/docs/pantheon-workflow).
