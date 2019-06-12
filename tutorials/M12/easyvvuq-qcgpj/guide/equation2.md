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
