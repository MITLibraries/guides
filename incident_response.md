---
order: 1000
---
# Incident Response Guidelines

## What is an incident response?

For our purposes, we are describing an incident as any extended outage to a
system or service under our control as well as any security breach that may
involve MIT data on said systems.

An incident response is our documentation as to how we handled those incidents.
The intent is to make it clear what happened and how we responded.

## What requires an incident response?

Any outage that lasts more than 45 minutes.

Every suspected security breach, regardless of whether an outage was involved
or if it was determined after the fact that no security breach occurred.

## Who should write them?

The report should be initially created and shared with other responders as soon
as the triggering criteria is met by whoever is currently investigating.
However, writing full details of the report should not take precedence over
fixing the problem. It is likely we can find a balance between documenting and
fixing in which our documentation actually helps us with the fixing and in fact
does not block getting a solution in place even though it may feel that way at
times. Often details of a report will be filled in after the problem is
resolved by referencing email, logs, and slack discussions, and other people
involved for more information.

Whenever we note in the timeline someone else's name, that person should be
expected to participate in the writing and reviewing of the report. **The report
becomes the shared responsibility of everyone who is named in the report.**

## What goes in a report?
The [report template](https://docs.google.com/document/d/1yfL1XPPQrwhnMdIw7CLpBM56uY2b-SCZfNerkwCGDqU/edit?usp=sharing
)
provides an overview of what should be included, but the general idea is:

**Issue Summary**: Provide an overview of the issue.

**Timeline**: Provide a detailed timeline of the incident, include names of
staff that were involved and invite them to directly provide additional details
to the document as soon as you name them.

**Root Cause**: Describe what caused the problem (this may not be known when
the report is initially created, but by the end it hopefully will be).
Don’t hide or downplay the root cause for any reason.

**Resolution and recovery**: Describe how the problem was resolved.

**Corrective and Preventative Measures**: Describe how the problem might be
avoided in the future or how we may have responded differently. This may list
specific changes that will be implemented immediately as well as future
projects to replace or improve problem components.

See also:
[How to write an Incident Report / Postmortem](https://sysadmincasts.com/episodes/20-how-to-write-an-incident-report-postmortem)

## Where do I get a template?

https://docs.google.com/document/d/1yfL1XPPQrwhnMdIw7CLpBM56uY2b-SCZfNerkwCGDqU/edit?usp=sharing

## How do I submit my completed report?

1. Put it in the [Google Drive folder](https://drive.google.com/open?id=1Gursqku_NsUyGTXyWa6LUESIFNTBcf3G
)
1. Email it to TLT
1. Share it on slack with appropriate teams

## Additional reading:
- [How to write an Incident Report / Postmortem](https://sysadmincasts.com/episodes/20-how-to-write-an-incident-report-postmortem)
- [Managing Incidents](https://landing.google.com/sre/book/chapters/managing-incidents.html)
- [Google API infrastructure outage incident report](https://developers.googleblog.com/2013/05/google-api-infrastructure-outage_3.html)
