---
order: 1000
---
### OAuth at MIT

The [MIT OpenID Connect pilot](https://oidc.mit.edu/) includes an OAuth provider which you can use for authentication. [Documentation](http://kb.mit.edu/confluence/display/istcontrib/Logging+in+Users+to+your+application+using+OpenID+Connect) for MIT's OAuth implementation is available in the [Knowledge Base](http://kb.mit.edu/). (This is different from, and superior to, the documentation on the OIDC web site.)

#### Code you can reuse

The Libraries have already written several OAuth integrations you can and should reuse where applicable:
* [Rails](https://github.com/MITLibraries/omniauth-mit-oauth2)
* [Flask](https://github.com/MITLibraries/flask-mitoauth2)
* Django, as part of the [solenoid](https://github.com/MITLibraries/solenoid) project (see `solenoid/userauth/backends.py`)

#### Policy

There is ITDD policy on the use of Heroku, which may be relevant to you if you using OAuth.

* Apps that don’t require end-user authentication may be deployed to Heroku.
* Apps that use, store, or consume [sensitive data](http://infoprotect.mit.edu/what-needs-protecting) require multi-factor/DUO authentication and therefore may not be deployed on Heroku.
* Other apps that do require end-user authentication may be deployed to Heroku (and use OIDC) if the work falls into one of these categories:
  * The development work is clearly identified as an experiment/POC only and not intended for production, or
  * The project is in the early stages of development, and will ultimately be transferred to a VM for production, or
  * The app will only be used by fewer than 5 users from the Libraries staff, and no other user types, or
  * You have cleared the use of Heroku/OIDC with the ITDD leadership team for a special case.
