#pragma once

#include "Kernel.h"

class ReactionThirdOrderEnergy : public Kernel
{
public:
  ReactionThirdOrderEnergy(const InputParameters & parameters);

  static InputParameters validParams();

protected:
  virtual Real computeQpResidual();
  virtual Real computeQpJacobian();
  virtual Real computeQpOffDiagJacobian(unsigned int jvar);

  // MooseVariable & _coupled_var_A;
  // MooseVariable & _coupled_var_B;
  const VariableValue & _v;
  const VariableValue & _w;
  const VariableValue & _x;
  unsigned int _v_id;
  unsigned int _w_id;
  unsigned int _x_id;

  // The reaction coefficient
  const MaterialProperty<Real> & _reaction_coeff;
  Real _stoichiometric_coeff;
  Real _threshold_energy;

  bool _v_eq_u;
  bool _w_eq_u;
  bool _x_eq_u;
};
