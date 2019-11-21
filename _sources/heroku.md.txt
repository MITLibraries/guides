# Heroku

This is not intended to replace the Heroku documentation. Some common
practices are documented here for convenience.
However, [read the docs](https://devcenter.heroku.com).

## What’s weird about Heroku at first?

### File system

Heroku has no persistent file system. Don’t write anything and
expect it to be there even on the next request (it often is, but
isn’t reliable… use S3).

NOTE: files stored in your code repository or generated at deploy time, such as
css/js/images, are okay to use the Heroku file system for. If your app expects
to be exceptionally popular, a CDN may be appropriate.

### Logging

Heroku expects you to ship logs elsewhere (because of the no
persistent filesystem). See our [Logging](/logging) documentation for our centralized solution.

Use the Heroku CLI application to do the following:

```bash
heroku drains:add \
'https://listener.logz.io:8081?token=OUR_LOGZ_TOKEN&app=YOUR_HEROKU_APP_NAME' \
--app YOUR_HEROKU_APP_NAME
```
_Note: Ask on the `#engineering` Slack channel for our shared Logz.io token._

You should set up log drains for both staging and production.

### Exception Logging

Use our [Exception Monitoring](/exception_monitoring) service.

### Database Backups

Make sure to configure backups. This is not automatic (it
is free for daily with a one week retention even on the free pg plan
that comes with every app). You do need to
[Schedule your DB backups](https://devcenter.heroku.com/articles/heroku-postgres-backups)!

### Static vs Dynamic IPs

_NOTE: if you need a static IP, please considering using an AWS solution. Ask in the `#engineering`
channel to discuss options. The following is probably not what you need._

Many servers have traditionally had Static IPs. You do _not_ get
Static IPs from Heroku by default. Most apps don't need Static IPs
and this poses no problem at all.

However, if you are working with a vendor who insists on API access
via a static IP, you can activate and configure an add-on such as
[Proximo](https://devcenter.heroku.com/articles/proximo)
to get a set of static IPs the vendor can approve for access.

This will route outbound traffic over a static IP. Inbound traffic
will continue to use the Heroku supplied dynamic IP.


## Billing

We have a shared billing account. Password is in our LastPass. Ask in the `#engineering` Slack
channel if you need access.
That account should be the owner rather than setting up billing for each
app individually.

Only use that shared account to claim ownership or change settings
that require the owner. Otherwise, use your own Heroku account. Add
yourself to any projects you want (but at least the ones you help maintain!).

If you don't use Heroku regularly, such as not being a full time developer, you may
ask a full time developer to assist in moving apps to the billing account.
The only thing that shared account gives you is billing
control (aka you aren’t missing anything important).

Need a new app moved into our paid accounts? Set it up with your
account then transfer ownership to the shared account when it is
ready for billing.

Not sure if something is too expensive to use as an add-on? Ask.
There is no fixed rule, so getting other thoughts on the cost /
benefit is the best current option.


## Pipelines

TL;DR: Use [pipelines](https://devcenter.heroku.com/articles/pipelines).
They are :mega: :rainbow: :beers: :fireworks:

We have staging sites tied to our Master branches. Merge code into
master and staging builds will update automatically (after tests
pass).

Before merging, we have PR builds spin up with staging settings into
new apps. You can access the link to the apps in the PR itself.
These are helpful when asking non-developers to sign off on a
feature before it is merged.

PR builds copy ENV from Staging (dev note: `app.json` does the magic
on this in project root).

Staging and Production ENV are entirely separate. Changing one does
NOT change the other. This will make you confused one day.

On deploy or ENV change, the application will restart. It is
normally a quick blip and doesn’t require downtime announcements.


## Production Deploy with Pipelines Cheatsheet

### Tag a release in GitHub with release notes that are useful

From the repo code page on GitHub, go to Releases, and then click the
"Draft a new release" button. Number the release appropriately, and
use the number for the title if you don't have a title. Put notes on
what's changed in the release in the description.

FYI: The tag is purely informational. It is not currently used to push
to production using Pipelines. Pushing to prod moves whatever is on
staging, which is quite likely `master` unless you are doing weird
things (note: don't do weird things).

### Confirm everything is all good on staging.

Staging probably has `master`. If it works, pushing to prod should
be :rainbow: unless you forgot you'll need changes to ENV for any new
features you may be pushing if so, make said changes!

Get stakeholder sign off on the Pipeline staging app if it seems
appropriate (i.e. only push stuff that has been approved to go live
and / or is a bug / security fix)… but ideally that has been done
before merge with PR builds… right? right‽

### Login to Heroku Dashboard

On the app Pipeline page, click "Promote to Production"

Choose the "compare on GitHub option" to confirm the change set is
indeed what you expect it to be. If it is, go back and click
"Promote". If it is not, determine why it is not what you expect then
make decide what to do about that.

### Confirm the app restarts and seems good

It takes a few seconds to restart. If things are _not_ good, rollback
in the Dashboard.

NOTE: rollback only rolls back ENV and code changes. If your deploy
modified your db schema or migrated data in any way, you _will_ need
to roll that back separately.
[Rollback Docs](https://devcenter.heroku.com/articles/releases#rollback)

### Inform stakeholders if appropriate

You just made a change to production. Tell people that care.

## Manual Deploys

You can still of course manually deploy when using Pipelines,
but it is best to do this to staging and then promote from there
rather than just hoping everything is going to be great in
production.

## Viewing / changing Environment Variables

Using ENV for config is common for Heroku deploys. You can view and
change settings via either the Heroku CLI or the Web UI.
[Heroku Config Vars Documentation](https://devcenter.heroku.com/articles/config-vars#setting-up-config-vars-for-a-deployed-application)

You use the CLI to run with a local `.env` file in development
with the [`heroku local`](https://devcenter.heroku.com/articles/heroku-local)
command.

You should store a copy of your staging and production ENV in our
shared LastPass folder.

## Deploy Hooks

It is often useful to get notifications when staging or production apps are deployed and
[Deploy Hooks](https://devcenter.heroku.com/articles/deploy-hooks)
can do that for you.

Deploy Hooks can send email and / or notify a slack channel on new
builds. Using a Moira list with an email hook allows for interested
stakeholders to stay in the loop (note: keep in mind the
deploy hooks don't always have a ton of context as to what has
changed, so only alerting stakeholders that are comfortable with
receiving emails with cryptic notes about a specific SHA being
deployed to staging / production is best).

## Dynos

We use paid [Dynos](https://devcenter.heroku.com/articles/dynos).
So far the $7 plan works fine for us in production and free dynos on
staging and pr builds. We can pay more if we need to, but this has
been fine for most apps so far.

If an app needs background jobs (email send, sword deposit, etc),
that’s the job of the worker dyno and the cost is the same as your
main dyno (or at least you can’t do one paid and one free… you may
be able to do one higher and one cheap?).

## Domain Names and SSL

It’s not significantly different than getting a DNS entry for a vm.
ts3help is the best path and provide details on what is necessary
via the
[Custom Domain](https://devcenter.heroku.com/articles/custom-domains) and
[Automated Certificate Management](https://devcenter.heroku.com/articles/automated-certificate-management).

### Example email to ITS help (not fix-lib) to start the process

```
The [YOUR PROJECT NAME] project requests the following domain name
registration:

CNAME: [YOUR_DESIRED_REGISTRATION].mit.edu
Target: [YOUR_DESIRED_REGISTRATION].mit.edu.herokudns.com
Cost Object: [ITS fill-in]
Contact E-mail: [ITS fill-in]

Please let me know if you need any additional information.
```

If you are doing the Heroku default Automated Certificate Management (Let's Encrypt), that's enough.
If you need an
Incommon cert for some reason, include this next bit too. Most applications are fine with Let's Encrypt.

```
Additionally, we'll need an SSL cert for that domain. General information is
available here on what we'll need:
https://devcenter.heroku.com/articles/ssl

Essentially, once we have the cert I can upload it and the private key to
Heroku.
```

## MIT Authentication

See [Touchstone via SAML](/touchstone_saml.md) for our authentication best practice.

[MIT Pilot OAuth](/oauth) should not be used.