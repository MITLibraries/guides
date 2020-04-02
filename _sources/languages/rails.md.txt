# Rails at MIT Libraries

## Style and Conventions

- follow [The Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)
- use [rubocop](https://github.com/bbatsov/rubocop) to lint before requesting
  code reviews

## Test Frameworks

- use of either [minitest](https://github.com/seattlerb/minitest) or
  [rspec](https://github.com/rspec/rspec-rails) is fine

## Continuous Integration

You should use GitHub Actions. If you feel you have reason to use another
solution, ask in #engineering on Slack to get peer feedback as to confirm
whether others agree your use case differs enough to not use our common
solution.

To use our standard setup, do the following:

- Make a copy of
[our template](https://raw.githubusercontent.com/MITLibraries/bento/master/.github/workflows/ci.yml), 
to your repo in the path `.github/workflows/ci.yml`

- Ensure you are using SimpleCov and have setup LCOV as a formatter.

  - Add `gem simplecov` and `gem simplecov-lcov` to your test group in your
`Gemfile`.
  - `bundle install`
  - Add the following to the very top of your `test/test_helper.rb`

```ruby
require 'simplecov'
require 'simplecov-lcov'
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
]
SimpleCov.start('rails')
```

- Commit on a new branch and push your changes

- Open a PR and your Action should run (and pass!). If not, debug or ask on our
Slack for tips.

## Rails Development Environment

- We maintain a [VagrantFile](https://github.com/MITLibraries/mit_vagrant_dev)
  to help developers join our Rails projects with minimal effort
- It is not a requirement to use it, but if you are having (or causing)
  problems and aren't using it, please use it and see if it helps

## Deployments

- We often target [Heroku](/deploy/heroku) as a deployment platform and use Pipelines so custom
  deployment scripts are not necessary
- If the project requires deploying to a vm, use
  [capistrano](https://github.com/capistrano/capistrano) or
  [ansible](https://www.ansible.com) deployment scripts.

## Ruby Versions

- Use the latest stable release unless you have a documented reason not to
  (an [ADR](https://github.com/npryce/adr-tools) would be a great place to
  document this if the project is using them)
- see also: `Upgrading Ruby on Rails and Deprecations` below

## Rails Versions

- Use the latest
- see also: `Upgrading Ruby on Rails and Deprecations` below

## Upgrading Ruby on Rails and Deprecations

- read the upstream upgrade notes. They will exist and will be useful.
- upgrade and get stuff working. It's okay to ignore deprecations during this
  initial upgrade step
- once everything works in the new version commit! you are not done though
- address the deprecations now. any deprecations that are not addressed
  immediately should get a ticket to remind us to go back and do it later
- if we deal with deprecations early, upgrading versions is usually easy

## Gems and Updates

- subscribe to security alerts for all gems used by your project.
  [Dependabot](https://dependabot.com) or [Depfu](https://depfu.com) are
  efficient ways to do this. Keep everything up to date even after the project
  is in production to avoid accumulating unnecessary technical debt.

## Layout and Styles

- Use our [mitlibraries-theme](https://github.com/MITLibraries/mitlibraries-theme) gem. See that repo for documentation.

## Authentication

- See our general [Touchstone](/authentication/touchstone_saml) docs that include some
  Rails specific information
- Use [Devise](https://github.com/plataformatec/devise), probably with
  [OmniAuth](https://github.com/omniauth/omniauth)
- [MIT OpenID Pilot](https://oidc.mit.edu) should not be used unless it leaves pilot stage

## Authorization

- Use [CanCanCan](https://github.com/CanCanCommunity/cancancan)
