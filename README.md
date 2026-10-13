# 2 DOF Vibration Isolation System for Marine Shock Mitigation Using Passive and Active Controls

[![Department](https://shields.io)](https://futminna.edu.ng)
[![School](https://shields.io)](https://futminna.edu.ng)
[![Software](https://shields.io)](https://mathworks.com)

This repository contains the dynamic systems modeling, state-space vector arrays, and simulation code engines developed by **Group 10** for the **MCE512 (Vibrations and Control System)** design project. The research evaluates fluid-viscous and automated proportional-integral-derivative (PID) active loops to insulate marine machinery and structures from ocean wave shocks.

---

## 👥 Group 10 Project Members & Team

| Matric Number | Student Full Name | Core Engineering Responsibility |
| :--- | :--- | :--- |
| 2021/1/81010ET | **Chioma Favour Chukwu** | Physical System Parameters & Boundary Conditions |
| 2021/1/79849ET | **Adeoluwa Omotolawa Amodu** | Newtonian Mechanics & Differential Matrix Derivation |
| 2021/1/79838ET | **Christian Owoicho-Oche Ameh** | Lagrangian Modeling & Open-Loop Transfer Functions |
| 2021/1/79587ET | **Abdulrahman Abubakar** | Routh-Hurwitz Stability & Ziegler-Nichols PID Tuning |
| 2022/2/85570ET | **Richard Chidubem Aniekwe** | MATLAB Script Implementation & Data Visualization |

* **Supervised & Instructed by:** Engr. Dr. T. A. Foloruso (Course Lecturer & Head of Department)

---

## 📝 1. Project Background & System Overview
Marine vessels operate under constant dynamic loading caused by internal propulsion mechanisms and external harmonic wave-induced hull slamming. Without proper mitigation, these high-amplitude oscillations cause mechanical structural fatigue and system component failures.

This project designs and models a **Two-Degree-of-Freedom (2-DOF) Vibration Isolation System** analogous to a quarter-car suspension architecture:
* **Sprung Mass (\(m_1\)):** Represents the protected marine platform payload (sensitive electronic instrumentation arrays, engine mounts, or crew operator stations).
* **Unsprung Mass (\(m_2\)):** Represents the vessel hull structure interface block weight.
* **Excitation Input (\(y(t)\)):** Models the harmonic oceanic wave disturbance acting on the hull plating.

<p align="center">
  <img src="Response Plot/Mechanical_Concept_Sketch.png" width="750" alt="Mechanical Concept Sketch"/>
</p>

---

## 📐 2. Plant Transfer Function & Stability Analysis

### Open-Loop Open-Plant Normalized Transfer Function \(G(s)\)
Evaluating Newtonian and Lagrangian balance vectors produces an identical fourth-order open-loop plant:

\[G(s) = \frac{X_1(s)}{Y(s)} = \frac{60s^2 + 31000s + 4 \times 10^6}{s^4 + 17.5s^3 + 4560s^2 + 31000s + 4 \times 10^6}\]

### Stability & System Root Trajectories
The uncompensated open-loop plant exhibits low damping and root locus structures near the marginal boundaries. The system behavior is mapped below:

<p align="center">
  <img src="Response%20Plot/Root%20Locus%20for%20passive%20isolation.png" width="480" alt="Open-Plant Root Locus Chart"/>
  <img src="Response%20Plot/bode%20plot%20for%20original%20unisolated%20system.png" width="480" alt="Original Unisolated Plant Bode Diagram"/>
</p>

---

## 📉 3. Transient Response Performance Profiles

### 1. Base Plant Uncontrolled Sinusoidal Input Track
Without active or passive dampening elements, the uncompensated system has low natural damping limits, causing an amplification of wave shocks due to high unisolated transmissibility.

<p align="center">
  <img src="Response%20Plot/original%20unisolated%20system%20response.png" width="750" alt="Original Uncontrolled Time Tracking"/>
</p>

### 2. Passively Controlled Isolation Profile
Optimizing the core system stiffness (\(k_1 = 10,595 \text{ N/m}\)) shifts operation into an isolated frequency spectrum (\(r > \sqrt{2}\)), bringing transmissibility below unity (\(T_r = 0.218\)). This mechanical isolation reduces transient wave amplitude by **74.98%**.

<p align="center">
  <img src="Response%20Plot/passive%20isolation.png" width="480" alt="Passively Controlled History Tracking"/>
  <img src="Response%20Plot/bode%20plot%20for%20passive%20isolation.png" width="480" alt="Passive Plant Bode Frequency Response"/>
</p>

### 3. Actively Controlled Loop Isolation (Ziegler-Nichols Tuned PID Loop)
By resolving critical gains using Routh-Hurwitz arrays (\(K_{cr} = 0.31\), \(P_{cu} = 0.1304\text{s}\)), an active parallel PID controller was designed (\(K_p = 0.186\), \(K_i = 2.853\), \(K_d = 0.00303\)). The active loop neutralizes incoming wave shocks, suppressing the peak payload displacement amplitude by **85.84%**.

<p align="center">
  <img src="Response%20Plot/active%20isolation.png" width="480" alt="Active PID Controlled Time Tracking"/>
  <img src="Response%20Plot/Root%20Locus%20for%20active%20isolation.png" width="480" alt="Closed Loop Active Root Locus Plot"/>
</p>

---

## 📊 4. Combined System Comparative Analysis

### Time-Domain System Comparison (`combine isolation comparison.png`)
*The comprehensive benchmark tracking diagram below illustrates the exact performance changes between the raw unmitigated plant, passive component shifts, and active PID feedback loop control under standard marine wave shocks (\(\omega = 25\text{ rad/s}\)).*

<p align="center">
  <img src="Response%20Plot/combine%20isolation%20comparison.png" width="850" alt="Combined Time History Displacement Comparison"/>
</p>

### Frequency-Domain Multi-Response Comparison (`bode plot for combine isolation comparison.png`)
*This comparative Bode diagram shows the magnitude attenuation and phase-angle roll-off optimization achieved across the full design spectrum.*

<p align="center">
  <img src="Response%20Plot/bode%20plot%20for%20combine%20isolation%20comparison.png" width="510" alt="Bode Multi-Response Attenuation Graph"/>
  <img src="Response%20Plot/bode%20plot%20for%20active%20isolation.png" width="430" alt="Isolated Active Closed Loop Bode Map"/>
</p>

---

## 🚀 Execution & Simulation Guide
1. Pull this project workspace down to your local system path folder:
   ```bash
   git clone https://github.com
   ```
2. Launch **MATLAB** and ensure you have the **Control System Toolbox** active.
3. Open and run `MATLAB code/simulation.m` to generate all dynamic characteristic arrays and verify the 10 data plots.
