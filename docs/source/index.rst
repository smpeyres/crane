Welcome to CRANE
=====

.. warning::

   Documentation pages of CRANE are under construction.

`CRANE <https://arxiv.org/abs/1905.10004>`_ (Chemical ReAction NEtwork) is an open-source
`MOOSE <https://mooseframework.inl.gov/>`_-based **plasma chemistry**
software developed by the Laboratory of Computational Plasma Physics (LCPP)
at the University of Illinois Urbana-Champaign, that was designed to
address non-equilibrium plasma chemistry problems of arbitrary size.

CRANE can be used on its own, without any other MOOSE modules or applications.
In this case, zero-dimensional (0D) modeling of global/volume-averaged chemical kinetics is supported.

`Zapdos <http://dx.doi.org/10.1088/0022-3727/49/23/235204s>`_ is a separate software developed by the Shannon Lab
at the North Carolina State University for the modeling of low-temperature plasmas.
Zapdos is coupled to CRANE to allow for easier multidimensional (1D, 2D, 3D) modeling of reactive plasma systems.
If you wish to use Zapdos in conjunction with CRANE,
please visit `Zapdos' Github repository <https://github.com/shannon-lab/zapdos>`.

Contents
--------

.. toctree::
   :maxdepth: 1

   overview
   build
   running
   tutorials
   contributing
   references

Citing
------

If you use CRANE, please cite us in your publication :cite:`keniley2019crane`:

.. code-block:: bibtex

   @misc{keniley2019crane,
      title={CRANE: A MOOSE-based Open Source Tool for Plasma Chemistry Applications},
      author={Shane Keniley and Davide Curreli},
      year={2019},
      eprint={1905.10004},
      archivePrefix={arXiv},
      primaryClass={physics.plasm-ph}
   }

.. admonition:: Citing

   S. Keniley and D. Curreli,
   CRANE: A MOOSE-based Open Source Tool for Plasma Chemistry Applications,
   arXiv:1905.10004v1 [physics.plasma-ph], 2019.
   `https://arxiv.org/abs/1905.10004 <https://arxiv.org/abs/1905.10004>`_

Acknowledgements
----------------

The development of CRANE was supported by the National Science
Foundation under Grant No.
`1740310 <https://www.nsf.gov/awardsearch/showAward?AWD_ID=1740310>`_.
CRANE is built as part of the MOOSE
framework developed at Idaho National Laboratory. The MOOSE team has
been an invaluable resource during the development of CRANE.
