# Python Guidelines

## Python versions

You should be using the most recent stable version. Don't use Python 2. If creating AWS lambda functions, refer to [their docs](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html) for information on the latest supported Python version (seems to lag behind the official Python releases).

## Creating a project from templates

We have Github template repositories for two types of Python projects:

- [CLI applications](https://github.com/MITLibraries/python-cli-template), generally created with [Click](https://click.palletsprojects.com/) and run as containers in Fargate.
- [AWS lambda functions](https://github.com/MITLibraries/python-lambda-template), published and run as containerized functions.

If you are creating either of those types of applications, please start from a template. See [Github guidelines for creating a repository from a template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template).

Note: it's important that you follow all of the setup instructions in the template's README, particulary those regarding Github settings for the repository.

If you notice anything that needs to be updated in either of the templates, please submit a PR!

## Style and coding Conventions

In general, you should follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) and [PEP 257](https://www.python.org/dev/peps/pep-0257/). Unless otherwise stated here, assume those two guidelines are in effect.

If you are providing function docstrings, use [reST](http://docutils.sourceforge.net/rst.html). In addition to a description of what a function does, you should document the parameters:

```python
def widgetize(widget):
  """Properly widgetize the widget.

  This ensures that the widget conforms to the strict standards
  governing conformant widgets.

  :param widget: a widget what needs widgetizing
  """

  standardize(widget)
```

### Linting, code quality, and code safety

Our standard Python code checkers in all repositories include:

- [bandit](https://bandit.readthedocs.io/en/latest/) - security
- [black](https://black.readthedocs.io/en/stable/) - formatting
- [isort](https://pycqa.github.io/isort/) - import order
- [mypy](https://mypy.readthedocs.io/en/stable/) - type hinting
- [pylama](https://github.com/klen/pylama) - formatting and code quality (wrapper around several other tools)

These tools should be used during development and are run automatically in Github Actions during CI. They are all included in the template repositories listed above, and have integrations for common code editors to allow automatic checking and reformatting during development.

The linters are usually run together with the `make lint` command in a project's Makefile. See the template repositories for examples.

## Dependencies

Use [Pipenv](https://pipenv.readthedocs.io/en/latest/) to manage dependencies for Python applications. If there's some reason you need to support pip, then you should still manage dependencies with pipenv, but generate your `requirements.txt` file as needed with:

```
pipenv requirements > requirements.txt
```

If you are creating a Python library, [Poetry](https://python-poetry.org/) is the preferred package and distribution manager.

## Project Documentation

Use [Sphinx](http://sphinx-doc.org/) for generating project documentation.

## Testing

All Python code should be thoroughly tested for expected cases, not just best-case scenarios. We generally use [Pytest](https://docs.pytest.org) as the test framework for our repos, along with [Coverage](https://coverage.readthedocs.io/) for test coverage reporting. These are included in the template repository dev dependencies.

Other useful tools for testing in Python:

- [moto](http://docs.getmoto.org/en/latest/) - for mocking AWS services in tests
- [requests-mock](https://requests-mock.readthedocs.io/en/latest/) - for mocking HTTP requests
- [vcrpy](https://vcrpy.readthedocs.io/en/latest/) - for automatically capturing calls to external APIs for reuse in tests
