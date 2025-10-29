<div align="center"><a name="readme-top"></a>

# 🧠 Neurophysics Research — Cortical Synchronization × Neuroimaging Systems  

[![Python](https://img.shields.io/badge/Python-3.8%2B-3670A0?logo=python&logoColor=white&labelColor=0d1117&style=flat)](https://www.python.org/)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2022a-ff9e0f?logo=mathworks&logoColor=white&labelColor=0d1117&style=flat)](https://www.mathworks.com/)
[![Neuroscience](https://img.shields.io/badge/Domain-Neurophysics-lightgrey?logo=brain&logoColor=white&labelColor=0d1117&style=flat)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-2ECC71?labelColor=0d1117&style=flat)](https://choosealicense.com/licenses/mit/)

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/sabneet-bains/Neurophysics-Research)

**Computational modeling of cortical microcolumns** to explore **inhibition, synchrony, and conductivity** in the aging brain and neurodegenerative disorders.  

<sup>*Developed for my Drexel University thesis on postsynaptic inhibition, later integrated into neuroimaging pipelines at Eli Lilly.*</sup>

<img src="https://github.com/sabneet95/Machine-Learning/blob/master/brain.png" alt="Brain Visualization" width="800">

</div>

> [!NOTE]  
> <sup>Part of the <b>Foundational & Academic</b> collection — research frameworks connecting computational neuroscience and medical imaging automation.</sup>


## 🧭 Table of Contents
- [Overview](#-overview)
- [Architecture](#-architecture)
- [Focus Areas](#-focus-areas)
- [Directory Structure](#-directory-structure)
- [Requirements](#-requirements)
- [Usage](#-usage)
- [Testing](#-testing)
- [Contributing](#-contributing)
- [Future Work](#-future-work)
- [Author](#-author)
- [License](#-license)


## 🧩 Overview
This repository simulates **inhibitory–excitatory cortical networks** to study how **postsynaptic inhibition** modulates global synchronization and information flow.  
Python modules leverage the **NEURON + Explore** framework for simulation, while MATLAB routines automate **PET/MRI analysis** through FSL + SPM integration.

**Core goals**
- Quantify **synchronous firing** using SPIKE-distance metrics.  
- Examine effects of **conductivity** (0.05 – 0.95 µS) and **inhibitory ratios** (~20 %).  
- Bridge **computational models** with **neuroimaging pipelines** for Alzheimer’s and aging research.

> [!TIP]  
> Each experiment is parameter-driven — adjust inhibitory ratios or conductivity to explore network stability and emergent synchrony.

<div align="right">

[![Back to Top](https://img.shields.io/badge/-⫛_TO_TOP-0d1117?style=flat)](#readme-top)

</div>


## 🧱 Architecture

### 🧮 MATLAB Components
- PET/MRI processing via hybrid **MATLAB + Java Swing GUI**.  
- FSL + SPM integration for 3-D image registration and normalization.  
- Batch-QC jobs with automated error handling and memory safety.

### 🧠 Python Components
- `block_inhib.py` orchestrates inhibitory/excitatory network creation and simulation.  
- Built on **Explore** modular modes: placement → connectivity → simulation → spiking.  
- Outputs raster plots and SPIKE maps for synchronization quantification.

> [!NOTE]  
> The architecture supports parallel experimentation — run multiple conductivity/inhibition combinations for comparative plots.

<div align="right">

[![Back to Top](https://img.shields.io/badge/-⫛_TO_TOP-0d1117?style=flat)](#readme-top)

</div>


## 🧩 Focus Areas  

| 🔬 Research Axis | 🧩 Component | 🔍 Objective |
|:-----------------|:-------------|:-------------|
| **Inhibitory–Excitatory Dynamics** | `block_inhib.py` | Analyze network synchrony and inhibition balance under varied conductivity values. |
| **Neuroimaging Automation** | `Alzheimers_Analysis.m` | Standardize PET/MRI registration and statistical processing via MATLAB + FSL/SPM. |
| **Cross-Modal Integration** | MATLAB ↔ Python bridge | Combine network outputs with imaging metadata for correlation analysis. |
| **Visualization** | Raster plots / SPIKE maps | Map synchronization patterns and propagation delays across neuronal clusters. |
| **Computational Reproducibility** | Modular config + logging | Ensure consistent experiment tracking for comparative studies. |

<div align="right">

[![Back to Top](https://img.shields.io/badge/-⫛_TO_TOP-0d1117?style=flat)](#readme-top)

</div>


## 📂 Directory Structure
````text
Neurophysics-Research/
│
├── Alzheimers/
│   └── Alzheimers_Analysis.m
│
├── Neural Networks/
│   └── block_inhib.py
│
├── brain.png
├── LICENSE
└── README.md
````

> [!TIP]  
> Directory organization follows **domain purpose → modality** — MATLAB for **neuroimaging**, Python for **network simulation**.

<div align="right">

[![Back to Top](https://img.shields.io/badge/-⫛_TO_TOP-0d1117?style=flat)](#readme-top)

</div>


## ⚙️ Requirements
````text
MATLAB ≥ R2022a  
Python ≥ 3.8 (with neuron, pandas, numpy, explore)  
FSL + SPM (for PET/MRI registration)  
Windows 10 x64 (≥ 8 cores / 2 GB RAM)
````

> [!IMPORTANT]  
> Ensure **FSL + SPM paths** are properly configured in MATLAB before running the imaging pipeline  
> (e.g., `setenv('FSLDIR',...)` and `addpath('spm12')`).  
>  
> Install Python dependencies via:  
> ```bash
> pip install neuron pandas numpy explore
> ```

<div align="right">

[![Back to Top](https://img.shields.io/badge/-⫛_TO_TOP-0d1117?style=flat)](#readme-top)

</div>


## 🚀 Usage

### 🧮 MATLAB Neuroimaging
1. Open `Alzheimers_Analysis.m` in MATLAB.  
2. Provide PET/MRI dataset directories when prompted.  
3. The pipeline performs **registration**, **normalization**, and **batch processing** using FSL + SPM.  
4. Review generated QC logs and processed volumes within the designated output directory.

---

### 🧠 Python Simulations
````bash
# Clone and navigate
git clone https://github.com/sabneet95/Neurophysics-Research.git
cd Neurophysics-Research

# Run simulation
python block_inhib.py
````

Adjust parameters (**conductivity EE**, **block size NB**, **δ fraction**) directly in `block_inhib.py`.  
Simulation outputs include **raster plots**, **spike-distance matrices**, and **summary CSVs** for comparative analysis.

> [!TIP]  
> Simulation results are automatically saved as `raster_plot.png` and `spike_distance.csv`, ready for post-processing in MATLAB, Python (e.g., Matplotlib, Seaborn), or FSL-based visual pipelines.

<div align="right">

[![Back to Top](https://img.shields.io/badge/-⫛_TO_TOP-0d1117?style=flat)](#readme-top)

</div>


## 🧪 Testing
Simulation Validation Details

- Validated **SPIKE-distance synchronization** metrics with raster-plot activity comparisons.  
- MATLAB PET pipeline benchmarked on **Eli Lilly Alzheimer’s datasets (2016–2017)**.  
- Planned integration of **pytest** and the **MATLAB Unit Testing Framework** for cross-language validation.

<div align="right">

[![Back to Top](https://img.shields.io/badge/-⫛_TO_TOP-0d1117?style=flat)](#readme-top)

</div>


## 🤝 Contributing
1. Open an issue before large-scale modifications or algorithmic updates.  
2. Clearly document any parameter changes with associated **plots**, **SPIKE metrics**, or **statistical results**.  
3. Pull requests focusing on:  
   - **Python-only reproducibility** (PyNN / Brian2)  
   - **Advanced visualization notebooks** (e.g., raster overlays, 3D firing maps)  
   - **Containerized workflows** (Docker or Singularity)  

are encouraged.

> [!TIP]  
> Cross-modal contributions connecting **computational simulations** to **neuroimaging data** (EEG, PET, or fMRI) are highly valuable for bridging neuroscience and physics.

<div align="right">

[![Back to Top](https://img.shields.io/badge/-⫛_TO_TOP-0d1117?style=flat)](#readme-top)

</div>


## 🔮 Future Work
- Perform **parameter sweeps** for dynamic inhibitory neuron ratios.  
- Integrate **stochastic noise** and **Hebbian learning** rules.  
- Transition MATLAB imaging routines to **Python (NiBabel + Nilearn)** for unified analysis.  
- Collaborate with **JHU AI research** for accelerated neural simulations and multi-scale modeling.

<div align="right">

[![Back to Top](https://img.shields.io/badge/-⫛_TO_TOP-0d1117?style=flat)](#readme-top)

</div>


<div align="center">

##
### 👤 Author  
**Sabneet Bains**  
*Quantum × AI × Neurophysics*  
[LinkedIn](https://www.linkedin.com/in/sabneet-bains/) • [GitHub](https://github.com/sabneet-bains)

##
### 📄 License  
Licensed under the [MIT License](https://choosealicense.com/licenses/mit/)

<sub>“The brain’s music is rhythm and delay — neurophysics translates it into code.”</sub>

</div>
