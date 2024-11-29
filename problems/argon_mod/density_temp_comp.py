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
from matplotlib.legend_handler import HandlerTuple

# Load original data
file_og = '../argon_microdischarge/argon_test_out.csv'
data_og = pd.read_csv(file_og)

# Load modified data
file_mod = 'argon_test_mod_out.csv'
data_mod = pd.read_csv(file_mod)

fig, ax1 = plt.subplots()

ax1.loglog(data_og['time'], data_og['e'], 'k',linewidth=2)
ax1.loglog(data_mod['time'], data_mod['e'], 'k--', linewidth=2)
# Set axis labels
ax1.set_xlabel('Time (s)')
ax1.set_ylabel('Plasma Density (cm$^{-3}$)')
# Set axis limits
ax1.set_xlim([1e-10, 1e-3])
ax1.set_ylim([1e5, 1e14])

ax2 = ax1.twinx()
ax2.semilogx(data_og['time'], data_og['Te'], 'r', linewidth=2)
ax2.semilogx(data_mod['time'], data_mod['Te'], 'r--', linewidth=2)
ax2.set_ylabel('Electron Temperature, $T_e$ (eV)', color='r')
ax2.tick_params(axis='y', colors='r')

# Set axis ticks
ax2.tick_params(axis='both', which='both', direction='out', top=True, right=True)

# Create custom legend with two rows and two lines
original_line = plt.Line2D([], [], color='grey', linewidth=2, linestyle='-', label='Original')
modified_line = plt.Line2D([], [], color='grey', linestyle='--', linewidth=2, label='Modified')

# Combine legends into one
ax1.legend(handles=[original_line, modified_line], loc='center left')

# Save and show plot
fig.savefig('density_temp_comp_plot.png', bbox_inches='tight',dpi=600)
plt.show()
