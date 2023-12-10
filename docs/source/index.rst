Welcome to CRANE
================

.. warning::

   Documentation pages of CRANE are under construction.

`CRANE <https://arxiv.org/abs/1905.10004>`_ (Chemical ReAction NEtwork) is an
open-source software for the simulation of chemical kinetics in
nonequilibrium plasmas developed by the
Laboratory of Computational Plasma Physics (LCPP) at the University of Illinois Urbana-Champaign.
It is designed to be used either as a standalone application,
or as a coupled application within the MOOSE finite element framework.
CRANE is written in C++ and is released under the
`LGPL-2.1 License v3.0 <https://github.com/lcpp-org/crane/blob/master/LICENSE>`_.

CRANE was developed within the `MOOSE <https://mooseframework.inl.gov/>`_ framework.
MOOSE (Multiphysics Object Oriented Simulation Environment) is a finite element software
developed at Idaho National Labroatory :cite:t:`gaston2009MOOSE`,
which provides a software framework for coupled nonlinear multiphysics simulations.
MOOSE's modular structure allows different codes to be coupled in two ways:
they may be compiled together and included in a single fully coupled nonlinear solver,
or applications can be loosely coupled with the ``MultiApp`` system.
Primarily built for large-scale nuclear reactor simulations,
the MOOSE framework is well-suited to the study of plasmas due to its massively parallel operation
and its ability to treat multi-phase systems (such as plasma-liquid interactions).

CRANE aims to further expand the plasma simulation capabilties of the MOOSE framework
by including a chemical kinetics solver. Using the MOOSE framework's *Actions* system,
CRANE allows lists of chemical reactions to be added to the input file in a simple,
human-readable format to construct reaction networks. These lists are then parsed
and constructed into separate *Kernels* for each reacant and product in each reaction.
The addition of reactions requires no C++ programming from the user.

CRANE can be used on its own, without any other MOOSE modules or applications.
In this case, zero-dimensional (0D) modeling of global/volume-averaged chemical kinetics is supported.
If compiled into other MOOSE applications as a submoduke, CRANE provides the user with the ability
to solve chemical reaction networks as part of a larger multiphysics simulation.

The relative ease of coupling different codes together is a strong advantage
for both CRANE and other MOOSE applications.
By compiling CRANE as a submodule in `Zapdos <http://dx.doi.org/10.1088/0022-3727/49/23/235204s>`_,
which is a separate software developed by the Shannon Lab at the North Carolina State University
for drift-diffusion modeling of low-temperature plasmas, a user is able to numerically solve a
fully-coupled system of multispecies drift-diffusion-reaction equations in multidimensional domains
(1D, 2D, 3D) to simulate nonequilibrium plasma discharges, such as plasma-liquid interactions
and processing plasma chambers.
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
