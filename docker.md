---
order: 1000
---
### Containerizing Your App

This will provide some guidelines for getting your application ready for containers. This is mostly relevant for custom software, as existing solutions will (hopefully) already have a Dockerfile.

#### Dockerfile Guidelines

1. Keep your Dockerfile simple. If you have complicated logic that needs to be done, put it in a shell script and call it from your Dockerfile.
2. Specify the minor language version in your base image, e.g. `FROM python:3.6`.
3. Use both an ENTRYPOINT and CMD (more on this below).
4. EXPOSE a port if you are deploying a web app. This is good documentation more than anything else.
5. Leave environment variables out of your Dockerfile. These should be set at run time through the orchestration framework.
6. Use COPY instead of ADD (unless you really need ADD).

##### ENTRYPOINT/CMD

Deciding how and when to use ENTRYPOINT and CMD can be confusing. The suggested usage made here is done for clarity of intent and most predictable behavior. Each Dockerfile should have both an ENTRYPOINT and CMD. Think of your ENTRYPOINT as your application's main command and the CMD as the most common arguments. A few examples:

```
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "s", "-p", "3000", "-b", "0.0.0.0"]
```

```
ENTRYPOINT ["gunicorn", "myapp.wsgi"]
CMD ["-b", "0.0.0.0:5000", "-w", "2"]
```

Specifying both an ENTRYPOINT and CMD clearly communicates to anyone looking at this how the app should be run. This also makes it easier to run since a simple `docker run` command will execute the ENTRYPOINT with CMD as the arguments. Both can still be changed at run time if needed; consider ENTRYPOINT and CMD as your defaults.

You may also sometimes see these options used with a slightly different syntax, for example:

```
ENTRYPOINT bundle exec
```

Note how `bundle exec` is not specified as an array. The simplest suggestion is don't do this. Using an array, as shown in the earlier examples, will almost always lead to fewer unexpected issues.

#### .dockerignore

In most cases, your Dockerfile will be copying much of your project's source directory into the container. Copying a few extraneous files isn't usually a problem, but try to avoid copying local directories full of dependencies like `vendor/bundle` or a virtualenv. The easiest way to do this is to make sure you use a `.dockerignore` file. It works like `.gitignore`.

#### Example Dockerfiles

For a Python WSGI app:

```
FROM python:3.6

COPY . /myapp/
WORKDIR /myapp
RUN python3.6 -m pip install pipenv
RUN pipenv install --system --deploy

EXPOSE 5000
ENTRYPOINT ["gunicorn", "myapp.wsgi"]
CMD ["-b", "0.0.0.0:5000", "-w", "2"]
```

For a Rails app:

```
FROM ruby:2.4

COPY . /myapp/
WORKDIR /myapp
RUN bundle install

EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "s", "-p", "3000", "-b", "0.0.0.0"]
```
