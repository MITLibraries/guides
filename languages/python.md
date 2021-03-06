# Python Guidelines

## Python Versions

You should be using the most recent stable version. Don't use Python 2.

## Style and Coding Conventions

In general, you should follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) and [PEP 257](https://www.python.org/dev/peps/pep-0257/). Unless otherwise stated here, assume those two guidelines are in effect. It is recommended to use [flake8](http://flake8.pycqa.org/en/latest/) during development and CI.

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

## Dependencies

Use [Pipenv](https://pipenv.readthedocs.io/en/latest/) to manage dependencies. If there's some reason you need to support pip, then you should still manage dependencies with pipenv, but generate your `requirements.txt` file as needed with:

```
$ pipenv lock -r
```

## Project Documentation

Use [Sphinx](http://sphinx-doc.org/) for generating project documentation.

## Testing

Since we no longer have to support both Python 2 and 3 there's less need for [tox](https://tox.readthedocs.org/en/latest/), though it can still be useful. Unless you are using something like Django that comes with its own testing framework, use [pytest](https://docs.pytest.org).
