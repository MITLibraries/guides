# Proxy URLs

## tl;dr #### 

When constructing a url for IP-restricted content that needs
to be accessible both on-campus and off-campus best practice
is to use a proxy URL.

Proxy URLs should have the form:

`https://libproxy.mit.edu/login?url=<target url>`

## What is a proxy URL?

A proxy URL sends a request to our proxy server to create a
proxied session to the target URL on behalf of a user.

A proxy URL is constructed by appending a **target url** to
our **proxy prefix**.

like so
`https://libproxy.mit.edu/login?url=https://www.nature.com`

## Why use a proxy URL?

Our proxy server's main purpose is to communicate with
external service providers on behalf of MIT users in cases
where the user’s browser is not on MIT’s network and where
the service provider only accepts connections from clients
on MIT's network. 

Requests made via our proxy server are seen by service
providers as coming from within the MIT network.

The proxy server has the ability to determine if a
connection should be proxied. Typically, if the user’s
browser is reporting an IP address that falls within the MIT
range, the user does not require proxy services and EZproxy
redirects the user’s browser directly to the service
provider.

If the user’s browser reports an IP address that is not
within the MIT range, EZproxy will direct the user to
authenticate via touchstone and then set up a proxied
session on behalf of the user. 

When constructing a url for IP-restricted content that needs
to be accessible both on-campus and off-campus best practice
is to use a proxy URL.

If your application needs to check if a URL is proxy-able
before providing links to users, there are some possible
ways to do that documented:
[https://wikis.mit.edu/confluence/display/LIBPROXSERV/Proxy+lookup+scripts](https://wikis.mit.edu/confluence/display/LIBPROXSERV/Proxy+lookup+scripts)

## Configuration Reqirements

The proxy server will only proxy connections to service
providers listed in its configuration file. A proxy URL with
a target domain or hostname that is not known to the proxy
server will result in an error. Create a fix-lib ticket if
you will be creating proxy URLs for a new service provider.

## How EZproxy works

The proxy server runs commercial software called
[Ezproxy](https://help.oclc.org/Library_Management/EZproxy)

[Read more about how it
works](https://help.oclc.org/Library_Management/EZproxy/Get_started/About_EZproxy)
