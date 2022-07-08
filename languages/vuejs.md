# Vue.js at MIT Libraries

## Style and Conventions

- use `yarn lint` to lint before requesting code reviews

## Test Frameworks

- use [jest](https://jestjs.io)

## Continuous Integration

You should use GitHub Actions. If you feel you have reason to use another
solution, ask in #engineering on Slack to get peer feedback as to confirm
whether others agree your use case differs enough to not use our common
solution.

To use our standard setup, do the following:

- Make a copy of
  [our template](https://github.com/MITLibraries/disco-poc-vue/blob/main/.github/workflows/ci.yml),
  to your repo in the path `.github/workflows/ci.yml`.

- Commit on a new branch and push your changes

- Open a PR and your Action should run (and pass!). If not, debug or ask on our
  Slack for tips.

👉 Code Coverage coming soon 👈

## Package manager

You should use [yarn](https://yarnpkg.com) unless you have a really good reason
not to for projects developed by our team. For external projects you are working
with, use whatever they use.

On macOS, we recommend `brew` to install and manage `yarn`.

## Development Environment

- For local development, you will need the ENV for the app you're working with.
  Contact an engineer who's worked on the app, and they will provide you with
  the requisite .env file
- Application specific details should be included in the application README
  `yarn run` will likely give you useful project specific commands

## Deployments

- We target [Heroku](/deploy/heroku) as a deployment platform and use Pipelines
  so custom deployment scripts are not necessary
- For static apps, we are using
  [heroku-buildpack-static](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-static)
  Please also note that the application will need to be re-deployed using the
  Heroku tooling when making adjustments to environment variables when using
  this build pack.

❗ If you use another solution or are not building a static app, please document that here.

## Vue Versions

- Use the latest stable release unless you have a documented reason not to
  (an [ADR](https://github.com/npryce/adr-tools) would be a great place to
  document this if the project is using them)

## Dependency Updates

- subscribe to security alerts for all dependencies used by your project.
  [Dependabot](https://dependabot.com) is an
  efficient ways to do this.
- Keep everything up to date even after the project
  is in production to avoid accumulating unnecessary technical debt.
- If we have reasons we cannot update to a new version of a dependency, open a
  ticket and describe the problem so it is clear what the problem is that needs
  to be addressed

## Layout and Styles

- Use our [mitlib-style](https://github.com/MITLibraries/mitlib-style) as a
  guide.

## Authentication

TBD

## Authorization

TBD
