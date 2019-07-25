---
order: 1000
---
### Rails at MIT Libraries

#### Style and Conventions
- follow [The Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)
- use [rubocop](https://github.com/bbatsov/rubocop) to lint before requesting
  code reviews

#### Test Frameworks
- use of either [minitest](https://github.com/seattlerb/minitest) or
  [rspec](https://github.com/rspec/rspec-rails) is fine

#### Rails Development Environment
- We maintain a [VagrantFile](https://github.com/MITLibraries/mit_vagrant_dev)
  to help developers join our Rails projects with minimal effort
- It is not a requirement to use it, but if you are having (or causing)
  problems and aren't using it, please use it and see if it helps

#### Deployments
- We often target [Heroku](/heroku.html) as a deployment platform and use Pipelines so custom
  deployment scripts are not necessary
- If the project requires deploying to a vm, use
  [capistrano](https://github.com/capistrano/capistrano) or
  [ansible](https://www.ansible.com) deployment scripts.

#### Ruby Versions
- Use the latest stable release unless you have a documented reason not to
  (an [ADR](https://github.com/npryce/adr-tools) would be a great place to
  document this if the project is using them)
- see also: `Upgrading Ruby on Rails and Deprecations` below

#### Rails Versions
- Use the latest
- see also: `Upgrading Ruby on Rails and Deprecations` below

#### Upgrading Ruby on Rails and Deprecations
- read the upstream upgrade notes. They will exist and will be useful.
- upgrade and get stuff working. It's okay to ignore deprecations during this
  initial upgrade step
- once everything works in the new version commit! you are not done though
- address the deprecations now. any deprecations that are not addressed
  immediately should get a ticket to remind us to go back and do it later
- if we deal with deprecations early, upgrading versions is usually easy

#### Gems and Updates
- subscribe to security alerts for all gems used by your project.
  [Dependabot](https://dependabot.com) or [Depfu](https://depfu.com) are
  efficient ways to do this. Keep everything up to date even after the project
  is in production to avoid accumulating unnecessary technical debt.

#### Layout and Styles
- Use our [mitlibraries-theme](https://github.com/MITLibraries/mitlibraries-theme) gem. See that repo for documentation.

#### Authentication
- See our general [Touchstone](/touchstone_saml.html) docs that include some
  Rails specific information
- Use [Devise](https://github.com/plataformatec/devise), probably with
  [OmniAuth](https://github.com/omniauth/omniauth)
- [MIT OpenID Pilot](https://oidc.mit.edu) needs to be approved on a per-project
  basis if it will be public facing. It can be used with no approval for staff-only authentication needs
- We maintain [omniauth-mit-oauth2](https://github.com/MITLibraries/omniauth-mit-oauth2)
  to make it easy to integrate with OmniAuth

#### Authorization
- Use [CanCanCan](https://github.com/CanCanCommunity/cancancan)
