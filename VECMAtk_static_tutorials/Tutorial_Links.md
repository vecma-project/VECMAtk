# VECMAtk Tutorials

The links to the detailed tutorials for VECMAtk components and applications are provided below:

1. [**FabSim3**](https://fabsim3.readthedocs.io/en/latest/index.html) is an automation toolkit written in Python 3 featuring an integrated test infrastructure and a flexible plugin system. There are several plugins available from a diverse range of scientific domains, such as

   - [FabUQCampaign](https://github.com/wedeling/FabUQCampaign/blob/master/Tutorial_Setup.md) for a climate modelling;
   - [FabMD]( https://github.com/UCL-CCS/FabMD) for a molecular dynamics modelling using Large-scale Atomic/Molecular Massively Parallel Simulator (LAMMPS);
   - [FabFlee](https://github.com/djgroen/FabFlee/blob/master/doc/FabFlee.md) for a migration modelling;
   - [FabMogp](https://github.com/edaub/fabmogp/blob/master/Tutorial.rst) for an earthquake modelling;
   - [FabCovid19](https://github.com/djgroen/FabCovid19/blob/master/README.md) for a Covid-19 modelling.

2. [**EasyVVUQ**](https://easyvvuq.readthedocs.io/en/dev/index.html) is a Python library designed to facilitate verification, validation and uncertainty quantification (VVUQ) for a wide variety of simulations. It accounts for uncertainty quantification (UQ) and validation patterns in application to  earlier described domains.

   **UQ Sampling techniques and tutorials**
   There are four different types of uncertainty quantification samplers in EasyVVUQ. 

   - Stochastic Collocation (SC) sampler examples:

     - [Advection Diffusion Equation](https://github.com/wedeling/FabUQCampaign/blob/master/Tutorial_ADE.md) (ADE) using FabUQCampaign plugin;
     - [Two-dimensional ocean model](https://github.com/wedeling/FabUQCampaign/blob/master/Tutorial_ocean.md) (Ocean2D) using FabUQCampaign plugin;
     - [Flee algorithm sensitivity analysis](https://github.com/djgroen/FabFlee/blob/master/doc/TutorialSensitivity.md) using FabFlee plugin.
     
   - Polynomial Chaos Expansion (PCE) sampler has an example tutorial in application to the Fusion workflow, see [here](https://github.com/UCL-CCS/EasyVVUQ/blob/dev/docs/fusion_tutorial.rst).

   - Random Sampler is also available and has an example of ensemble of [LAMMPS simulations](https://github.com/UCL-CCS/FabMD/blob/master/doc/EasyVVUQ_FabMD_example.md) using FabMD plugin.
     
   - Latin Hypercube technique is applied in an earthquake model in the FabMogp plugin, see [here](https://github.com/edaub/vecma_workshop_tutorial/blob/master/Tutorial.rst).

   **Validation pattern tutorials**
   Currently, there are two example tutorials available on validation:

   - [Ensemble Output validation](https://github.com/djgroen/FabFlee/blob/master/doc/TutorialValidate.md) in application to the FabFlee plugin;
   - [Quantity of interest distribution](https://github.com/UCL-CCS/https://github.com/UCL-CCS/EasyVVUQ/blob/dev/docs/validate_similarities.rst) extraction in application to Fusion application.     

3. [**Quality in Cloud and Grid**](http://www.qoscosgrid.org) (QCG) is an integrated system offering advanced job and resource management capabilities to deliver to end-users supercomputer-like performance and structure. QCG consists of the following components:

   - [QCG-Pilot Job](https://qcg-pilotjob.readthedocs.io/en/latest/) is a Pilot Job system that allows to execute many subordinate jobs in a single scheduling system allocation.
  
   - [QCG-Client](http://www.qoscosgrid.org/trac/qcg-broker/wiki/client_user_guide) is a command line client for execution of computing jobs on the clusters offered by QCG middleware.

   - [QCG-Now](http://www.qoscosgrid.org/qcg-now/en/) is a desktop, GUI client for easy execution of computing jobs on the clusters offered by QCG middleware.

4. [**EasyVVUQ-QCGPJ**](https://easyvvuq-qcgpj.readthedocs.io/en/plugin/#) is a lightweight plugin for parallelization of EasyVVUQ with the QCG-PilotJob mechanism. To learn more, please see the tutorial example here.

5. [**MUSCLE3**](https://muscle3.readthedocs.io/) is the third incarnation of the Multiscale Coupling Library and Environment.
   
   - [ISR3D]() is the 3D in-stent restenosis application aiming to simulate smooth muscle cells (SMC) proliferation and restenosis process as a complication after coronary stenting procedure. It is a fully coupled 3D multiscale model, which includes several single-scale submodels as well as utility modules which facilitate communication between the submodels. 
