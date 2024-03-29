# Exception Monitoring

This will provide some guidelines for adding exception monitoring to your application using our Sentry subscription.

## What software needs Exception Monitoring

In general, all of the deployed custom software we write should have exception monitoring. If a product is no longer being maintained and we are actively moving to replace or retire it, exception monitoring should probably not be included.

## What are we using for Exception Monitoring

[Sentry](https://sentry.io/mit-libraries/)

## How do I get an account?

The accounts are maintained by EngX, so ask in our channel on the #engineering Slack channel if don't yet have a Sentry login to our account.

## How can I add Sentry to my application

1. From the main MIT Libraries Sentry page, choose "Add New > Project"
1. Choose the language for some general instructions and useful provide a name for the project
1. Follow the instructions that are provided by Sentry (NOTE: see below for some language specific tips we've come up with beyond the official documentation)

## How can I add Sentry to my Rails application

For most Rails application needs:
- Create a project for your application in [Sentry](https://sentry.io/organizations/mit-libraries/projects/new/).
- Add `SENTRY_DSN` to your ENV. Set the value to whatever the project you just created provides.
- Add `SENTRY_ENV` to your ENV. The value for this variable depends on which instance of your application you're
configuring. For example, `pr` (for pipelines), `staging`, `dev`, and `prod` are all acceptable values.
- Add the Sentry gems to your Gemfile:
```Ruby
gem 'sentry-rails'
gem 'sentry-ruby'
```
- Create a a Sentry initializer in `config/initializers/sentry.rb`:
```Ruby
Sentry.init do |config|
  return unless ENV.has_key?('SENTRY_DSN')
  config.dsn = ENV.fetch('SENTRY_DSN')
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.environment = ENV.fetch('SENTRY_ENV', 'unknown')
end
```
- Run the app and exceptions will be shipped to Sentry automatically with no additional initialization required. You
can test that it's working by sending a message from the console like this: `Sentry.capture_message('test')`.

## How can I add Sentry to my JavaScript features in my Rails application

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

## How can I add Sentry to my Python application

For both Django and Flask, add `SENTRY_DSN` to your ENV and set this to whatever value the project you just created provides.

### Django

1. `pipenv install sentry-sdk`
2. Add the following to your production settings file:
```
import os
import sentry_sdk
from sentry_sdk.integrations.django import DjangoIntegration

sentry_sdk.init(
    dsn="os.getenv(SENTRY_DSN)",
    integrations=[DjangoIntegration()]
)
```
   For more info, check out the [Sentry Django setup docs](https://docs.sentry.io/platforms/python/django/)

### Flask

1. `pipenv install sentry-sdk[flask]`
2. Add the following to your production settings file:
```python
import os
import sentry_sdk
from sentry_sdk.integrations.flask import FlaskIntegration

sentry_sdk.init(
    dsn="os.getenv(SENTRY_DSN)",
    integrations=[FlaskIntegration()]
)

app = Flask(__name__)
```
   For more info, check out the [Sentry Flask setup docs](https://docs.sentry.io/platforms/python/flask/)

## How can I add Sentry to my PHP application

There is a [Sentry PHP library](https://github.com/getsentry/sentry-php) that will do most of the work for you. Depending on what PHP framework you are using, the final integration will vary.

### Drupal

Sentry integration within Drupal is provided via [Raven](https://www.drupal.org/project/raven).

For Drupal 8, add Raven via `composer require drupal/raven`, which will install both Raven and the Sentry PHP library.

For Drupal 7, you will need [X Autoload](https://www.drupal.org/project/xautoload) and the [Libraries API](https://www.drupal.org/project/libraries). Additionally, you will need to place the Sentry PHP library at `/sites/all/libraries/sentry-php/` so that the path to the client is `/sites/all/libraries/sentry-php/lib/Raven/Client.php`.

After installing, log into the Drupal application to configure the DSN and other settings at `/admin/config/development/raven`.

### WordPress

Sentry integration within WordPress is provided via [WP Sentry Integration](https://wordpress.org/plugins/wp-sentry-integration/).

Further WordPress instructions will be available soon.
