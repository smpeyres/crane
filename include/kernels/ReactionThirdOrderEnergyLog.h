//* This file is part of Crane, an open-source
//* application for plasma chemistry and thermochemistry
//* https://github.com/lcpp-org/crane
//*
//* Crane is powered by the MOOSE Framework
//* https://www.mooseframework.org
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "Kernel.h"

class ReactionThirdOrderEnergyLog : public Kernel
{
public:
  ReactionThirdOrderEnergyLog(const InputParameters & parameters);

  static InputParameters validParams();

protected:
  virtual Real computeQpResidual();
  virtual Real computeQpJacobian();
  virtual Real computeQpOffDiagJacobian(unsigned int jvar);

  const VariableValue & _v;
  const VariableValue & _w;
  const VariableValue & _x;
  unsigned int _v_id;
  unsigned int _w_id;
  unsigned int _x_id;
  bool _v_eq_u;
  bool _w_eq_u;
  bool _x_eq_u;

  const MaterialProperty<Real> & _reaction_coeff;
  Real _stoichiometric_coeff;
  Real _threshold_energy;
};
