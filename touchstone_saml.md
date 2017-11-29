---
order: 1000
---
# Touchstone / Shibboleth / SAML Authentication

# What is Touchstone?

[Touchstone at MIT](http://ist.mit.edu/touchstone-detail)

Touchstone is MIT's Shibboleth implementation that includes DUO for two factor
authentication.

# What is Shibboleth?

[Shibboleth wikipedia entry](https://en.wikipedia.org/wiki/Shibboleth_(Shibboleth_Consortium))

# What is SAML?

[Security Assertion Markup Language](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language)

# What are we doing here?

We want to use Touchstone, and thus Shibboleth, but without the `mod_shib`
Apache HTTPd plugin. We can do this by utilizing the SAML protocol that
the Touchstone server can support.

`mod_shib` traditionally is the Shibboleth SP (service provider). We'll be
implementing an SP in our application. The Touchstone service that MIT provides
is the Shibboleth IdP (identity provider).

There are some open source [support libraries for many languages](https://github.com/onelogin)
that will make this fairly easy.

This initial documentation will focus on using
[ruby-saml](https://github.com/onelogin/ruby-saml) with
[omniauth-saml](https://github.com/omniauth/omniauth-saml) and
[devise](https://github.com/plataformatec/devise) for a standard Rails
application the principles should hold with other languages.

A sample barebones functioning [rails application is available](https://github.com/MITLibraries/rails_saml_example).


# Registering a SAML SP in MIT Touchstone

The request itself is simple, but preparing your application for _successful_
submission takes some understanding of what is happening and providing what IST
needs in a way they can easily consume it. This is not hard, but it is
confusing and opaque. Please ask for help if you find yourself thinking it
would be easier to just `mod_shib` on a VM and make this someone else's problem.

## Request DNS registration

IS&T TouchStone support prefers a `*.mit.edu` domain for each Touchstone
protected application. The easiest path to that is to just request DNS
registration for both staging and production environments.

note: Local development, automated tests, and PR builds will likely use
non-Touchstone authentication and thus don't require DNS or Touchstone
registrations.

## Generating a self-signed certificate for Touchstone

Touchstone support requests a long lived self signed certificate. The following
command will give you a 10 year cert with no password which is useful for
production environments where entering a password is non-ideal. If the private
key is compromised in any way, generate a new one and inform Touchstone support.

```
openssl req -new -x509 -nodes -newkey rsa:2048 -keyout APP_KEY.pem -days 3650 -out APP_CERT.pem
```

Suggestions for the prompts:
- US
- Massachusetts
- Cambridge
- MIT
- MIT Libraries
- APP_NAME.mit.edu
- lib-touchstone@mit.edu [if you use this, make sure you are on the moira list]

## Configuring the application

- follow omniauth-saml instructions (which follow Facebook instructions)
  - add gem and bundle
  - run migrations
- in devise.rb do something like:

[sample app config](https://github.com/MITLibraries/rails_saml_example/blob/master/config/initializers/devise.rb#L278-L302)

## Generating application metadata

Touchstone registers the application by consuming metadata that the SP
generates. `ruby-saml` can provide this metadata on a devise configured application at `/users/auth/saml/metadata`

Once you deploy your application and the DNS is working, you will provide that
URL to IST and they will have everything they need in one place to register the
application. NOTE: they do not regularly poll the SP metadata so if you make
configuration or code changes that change the SP metadata, you need to ask
touchstone support to re-ingest the metadata.

### testshib

I found it frustrating to configure a SAML application against MIT Touchstone with the information they provide which is all Shibboleth specific. However,
[testshib.org](http://www.testshib.org) allows you to register your SP against
a test IdP and instantly see the results and error logs (you will have error
logs).

If you [12 factor your app](https://12factor.net), changing from the testshib
IdP to the MIT Touchstone IdP later will be simple.

However, you need to be able to redirect back to your application from testshib
for authentication to succeed. I found `ngrok` to be super helpful for that.

### ngrok

[ngrok](https://ngrok.com)

This allows you to spin up a publicly accessible endpoint with a secure tunnel
back to your localhost. So if I run my rails app on port 5000, I'd run
`ngrok http 5000` to tunnel my port 5000 to an ngrok endpoint and then start my
local server on port 5000.

Note: every time you start ngrok you get a new endpoint. This means you will
need to re-upload your SP metadata to testshib. This is only a minor
inconvenience as the change takes place instantly.

### SP Metadata

Once you have ngrok running you can export your SP metadata and upload it to
testshib.

You can then test authentication and debug any issues.

## Email Touchstone help

Once you've confirmed you have your SP working with the testshib IdP, you can
push your code to wherever it will run (Heroku, a container somewhere, etc).
It should be using the DNS entry you will be registering with Touchstone at this
time as well.

Access the metadata at `FQDN/users/auth/saml/metadata` and confirm it looks
reasonable.

Send an email to `touchstone-support@mit.edu` with the following information:

```
I would like to register the following SAML SP with Touchstone.

SP Metadata URL: https://YOUR_APP.mit.edu/users/auth/saml/metadata
Contact email address: lib-touchstone@mit.edu
Web server host name: YOUR_APP.mit.edu
Organization name: MIT Libraries
Organization URL: https://libraries.mit.edu
```

## Non-touchstone auth for PR builds and local development

Registering a local SP for Touchstone is probably more trouble than it's worth.
Using an alternative authentication strategy for local, test and PR builds is
recommended.