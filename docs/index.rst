.. MIT Libraries documentation master file, created by
   sphinx-quickstart on Thu Mar 12 11:24:15 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

MIT Libraries Developer Documentation
=====================================

Contents:

.. toctree::
   :maxdepth: 2

   git
   python

Making Changes to this Documentation
------------------------------------

Changes to this documentation should follow the workflow outlined in
:doc:`git`. Make sure you have `Sphinx installed <http://sphinx-doc.org/latest/install.html>`_. The source documentation is in the `docs/`
directory.

Create a local feature branch for your changes:

.. code:: bash

    $ git clone https://github.com/MITLibraries/mitlibraries.github.io.git
    $ cd MITLibraries
    $ git checkout -b <feature-branch>

Make your changes to the source documentation and then build the HTML docs:

.. code:: bash

    $ cd docs && make html

Commit the changes to your feature branch and push them to the remote
repository:

.. code:: bash

    $ git commit -a
    $ git push origin <feature-branch>
