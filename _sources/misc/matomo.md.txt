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

## For other applications

We don’t yet have a procedure for non-Rails apps. You will need to add 
the Matomo tracking JS (found in Settings > Websites > Tracking Code) to 
your app directly.

Confirm that tracking is working by visiting your site, clicking a few 
links, and making sure this activity was recorded in the Matomo dashboard. 
Also make sure that IPs are anonymized (they should be, but make sure anyway).

## Other things to note

We run a cron job as a scheduled ECS task to compile the raw data (more 
info on this is available in the [GitHub repo]((https://github.com/MITLibraries/docker-matomo)). 
If you are not seeing any data in the dashboard, something is probably 
wrong with the cron job.
