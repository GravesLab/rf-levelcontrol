Radio-Frequency Level Controller
================================
Hardware and software for acquiring, analyzing, and controlling liquid level using non-contact RF sensors.
Includes software for acquiring and analyzing data from Rigol network analyzers.

Oscillator for MHz Sine Wave
----------------------------

inspired by ["RF oscillator uses current-feedback op amp"][EDN_rf]
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

In place of the [LM6161], I used the [LT1227].

The oscillator frequency is a function of the inductor and parallel capacitors.  It can be calculated with this Python function:

```python
>>> import math
>>> def f(L,C1,C2): return 1/(2*math.pi*math.sqrt(L*(C1*C2/(C1+C2))))
>>> f(0.000001,0.000000001,0.000000001)
7117625.434171771
```

Acquisition
-----------
For tuning purposes, network analyzer data was initially collected by hand; this was very tedious.  The [Rigol DSA815 network analyzer][rigol-na] is a USBTMC-compliant device, so I wrote a short Python script, inspired by [Python USBTMC][pyusbtmc] for the Rigol oscilloscope using commands from the Rigol DA815 programming guide.

Analysis
--------
The included IPython Notebook analyzes the raw spectral files in `/analysis/data` and generates a series of plots in `/analysis/plots/`.  The `gifsemble` shell script is included for assembling the resulting .png files into an animated .gif.  In this plot, the level of salt water in the vessel was changed in steps from 0 to 70mL and back to 0mL:

![network analysis][plot]

Experimental Design
-------------------

### Setup

- IKA ETS-DS heated stir plate with thermal feedback control
- 70mL glass cylinder is loaded with 50mL of aqueous solution
  - Also contains sugar oligomers, salts
  - Reaction produces furans and related products
- Heated with heat tape (probably nichrome in silicone) with a control knob
- Reacted at 140°C for 2-24 hours
- Products are pervaporated through a membrane in the bottom of the cylinder
  - Gradient provided by vacuum pump and vapor pressure of reaction solution
  - Product vapor is condensed in cold traps
- Liquid can be sampled during the run using the positive pressure of the vessel and an integral dip tube

### Control Goals

Maintain the liquid level within 10% of the target (±2.5mL)

### Concerns and Caveats

Turning on, off the stir plate vortexes the water, causing it to rise ~7.5mm 

Control
-------

Controlled using an Arduino running the [Arduino PID library][arduino-pid].


[EDN_rf]: http://www.edn.com/design/analog/4342658/RF-oscillator-uses-current-feedback-op-amp
[LM6161]: http://www.ti.com/lit/ds/symlink/lm6161.pdf
[LT1227]: http://cds.linear.com/docs/en/datasheet/1227fb.pdf
[rigol-na]: https://www.rigolna.com/products/spectrum-analyzers/dsa800/dsa815/
[pyusbtmc]: http://www.cibomahto.com/2010/04/controlling-a-rigol-oscilloscope-using-linux-and-python/
[schematic]: https://cdn.rawgit.com/GravesLab/rigol-networkanalyzer/master/img/oscillator-schematic.svg
[plot]: img/animated-salt-vortex.gif
[arduino-pid]: https://github.com/br3ttb/Arduino-PID-Library
