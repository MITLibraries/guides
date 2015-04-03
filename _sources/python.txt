
Python Guidelines
=================

Python Versions
---------------

We still have 2.6 on some servers, so for now, you should support 2.6+ and 3.3+.


Style and Coding Conventions
----------------------------

In general, you should follow `PEP 8 <https://www.python.org/dev/peps/pep-0008/>`_ and
`PEP 257 <https://www.python.org/dev/peps/pep-0257/>`_. Unless otherwise stated here, assume those two guidelines are in effect.

Use `reST <http://docutils.sourceforge.net/rst.html>`_ in your docstrings. In addition to a description of what a function does, you should document the parameters::

    def frobber(widget):
        """Frob the widget.

        A widget has to be frobbed before being passed to the
        Dusenbury Device.

        :param widget: widget what needs frobbing
        """

        frob(widget)

All files should start with the following two lines as the first two lines (unless, of course, you are using a shebang)::

    # -*- coding: utf-8 -*-
    from __future__ import absolute_import

You may want to create a python template in your editor to make sure they are always there.

Project Documentation
---------------------

`Sphinx <http://sphinx-doc.org/>`_ is recommended for generating project documentation. `GitHub Pages Import <https://github.com/davisp/ghp-import>`_ can be useful for managing your built documentation.

Testing
-------

Use `tox <https://tox.readthedocs.org/en/latest/>`_. Keep any test-specific dependencies, i.e. unittest2, mock, etc., out of your ``requirements.txt`` file. Those should be specified in your ``tox.ini`` where necessary. You may want to consider using `pytest <http://pytest.org/latest/>`_ to run your tests and `pytest-cov <https://pypi.python.org/pypi/pytest-cov>`_ for coverage.
