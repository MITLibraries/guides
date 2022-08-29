# AWS Organization

As of December 2021, MIT Libraries has shifted to an AWS Organization containing multiple AWS Accounts. We have enabled AWS SSO, integrated with Touchstone, for access to all of our AWS Accounts in our AWS Organization.

## Getting Started

Verify that you can access our AWS Organization by visiting [MIT Libraries AWS Landing Page](https://mitlib.awsapps.com/start#/). Log in with your MIT kerb and be prepared for Touchstone MFA via the Duo app. This is the only way to access any resources in our AWS Accounts as a human. If you have any access issues, contact the InfraEng team via Slack or JSM.

## AWS Org Accounts

There are multiple AWS Accounts in our single AWS Organization. A few of these accounts have very limited access for a subset of InfraEng for the purpose of audit logging and security reviews. The remainder of the accounts serve one of three purposes.

1. Stage and Production workloads (one AWS Account for stage, one AWS Account for prod)
1. Dedicated AWS Accounts for groups in MIT Libraries with specific needs (e.g., the AWS Account for CREOS)
1. Development workspaces for experimenting and developing new infrastructure and/or experimenting with additional AWS Services

Access to these accounts is managed with two repositories that handle user/group creation and permission set / account assignment.

## Access

Detailed instructions for how to access AWS Accounts in our AWS Organization can be found at [AWS via AWS SSO](https://mitlibraries.atlassian.net/l/c/qi4DUczK) (this is a restricted KB, only available to members of DLS). Instructions for accessing the CLI of running EC2 instances can be found [SSM Roles - HowTo](https://mitlibraries.atlassian.net/wiki/spaces/IN/pages/2660597762/SSM+Role+-+How+to+use) (also in a restricted KB).
