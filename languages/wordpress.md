# WordPress at MIT Libraries

WordPress is one of several content management systems used at the MIT
Libraries, and forms the majority of [libraries.mit.edu](https://libraries.mit.edu).

## Deployments

### Local deployments

WordPress is used on EC2 instance VMs that are administered by the
Enterprise Services team. The Wordpress installation can be found at the
Apache site root, which is:

```bash
/var/www/html/htdocs/
```

Other applications can also be found under `htdocs/`, including a number of
static HTML files. Full documentation of the structure of the site can be
found on the [UX/WS wiki](https://wikis.mit.edu/confluence/display/UXWS/libraries.mit.edu+-+README).

### Cloud deployments

The Libraries have been experimenting with the Pantheon cloud platform, and
have set up [an agency account](https://dashboard.pantheon.io/organizations/35a57471-c78e-4ccf-a3f1-e8681d098e90#sites/sites) to coordinate this work.
In order to join the account, first sign up for a free Pantheon account and
then contact Matt Bernhardt to be added to the agency.

## Upgrading

Updates to the WordPress core, and community-contributed themes and plugins,
are largely performed using the standard process in the administrative UI.
For security purposes, however, the WordPress application is kept in a
"locked" state that prevents self-modification. 

Scripts to lock and unlock the Wordpress network can be found on [MIT's GitHub](https://github.mit.edu/mitlibraries/wordpress_deployment).
Running these scripts requires terminal access to each server. Questions about
this process should be directed to the Enterprise Systems team.

1. Unlock WordPress

2. Apply updates via administrative UI

3. Lock WordPress

## Database migrations

At times it is necessary to move database content between tiers. For example,
we copy production content down to the staging site in order to evaluate a
significant site redesign. As part of this process, it is necessary to run a
search-and-replace tool in order to change the site address throughout the
database.

The WordPress CLI has a [search-replace](https://developer.wordpress.org/cli/commands/search-replace/) command to accomplish this goal.
The specific flags that we use include `network`, `path`, and `url`:

```
/usr/local/bin/wp --network --path=/var/www/html/htdocs --url=http://old.website.url search-replace old.website.url new.website.url
```

## Locally Developed Code

While much of what we do with WordPress involves working with code that is
written elsewhere, there are times where we need to write a plugin or theme
locally.

### Style and Coding Conventions

The WordPress community has adopted a set of [coding standards](https://codex.wordpress.org/WordPress_Coding_Standards) to which all the
projects we develop should adhere. This includes standards for PHP, HTML, CSS,
and JavaScript.

For local development, we recommend using [PHP_CodeSniffer from Squiz Labs](https://github.com/squizlabs/PHP_CodeSniffer) as a
linter before pushing code to GitHub. The WordPress Coding Standards have been
[implemented for PHPCS on GitHub](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards).

GitHub offers integrations with Travis-CI and CodeClimate, both of which can
be used to run PHPCS and similar code analysis tools.

### Test Frameworks

Because most local development at the MIT Libraries focuses on the theme
layer, testing is frequently not practical beyond linting and static code
analysis (see above).

### Project Documentation

Documentation for a specific theme or plugin should be contained in markdown
files, inside a `docs/` directory in each repository. Where documentation is
simple enough, it can be contained only within the `readme.md` file.

### Upgrading Local Projects

You will need terminal access to the server, and your account should have git
and node available. We recommend creating a `deploy/` directory under your
account, and using [the deploy scripts for plugins and themes](https://github.mit.edu/mitlibraries/wordpress_deployment) that we have
written.

The steps to upgrade a locally-written project look like this:

1. Check out the project/branch you are upgrading into `~/deploy/$project-name`

```
git clone git@github.com:MITLibraries/wp-plugin-template.git ~/deploy/wp-plugin-template
```

2. If needed, install/run grunt to build

```bash
cd ~/deploy/wp-plugin-template
scl enable rh-nodejs8 /bin/bash
npm install
grunt
```

3. Run the relevant deploy script, passing the project name as arguments. If
you have not placed the deploy script into your deploy directory already, you
can symlink it from `/usr/local/scripts/`.

```
cd ~/deploy/
./deploy-plugin.sh wp-plugin-template wp-plugin-template
```

### Template projects

We have created a reference project that includes the recommended tooling
integrations and code standards:

[Plugin Template](https://github.com/MITLibraries/wp-plugin-template)

## Integrations

Integrations between Wordpress and external systems are needed for some
functionality. Some of these integrations are covered elsewhere in this
documentation ([exception monitoring](https://mitlibraries.github.io/guides/misc/exception_monitoring.html) and [centralized logging](https://mitlibraries.github.io/guides/misc/logging.html), for example).

Other integrations that are more specific to WordPress are detailed below.

### Zapier / Airtable and webforms

Web forms on libraries.mit.edu should be built and maintained using the
Contact Forms 7 (CF7) plugin. [Documentation for this can be found on the UX
wiki.](https://wikis.mit.edu/confluence/display/UXWS/Step+1%3A+Create+the+form) By design, this system keeps no record of submissions within WordPress.
The forms send emails, and the receiving system is responsible for tracking
the submission.

A small number of forms, however, do not work via email. Those forms instead
send submissions via webhook to Zapier, which in turn sends them to Airtable
for processing.

The Zapier account which stores this workflow is controlled by UX, with some
assistance from EngX. Some details are stored within the WordPress form UI,
while the Zapier UI controls the crosswalk between the form and Airtable.

The Airtable bases are constructed and maintained by each form owner. As of
this writing, Distinctive Collections is the only area of the Libraries which
uses this setup.
