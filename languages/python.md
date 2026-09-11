# Python Guidelines

## Installing Python for Development

At this time, the preferred way to handle both python virtual environments and the management of dependencies for a given project is to use [uv](https://docs.astral.sh/uv/).

Once `uv` is installed on your machine (see [`uv` installation instructions](https://docs.astral.sh/uv/getting-started/installation/)), `Makefile` commands like `make install` will be sufficient for setting up a virtual environment to work with.

To update `uv`, use `uv self update`.

### `uv` Quick Reference

#### Create a new, bare project
```shell
uv init --bare --python <VERSION, e.g. "3.14">
```

#### Create a virtual environment at `.venv`
```shell
uv venv .venv --python <VERSION, e.g. "3.14">
```

#### Add a dependency to a project
```shell
uv add <DEPENDENCY, e.g. "pandas">
```

Or to add a "dev" dependency (not built with Docker container):
```shell
uv add --dev <DEPENDENCY, e.g. "ipython">
```

#### Update all dependencies for project
```shell
uv lock --upgrade  # updates the uv.lock file, but nothing installed
uv sync --dev      # install all versions from lock file, including "dev" section
```

## Python versions

You should be using the most recent stable version. If creating AWS lambda functions, refer to [their docs](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html) for information on the latest supported Python version (seems to lag behind the official Python releases).

## Creating a project from templates

We have Github template repositories for two types of Python projects:

- [CLI applications](https://github.com/MITLibraries/python-cli-template), generally created with [Click](https://click.palletsprojects.com/) and run as containers in Fargate.
- [AWS lambda functions](https://github.com/MITLibraries/python-lambda-template), published and run as containerized functions.

If you are creating either of those types of applications, please start from a template. See [Github guidelines for creating a repository from a template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template).

Note: it's important that you follow all of the setup instructions in the template's README, particulary those regarding Github settings for the repository.

If you notice anything that needs to be updated in either of the templates, please submit a PR!

## Python Project Specification

The [Python Project Specification](https://github.com/MITLibraries/spec-python-projects) repository is a declarative standard for Python projects. It defines the tooling, configuration, file structure, and workflow targets that a compliant project should have.  The [SPECIFICATION.md](https://github.com/MITLibraries/spec-python-projects/blob/main/SPECIFICATION.md) file in that repository is designed to be a living document with fairly constant updates.

Where this page provides general principles and recommendations, the specification aims to provide auditable, concrete requirements, e.g. `pyproject.toml` configuration, Makefile targets, pre-commit hooks, CI workflows, Dockerfile patterns, etc.

## Style and coding Conventions

In general, you should follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) and [PEP 257](https://www.python.org/dev/peps/pep-0257/). Unless otherwise stated here, assume those two guidelines are in effect.

If you are providing function docstrings, use [Google style](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings). In addition to a description of what a function does, you should document the parameters:

```python
def widgetize(widget):
  """Properly widgetize the widget.

  This ensures that the widget conforms to the strict standards
  governing conformant widgets.

  Args:
    widget: A widget what needs widgetizing.
  """

  standardize(widget)
```

### Linting, code quality, and code safety

Our standard Python code checkers in all repositories include:

- [ruff](https://docs.astral.sh/ruff/) - formatting and linting (replaces black, isort, pylama, and bandit)
- [mypy](https://mypy.readthedocs.io/en/stable/) - type checking
- [pip-audit](https://pypi.org/project/pip-audit/) - dependency security auditing

These tools should be used during development and are run automatically in Github Actions during CI. They are all included in the template repositories listed above, and have integrations for common code editors to allow automatic checking and reformatting during development.

The linters are usually run together with the `make lint` command in a project's Makefile.

## Dependencies

Use [uv](https://docs.astral.sh/uv/) to manage dependencies for Python applications. Dependencies should be declared in `pyproject.toml` and locked with `uv lock`.

## Project Documentation

Use [Sphinx](http://sphinx-doc.org/) for generating project documentation.

## Testing

All Python code should be thoroughly tested for expected cases, not just best-case scenarios. We generally use [Pytest](https://docs.pytest.org) as the test framework for our repos, along with [Coverage](https://coverage.readthedocs.io/) for test coverage reporting. These are included in the template repository dev dependencies.

Other useful tools for testing in Python:

- [moto](http://docs.getmoto.org/en/latest/) - for mocking AWS services in tests
- [requests-mock](https://requests-mock.readthedocs.io/en/latest/) - for mocking HTTP requests
- [vcrpy](https://vcrpy.readthedocs.io/en/latest/) - for automatically capturing calls to external APIs for reuse in tests
