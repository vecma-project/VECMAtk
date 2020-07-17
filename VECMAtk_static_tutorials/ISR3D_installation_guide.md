MUSCLE 2.1.1 and ISR3D:
=======================
ISR3D model description
-----------------------

The «3D in-stent restenosis» (ISR3D) application is intended for simulation of smoot muscle cells (SMC) proliferation and restenosis process as a complication
after coronary stenting procedure. The 3D in-stent restenosis model (ISR3D) is a fully coupled 3D multiscale
model, which includes several single-scale submodels as well as utility modules which facilitate communication
between the submodels. The submodel structure is similar to the one used by Caiazzo et al. in [1] and is described in detail in [2–3]. The submodels are described in this section.

**Mechanical model of SMCs.** The model code is located in ``kernel/absmc``. The agent-based model is used for modelling of mechanical response of vessel’s
walls. The cells of vessel tissue and stent struts are presented as an array of point-wise particles with no mass, and
the interactions between them are provided by potential forces of repulsion and adhesion. The effective radii of
particles represent the radii of corresponding cells and change during growth. Mathematically the problem is
formulated as a Cauchy problem for a system of ordinary differential equation. The coordinates of agents after each
step of biological model or stent deployment model are taken as initial conditions.

**Biological model of SMCs** is located in ``kernel/absmc`` as well. Cell cycle model is used for modelling the cell dynamics. Cell lifecycle is a sequence of
growth, replication and division of the cell; at the end of the lifecycle the cell divides into two daughter cells. The
processes that influence the cell lifecycle take place in the 30 μm neighbourhood around the cell; time scale of one
cycle is around 24-48 hours.

The growth of separate cells is modelled by a finite-state automaton. For each cell it can be in the state of growth
(G1), synthesis/repeat growth/mitosis (S/G2/M), or be idle (G0). Cells move from one state to the next, and stop or
die under the influence of external factors such as mechanical stresses (from mechanic model of SMC), the
concentration of nitric oxide (calculated from the shear stresses passed by the hydrodynamic model), and the
concentration of growth suppressing drugs (from diffusion model). The biological model provides new radii, states
and coordinates of the cells as its output. Growth of the neointima takes several dozens of cell cycles and stops
several weeks after the stenting procedure. Growth can progress up to the full vessel occlusion in some special
cases.

**Hydrodynamic model.**  The model code is located in ``kernel/flow3d``. Blood flow in the stented vessel is driven by a stationary Newton hydrodynamic model,
which provides relevant range of shear stresses on the vessel walls. The simulation of blood flow in the vessel is
provided by the lattice Boltzmann calculation method in 3D rectangular mesh (D3Q18). The field of flow velocities in each
lattice cell at the next timestep, and shear stress values in the cells near the wall of the vessel are the output of the
solver.

**Utility mapping modules.** To produce the input data for hydrodynamic solver the array of agents has to be
presented as a surface of the vessel wall. Each cell of hydrodynamic solver mesh where agent is present is marked as
solid, and then the obtained configuration is smoothed. In the same way the values of shear stresses and drug
concentration in the vessel wall are mapped to the corresponding agent-cells.

[1] Caiazzo, A., Evans, D., Falcone, J. L., Hegewald, J., Lorenz, E., Stahl, B., Wang, D., Bernsdorf, J., Chopard, B., Gunn, J. P., Hose, D. R., Krafczyk, M., Lawford, P. V., Smallwood, R., Walker, D., & Hoekstra, A. G. (2011). A Complex Automata approach for in-stent restenosis: Two-dimensional multiscale modelling and simulations. Journal of Computational Science, 2(1), 9–17. https://doi.org/10.1016/j.jocs.2010.09.002

[2] Zun, P. S., Anikina, T., Svitenkov, A., & Hoekstra, A. G. (2017). A Comparison of Fully-Coupled 3D In-Stent Restenosis Simulations to In-vivo Data. Frontiers in Physiology, 8(May), 284. https://doi.org/10.3389/fphys.2017.00284

[3] Zun, P. S., Narracott, A. J., Chiastra, C., Gunn, J., & Hoekstra, A. G. (2019). Location-Specific Comparison Between a 3D In-Stent Restenosis Model and Micro-CT and Histology Data from Porcine In Vivo Experiments. Cardiovascular Engineering and Technology, 10(4), 568–582. https://doi.org/10.1007/s13239-019-00431-4

Quick Installation Guide
------------------------

MUSCLE 2.1.1
------------

The source code can be obtained from ``https://github.com/psnc-apps/muscle2``

Dependencies of muscle 2.1.1, for Debian-based distrubutions (e.g. Ubuntu)
``sudo apt-get install build-essential cmake ruby default-jdk python-dev gfortran openmpi-bin libopenmpi-dev``

ruby 1.8 also requires json

The installation file is located at ``$MUSCLE_DIR/build`` and is called ``build.sh``

To install, run
``sudo ./build.sh installation_dir``
Running it without parameters will install Muscle to ``/opt/muscle``

Detailed guide for installing Muscle is located at ``http://www.qoscosgrid.org/trac/muscle/wiki/Installation``

NB: before starting the Muscle you have to run
``source /opt/muscle/etc/muscle.profile`` (substitute your Muscle2 directory for /opt/muscle)


ISR3D
-----

The source code is located at ``https://gitlab.computationalscience.nl/pavel/ISR3D``

For access please contact Pavel Zun, pavel.zun at gmail.com

Dependencies: in addition to Muscle, ``ant`` and ``boost`` are required. Any modern version of boost will likely suffice.

To install into the active directory, create and run ``/ISR3D/build.machinename.sh``
An example of this file for a desktop Debian machine is ``build.linux.sh``;
For other machines it is necessary to prescribe the appropriate compiler name and the address of MUSCLE (and flags, if necessary)
Before installation, you have to run ``source /opt/muscle/etc/muscle.profile``
(This can also be added to your ``~/.bashrc`` to run automatically on terminal startup)

To test Muscle2 (on its own) and ISR3D run the following commands:

Muscle
```
source /opt/muscle/etc/muscle.profile
/opt/muscle/bin/muscle2 -c /opt/muscle/share/muscle/examples/cxa/LaplaceExample.cxa.rb -ma --tmp-path /YOUR_TEMPORARY_PATH_HERE/
```

ISR3D
Running all submodels without MPI:
```
. /opt/muscle/etc/muscle.profile
muscle2 -c cxa/isr.cxa.rb -am -p ./Results
```

Parallel calculation for blood flow:
In two separate terminals, or through &, run:
```
muscle2 -c cxa/isr.cxa.rb -m DD collector distributor SMC Blob voxelizer thrombusMapper -p ./Results
mpirun -np 2 muscle2 -c cxa/isr.cxa.rb -n BF -p ./Results -M 127.0.0.1:9000
```

where the address and port are taken from the message of the first (master) process, example:
``[muscle] Started the connection handler, listening on 127.0.0.1:9000``
