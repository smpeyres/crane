#* This file is part of Crane, an open-source
#* application for plasma chemistry and thermochemistry
#* https://github.com/lcpp-org/crane
#*
#* Crane is powered by the MOOSE Framework
#* https://www.mooseframework.org
#*
#* Licensed under LGPL 2.1, please see LICENSE for details
#* https://www.gnu.org/licenses/lgpl-2.1.html

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

filename = 'argon_test_mod_out.csv'
data = pd.read_csv(filename)
data['reduced_field_Td'] = data['reduced_field'] * 1e21

fig, ax1 = plt.subplots()

ax1.loglog(data['time'], data['reduced_field_Td'], 'k', linewidth=2)
ax1.set_xlabel('Time (s)')
ax1.set_ylabel('Reduced Field, $E/N$ (Td)', color='k')
ax1.tick_params(axis='y', colors='k')
ax1.tick_params(axis='both', which='both', direction='out', top=True, right=True)
ax1.set_xlim([1e-10, 1e-3])
ax1.set_ylim([1e-1, 1e3])

ax2 = ax1.twinx()
ax2.semilogx(data['time'], data['Te'], 'r--', linewidth=2)
ax2.set_ylabel('Electron Temperature, $T_e$ (eV)', color='r')
ax2.tick_params(axis='y', colors='r')
ax2.set_ylim(top=7.87)

# Make the right axis red
ax2.spines['right'].set_color('r')

fig.savefig('reduced_field_and_electron_temperature_mod.png', bbox_inches='tight', dpi=600)
plt.show()
