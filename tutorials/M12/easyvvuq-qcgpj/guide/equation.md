
Application model for the tutorial
==================================

To give users a sense of how EasyVVUQ-QCGPJ works, we provide a simple cooling
coffee cup model as a test application throughout the entire tutorial. This
allows users to quickly grasp the concept behind the model so they can put their
attention towards the functionality of EasyVVUQ with QCG-PJ, and how the toolkit
assists users with the process of UQ on their numerical model.

The sample physics model in this tutorial is inspired by the “cooling coffee cup
model” from [^2]. A cup of coffee is placed inside some environment of
temperature T~env~. Consequently, the cup of coffee experiences heat
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