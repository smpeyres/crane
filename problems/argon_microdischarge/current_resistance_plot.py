#* This file is part of Crane, an open-source
#* application for plasma chemistry and thermochemistry
#* https://github.com/lcpp-org/crane
#*
#* Crane is powered by the MOOSE Framework
#* https://www.mooseframework.org
#*
#* Licensed under LGPL 2.1, please see LICENSE for details
#* https://www.gnu.org/licenses/lgpl-2.1.html

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

filename = 'argon_test_out.csv'
data = pd.read_csv(filename)

data['field'] = data['reduced_field'] * data['Ar'] * 1e6
data['plasma_resistance'] = 0.004 * data['field'] / data['current']


fig, ax1 = plt.subplots()

# Plot current on the left y-axis
ax1.loglog(data['time'], data['current']*1000, 'b', label='Current', linewidth=2)
ax1.set_xlabel('Time (s)')
ax1.set_ylabel('Current, $I$ (mA)', color='blue')
ax1.set_xlim([1e-10, 1e-3])
ax1.tick_params(axis='both', which='both', direction='out', top=True, right=True)
ax1.tick_params(axis='y', colors='b')

# Create a second y-axis for plasma resistance
ax2 = ax1.twinx()
ax2.loglog(data['time'], data['plasma_resistance']/1000, 'g', label='Plasma Resistance', linewidth=2)
ax2.set_ylabel('Plasma Resistance, $R_p$ (k$\Omega$)', color='g')
ax2.tick_params(axis='y', colors='g')
ax2.spines['left'].set_color('b')
ax2.spines['right'].set_color('g')

# Save and show plot
fig.savefig('current_resistance_plot.png', bbox_inches='tight', dpi=600)
plt.show()



data['ballast_voltage'] = 1e5*data['current']
data['plasma_voltage'] =  0.004 * data['field']
total_voltage = 1000

fig, ax = plt.subplots()

# Plot ballast voltage
ax.loglog(data['time'], data['ballast_voltage'], 'r', label='Ballast Voltage', linewidth=2)

# Plot plasma voltage
ax.loglog(data['time'], data['plasma_voltage'], 'b', label='Plasma Voltage', linewidth=2)

# Plot the sum of ballast and plasma voltage
ax.loglog(data['time'], data['ballast_voltage'] + data['plasma_voltage'], 'g', label='Sum Voltage', linewidth=2)

# Plot total voltage
ax.loglog(data['time'], [total_voltage]*len(data['time']), 'k--', label='Total Voltage', linewidth=2)

ax.set_xlabel('Time (s)')
ax.set_ylabel('Voltage (V)')
ax.set_xlim([1e-10, 1e-3])
ax.legend()
ax.tick_params(axis='both', which='both', direction='out', top=True, right=True)

# Save and show plot
fig.savefig('voltage_plot.png', bbox_inches='tight', dpi=600)
plt.show()
