# VECMAtk Tutorials

The VECMAtk tutorials are divided into two formats:
- **Static tutorials** provide informative read-only information for the VECMAtk components with internal and external application instances.
- **Interactive tutorials** are easy-to-use as installation of the VECMAtk components are not required and they are versatile because users are able to append with additional remarks, which are hosted in the [VECMA JupyterHub](https://jupyter.vecma.psnc.pl) environment.

Here, we provide the links to the documentaion of VECMAtk components and tutorials for applications from a diverse range of scientific domains:

1. [**FabSim3**](https://fabsim3.readthedocs.io/en/latest/index.html) is an automation toolkit written in Python 3 featuring an integrated test infrastructure and a flexible plugin system. There are several plugins available from a diverse range of scientific domains, such as

   - [FabUQCampaign](https://github.com/wedeling/FabUQCampaign/blob/master/README.md) for coupling EasyVVUQ with FabSim3;
   - [FabMD](https://fabmd.readthedocs.io) for a molecular dynamics modelling using Large-scale Atomic/Molecular Massively Parallel Simulator (LAMMPS);
   - [FabFlee](https://github.com/djgroen/FabFlee/blob/master/doc/FabFlee.md) for a migration modelling;
   - [FabMogp](https://github.com/alan-turing-institute/vecma_workshop_tutorial/blob/master/Tutorial.rst) for an earthquake modelling;
   - [FabCovid19](https://github.com/djgroen/FabCovid19/blob/master/README.md) for a Covid-19 modelling.
   - [FabCovidsim](https://github.com/arabnejad/FabCovidsim/blob/dev/README.md) for CovidsSim epidemiological code.
   

2. [**EasyVVUQ**](https://easyvvuq.readthedocs.io) is a Python library designed to facilitate verification, validation and uncertainty quantification (VVUQ) for a wide variety of simulations. It accounts for uncertainty quantification (UQ) and validation patterns in application to various domains.

   We provide tutorials for the basic concepts of EasyVVUQ workflows using Jupyter Notebooks:

      - [Encoder and Decoder](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/a6852d6c5ba36f15579e601d7a8d074505f31084?filepath=tutorials%2Fbasic_tutorial.ipynb) to set-up an input file for a simulation code and to parse the output of the simulation;
      - [Campaign](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/a6852d6c5ba36f15579e601d7a8d074505f31084?filepath=tutorials%2Fbasic_tutorial.ipynb) to operate and run simulations;
      - [Analysis](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/74d6a9f4b0eecc754918de2f3795395d35ac4875?filepath=tutorials%2Fvector_qoi_tutorial.ipynb) to analyse the simulation output. 

   2.1 **UQ Sampling techniques and tutorials**
   
   EasyVVUQ provides four sampling methods for analysis (see [Wright et al. (2020)](https://doi.org/10.1002/adts.201900246) for explanation of these sampling techniques:

   - [Stochastic Collocation](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/ce3bf5255cd9629e763e14101c81842aa63b2bce?filepath=tutorials%2Feasyvvuq_fusion_SC_dask_tutorial.ipynb),
   - [Polynomial Chaos Expansion](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/ce3bf5255cd9629e763e14101c81842aa63b2bce?filepath=tutorials%2Feasyvvuq_fusion_tutorial.ipynb),
   - [Monte Carlo Sensitivity Analysis](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/ce3bf5255cd9629e763e14101c81842aa63b2bce?filepath=tutorials%2Feasyvvuq_mcmc.ipynb),
   - [Markov-Chain Monte Carlo](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/ce3bf5255cd9629e763e14101c81842aa63b2bce?filepath=tutorials%2Fmcmc_tutorial.ipynb).

  

   We provide the static tutorials for these samplers below:
  
   - [Advection Diffusion Equation](https://github.com/wedeling/FabUQCampaign/blob/master/Tutorial_ADE.md) (ADE) using FabUQCampaign plugin;
   - [Two-dimensional ocean model](https://github.com/wedeling/FabUQCampaign/blob/master/Tutorial_ocean.md) (Ocean2D) using FabUQCampaign plugin;
   - [Flee algorithm sensitivity analysis](https://github.com/djgroen/FabFlee/blob/master/doc/TutorialSensitivity.md) using FabFlee plugin;
   - [LAMMPS simulations](https://fabmd.readthedocs.io/en/latest/execution.html#easyvvuq-fabmd-example) using FabMD plugin;
   - [Earthquake model](https://github.com/edaub/vecma_workshop_tutorial/blob/master/Tutorial.rst) using FabMogp plugin;

   Interactive tutorials for EasyVVUQ samplers with examples are available [here](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/dev?filepath=tutorials). 

   2.2 **Verification and Validation (V&V) patterns and tutorials**
   
   There are four prominent V&V patterns in VECMAtk, namely:

    - Stable Intermediate Forms (SIF)
    - [Level of Refinement (LoR)](https://fabsim3.readthedocs.io/en/latest/patterns.html#level-of-refinement-lor)
    - [Ensemble Output Validation (EoV)](https://fabsim3.readthedocs.io/en/latest/patterns.html#ensemble-output-validation-eov)
    - [Quantities of Interest Distribution Comparison (QDC)](https://fabsim3.readthedocs.io/en/latest/patterns.html#quantities-of-interest-distribution-comparison-qdc) 
    
    They are most suitable for multiscale computing applications with source codes available [here](https://github.com/djgroen/FabSim3/blob/master/fabsim/VVP/vvp.py).
  
   V&V examples:

   - [Ensemble Output Validation](https://github.com/djgroen/FabFlee/blob/master/doc/TutorialValidate.md) in application to the FabFlee plugin;
   - [Quantity of Interest Distribution Comparison](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/74d6a9f4b0eecc754918de2f3795395d35ac4875?filepath=tutorials%2Fvector_qoi_tutorial.ipynb) for the SIR epidemiology model. 


3. [**Quality in Cloud and Grid**](http://www.qoscosgrid.org) (QCG) is an integrated system offering advanced job and resource management capabilities to deliver to end-users supercomputer-like performance and structure. QCG consists of the following components:

   - [QCG-PilotJob](https://qcg-pilotjob.readthedocs.io/en/latest/) is a Pilot Job system that allows to execute many subordinate jobs in a single scheduling system allocation. 
   We demonstrate how EasyVVUQ workflows can be adapted to enable their executions with QCG-PilotJob on HPC machines [here](https://mybinder.org/v2/gh/UCL-CCS/EasyVVUQ/d105db613f6fa92783093eb561a29e5350128703?filepath=tutorials%2Fbasic_tutorial_qcgpj.ipynb). 
  
   - [QCG-Client](http://www.qoscosgrid.org/trac/qcg-broker/wiki/client_user_guide) is a command line client for execution of computing jobs on the clusters offered by QCG middleware.

   - [QCG-Now](http://www.qoscosgrid.org/qcg-now/en/) is a desktop, GUI client for easy execution of computing jobs on the clusters offered by QCG middleware.

4. [**EasySurrogate**](https://github.com/wedeling/EasySurrogate/blob/master/README.md) is a toolkit designed to facilitate the creation of surrogate models for multiscale simulations.

5. [**MUSCLE3**](https://muscle3.readthedocs.io/) is the third incarnation of the Multiscale Coupling Library and Environment.
   
   - [ISR3D](https://github.com/vecma-project/VECMAtk/blob/master/VECMAtk_static_tutorials/ISR3D_installation_guide.md) is the 3D in-stent restenosis application aiming to simulate smooth muscle cells (SMC) proliferation and restenosis process as a complication after coronary stenting procedure. It is a fully coupled 3D multiscale model, which includes several single-scale submodels as well as utility modules which facilitate communication between the submodels. 


We also present the application of these VECMAtk components to five domains, which are forced migration, fusion energy, climate, biomedicine and urban air pollution, in the publication by [Suleimenova et al.(2021)](https://doi.org/10.1016/j.jocs.2021.101402) to perform uncertainty quantification analysis, use surrogate models, couple multiscale models and execute sensitivity analysis on HPC.
