Working with AWS
================

This covers basic documentation for working with our AWS account.

.. warning:: You will have access to create AWS resources, but you should not do this unless you have been instructed to do so. Most of our infrastructure provisioning is automated through Terraform.

Getting Started
---------------

You will effectively have two different AWS accounts. The first is the account you will use to log into the web console. This account is integrated with Touchstone. To get access, ask in the #engineering channel. Someone with the correct permissions will need to log into https://groups.mit.edu/webmoira and add the user to ``the aws-672626379771-dev`` list. This will give you access to the AWS console which can be accessed from https://aws.mit.edu.

The next thing you need to do is complete the account setup that you can use 
to authenticate locally, either from the AWS CLI or through an AWS library like boto3. First, 
confirm with InfraEng (or ask on the #engineering Slack channel) that your CLI account has been
added to our AWS organization (InfraEng handles this via Terraform). Then, log into the AWS console and follow these steps.

1. Under ``Services`` in the top bar search for "IAM" and click on that.
2. Click on ``Users``, search for your kerb, and then click on it.
3. Click on the ``Security Credentials`` tab.
4. Click on the ``Create access key`` button.  
5. Make sure you copy the keys that it generates for you as this will be your only chance to do so.

Creating a new Moira-based Role
-------------------------------

In some cases we need to give non-developer library staff access to AWS resources directly. This is most commonly done when a user needs to be able to manage files in an S3 bucket. While we should strive to mediate access to AWS resources through applications, when the need arises, the way to do this is through a special moira list that's integrated with Touchstone.

Setting up the Moira List
~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: Make sure to follow these instructions carefully as there is some IS&T magic involved.

1. Go to https://groups.mit.edu/webmoira and create a new moira (*not* mailman) list.
2. The name of the list must start with ``aws-672626379771-``. For example, you could name it ``aws-672626379771-gis-upload``.
3. The options at the bottom of the list creation page should look like this:

  |  ☐ Is this list public?
  |  ☑ Is this list hidden?
  |  ☐ Is this list a mailing list?
  |  ☐ Is this list an AFS group?
  |  ☐ Is this group for use on IS&T's NFS servers?

4. Create the list.

Creating the IAM Role
~~~~~~~~~~~~~~~~~~~~~

In order to use this new list in AWS you will need to create a special IAM Role for it. *This should be done through Terraform, not pointing and clicking in the web console.* The following shows the necessary Terraform::

  data "aws_iam_policy_document" "saml_policy" {
    statement {
      actions = ["sts:AssumeRoleWithSAML"]

      principals {
        type        = "Federated"
        identifiers = [module.shared.mit_saml_arn]
      }

      condition {
        test     = "StringEquals"
        variable = "SAML:aud"
        values   = ["https://signin.aws.amazon.com/saml"]
      }
    }
  }

  resource "aws_iam_role" "saml_role" {
    name               = "IdP-<some name>"
    assume_role_policy = data.aws_iam_policy_document.saml_policy.json
  }

The name of the role needs to be the name of the moira list prefixed by ``IdP-``. For example, if the moira list you created was called ``aws-672626379771-foobar``, then the AWS role name should be ``IdP-foobar``.

This new role can now be used as you would any other IAM role. Users on the moira list who need to access AWS should log in the same way everyone does, through https://aws.mit.edu. If they are on more than one of these special moria lists, they will be presented with the option to choose which role they want to log in as. You can only be logged in under one of these roles at a time.

Weird Things
------------

Sometimes AWS is weird and frustrating. These things go here.

RSA 4096 Certs
~~~~~~~~~~~~~~

Amazon's Certificate Manager does not handle RSA 4096 certificates yet. If you have one of these it will need to be added to IAM. There is no way that I can find to do this through either Terraform or the web console. You'll have to use the AWS CLI::

  $ aws iam upload-server-certificate \
    --server-certificate-name <hostname> \
    --certificate-body file://<your cert>.crt \
    --certificate-chain file://<your cert>.chain.crt \
    --private-key file://<your cert>.key

EFS Mount Race Conditions
~~~~~~~~~~~~~~~~~~~~~~~~~

I have observed on multiple occasions problems with mounting newly created EFS mounts in EC2 instances. This seems more likely to happen with Terraform due to resources being provisioned all at once. My guess is the DNS for the new EFS mount has not propagated by the time the cloud-init script is run, where you would usually do the NFS mount.

There's no obvious (easy) mitigation for this. The good news is since it appears to simply be a DNS propagation issue, this should only be a problem for a short period after the initial provisioning of the EFS mount. My suggestion is to check the logs for your cloud-init script if you are spinning up an EC2 instance at the same time you are creating the EFS mount. There should be an error in there if it can't resolve the hostname for the mount.

Fargate Log Flushing
~~~~~~~~~~~~~~~~~~~~

Sometimes logs in Fargate don't get written, or are only partially written, to Cloudwatch. My own experience suggests the problem is that the logs are being discarded before being fully flushed to Cloudwatch. The fix, which I have found to be reliable, is to add a few seconds of sleep to your container after you have stopped the main process. You can see an example here: https://github.com/MITLibraries/workflow/blob/master/entrypoint.sh.

S3 Bucket Limit
~~~~~~~~~~~~~~~

There's a limit to the number of buckets an account can have in S3. Rather than creating a bunch of buckets, partition a few buckets with predictable prefixes. We do not currently do this, but it's a practice we should consider switching to, soon.
