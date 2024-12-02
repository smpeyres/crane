[Mesh]
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 1
  nx = 1
[]

[Variables]
  [e]
    family = SCALAR
    order = FIRST
    initial_condition = 1e6
    scaling = 1e-6
  []

  [Ar+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.5e6
    scaling = 1e-6
  []

  [Ar]
    family = SCALAR
    order = FIRST
    initial_condition = 8.1543668e18 # 100% Ar
    # initial_condition = 8.0728231e18 # 99% Ar
    scaling = 1e-18
  []

  [Ar*]
    family = SCALAR
    order = FIRST
    initial_condition = 1e6
    scaling = 1e-6
  []

  [Ar2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.5e6
    scaling = 1e-6
  []

  [F2]
    family = SCALAR
    order = FIRST
    initial_condition = 8.1543668e14 # 0.01% F2
    scaling = 1e-14
  []

  [F]
    family = SCALAR
    order = FIRST
    initial_condition = 1e6
    scaling = 1e-6
  []

  [F2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.5e6
    scaling = 1e-6
  []

  [F+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.5e6
    scaling = 1e-6
  []

  [F-]
    family = SCALAR
    order = FIRST
    initial_condition = 1e6
    scaling = 1e-6
  []

  [ArF*]
    family = SCALAR
    order = FIRST
    initial_condition = 1e6
    scaling = 1e-6
  []
[]

[ScalarKernels]
  [de_dt]
    type = ODETimeDerivative
    variable = e
  []

  [dAr+_dt]
    type = ODETimeDerivative
    variable = Ar+
  []

  [dAr_dt]
    type = ODETimeDerivative
    variable = Ar
  []

  [dAr*_dt]
    type = ODETimeDerivative
    variable = Ar*
  []

  [dAr2_dt]
    type = ODETimeDerivative
    variable = Ar2+
  []

  [dF2_dt]
    type = ODETimeDerivative
    variable = F2
  []

  [dF_dt]
    type = ODETimeDerivative
    variable = F
  []

  [dF2+_dt]
    type = ODETimeDerivative
    variable = F2+
  []

  [dF+_dt]
    type = ODETimeDerivative
    variable = F+
  []

  [dF-_dt]
    type = ODETimeDerivative
    variable = F-
  []

  [dArF*_dt]
    type = ODETimeDerivative
    variable = ArF*
  []
[]

[GlobalReactions]
  [argon]
    species = 'e Ar* Ar+ Ar Ar2+ F2 F F2+ F- ArF* F+'
    file_location = 'data'

    # These are parameters required equation-based rate coefficients
    equation_constants = 'Tgas J pi pres d_cm r_cm'
    equation_values = '900 2.405 3.141 760 0.2 0.05'
    equation_variables = 'Te'
    sampling_variable = 'reduced_field'

    reactions = '# From original microdischarge model
                  e + Ar -> e + e + Ar+          : EEDF (Ar_ionization)
                  e + Ar -> Ar* + e              : EEDF (Ar_excitation)
                  e + Ar* -> Ar + e              : EEDF (Ar*_deexcitation)
                  e + Ar* -> Ar+ + e + e         : EEDF (Ar*_ionization)
                  Ar2+ + e -> Ar* + Ar           : {8.5e-7*((Te/1.5)*11600/300.0)^(-0.67)} # Ma : 7.0e-7
                  Ar2+ + Ar -> Ar+ + Ar + Ar     : {(6.06e-6/Tgas)*exp(-15130.0/Tgas)}
                  Ar* + Ar* -> Ar2+ + e          : {6.0e-10}
                  Ar+ + e + e -> Ar + e          : {8.75e-27*((Te/1.5)^(-4.5))}
                  Ar* + Ar + Ar -> Ar + Ar + Ar  : {1.399e-32}
                  Ar+ + Ar + Ar -> Ar2+ + Ar     : {2.25e-31*(Tgas/300.0)^(-0.4)} # 2.1e-31 in NRL Electra
                # Some more argon reactions from Ma PSST 2024
                  Ar+ + e + e -> Ar* + e        : {8.75e-27*(Te^-4.5)}
                  Ar+ + e + Ar -> Ar* + Ar      : {1e-26}
                # Some more argon reactions from NRL Electra
                  Ar2+ + e -> Ar + Ar           : {5.0e-8}
                # Electron-impact reactions w F2 based on Ma PSST 2024, using Gudmundsson
                #   # F2 + e -> F- + F              : {4.5e-9*(Te^-1.35)*exp(-0.15/Te)}
                  F2 + e -> F2+ + e + e         : {1.37e-8*exp(-20.70/Te)}
                # # All other fluorine-involved reactions in Ma PSST 2024
                #   ArF* + e -> Ar + F + e        : {2.0e-7} # 2.4e-7 in NRL Electra
                #   Ar+ + F- -> ArF*              : {1.0e-6}
                #   F2+ + F- -> F + F + F         : {4.0e-8} # 4.0e-8 in NRL Electra, {1.5e-7*((300/Tgas)^0.5)} in Gudmundsson
                #   Ar2+ + F- -> ArF* + Ar        : {5.45e-5}
                #   # Ar* + F2 -> ArF* + F          : {7.5e-10} # 9.4e-10 in NRL Electra
                #   # Ar* + F2 -> Ar + F + F        : {3.1e-10}
                #   ArF* + Ar -> Ar + Ar + F      : {9.0e-12} # 9.0e-12 in NRL Electra
                #   # ArF* + F2 -> Ar + F + F + F   : {1.9e-9}
                #   ArF* -> Ar + F + hv           : {2.5e8} # 2.67e8 for hv_B, 2.4e8 for hv, and 2.1e7 for hv_A from NRL Electra
                # # Some association and dissociation from NIST kinetics database
                #   F + F + Ar -> F2 + Ar         : {2.67e-37*(Tgas/298)*exp(3190/Tgas)}
                #   F + F + F2 -> F2 + F2         : {2.67e-37*(Tgas/298)*exp(3190/Tgas)}
                #   F + F + F -> F2 + F           : {2.67e-37*(Tgas/298)*exp(3190/Tgas)}
                #   # F2 + F2 -> F + F + F2          : {7.59e-12*exp(-14313/Tgas)}
                #   # F2 + F -> F + F + F            : {7.59e-12*exp(-14313/Tgas)}
                #   # F2 + Ar -> F + F + Ar          : {7.59e-12*exp(-14313/Tgas)}
                # # Some reactions from NRL Electra paper
                #   e + F -> F- + hv                    : {1.0e-12} # 1e-15 in Gudmundsson
                #   e + ArF* -> Ar* + F-                : {3.0e-8}
                #   # e + F2 -> F + F + e                 : {3.0e-10}
                #   Ar* + Ar* -> Ar+ + e + Ar           : {1.2e-9}
                #   ArF* + F -> Ar + F + F              : {1.0e-12}
                #   ArF* + F2 -> Ar + F + F2            : {1.9e-9}
                #   ArF* + Ar + Ar -> Ar + Ar + Ar + F  : {5.0e-32}
                # IYMG charge exchange - all based on initial one from Gudmundsson
                # 5.00e-18 in Mao et al
                # 1.00e-11 in Huang et al, no reaction between Ar2+ and F, F2?
                # Removed dissociative charge exchange of F2, F2+ based on Mao et al
                #   F+ + F2 -> F2+ + F                 : {3.98e-11*((300/Tgas)^0.5)} # 1e-11 Huang et al
                #   F2+ + F -> F2 + F+                 : {3.98e-11*((300/Tgas)^0.5)}
                #   F+ + Ar -> F + Ar+                 : {3.98e-11*((300/Tgas)^0.5)} # 1e-11 Huang et al
                  Ar2+ + F2 -> F2+ + Ar + Ar         : {3.98e-11*((300/Tgas)^0.5)}
                #   Ar2+ + F -> F+ + Ar + Ar           : {3.98e-11*((300/Tgas)^0.5)}
                  F2+ + Ar -> F2 + Ar+               : {3.98e-11*((300/Tgas)^0.5)}
                  Ar+ + F2 -> F2+ + Ar           : {3.98e-11*((300/Tgas)^0.5)} # 1e-11 Huang et al
                #   Ar+ + F -> F+ + Ar             : {3.98e-11*((300/Tgas)^0.5)}
                # # Some ion-ion recombination from Gudmundsson
                #   F- + F+ -> F + F                   : {2.7e-7*((300/Tgas)^0.5)} #2.7e-7 in Huang et al
                #   F+ + F- + F -> F2 + F              : {8.18e-20*(Tgas^-2.5)}
                # # Recombination IYMG from Kushner GEC
                #   # e + F2+ -> F + F                   : {3.2e-8*(Te^-0.5)} # Gudmundsson, {1e-7*(Te^-0.5)}  Kushner IYMG, Huang et al
                #   # e + F+ -> F + hv                   : {4.5e-13*(Te^-0.5)} # Huang et al, {5e-13*(Te^-0.7)} Kushner IYMG
                #   # e + e + F+ -> F + e                : {7e-27*(Te^-4.5)} # Kushner IYMG
                #   # e + e + F+ -> F + e                : {5.12e-27*(Te^-4.5)} # Huang et al
                # # Ionization & dissociation from Gudmundsson
                #   e + F -> F+ + e + e            : {1.3e-8*exp(-16.50/Te)} # evil?
                #   e + F2 -> F+ + F- + e          : {2.26e-9*exp(-21.33/Te)}
                #   # e + F- -> F + e + e            : {3.27e-10*(Te^1.4)*exp(-2.68/Te)}
                #   # e + F2 -> F + F + e            : {1.18e-8*exp(-5.77/Te)}
                # # Neutral detachment from Mao et al
                #   F- + Ar -> F + Ar + e          : {5.27e-14}
                #   F- + F2 -> F + Ar + e          : {5.27e-14}
                # # Other reactions from Huang et al
                #   F- + F -> F2 + e               : {1.4e-10}
'
  []
[]

[AuxVariables]
  [reduced_field]
    order = FIRST
    family = SCALAR
    initial_condition = 6.131684e-20
  []

  [mobility]
    order = FIRST
    family = SCALAR
  []

  [Te]
    order = FIRST
    family = SCALAR
  []

  [current]
    order = FIRST
    family = SCALAR
  []
[]

[AuxScalarKernels]
  [reduced_field_calculate]
    type = ParsedAuxScalar
    variable = reduced_field
    constant_names = 'V d qe R'
    constant_expressions = '1000 0.002 1.602e-19 1e5'
    args = 'reduced_field Ar F2 current'
    function = 'V/(d+R*current/(reduced_field*(Ar+F2)*1e6))/((Ar+F2)*1e6)'
    execute_on = 'TIMESTEP_END'
  []

  [e_drift]
    type = ParsedAuxScalar
    variable = current
    constant_names = 'r pi'
    constant_expressions = '0.0005 3.1415926'
    args = 'reduced_field mobility Ar F2 e'
    function = '((reduced_field * mobility * (Ar+F2)*1e6) * 1.6e-19 * pi*(r^2.0) * (e*1e6))'
    execute_on = 'TIMESTEP_BEGIN'
  []

  [mobility_calculation]
    type = ScalarLinearInterpolation
    variable = mobility
    sampler = reduced_field
    property_file = 'data/electron_mobility.txt'
    execute_on = 'INITIAL TIMESTEP_BEGIN'
  []

  [temperature_calculation]
    type = ScalarLinearInterpolation
    variable = Te
    sampler = reduced_field
    property_file = 'data/electron_temperature.txt'
    execute_on = 'INITIAL TIMESTEP_BEGIN'
  []
[]

[Debug]
  show_var_residual_norms = true
[]

[Executioner]
  type = Transient
  end_time = 1e-3
  solve_type = newton
  dtmin = 1e-16
  dtmax = 1e-6
  line_search = basic
  steady_state_detection = true

  # Add minimal nonlinear controls
  nl_rel_tol = 1e-5 # Relatively loose
  nl_max_its = 10 # Limit iterations

  petsc_options_iname = '-pc_type -pc_factor_shift_type -pc_factor_shift_amount'
  petsc_options_value = 'lu       NONZERO               1e-10'

  [TimeSteppers]
    [adaptive]
      type = IterationAdaptiveDT
      cutback_factor = 0.1
      dt = 1e-12
      growth_factor = 1.01
    []
  []
[]

# [Executioner]
#   type = Transient
#   end_time = 1e-3
#   solve_type = linear
#   dtmin = 1e-16
#   dtmax = 1e-6
#   line_search = none
#   steady_state_detection = true

#   # scheme = bdf2 # More stable than default Euler
#   petsc_options_iname = '-pc_type -pc_factor_shift_type -pc_factor_shift_amount'
#   petsc_options_value = 'lu       NONZERO               1e-10'
#   [TimeSteppers]
#     [adaptive]
#       type = IterationAdaptiveDT
#       cutback_factor = 0.1
#       dt = 1e-12
#       growth_factor = 1.01
#     []
#   []
# []

[Preconditioning]
  [smp]
    type = SMP
    full = true
    #ksp_norm = none
  []
[]

[Outputs]
  [out]
    type = CSV
  []
  [console]
    type = Console
    execute_scalars_on = 'none'
  []
[]
