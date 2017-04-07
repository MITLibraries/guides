# Python Guidelines

## Python Versions

In most cases, we should have at least 3.4 available on local servers. Unless there's a specific reason to do so, there is no need to support Python 2.

## Style and Coding Conventions

In general, you should follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) and [PEP 257](https://www.python.org/dev/peps/pep-0257/). Unless otherwise stated here, assume those two guidelines are in effect. It is recommended to use [flake8](http://flake8.pycqa.org/en/latest/) during development and CI.

Use [reST](http://docutils.sourceforge.net/rst.html) in your docstrings. In addition to a description of what a function does, you should document the parameters:

```python
def widgetize(widget):
  """Properly widgetize the widget.

  This ensures that the widget conforms to the strict standards
  governing conformant widgets.

  :param widget: a widget what needs widgetizing
  """

  standardize(widget)
```

If you are supporting Python 2.7 you should make sure the first line of all your files contains:

```python
# -*- coding: utf-8 -*-
from __future__ import absolute_import
```

If you are only targeting Python 3, this is not necessary.

## Project Documentation

Use [Sphinx](http://sphinx-doc.org/) for generating project documentation.

## Testing

Use [tox](https://tox.readthedocs.org/en/latest/). Keep any test-specific dependencies, i.e. unittest2, requests_mock, etc., out of your `requirements.txt` file. Those should be specified in your `tox.ini` where necessary.
