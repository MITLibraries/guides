Legacy Terraform
=========

This contains most of the documentation for how we use Terraform here. The primary repository is located at https://github.com/MITLibraries/mitlib-terraform but there are other repos in the org that provide modules.

Getting Started
---------------

For all new TF work you should be using version 0.12. We make heavy use of workspaces to manage deploying to different environments. The first thing you should do is set the ``TF_WORKSPACE`` environment variable to ``stage``. You should make this change persistent in whatever way you manage environment variables on your system. The easiest way to do this is to add the following to your ``~/.bashrc`` file (if you use bash)::

  export TF_WORKSPACE=stage

However you choose to do this, *it should be the first thing you do.* Making this change will ensure you aren't accidentally deploying to production.

Workspaces
----------

We use ``stage`` and ``prod`` workspaces. If you have followed the instructions you should be deploying to the staging workspace by default. You can simply run ``terraform plan`` and ``terraform apply`` and it will deploy to staging.

When you are ready to deploy to production you will need to explicitly specify the ``prod`` workspace. Rather than changing the ``TF_WORKSPACE`` envvar for your entire session, the recommended practice is to change it only for the command you are running. This may vary depending on which shell you are using. For bash, you would do the following::

  $ TF_WORKSPACE=prod terraform plan

Doing things this way keeps it explicit about deploying to production.

Modules
-------

Our current TF config uses quite a few external modules. This is a decision that has not aged well. TF modules are an acceptable solution, but the advice given in `the Terraform documentation <https://www.terraform.io/docs/modules/index.html#when-to-write-a-module>`_ should be followed. In general, if you are just wrapping a handful of AWS resources, don't use a module; it's better to just copy and paste. If you are using an external module make sure you are linking to a specific release and not just the master branch.

Variables
---------

If there are differences between staging and production, or you have secrets that need to be included, you should use TF variables. Include ``prod.tfvars`` and ``stage.tfvars`` files in your config. These should not be checked into version control. The main repo is currently set to ignore all ``.tfvars`` files.

We don't have a great solution for sharing these variables yet. Until a better solution can be set up, you will need to manually sync these variables to the ``mit-tfvars`` S3 bucket. The structure of this bucket should mimic the structure of the main repo.
