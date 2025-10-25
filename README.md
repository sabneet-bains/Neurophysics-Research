# 🧠 Neurophysics Research  

[![Python](https://img.shields.io/badge/Python-3.8%2B-blue?logo=python)](https://www.python.org/)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2022a-orange?logo=mathworks&logoColor=white)](https://www.mathworks.com/)
[![Neuroscience](https://img.shields.io/badge/Domain-Neurophysics-lightgrey?logo=brain&logoColor=white)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

<br>

**Computational neurophysics models of cortical microcolumns** for investigating **synchronization, inhibition, and conductivity dynamics** in aging and neurological disorders.

<img src="https://github.com/sabneet95/Machine-Learning/blob/master/brain.png" alt="Brain Visualization" width="700">

> *Originally developed for my Drexel University thesis on postsynaptic inhibition and later integrated into neuroimaging pipelines at Eli Lilly.*


## 🧭 Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Directory Structure](#directory-structure)
- [Requirements](#requirements)
- [Usage](#usage)
- [Testing](#testing)
- [Contributing](#contributing)
- [Future Work](#future-work)
- [Author](#author)
- [License](#license)


## 🧩 Overview
This repository models **mixed inhibitory–excitatory neural networks** to study how **postsynaptic inhibition** affects global synchrony across simulated cortical microcolumns.

Simulations use the **NEURON + Explore Python framework** with **MATLAB-based PET/MRI automation** for neuroimaging analysis.

Key goals:
- Quantify **synchronous firing** via SPIKE-distance metrics.  
- Explore the impact of **conductivity (0.05–0.95 μS)** and **inhibitory ratios (20 %)**.  
- Bridge **computational neuroscience** with **applied imaging pipelines** for aging and Alzheimer’s research.


## 🧱 Architecture

### **MATLAB Components**
- PET/MRI processing via hybrid *MATLAB + Java Swing GUI*.  
- FSL + SPM integration for 3-D normalization and transformation.  
- Automated QC batch jobs and memory-safe execution.

### **Python Components**
- `block_inhib.py` orchestrates inhibitory–excitatory network generation and simulation.  
- Uses *Explore*’s modular modes for placement, connectivity, simulation, and spiking.  
- Outputs raster plots and color-coded SPIKE maps for synchronization analysis.


## 📂 Directory Structure
```
Neurophysics-Research/
├── Alzheimers/
│   └── Alzheimers_Analysis.m
├── Neural Networks/
│   └── block_inhib.py
├── brain.png
├── LICENSE
└── README.md
```


## ⚙️ Requirements
- **MATLAB R2022a** or later  
- **Python 3.8+** with `neuron`, `pandas`, `numpy`, `explore`  
- **FSL + SPM** installed (for MRI/PET transformations)  
- Tested on Windows 10 x64 (8 cores / 2 GB RAM minimum)


## 🚀 Usage

### **MATLAB Neuroimaging**
1. Launch `Alzheimers_Analysis.m` in MATLAB.  
2. Provide dataset paths in the GUI dialog.  
3. The pipeline copies, registers, and normalizes PET/MRI scans using FSL + SPM.

### **Python Simulations**
1. Clone the repo:  
   ```bash
   git clone https://github.com/sabneet95/Neurophysics-Research.git
   cd Neurophysics-Research
   ```
2. Run the inhibitory–excitatory simulation:  
   ```bash
   python block_inhib.py
   ```
3. Adjust parameters (conductivity EE, block size NB, δ fraction) directly in `block_inhib.py`.


## 🧪 Testing
<details>
<summary>Simulation Validation</summary>

- Cross-checked SPIKE distances with raster-plot synchronization.  
- MATLAB pipeline verified on Alzheimer’s PET datasets (Eli Lilly 2016–2017).  
- Planned integration of `pytest` and MATLAB Unit Testing Framework.
</details>


## 🤝 Contributing
1. Open an issue before large modifications.  
2. Document all parameter changes and provide sample plots.  
3. Pull requests focusing on:
   - Python-only reproducibility (e.g., PyNN/Brian2)  
   - Raster-plot visualization notebooks  
   - Docker or containerized workflows  

are encouraged.


## 🔮 Future Work
- Parameter sweeps for varying inhibitory neuron ratios.  
- Incorporate stochastic noise and learning dynamics.  
- Migrate MATLAB imaging routines to Python + NiBabel.  
- Integrate with JHU AI research on neural simulation acceleration.


## 🧠 Author
**Sabneet Bains** — *Quantum × AI × Neurophysics*  
[LinkedIn](https://www.linkedin.com/in/sabneet-bains/) • [GitHub](https://github.com/sabneet-bains)


## 📄 License
This repository is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

