# VECMAtk Tutorials

The VECMAtk tutorials are divided into two formats:
- **Static tutorials** provide informative read-only information for the VECMAtk components with internal and external application instances.
- **Interactive tutorials** are easy-to-use as installation of the VECMAtk components are not required and they are versatile because users are able to append with additional remarks, which are hosted in the [VECMA JupyterHub](https://jupyter.vecma.psnc.pl) environment.

In this file, we provide the links to the documentaion of VECMAtk components and tutorials for applications from a diverse range of scientific domains:

1. [**FabSim3**](https://fabsim3.readthedocs.io/en/latest/index.html) is an automation toolkit written in Python 3 featuring an integrated test infrastructure and a flexible plugin system. There are several plugins available from a diverse range of scientific domains, such as

   - [FabUQCampaign](https://github.com/wedeling/FabUQCampaign/blob/master/README.md) for a climate modelling;
   - [FabMD](https://fabmd.readthedocs.io) for a molecular dynamics modelling using Large-scale Atomic/Molecular Massively Parallel Simulator (LAMMPS);
   - [FabFlee](https://github.com/djgroen/FabFlee/blob/master/doc/FabFlee.md) for a migration modelling;
   - [FabMogp](https://github.com/alan-turing-institute/vecma_workshop_tutorial/blob/master/Tutorial.rst) for an earthquake modelling;
   - [FabCovid19](https://github.com/djgroen/FabCovid19/blob/master/README.md) for a Covid-19 modelling.
   - [FabCovidsim](https://github.com/arabnejad/FabCovidsim/blob/dev/README.md) for CovidsSim epidemiological code.
   

2. [**EasyVVUQ**](https://easyvvuq.readthedocs.io) is a Python library designed to facilitate verification, validation and uncertainty quantification (VVUQ) for a wide variety of simulations. It accounts for uncertainty quantification (UQ) and validation patterns in application to  earlier described domains.

We provide tutorials for the basic concepts of EasyVVUQ workflows using Jupyter Notebooks:

   - [Encoder and Decoder](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/a6852d6c5ba36f15579e601d7a8d074505f31084?filepath=tutorials%2Fbasic_tutorial.ipynb) to set-up an input file for a simulation code and to parse the output of the simulation;
   - [Campaign](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/a6852d6c5ba36f15579e601d7a8d074505f31084?filepath=tutorials%2Fbasic_tutorial.ipynb) to operate and run simulations;
   - [Analysis](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/74d6a9f4b0eecc754918de2f3795395d35ac4875?filepath=tutorials%2Fvector_qoi_tutorial.ipynb) to analyse the simulation output. 

   **UQ Sampling techniques and tutorials**
   EasyVVUQ provides four sampling methods for analysis:

   - Stochastic Collocation,
   - Polynomial Chaos Expansion,
   - Monte Carlo Sensitivity Analysis,
   - Markov-Chain Monte Carlo.

   We provide the static tutorials for these samplers below:
  
   - [Advection Diffusion Equation](https://github.com/wedeling/FabUQCampaign/blob/master/Tutorial_ADE.md) (ADE) using FabUQCampaign plugin;
   - [Two-dimensional ocean model](https://github.com/wedeling/FabUQCampaign/blob/master/Tutorial_ocean.md) (Ocean2D) using FabUQCampaign plugin;
   - [Flee algorithm sensitivity analysis](https://github.com/djgroen/FabFlee/blob/master/doc/TutorialSensitivity.md) using FabFlee plugin;
   - [LAMMPS simulations](https://fabmd.readthedocs.io/en/latest/execution.html#easyvvuq-fabmd-example) using FabMD plugin;
   - [Earthquake model](https://github.com/edaub/vecma_workshop_tutorial/blob/master/Tutorial.rst) using FabMogp plugin;

   Interactive tutorials for EasyVVUQ samplers with examples are available [here](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/dev?filepath=tutorials). 

   **Verification and Validation (V&V) patterns tutorials**
   There four V&V patterns implemented in VECMAtk, which are described [here](https://github.com/djgroen/FabSim3/blob/master/fabsim/VVP/vvp.py).

   V&V examples:

   - [Ensemble Output validation](https://github.com/djgroen/FabFlee/blob/master/doc/TutorialValidate.md) in application to the FabFlee plugin;
   - [Quantity of interest distribution](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/74d6a9f4b0eecc754918de2f3795395d35ac4875?filepath=tutorials%2Fvector_qoi_tutorial.ipynb) extraction for the SIR epidemiology model. 


3. [**Quality in Cloud and Grid**](http://www.qoscosgrid.org) (QCG) is an integrated system offering advanced job and resource management capabilities to deliver to end-users supercomputer-like performance and structure. QCG consists of the following components:

   - [QCG-Pilot Job](https://qcg-pilotjob.readthedocs.io/en/latest/) is a Pilot Job system that allows to execute many subordinate jobs in a single scheduling system allocation.
  
   - [QCG-Client](http://www.qoscosgrid.org/trac/qcg-broker/wiki/client_user_guide) is a command line client for execution of computing jobs on the clusters offered by QCG middleware.

   - [QCG-Now](http://www.qoscosgrid.org/qcg-now/en/) is a desktop, GUI client for easy execution of computing jobs on the clusters offered by QCG middleware.

4. [**EasySurrogate**](https://github.com/wedeling/EasySurrogate/blob/master/README.md) is a toolkit designed to facilitate the creation of surrogate models for multiscale simulations.

5. [**MUSCLE3**](https://muscle3.readthedocs.io/) is the third incarnation of the Multiscale Coupling Library and Environment.
   
   - [ISR3D](https://github.com/vecma-project/VECMAtk/blob/master/VECMAtk_static_tutorials/ISR3D_installation_guide.md) is the 3D in-stent restenosis application aiming to simulate smooth muscle cells (SMC) proliferation and restenosis process as a complication after coronary stenting procedure. It is a fully coupled 3D multiscale model, which includes several single-scale submodels as well as utility modules which facilitate communication between the submodels. 
