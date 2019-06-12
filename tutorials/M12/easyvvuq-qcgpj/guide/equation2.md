
There are different methods of UQ in a multiscale application. One of which is
non-intrusive, in which we treat a single-scale model as a blackbox. For
example, we treat the transport model as a blackbox and apply PCE to 4 uncertain
input parameters, diffusivity *DN*, with 4th order polynomial, and this yields
(4+2)<sup>4</sup> or 1296 samples. The transport model then outputs temperature profiles
*T<sub>a</sub>(p)*, where *T<sub>a* is the temperature of species
*a* and *p* the toroidal flux coordinate value. Here we take the
EasyVVUQ-QCGPJ workflow from the tutorial materials and made a few changes
suitable for the transport model. Then we use it to prepare and run all samples,
then EasyVVUQ collates the results from these samples and calculates the mean,
standard deviation, variance, and Sobol indices of *T<sub>a</sub>(p)*. The
figures below show the statistical analysis results of electron temperature
 *T<sub>e</sub>* and the first-order Sobol indices.

![](media/fdfc6ad7d484e9648d2d402103ef73c7.png)

![](media/d2479039925cd0353c46c50b9c1fdf94.png)

Mean, standard deviation, and variance of the *T<sub>e</sub>* (left) and first-order
Sobol indices (right) from 1296 samples.

Besides the non-intrusive UQ method on the transport model, we are also
exploring the semi-intrusive UQ method. In the semi-intrusive method, the
transport and equilibrium models are treated as individual blackboxes. The PCE
method is applied to the transport model/blackbox first, then the statistical
information of *T<sub>a</sub>* is propagated into the equilibrium blackbox as
inputs. The PCE method is applied again to get statistical analysis of the
equilibrium code output. Ultimately we want to perform UQ to the entire
multiscale workflow, which would mean many more samples are necessary.
