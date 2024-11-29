import pandas as pd

# Read the lookup table data into a DataFrame
lookup_swarm = pd.read_csv("../unprocessed/lookUpTableSwarm.txt", sep="\s+", comment="#")

# Extract the relevant columns
reduced_field = lookup_swarm["RedField(Td)"]*1.0e-21
electron_temperature = lookup_swarm["EleTemp(eV)"]

# Create a new DataFrame with the extracted columns
Te = pd.DataFrame({"RedField(Td)": reduced_field, "EleTemp(eV)": electron_temperature})

# Save the extracted data to a new file
Te.to_csv("electron_temperature.txt", sep=" ", index=False, header=False)

N = 8.1543668e18*1.0e6 # 900 K, 760 torr

mobility = lookup_swarm["RedMob((msV)^-1)"]/N

mu = pd.DataFrame({"RedField(Td)": reduced_field, "Mobility(cm^2/Vs)": mobility})

mu.to_csv("electron_mobility.txt", sep=" ", index=False, header=False)

lookup_rate = pd.read_csv("../unprocessed/lookUpTableRateCoeff.txt", sep="\s+", comment="#")

# Extract the relevant columns
reduced_field = lookup_rate["RedField(Td)"]*1.0e-21

R4_ine = lookup_rate["R4_ine(m^3s^-1)"]*1.0e6
R4_sup = lookup_rate["R4_sup(m^3s^-1)"]*1.0e6
R6_ine = lookup_rate["R6_ine(m^3s^-1)"]*1.0e6
R7_ine = lookup_rate["R6_ine(m^3s^-1)"]*1.0e6

exc = pd.DataFrame({"RedField(Td)": reduced_field, "R4_ine(cm^3/s)": R4_ine})
exc.to_csv("Ar_excitation.txt", sep=" ", index=False, header=False)

de_exc = pd.DataFrame({"RedField(Td)": reduced_field, "R4_sup(cm^3/s)": R4_sup})
de_exc.to_csv("Ar*_deexcitation.txt", sep=" ", index=False, header=False)

ion = pd.DataFrame({"RedField(Td)": reduced_field, "R6_ine(cm^3/s)": R6_ine})
ion.to_csv("Ar_ionization.txt", sep=" ", index=False, header=False)

step_ion = pd.DataFrame({"RedField(Td)": reduced_field, "R7_ine(cm^3/s)": R7_ine})
step_ion.to_csv("Ar*_ionization.txt", sep=" ", index=False, header=False)

