---
order: 1000
---

### Proxy URLs

**tl;dr:** The only supported way to construct a URL that requests service from
EZproxy is this: `http://libproxy.mit.edu/login?url=<target url>`.

#### Why use a proxy URL?
A proxy server allows a user to access an electronic resource by acting as a
substitute for that user in the eyes of the content provider.

The MIT Libraries' proxy servers are on MIT’s network at two different IP
addresses. They run commercial software called EZproxy. Our proxy servers' main
purpose is to communicate with external content vendors on behalf of MIT users
in cases where the user’s browser is not on MIT’s network, and the vendor only
accepts connections from MIT's network range.

Most of the Library’s licensed e-resources are subscriptions from commercial
vendors and are subject to license agreements. In the majority of cases the
vendor has agreed to accept direct, anonymous, unauthenticated connections from
any IP address within the range they have on file for MIT. On-campus users will
automatically have an IP address within that range, but off-campus users will
not. Off-campus users must be “proxied” i.e. they need a facility (whose IP
address is within the MIT range) to contact vendors on their behalf and mediate
their session.

#### How EZproxy works
When a vendor website or URL pattern is configured in EZproxy, rules are
applied that enable EZproxy to determine whether the user requires proxying or
not. If the user’s browser is reporting an IP address that falls within the MIT
range, the user does not require proxy services and EZproxy redirects the
user’s browser directly to the target site.

If the user’s browser reports an IP address that is not within the MIT range,
EZproxy will authenticate the user and then set up a proxied session on behalf
of the user. Whenever a URL is constructed for content that needs to be
accessible both on-campus and off-campus, best practice is always to route the
URL through the proxy server and let EZproxy decide whether proxying is
required or not.

#### EZproxy configuration
While it is good practice to let EZproxy decide when its services are required,
it can only do this if it knows about the site in question. Asking EZproxy to
handle a site that it does not know about will result in an error. **If URLs for
a new site are to be constructed, it is imperative that the proxy servers be
configured accordingly before the URLs can be handled by EZproxy.** Contact TS3
if you need EZproxy to handle URLs for a new domain.

#### How to construct a proxy URL
The only supported way to construct a URL that requests service from
EZproxy is this: `http://libproxy.mit.edu/login?url=<target url>`. For example:
[http://libproxy.mit.edu/login?url=https://dx.doi.org/10.1002/2017JE005302](http://libproxy.mit.edu/login?url=https://dx.doi.org/10.1002/2017JE005302)

There is an unfortunate idea floating around that the same URL could be
constructed like this: [https://dx.doi.org.libproxy.mit.edu/10.1002/2017JE005302](https://dx.doi.org.libproxy.mit.edu/10.1002/2017JE005302)
**Do not do this!** Because some URLs constructed like this will work, it is often
assumed that this is acceptable practice. It is not. Such URLs will sometimes
work and sometimes fail, and this construction is not supported by EZproxy.
