Rigol Network Analyzer
======================
Software for acquiring and analyzing data from Rigol network analyzers

Oscillator for MHz Sine Wave
----------------------------

"RF oscillator uses current-feedback op amp"
EDN 2002-10-03, Victor Koren

Current-feedback operational amplifiers have extremely high output slew rates compared to standard voltage-follower op amps.  A current-feedback op amp can be configured as a Colpitts oscillator with a high-powered buffered output.

The bill of materials is small:
- 1x current-feedback op amp, LM6181 or similar
- 3x film capacitor, 100 nF
- 2x film capacitor, 1 nF
- 1x through-hole inductor, 1 µH
- 1x metal film resistor, 1 kΩ
- 1x metal film resistor, 330 Ω
- 1x metal film resistor, 100 Ω
- 1x metal film resistor, ~50 Ω
- 1x ±12V power supply

![oscillator schematic][schematic]

Analysis
--------
The included IPython Notebook analyzes the raw spectral files in `/analysis/data` and generates a series of plots in `/analysis/plots/`:

![network analysis][plot]





[schematic]: img/oscillator-schematic.svg
[plot]: img/nano_vortex.png
