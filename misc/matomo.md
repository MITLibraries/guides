# Configuring Matomo for analytics

[Matomo](https://matomo.org) (formerly piwik) is an open-source analytics 
software. We prefer it to Googe Analytics due to its emphasis on user 
privacy. Whenever possible, Matomo should be used for analytics instead 
of GA in MIT Libraries applications.

Our Matomo instance runs as a Docker container in Fargate. A repo with 
the dockerfile and config is located on [GitHub](https://github.com/MITLibraries/docker-matomo).

This guide will walk through the basic steps to add a website to Matomo. 
For more in-depth information on using and developing Matomo, see the 
[offical Matomo docs](https://matomo.org/help/).

## Universal settings

All websites tracked by Matomo anonymize visitor IPs to two bytes (e.g., 
192.168.x.x).

## Setting up a new website in Matomo

Each app is tracked as a website in Matomo. Please create a different 
website for each environment of your application (e.g., staging and prod 
will be separate websites in Matomo).

_Note: Accounts with superuser permissions add new websites to Matomo. 
If you don’t have superuser access, ask EngX._

1. Log into Matomo at https://analytics-prod.mitlib.net. (There is also 
a staging instance behind the Cisco VPN at https://analytics-stage.mitlib.net.) 
If you don't have an account, EngX can create one for you.
2. Click the Settings link (gearbox in navbar) > Websites > Manage > 
Add a new measurable,
3. Give the measurable a useful name. We generally use the name the app is 
known by internally, plus a note if it’s the staging app. E.g.: “Bento” 
or “Bento (staging)”.
4. Add the root URL for the application, as well as any aliases. It is 
not necessary to add specific routes in the application.
5. Leave the remaining settings as their defaults, then click ‘Save’.

The website will now be listed under Websites > Manage.

## Setting up Matomo tracking in your app

Now that you've added your app to Matomo, you can set up tracking by 
adding Matomo's tracking code to your app.

### For Rails applications hosted on Heroku

The tracking code is already included in the [mitlibraries-theme gem](https://github.com/mitlibraries/mitlibraries-theme). Assuming your app uses mitlibraries-theme, you can 
activate tracking by adding the following environment variables to your 
Heroku app:

* `MATOMO_URL` - the URL of the Matomo app you are connecting to (probably 
this one: https://analytics-prod.mitlib.net/). Make sure to include the 
trailing forward slash!
* `MATOMO_SITE_ID` - the ID of the measurable you are tracking. You can 
find this in Matomo by going to Settings (gearbox icon in navbar) > Websites 
> Manage. The ID for each website will appear underneath the website name.

### For other applications

We don’t yet have a procedure for non-Rails apps. You will need to add 
the Matomo tracking JS (found in Settings > Websites > Tracking Code) to 
your app directly.

Confirm that tracking is working by visiting your site, clicking a few 
links, and making sure this activity was recorded in the Matomo dashboard. 
Also make sure that IPs are anonymized (they should be, but make sure anyway).

## Other things to note

* Matomo prod is at https://analytics-prod.mitlib.net. Staging is at 
https://analytics-stage.mitlib.net.
* Matomo staging is behind the Cisco VPN. You will not be able to access 
it using the GlobalProtect VPN.
* We run a cron job as a scheduled ECS task to compile the raw data (more 
info on this is available in the [GitHub repo]((https://github.com/MITLibraries/docker-matomo)). 
If you are not seeing any data in the dashboard, something is probably 
wrong with the cron job.
