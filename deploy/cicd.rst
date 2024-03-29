Continuous Integration/Deployment
=================================

Your first choice for CI/CD should be Github Actions. If you are having trouble getting this to work, please ask in the #engineering Slack channel.

.. sidebar:: Heroku Deploys

   If your application is being deployed to Heroku, you should just be using Heroku Pipelines, not Github Actions.

This guide will provide an overview of how the deployment process should generally work, with specific examples for the more common cases.

Overview
--------

Most applications will have specific needs that may differ from other applications, but the general process for testing and deployment should follow the form:

1. Run tests when pushing commits.
2. Deploy staging build when merging PR onto master branch.
3. Deploy production build when a release is created.

The act of creating a release in Github is how you decide when to deploy a new production instance. The most recent release should always be the code that's running in production.

Testing
-------

.. sidebar:: Language specific examples

   - `CI for Rails at MIT Libraries <../languages/rails.html#continuous-integration>`_

The testing action will likely vary from project to project, so your best bet will be to look at examples of what other projects have done and ask in #engineering if you are having trouble. As a general rule your testing action should run on every push. This can be accomplished by setting::

  on: push

in your ``.github/workflows/test.yml`` file.

AWS 2.0 Fargate/Lambda Deployment
---------------------------------

With the migration to our AWS Organization (see `AWS 2.0 <./aws-2.0>`), we have simplified and automated the container deployment process.

1. For both Lambda functions and ECS tasks/services, we make use of the AWS ECR container repositories. These are fully managed by the `mitlib-tf-workloads-ecr <https://github.com/mitlibraries/mitlib-tf-workloads-ecr>`` repository. The repo not only creates the ECR repository, it also generates the Makefile for the associated repo that builds the container as well as the GitHub Actions workflows for pushing containers to dev, stage, and prod AWS Accounts.
2. Once an Infra engineer has deployed the ECR repository, some copy/paste from the Terraform outputs will setup the Makefile and GitHub Actions workflows for the container repo.
3. The automation follows our standard practice that (a) PRs to the `main` branch will push an updated container to the dev AWS Account, (b) merges to `main` will push an updated container to the stage AWS Account, and (c) a tagged release on `main` will copy the container from the stage to the prod AWS Account.

The section below is only necessary for applications that are not yet migrated to the new AWS Organization.

Legacy AWS Fargate Deployment
-----------------------------

Most of our AWS deployments target Fargate. The staging and production deploys should look more or less the same. There is a yaml template (:download:`deploy.yml`) that can be used for both, with only a few changes you will need to make. To use this template, do the following:

1. Make two copies of the template, one called ``.github/workflows/stage.yml`` and one called ``.github/workflows/prod.yml``.
2. Set the top level ``name`` key in each file to something more descriptive, like "Deploy staging build" and "Deploy production release".
3. For the ``stage.yml`` file change the ``on`` key to::

     on:
       push:
         branches: [master]

  And for the ``prod.yml`` file change the ``on`` key to::

    on:
      release:
        types: [published]

4. In the template, under the ``env`` section, set the ``IMAGE``, ``CLUSTER`` and ``SERVICE`` to the values given to you by the infrastructure team.
5. You will need a set of keys for a deploy user that has permission to upload images to ECR and redeploy the ECS service (ask in #engineering if you have not been given these). These should be set as secrets through the Github UI for the repo.
