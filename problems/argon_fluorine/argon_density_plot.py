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

fig, ax = plt.subplots()
ax.loglog(data['time'], data['e'], label='e')
ax.loglog(data['time'], data['Ar+'],  label='Ar$^+$')
ax.loglog(data['time'], data['Ar2+'],  label='Ar$_2^+$')
ax.loglog(data['time'], data['Ar*'], label='Ar$^*$')
ax.loglog(data['time'], data['F'], label='F')
ax.loglog(data['time'], data['F2+'],  label='F$_2^+$')
ax.loglog(data['time'], data['ArF*'], label='ArF$^*$')
ax.loglog(data['time'], data['F-'], label='F$^-$')
ax.loglog(data['time'], data['F+'], label='F$^+$')

# Set axis labels
ax.set_xlabel('Time (s)')
ax.set_ylabel('Density (cm$^{-3}$)')

# Set axis limits
ax.set_xlim([1e-10, 1e-3])
ax.set_ylim([1e5, 1e18])

# Set axis ticks
ax.tick_params(axis='both', which='both', direction='out', top=True, right=True)

# Add legend
ax.legend()

# Save and show plot
fig.savefig('argon_species_mod.png', bbox_inches='tight',dpi=600)
plt.show()
