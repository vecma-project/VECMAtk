# Uncertainty Quantification in Numerical Models: from simple model on Newton's law of cooling to multiscale fusion model
### Demonstration on efficient, parallel Execution of EasyVVUQ with QCG Pilot Job Manager on local and HPC resources (a step-by-step guide)

Contents
========

[TOC]

Preface
=======

In this tutorial, you will get a step-by-step guidance on the usage of several
VECMAtk components to perform uncertainty quantification calculations within a
local and HPC execution environment. A simple numerical model that simulates the
temperature of a coffee cup under the Newton’s law of cooling is provided here
as an example application, but the general scheme of conduct can be practiced in
any application. In this tutorial you will learn about the following VECMA
software components:

-   [EasyVVUQ](https://github.com/UCL-CCS/EasyVVUQ) - a Python3 library that
    aims to facilitate verification, validation and uncertainty quantification,
-   [QCG Pilot Job](https://wiki.vecma.eu/qcg-pilotjobs) - a Pilot Job system
    that allows to execute many subordinate jobs in a single scheduling system
    allocation,
-   [EasyVVUQ-QCGPJ](https://github.com/vecma-project/easyvvuq-qcgpj) - a
    lightweight integration code that simplifies usage of EasyVVUQ with a QCG
    Pilot Job execution engine,
-   [QCG-Client](http://www.qoscosgrid.org/trac/qcg-broker/wiki/client_user_guide) - a command line client for execution of computing jobs on the clusters offered by QCG middleware,
-   [QCG-Now](http://www.qoscosgrid.org/qcg-now/en/) - a desktop, GUI client for
    easy execution of computing jobs on the clusters offered by QCG middleware.

Introduction 
=============

As the performance of supercomputers become more powerful, it also turns into a
driving force for the science and engineering communities to construct
computational models of higher complexities. These models can help explore
sciences that were previously restricted by the computing powers of
older-generation computers. However, are these complex computational models
reliable? Are their calculations comparable to experimental measurements? Any
simulation model, regardless of its level of complexity, becomes more robust if
verified, validated, and minimized on uncertainties. Hence, uncertainty
quantification becomes one of the central objectives in computational modelling.
As defined in the VECMA glossary<sup>[1](#fn1)</sup>, uncertainty quantification UQ is a
“discipline, which seeks to estimate the uncertainty in the model input and
output parameters, to analyse the sources of these uncertainties, and to reduce
their quantities.” However, this process can quickly become cumbersome because
just a few uncertain inputs could require hundreds or even thousands of samples.
Such a number of tasks cannot be performed effectively without (1) adequate
computational resources, (2) a dedicated approach and (3) specialised
programming solutions.


In light of the aforementioned increase in availability of computing power,
there is also an increase in operating cost of large data centers. Therefore,
more emphasis must be placed on developing the appropriate mechanisms and
solutions that enable effective execution of calculations and yet follow the
administrative policies of the resource providers. Therefore, to address the
requirements of UQ analysis and technological concerns we have integrated
EasyVVUQ with QCG Pilot Job Manager in the VECMAtk to offer users a complete
solution for performing highly intensive UQ studies on the HPC resources of
peta- and in the future exa-scales. This solution allows users to submit the
entire workflow as a single job into a HPC cluster and thus avoids the
limitations and restrictions imposed by the administrative policies of resource
providers. Inside the resource allocation created for a single job, QCG Pilot
Job Manager deals with the execution of a potentially very high number of
subjobs in an automatic, flexible and efficient way. Although QCG Pilot Job
Manager is designed to support execution of complex computing tasks on HPC
clusters, it can also be used on a local computer, allowing users to
conveniently test their execution scenarios prior to the actual production runs
using the same programming and execution environment.

The tutorial is structured as follows: first, we provide a description to a
simple numerical model that serves as an example application in the tutorial,
then we provide instruction on how to install the EasyVVUQ-QCGPJ component of
the VECMAtk and other essential software tools. The tutorial materials download
information is also included. Next, we provide a glimpse into the structure of
EasyVVUQ-QCGPJ workflow, followed by instructions into the configuration on
environment-specific settings. Then, we showcase 4 different approaches (local,
SLURM, QCG Client, and QCG-Now) you can choose from to execute EasyVVUQ on the
sample application, all under the management of the QCG Pilot Job. For any
reader who is interested in learning more about UQ applied to a multiscale
workflow, a section describing the fusion model is positioned at the end of the
tutorial.

**Notice 1**: The tutorial contains some steps related to the execution of EasyVVUQ
/ QCG Pilot Job task via queuing system and/or QCG access tools. To follow these
steps you must have an account with a computing cluster controlled by SLURM and
if you want to use QCG tools it has to be part of the QCG infrastructure. In
order to get access to Eagle cluster at Poznan Supercomputing and Networking
Center, which is available with Slurm and QCG, please drop an e-mail with a
short motivation to VECMA infrastructure’s leader - Tomasz Piontek:
piontek_at_man.poznan.pl.


Application model for the tutorial
==================================

To give users a sense of how EasyVVUQ-QCGPJ works, we provide a simple cooling
coffee cup model as a test application throughout the entire tutorial. This
allows users to quickly grasp the concept behind the model so they can put their
attention towards the functionality of EasyVVUQ with QCG-PJ, and how the toolkit
assists users with the process of UQ on their numerical model.

The sample physics model in this tutorial is inspired by the “cooling coffee cup
model” from [^2]. A cup of coffee is placed inside some environment of
temperature $$T_{\text{env}}$$. Consequently, the cup of coffee experiences heat
loss and its temperature $$T$$varies in time $$t$$, as described mathematically
by the Newton’s law of cooling:

[^2]: https://uncertainpy.readthedocs.io/en/latest/examples/coffee_cup.html

$$\text{dT}(t)/\text{dt}\  = \  - \kappa(T(t) - T_{\text{env}})$$,

where $$\kappa$$ is a constant that describes the system. The python script
pce_model.py, which is provided as part of the tutorial materials, takes the
initial coffee temperature $$T_{0}$$, $$\kappa$$ and $$T_{\text{env}}$$ and
solve the above equation to find $$T$$. The quantity of interest here is $$T$$,
but there are uncertainties to the inputs $$\kappa$$ and $$T_{\text{env}}$$. The
goal here is to obtain the probability distribution of the measured value $$T$$,
given that there are uncertainties to the inputs. Please note that, from this
point forward, all quantities will be mentioned without explicit units.

We begin the UQ calculations to the model by defining lower and upper threshold
values to a uniform distribution for both uncertain inputs:

$$0.025\  \leq \kappa\  \leq 0.075$$, and

$$15.0\  \leq T_{\text{env}} \leq 25.0$$.

The initial coffee temperature $$T_{0}$$ is set to be 95.0, and the calculation
runs from $$t = 0$$ to $$t = 200$$. At the end of the simulation, we defined two
extra parameters $$T_{e}$$ and $$T_{i}$$, with $$T_{e}\  \equiv T$$ and $$T_{i}\
\equiv \  - T$$. We select the Polynomial Chaos Expansion[^3] PCE method with
1st order polynomial, which would result in $$(1 + 2)^{2}$$ or 9 sample runs. A
python script is provided in the tutorial material “test_pce_pj.py”, showcasing
how EasyVVUQ-QCGPJ takes the input parameters and handle all sample calculations
in an efficient manner, and provides statistical analysis to the outputs
$$T(t)$$ (i.e. mean, standard deviation, variance, Sobol indices[^4]). Here is a
schematic depicting the entire UQ procedure described above.

[^3]: https://en.wikipedia.org/wiki/Polynomial_chaos

[^4]: https://en.wikipedia.org/wiki/Variance-based_sensitivity_analysis

![](media/3e3df0f30600f1c35825e952a384b027.png)

UQ of the cooling coffee cup model: the EasyVVUQ-QCGPJ of the VECMAtk takes the
uncertain inputs and produces statistical analysis to $$T(t)$$. The plots on the
right are the calculated average temperature, standard deviation $$< T(t) > \pm
\sigma$$, and variance (top plot); and the first order Sobol indices for the
uncertain input parameters $$\kappa$$ and $$T_{\text{env}}$$ (bottom plot).

The rest of the tutorial will guide you through the toolkit installation and
execution of this model. Before “running test_pce_pj.py”, please be sure to
check all parameters and make changes accordingly.

Installation of EasyVVUQ-QCGPJ
==============================

1.  If you are going to work remotely on a cluster, please login into access
    node and start an interactive SLURM job (we are doing it on Eagle cluster,
    which is a part of the VECMA testbed).

| \$ ssh user\@eagle.man.poznan.pl \$ srun -n 1 --time=2:00:00 --partition=plgrid --pty /bin/bash |
|-------------------------------------------------------------------------------------------------|


2.  Be sure that **Python 3.6+** and **pip 18.0.1+** are installed and available
    in your environment. In case of Eagle cluster use the module for the newest
    version of the python.

| \$ python3 -V Python 3.6.6 \$ module load python/3.7.3 \$ python3 -V Python 3.7.3 |
|-----------------------------------------------------------------------------------|


3.  Check if virtualenv is installed on your system and if not install it

| \$ virtualenv --version bash: virtualenv: command not found \$ pip3 install --user virtualenv Collecting virtualenv Downloading https://files.pythonhosted.org/packages/ca/ee/8375c01412abe6ff462ec80970e6bb1c4308724d4366d7519627c98691ab/virtualenv-16.6.0-py2.py3-none-any.whl (2.0MB) 100% \|████████████████████████████████\| 2.0MB 2.0MB/s Installing collected packages: virtualenv The script virtualenv is installed in '/home/plgrid/user/.local/bin' which is not on PATH. Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location. Successfully installed virtualenv-16.6.0 |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


4.  If required, attend the warning from the previous step, add \~/.local/bin to
    the PATH environment variable and make it permanent by updating the .bashrc
    file.

| \$ export PATH=/home/plgrid/user/.local/bin:\$PATH \$ echo 'PATH=/home/plgrid/user/.local/bin:\$PATH' \>\> .bashrc \$ virtualenv --version 16.6.0 |
|---------------------------------------------------------------------------------------------------------------------------------------------------|


5.  Create virtualenv for the EasyVVUQ with QCG-PJ support:

| \$ virtualenv \~/.virtualenvs/easyvvuq-qcgpj Using base prefix '/opt/exp_soft/local/generic/python/3.7.3' New python executable in /home/plgrid/user/.virtualenvs/easyvvuq-qcgpj/bin/python3.7 Also creating executable in /home/plgrid/user/.virtualenvs/easyvvuq-qcgpj/bin/python Installing setuptools, pip, wheel... done. |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


6.  Activate this virtualenv:

| \$ . \~/.virtualenvs/easyvvuq-qcgpj/bin/activate (easyvvuq-qcgpj) user\@e0192:\~\$ |
|------------------------------------------------------------------------------------|


7.  Install the easyvvuq-qcgpj package using pip3  
    (Note: if you are not able to use pip in your environment you can always
    install all required packages manually as they are publicly available, e.g.
    by cloning repositories for missing packages and invoking python3 setup.py
    install for each one - take a look for the requirements here:
    https://github.com/vecma-project/EasyVVUQ-QCGPJ/blob/m12/setup.py)

| (easyvvuq-qcgpj)\$ pip3 install git+https://github.com/vecma-project/EasyVVUQ-QCGPJ.git\@m12 |
|----------------------------------------------------------------------------------------------|


Getting the tutorial materials
==============================

1.  Create directory for the tutorial

| \$ mkdir tutorial |
|-------------------|


2.  The materials used in this tutorial are available in GitHub VECMAtk
    repository. Clone them with the following commands:

| \$ cd \~/tutorial \$ git clone https://github.com/vecma-project/VECMAtk.git |
|-----------------------------------------------------------------------------|


Execution of EasyVVUQ with QCG Pilot Job
========================================

In this tutorial we describe 4 ways to execute EasyVVUQ with QCG Pilot Job.

1.  Local execution

2.  With SLURM

3.  With QCG-Client

4.  With QCG-Now

Each method has its own advantages and disadvantages. The local execution can be
easily performed on a laptop and instantly provide an overview to users. The
execution using SLURM, similar to the execution with QCG-Client, may be useful
for those who are using queuing system on a daily manner. The execution with
QCG-Now could be an interesting option for those who prefer GUI and the
automatized access to resources.

In the rest of this tutorial, the overall structure of the EasyVVUQ-QCGPJ
workflow is discussed before the step-by-step instructions are presented for
each method of execution. The eventual choice of method should be based on the
user’s preferences and requirements.

EasyVVUQ-QCGPJ workflow
-----------------------

The approach we took to integrate EasyVVUQ with QCG Pilot Job Manager is
considerably non-intrusive. The changes we introduced to the EasyVVUQ workflow
itself are small and mainly concentrated at the encoding and application
execution steps, thus the overhead needed to plug-in QCG Pilot Jobs into the
basic workflow is negligible. The integration code provides a generic mechanism
that could easily be adapted by different application teams to quantify
uncertainties of their codes. In this section we briefly describe the main parts
of a workflow used in the tutorial. For the extensive reference to how
EasyVVUQ-QCGPJ works, please go to:  
<https://github.com/vecma-project/EasyVVUQ-QCGPJ/tree/m12>

The workflow constructed for uncertainty quantification of a cooling coffee cup
is available in:

\~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/app/test_pce_pj.py

Considerably simplified, it looks as follows:

| def test_pce_pj(tmpdir): \# Initializing the QCG PJ Manager m = LocalManager([], client_conf) \# Set up a fresh campaign called "pce" my_campaign = uq.Campaign(name='pce', work_dir=tmpdir) \# Skipped code that initialises the campaign and samples for the use-case. \# Create PJConfigurator & save its state PJConfigurator(my_campaign).save() \# Execute encode -\> execute for each run (sample) using QCG PJ manager for key in my_campaign.list_runs(): encode_job = { "execution": { "name": 'encode_' + key, "exec": 'easyvvuq_encode', "args": [my_campaign.campaign_dir, key], ... }, "resources": { "numCores": {"exact": 1} } } execute_job = { "execution": { "name": 'execute_' + key, "exec": 'easyvvuq_execute', "args": [my_campaign.campaign_dir, key, 'easyvvuq_app', pce_app_dir + "/pce_model.py", "pce_in.json"], "wd": cwd }, "resources": { "numCores": {"exact": 1} }, "dependencies": { "after": ["encode_" + key] } } m.submit(Jobs().addStd(encode_job)) m.submit(Jobs().addStd(execute_job)) \# wait for completion of all PJ tasks and terminate the QCG PJ manager m.wait4all() m.finish() m.stopManager() m.cleanup() \# The rest of typical EasyVVUQ processing (collation, analysis) |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


We can distinguish the following key elements from this script:

-   Instantiation of QCG Pilot Job Manager.

-   Typical initialisation of a Campaign and generation of samples.

-   Instantiation of PJConfigurator object and the documentation of its state.
    Please note that the PJConfigurator object is constructed and saved in the
    main process, but it will be loaded later by QCG Pilot Job Manager tasks as
    separate processes.

-   The loop over runs (samples) and execution of encode / execute steps as QCG
    Pilot Job Manager tasks. In order to simplify execution of tasks, the
    special executable scripts easyvvuq_encode, easyvvuq_execute and
    easyvvuq_app are provided and are used as input files to the Pilot Job's
    tasks. They internally loads the configuration stored by PJConfiguration to
    execute EasyVVUQ operations.

-   Wait for completion of all QCG Pilot Job Manager tasks.

-   The collation and analysis made in a typical way, unperturbed from the
    EasyVVUQ script.

What is worth stressing is the fact that the workflow is generic enough such
that the majority of applications can either use it directly, or make
adjustments according to the specific needs of use cases. For example, we can
imagine that for some applications all encoding steps have to be executed before
the first execution step begins. In that case, other applications only have to
make simple modification to the presented workflow before use.

Common configuration before execution
-------------------------------------

1.  Please check and update if needed the content of environment configuration
    file located in:
    \~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/app/easypj_conf.sh. This
    file is used to configure system-specific settings for the developed
    workflow. Once you open this file, make sure the appropriate environment
    modules are loaded and virtualenv is activated. Do not change the part
    related to setting environment variables, for those variables are used in
    the workflow.

2.  Source the configuration file. Once sourced, it should activate virtualenv:

| \$ . \~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/app/easypj_config.sh (easyvvuq-qcgpj)\$ |
|-----------------------------------------------------------------------------------------------|


Local execution
---------------

1.  Be sure that you have sourced the easypj_conf.sh file and are in the proper
    virtualenv.

2.  Go into the
    \~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/local_execution:

| (easyvvuq-qcgpj)\$ cd \~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/local_execution |
|----------------------------------------------------------------------------------------|


3.  Execute the workflow:  
    (Note that for the local execution we are using a slightly modified version
    of the core workflow [not from the ../app folder] - since we are going to
    test this workflow locally, we define 4 virtual cores to demonstrate how QCG
    Pilot Job Manager executes tasks in parallel.)

| (easyvvuq-qcgpj)\$ python3 test_pce_pj.py |
|-------------------------------------------|


4.  When processing completes, check results produced by EasyVVUQ.

Execution using SLURM
---------------------

*This execution is possible only on a cluster with the SLURM queuing system. In
this tutorial we assume that EasyVVUQ-QCGPJ has been configured on the Eagle
cluster in the way as described in the section Installation of EasyVVUQ-QCGPJ
and the tutorial files has been cloned into the \~/tutorial/VECMAtk.*

1.  Go into the \~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/slurm_execution

| \$ cd \~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/slurm_execution |
|------------------------------------------------------------------------|


2.  Adjust the SLURM job description file: test_pce_pj.sh.

3.  Submit the workflow as a SLURM batch job:

| \$ sbatch test_pce_pj.sh Submitted batch job 11094963 |
|-------------------------------------------------------|


4.  You can check the status of your SLURM jobs with:

| \$ squeue -u plguser JOBID PARTITION NAME USER ST TIME NODES NODELIST(REASON) 11094963 fast easyvvuq plguser R 0:02 1 e0022OBID |
|---------------------------------------------------------------------------------------------------------------------------------|


5.  Alternatively you can display detailed information for a concrete job:

| \$ sacct -j 11094963 JobID JobName Partition Account AllocCPUS State ExitCode ------------ ---------- ---------- ---------- ---------- ---------- -------- 11094963 easyvvuq_+ fast vecma2019 4 COMPLETED 0:0 11094963.ba+ batch vecma2019 4 COMPLETED 0:0 11094963.0 .encode_R+ vecma2019 1 COMPLETED 0:0 11094963.1 .encode_R+ vecma2019 1 COMPLETED 0:0 11094963.2 .encode_R+ vecma2019 1 COMPLETED 0:0 11094963.3 .encode_R+ vecma2019 1 COMPLETED 0:0 11094963.4 .execute_+ vecma2019 1 COMPLETED 0:0 11094963.5 .execute_+ vecma2019 1 COMPLETED 0:0 11094963.6 .execute_+ vecma2019 1 COMPLETED 0:0 11094963.7 .encode_R+ vecma2019 1 COMPLETED 0:0 11094963.8 .execute_+ vecma2019 1 COMPLETED 0:0 11094963.9 .execute_+ vecma2019 1 COMPLETED 0:0 11094963.10 .encode_R+ vecma2019 1 COMPLETED 0:0 11094963.11 .encode_R+ vecma2019 1 COMPLETED 0:0 11094963.12 .encode_R+ vecma2019 1 COMPLETED 0:0 11094963.13 .execute_+ vecma2019 1 COMPLETED 0:0 11094963.14 .execute_+ vecma2019 1 COMPLETED 0:0 11094963.15 .execute_+ vecma2019 1 COMPLETED 0:0 11094963.16 .encode_R+ vecma2019 1 COMPLETED 0:0 11094963.17 .execute_+ vecma2019 1 COMPLETED 0:0 |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


6.  When the job completes, you can check the file output[jobid].txt, in which
    you will find the output produced by EasyVVUQ.

Execution with QCG-Client
-------------------------

*This execution can be performed only on a machine with QCG-Client installed and
configured to execute jobs on a cluster with SLURM queuing system. In the
tutorial we assume the usage of the QCG Client installed on qcg.man.poznan.pl
and the Eagle cluster, which is a part of the PLGrid infrastructure. These two
machines share the same \$HOME directory where both EasyVVUQ-QCGPJ has been
configured in the way described in the section Installation of EasyVVUQ-QCGPJ
and the tutorial files has been cloned into the \~/tutorial/VECMAtk.*

1.  Login into the machine with qcg-client

| \$ ssh user\@qcg.man.poznan.pl |
|--------------------------------|


2.  Go into the \~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/qcg_execution

| \$ cd \~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/qcg_execution |
|----------------------------------------------------------------------|


3.  Adjust QCG job description file: test_pce_pj.qcg.

4.  Submit the workflow as a QCG batch job (you may be asked to provide your
    personal certificate credentials):

| \$ qcg-sub test_pce_pj.qcg Enter GRID pass phrase for this identity: ...                                                               |
| test_pce_pj.qcg {} jobId = J1559813849509_easyvvuq_pj_qcg_4338                                                                         |
|----------------------------------------------------------------------------------------------------------------------------------------|


5.  You can list and check the status of QCG jobs with:

| \$ qcg-list ... IDENTIFIER NOTE SUBMISSION START FINISH STATUS HOST FLAGS DESCRIPTION J1559813849509_easyvv\* 06.06.19 11:39 PREPROCESSING eagle S UP |
|-------------------------------------------------------------------------------------------------------------------------------------------------------|


6.  A detailed information about the lastly submitted job can be obtained in the
    following way:

| \$ qcg-info ... J1559814286855_easyvvuq_pj_qcg_5894 : Note: UserDN: \*\*\*\* TaskType: SINGLE SubmissionTime: Thu Jun 06 11:44:47 CEST 2019 FinishTime: Thu Jun 06 11:45:18 CEST 2019 ProxyLifetime: P24DT23H48M33S Status: FINISHED StatusDesc: StartTime: Thu Jun 06 11:44:47 CEST 2019 Purged: true Allocation: HostName: eagle ProcessesCount: 4 ProcessesGroupId: qcg Status: FINISHED StatusDescription: SubmissionTime: Thu Jun 06 11:44:47 CEST 2019 FinishTime: Thu Jun 06 11:45:52 CEST 2019 LocalSubmissionTime: Thu Jun 06 11:44:52 CEST 2019 LocalStartTime: Thu Jun 06 11:45:02 CEST 2019 LocalFinishTime: Thu Jun 06 11:45:18 CEST 2019 Purged: true WorkingDirectory: gsiftp://eagle.man.poznan.pl//tmp/lustre/plguser/J1559814286855_easyvvuq_pj_qcg_5894_task_1559814287294_978 |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


7.  When the job completes, the results are downloaded to results[JOB_ID]
    directory.

Execution with QCG-Now
----------------------

*At this moment QCG-Now allows users to submit jobs to PLGrid clusters only,
thus in order to use the tool, an account with PLGrid is mandatory. As before,
we assume the usage of Eagle.*

The installation, configuration and basic usage of QCG-Now is described here:  
<http://www.qoscosgrid.org/qcg-now/en/instructions/firststeps/elementary>

During the configuration you should select PLGrid as a domain and then whenever
QCG-Now asks about user ID/password you should provide your PLGrid credentials.

When installed and configured, the steps to submit an EasyVVUQ / QCG Pilot Job
task from QCG-Now are as follows:

1.  Get the tutorial files using GIT or download them zipped from
    <https://github.com/vecma-project/VECMAtk/archive/master.zip> - then extract
    the files.

2.  In the main window of QCG-Now click "+"

    ![](media/c0ef8b0d4973262fead203f617ac86ef.png)

3.  The New Task definition window should open. When you select the Files tab it
    should look as follows:

![](media/d23169802e43408494abfa239f06258a.png)

1.  Drag&drop the /tutorials/M12/easyvvuq-qcgpj/app/test_pce_pj.py file from the
    extracted zip file into "DROP FILES HERE" space:

![](media/94b0a837fce4828413b3d6aea5e5a24a.png)

1.  In the Properties tab select:

>   Application: **bash**

>   Task Name: EasyVVUQ test

>   Grant: leave blank to use a default one or select another

>   Submission type: **Submit script**

>   In the opened textarea write:

| . \~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/app/easypj_config.sh python3 test_pce_pj.py |
|------------------------------------------------------------------------------------------------|


![](media/88b25f5e5da8da6c8cc91ef62b9921e4.png)

1.  In the Requirements tab select:

>   Resource: **eagle**

>   Calculation type: **Parallel** (Number of nodes: **1**, Cores per node:
>   **4**, Processes per node **4**)

>   Walltime: **5 minutes**

![](media/1cf427dde7342a1f2afc2cd690de3c2f.png)

1.  Click the submit button (the arrow in the top-right corner). At this moment
    QCG-Now initiates a data transfer to the computing resources and requests
    the QCG middleware for the task execution.

![](media/e7661bb8dcb3dc1080a94e990c6f9435.png)

1.  When submitted, the task is added to the list of tasks in the main window,
    where it is possible to track the state and progress of its execution in two
    complementary views:

    ![](media/5762ccf0f5245501fa55c62392eafba1.png)

    ![](media/01f4f4d0ff1b3580f63ff79ce76c4746.png)

2.  When the task completes successfully, the output data is transferred back to
    a user's computer and user can open a directory with results using one of
    dedicated buttons from the main window.  
    

    ![](media/33b800ae70cdfa9c8c3b6196cea419e0.png)

    >   or

    ![](media/7fdfeda63edc65a44b63b8cdf36ffbee.png)

Example of a real multiscale application: Fusion
================================================

There are many natural and physical phenomena considered as multi-scale
processes. One of such phenomena is the thermonuclear fusion reaction. To
achieve fusion on reactors such as the ITER tokamak[^5], scientists need to
understand both the small-scaled turbulence and the large-scale plasma
transport, for the instabilities produced by turbulence affects plasma
confinement. This is a problem that involves a wide range of spatial and
temporal scales. Previously scientists were only able to focus on building
single-scaled physics models due to very-limited computing capacity. However,
with supercomputers performance continuously on the rise, multiscale modelling
becomes feasible and there are much effort within the fusion community to come
up with a reliable simulation model to understand the multiscale phenomenon.

[^5]: https://www.iter.org/

![](media/ee8f1067678536981ef8ae259c094cd3.jpg)

An illustration of the ITER tokamak.

The multiscale fusion workflow (MFW) is one of such efforts. It takes the
component base approach to connect several single-scaled models into a workflow:
the equilibrium model that updates tokamak equilibrium information; turbulence
model that calculates particle and heat fluxes; transport model that maps out
the core plasma profiles (e.g. temperature); conversion module that converts
fluxes calculated by the turbulence model into transport coefficients required
by transport model. In addition, there is a sources component that provides
sources’ profiles to the transport model. The figure below shows the structure
of the workflow, where the flow of data amongst models is represented by arrows.

![](media/227082027e6fdb7cf27136556953ae23.png)

The Multiscale Fusion Workflow (MFW). The runtime of each code is listed on the
right.

The specifics of MFW and some of its simulation results were reported in Luk et.
al.[^6] These results include simulating a tokamak plasma until its electron
temperature reaches quasi-steady state. While the MFW is showing some promising
results, there are uncertainties within the simulation, namely external
uncertainties from the sources and equilibrium models, and internal
uncertainties from the turbulence model. We need to define and reduce these
uncertainties to ensure confidence in the simulation results.

[^6]: O.O. Luk, O. Hoenen, A. Bottino, B.D. Scott, D.P. Coster, “ComPat
framework for multiscale simulations applied to fusion plasmas”, Computer
Physics Communications (2019), https://doi.org/10.1016/j.cpc.2018.12.021.

There are different methods of UQ in a multiscale application. One of which is
non-intrusive, in which we treat a single-scale model as a blackbox. For
example, we treat the transport model as a blackbox and apply PCE to 4 uncertain
input parameters, diffusivity *DN*, with 4th order polynomial, and this yields
(4+2)4 or 1296 samples. The transport model then outputs temperature profiles
$$T_{\alpha}(\rho)$$, where $$T_{\alpha}$$ is the temperature of species
$$\alpha$$ and $$\rho$$is the radial coordinate value. Here we take the
EasyVVUQ-QCGPJ workflow from the tutorial materials and made a few changes
suitable for the transport model. Then we use it to prepare and run all samples,
then EasyVVUQ collates the results from these samples and calculates the mean,
standard deviation, variance, and Sobol indices of $$T_{\alpha}(\rho)$$. The
figures below show the statistical analysis results of electron temperature
$$T_{e}$$ and the first-order Sobol indices.

![](media/fdfc6ad7d484e9648d2d402103ef73c7.png)

![](media/d2479039925cd0353c46c50b9c1fdf94.png)

Mean, standard deviation, and variance of the $$T_{e}$$ (left) and first-order
Sobol indices (right) from 1296 samples.

Besides the non-intrusive UQ method on the transport model, we are also
exploring the semi-intrusive UQ method. In the semi-intrusive method, the
transport and equilibrium models are treated as individual blackboxes. The PCE
method is applied to the transport model/blackbox first, then the statistical
information of $$T_{\alpha}$$ is propagated into the equilibrium blackbox as
inputs. The PCE method is applied again to get statistical analysis of the
equilibrium code output. Ultimately we want to perform UQ to the entire
multiscale workflow, which would mean many more samples are necessary.

## References
<a name="fn1">1</a>: https://wiki.vecma.eu/glossary<br/>
<a name="fn2">2</a>: https://uncertainpy.readthedocs.io/en/latest/examples/coffee_cup.html<br/>
<a name="fn3">3</a>: https://en.wikipedia.org/wiki/Polynomial_chaos<br/>
<a name="fn4">4</a>: https://en.wikipedia.org/wiki/Variance-based_sensitivity_analysis<br/>
<a name="fn5">5</a>: https://www.iter.org/<br/>
<a name="fn6">6</a>: O.O. Luk, O. Hoenen, A. Bottino, B.D. Scott, D.P. Coster, “ComPat
framework for multiscale simulations applied to fusion plasmas”, Computer
Physics Communications (2019), https://doi.org/10.1016/j.cpc.2018.12.021.
