# Central Logging

We use Logz.io for central logging. All apps should be sending logs here. Note that this is different than [exception monitoring](https://mitlibraries.github.io/guides/misc/exception_monitoring.html). Access to our Logz.io account is managed through Touchstone and must be accessed with the following URL: [Logz.io for MIT Libraries](https://logzio-libraries.mit.edu).

## Logging Standards

Everything effectively goes into a big bucket in Logz, so we need to make sure that we are all following some baseline standards.

## Requirements

1. Every app must use an `app` field whose value follows the pattern: `<app name>-<server type>`. For example: `bento-prod`.
2. Use JSON as your log format. If this is not possible use syslog format.

## Access
Access to our [Logz.io for MIT Libraries](https://logzio-libraries.mit.edu) is managed through Moira groups and Touchstone (which provides SSO and MFA). If you do not have an account in [Logz.io for MIT Libraries](https://logzio-libraries.mit.edu) and need one, please reach out to the EngX or InfraEng leads and one of them will update the Moira group to provide access.

_Note: Ask on the `#engineering` Slack channel for our shared Logz.io token._
