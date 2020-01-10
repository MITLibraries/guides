# Central Logging

We use Logz.io for central logging. All apps should be sending logs here. Note that this is different than [exception monitoring](https://mitlibraries.github.io/exception_monitoring.html).

## Logging Standards

Everything effectively goes into a big bucket in Logz, so we need to make sure that we are all following some baseline standards.

## Requirements

1. Every app must use an `app` field whose value follows the pattern: `<app name>-<server type>`. For example: `bento-prod`.
2. Use JSON as your log format. If this is not possible use syslog format.

Note: if you have trouble logging into Logz.io or finding our Logz.io token, contact ops. The token is also stored in our shared dev Lastpass folder.
