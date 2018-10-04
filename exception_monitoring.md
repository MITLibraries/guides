---
order: 1000
---
### Exception Monitoring

This will provide some guidelines for adding exception monitoring to your application using our Sentry subscription.

#### What software needs Exception Monitoring

In general, all of the deployed custom software we write should have exception monitoring. If a product is no longer being maintained and we are actively moving to replace or retire it, exception monitoring should probably not be included.

#### What are we using for Exception Monitoring

[Sentry](https://sentry.io/mit-libraries/)

#### How do I get an account?

The accounts are maintained by DLE, so ask in our channel on Slack if don't yet have a Sentry login to our account.

#### How can I add Sentry to my application

1. From the main MIT Libraries Sentry page, choose "Add New > Project"
1. Choose the language for some general instructions and useful provide a name for the project
1. Follow the instructions that are provided by Sentry (NOTE: see below for some language specific tips we've come up with beyond the official documentation)

#### How can I add Sentry to my Rails application
- For most Rails application needs
  - just add `gem 'sentry-raven'` to your Gemfile
  - add `SENTRY_DSN` to your ENV. Set the value to whatever the project you just created provides.
  - run the app and exceptions will be shipped to Sentry automatically with no additional initialization required

#### How can I add Sentry to my JavaScript features in my Rails application
- Obtain a sentry js style DSN key by going to https://docs.sentry.io/clients/javascript/ and select your application from the configuration dropdown under "Configuring the Client"
- NOTE: do not use the DSN you used for your Rails application, it is important you use the specific JS key as it will be publicly shared unlike your Rails DSN.
- set `JS_EXCEPTION_LOGGER_KEY` value to the project specific JavaScript DSN in your ENV
- Include something like the following in your application template:
```
<% if ENV['JS_EXCEPTION_LOGGER_KEY'].present? %>
  <script src="https://cdn.ravenjs.com/3.25.2/raven.min.js" crossorigin="anonymous"></script>
  <script>Raven.config('<%= ENV['JS_EXCEPTION_LOGGER_KEY'] %>').install()</script>
<% end %>
```

#### How can I add Sentry to my Python application

For both Django and Flask, add `SENTRY_DSN` to your ENV and set this to whatever value the project you just created provides.

##### Django
1. `pipenv install raven`
2. Add the following to your config:

   ```python
   INSTALLED_APPS = (
     'raven.contrib.django.raven_compat',
   )
   ```

##### Flask
1. `pipenv install raven[flask]`
2. Add the following to your app config:

   ```python
   from raven.contrib.flask import Sentry

   app = Flask(__name__)
   Sentry(app)
   ```

#### How can I add Sentry to my PHP application

There is a [Sentry PHP library](https://github.com/getsentry/sentry-php) that will do most of the work for you. Depending on what PHP framework you are using, the final integration will vary.

##### Drupal

Sentry integration within Drupal is provided via [Raven](https://www.drupal.org/project/raven).

For Drupal 8, add Raven via `composer require drupal/raven`, which will install both Raven and the Sentry PHP library.

For Drupal 7, you will need [X Autoload](https://www.drupal.org/project/xautoload) and the [Libraries API](https://www.drupal.org/project/libraries). Additionally, you will need to place the Sentry PHP library at `/sites/all/libraries/sentry-php/` so that the path to the client is `/sites/all/libraries/sentry-php/lib/Raven/Client.php`.

After installing, log into the Drupal application to configure the DSN and other settings at `/admin/config/development/raven`.

##### WordPress

Sentry integration within WordPress is provided via [WP Sentry Integration](https://wordpress.org/plugins/wp-sentry-integration/).

Further WordPress instructions will be available soon.
