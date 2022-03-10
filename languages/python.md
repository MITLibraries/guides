# Python Guidelines

## Python Versions

You should be using the most recent stable version. Don't use Python 2.

## Style and Coding Conventions

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

## Linting
It is recommended to use [black](https://black.readthedocs.io/en/stable/) (formatting), [flake8](https://flake8.pycqa.org/en/latest/index.html#quickstart) (formatting), [bandit](https://bandit.readthedocs.io/en/latest/) (security),[mypy](https://mypy.readthedocs.io/en/stable/) (type hinting), and [isort](https://pycqa.github.io/isort/) (import order) during development and CI. Black is preferred as the primary formatting style due to its easy methods for auto-formatting the code. 

To install these linters when starting a new project, run `pipenv install --dev black flake8 bandit mypy isort`. The linters can be run together by adding a `make lint` command to the project's Makefile. See the [Makefile](https://github.com/MITLibraries/alma-scripts/blob/main/Makefile) for the `llama` application for an example.




## Command line interfaces
Typically, [click](https://click.palletsprojects.com/en/8.0.x/) is used for creating command line interfaces (CLI) in Python projects.

## Dependencies

Use [Pipenv](https://pipenv.readthedocs.io/en/latest/) to manage dependencies. If there's some reason you need to support pip, then you should still manage dependencies with pipenv, but generate your `requirements.txt` file as needed with:

```
$ pipenv lock -r
```

## Project Documentation

Use [Sphinx](http://sphinx-doc.org/) for generating project documentation.

## Testing

Since we no longer have to support both Python 2 and 3 there's less need for [tox](https://tox.readthedocs.org/en/latest/), though it can still be useful. Unless you are using something like Django that comes with its own testing framework, use [pytest](https://docs.pytest.org).
