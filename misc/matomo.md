# Configuring apps to use Matomo for analytics

[Matomo](https://matomo.org) (formerly piwik) is an open-source analytics 
software. We prefer it to Googe Analytics due to its emphasis on user 
privacy.

Our Matomo instance runs as a Docker container in Fargate. A repo with 
the dockerfile and config is located on [GitHub](https://github.com/MITLibraries/docker-matomo).

This guide covers how to add Matomo tracking code to a web application. 
For more in-depth information on using and developing Matomo, see the 
[offical Matomo docs](https://matomo.org/help/). For information specific
to our implementation, such as config and how to access staging and prod, visit
the [Matomo analytics](https://wikis.mit.edu/confluence/display/UXWS/Matomo+analytics) page in the UXWS Confluence.

## For Rails applications hosted on Heroku

The tracking code is already included in the [mitlibraries-theme gem](https://github.com/mitlibraries/mitlibraries-theme). Assuming your app uses mitlibraries-theme, you can 
activate tracking by adding the following environment variables to your 
Heroku app:

* `MATOMO_URL` - the URL of the Matomo app you are connecting to. Make sure to include the trailing forward slash!
* `MATOMO_SITE_ID` - the ID of the measurable you are tracking. You can 
find this in Matomo by going to Settings (gearbox icon in navbar) > Websites > Manage. The ID for each website will
appear underneath the website name.

## For the WordPress network hosted on Pantheon

The [mitlib-analytics plugin](https://github.com/MITLibraries/mitlib-wp-network/tree/master/web/app/plugins/mitlib-analytics)
inserts Matomo tracking code into the network. The plugin has two config values -- Matomo URL and Matomo property ID --
both of which can be set in the network admin console.

Note that we collect data for libraries.mit.edu and LibGuides in the same Matomo property, so these will use the same
property ID.

## For LibGuides and another LibApps products

We track LibGuides on the same Matomo property as the WordPress network. Since there is no staging or dev environment in LibApps, we need to make the changes live in prod by adding/editing tracking code in the header.

The
[hosted-branding repo](https://github.com/MITLibraries/hosted-branding) details how to modify LibApps headers. Once you
have made changes, make sure to check the updated header markup into the hosted-branding repo.

If you'd like to test changes before they go live, we have a
[test group in LibGuides](https://libguides.mit.edu/test-group) that has its own header/footer and JS/CSS. The test
group has minimal content, but you should be able to discern whether tracking data is being sent to Matomo.

## For static sites

The [mitlib-tf-workloads-libraries-website](https://github.com/mitlibraries/mitlib-tf-workloads-libraries-website) repo
builds a CDN for static content. Typically, this is infrastructure is used for legacy sites like
[Future of Libraries](https://github.com/MITLibraries/future-of-libraries-static).

Matomo needs to be set up differently for these sites in order to accommodate the CSP directives for the CDN. As
described in [this FAQ](https://matomo.org/faq/general/faq_20904/), the tracking code should be loaded from the site's
assets directory (rather than inline), and the client script should be loaded explicitly (rather than from the tracking
code).

For Future of Libraries, and likely for other static sites, these `script` tags will have to be added to the `head` of
each HTML file in the site. The best way we've found to do this is find/replace in your IDE, which feels adequate for a one-time process. If we find that we need to edit the script tags often, then a find/replace script may be useful.

## For DSpace@MIT

The DSpace@MIT codebase is hosted on Atmire's GitLab organization. In order to add or modify tracking code, you will
need a GitLab account. As of June 2023, the Digital Library Systems Manager is our point of contact with Atmire.

_More details to be added once we've configured Matomo in DSpace@MIT._

## For Dome

TBD, pending migration of Dome to our AWS org.

## Other things to note

We run a cron job as a scheduled ECS task to compile the raw data (more 
info on this is available in the [GitHub repo]((https://github.com/MITLibraries/docker-matomo)). 
If you are not seeing any data in the dashboard, something is probably 
wrong with the cron job.
