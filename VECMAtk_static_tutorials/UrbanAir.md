# UrbanAir tutorial for modeling air quality at street level in the cities
### A step-by-step guide for execution of air quality simulation and integration with EasyVVUQ on HPC resources

## Preface

In this tutorial you will get step-by-step guidance on the usage of several VECMAtk components to simulate air quality in the city at street level. You will also perform uncertainty quantification
calculations within HPC execution environment. In this tutorial you will learn about the following VECMA software components and how these components are used as shown in the Tube Mapo below:

![Graphical depiction of the VECMAtk components used in the UrbanAir tutorial](https://raw.githubusercontent.com/vecma-project/VECMAtk/master/VECMAtk_static_tutorials/UrbanAirMap.png)

-   [EasyVVUQ](https://easyvvuq.readthedocs.io/en/latest/) - a Python3 library that aims to facilitate verification, validation and uncertainty quantification,
-   [QCG Pilot Job](https://wiki.vecma.eu/qcg-pilotjobs) - a Pilot Job system that allows to execute many subordinate jobs in a single scheduling system allocation,
-   [EasyVVUQ-QCG-PJ](https://easyvvuq-qcgpj.readthedocs.io/en/latest/) - Python API for HPC execution of EasyVVUQ.

    
    
## Contents
  * [Air quality simulations](#urban-air-simulations)
  * [Installation of required software packages](#installation)
	* [Licensing](#licensing)
  * [Execution of UrbanAir simulations](#execution-of-urbanair-simulations)
  * [Sensitivity analysis of parameters using EasyVVUQ](#sensitivity-analysis-of-parameters-using-easyvvuq)

## Air quality simulations
In this tutorial we demonstrate how to assess air quality in complex urban areas at street level. The exemplary simulation concerns Garbary Street in Poznan, Poland:
![Garbary streen in Poznan, Poland]{}
It is a narrow, long street surrounded by tall buildings, forming what is called a street corridor. The perpendicular to the street wind, heavy car traffic and poor
heat appliances makes this street vulnerable to high concentrations of NO2/NOx (attributed to vehicles) and PM2.5 and PMP20 (attributed to heat appliances). 
The simulation setup focuses on predicting NO2 concentration.


## Installation
To perform this tutorial a binary application is available at the Eagle cluster. In order to have access to it please follow the [Installation guide]{https://wiki.vecma.eu/access_eagle}.
In order to be able to run this tutorial, you have to be part of the VECMA Tutorials (plggvecmatut) team. To check if you are, follow the 'Make the "vecma" grant the default one' section of the aforementioned guide.
If you are not part of that team already, then please kontakt Michal Kulczewski (kulka@man.poznan.pl).


## Licensing

By using this tutorial you are not entitled:

- to copy the binary
- to copy the input data
- to reverse engineer the application
- etc...

 
## Execution of UrbanAir simulations

The single-model execution can be easily performed on HPC machine for instant results and for the overview of the application. User is allowed to steer some input parameters, e.g. number of cars
passing within an hours, or diesel to gasoline cars ratio. The weather conditions are fixed.

*DESCRIBE PARAMETERS*

1. Parameters

You may change parameters related to the gasoline cars:
- gas_cars: ratio of gasoline to diesel cars (0.1-0.9)
- gas_usage: fuel usage per 100km (4.0-13.0)
- gas_density: density of the gasoline fuel (0.1-0.9)
- gas_no2_index: NO2 index attributed to gasoline engines (0.001-0.01)

The parameters values should be changed in params.dat file (/home/plgrid-groups/plggvecmatut/single/data) which is processed upon UrbanAir execution. The best way is to copy entire *single/data* catalogue to your home directory,
edit it and use for the job submission (see below how to run).

2. Run

Once you copy the aforementioned catalogue (whole content) and edited the params.dat, you can run a job on Eagle machine. To this end please use the examplary submission file, *single/urbanair_single.qcg*. The data should be changed
according to the comments:

```
##name of the job
#QCG note=urbanairsingle
##host machine to run
#QCG host=eagle
##waltime, 360 minutes in this case
#QCG walltime=PT360M
##computational resources required, 1 node with 24 cores in this case
#QCG nodes=1:24
##input data to be stage in. Please replace $HOME/single/data with the path
## where you copied single/data content. The ->data means that the input data
##will be stores at jobdir/data catalogue (do not change this)
#QCG stage-in-dir=$HOME/single/data->data
##where to store output of the job, change as desired
#QCG stage-out-dir=.->$HOME/runs/urbanair.eagle.${JOB_ID}
##should be changed to your grant
#QCG grant=vecma2020
##change to your email address
#QCG notify=mailto:kulka@man.poznan.pl

...
```

Next, submit job using QCG-client, e.g.
```
qcg-sub urbanairsingle.qcg
```
where *urbainairsingle.qcg* is the updated submission file.

3. Graphical analysis

After the job has finished, there should a PNG file with the NO2 concentration for the domain at 2m height.
You can also visualize HDF5 output files.

![Example NO2 concentration at 2m height.](https://raw.githubusercontent.com/vecma-project/VECMAtk/master/VECMAtk_static_tutorials/UrbanAir_no2_2d.png)


## Sensitivity analysis of parameters using EasyVVUQ

The aim is to sample simulation input parameters and understand how identified assumptions in air quality prediction are pivotal to the validation results.

### Preparation of parameters for sensitivity analysis

The parameters are prepared on-the-fly upon execution of the job. You can change the input parameters ranges within *urbanair_pj_executor.py* file but then please correct
the executable paths in submission file.

```

    # Define parameter space
    params = {
		##gasoline to diesel ratio index
				"gas_engine": {
        "type": "float",
        "min": 0.1,
        "max": 0.9,
        "default": 0.72
        },
		##gasoline usage per 100km
        "gas_usage": {
        "type": "float",
        "min": 4.0,
        "max": 13.0,
        "default": 8.0
        },
		##density of the gasoline
        "gas_density": {
        "type": "float",
        "min": 0.1,
        "max": 0.9,
        "default": 0.75
        },
		##NO2 index for gasoline fuel
        "gas_no2_index": {
        "type": "float",
        "min": 0.001,
        "max": 0.01,
        "default": 0.00855
        }
```

### Run EasyVVUQ analysis on a remote machine using EasyVVUQ-QCG-PJ

Copy ensemble/data catalogue to your home directory. Next, change the *ensemble/urbanair_ensemble.qcg* accordingly (see *sinle* example:

```
#QCG name=urbanair_ensemble
#QCG host=eagle
#QCG walltime=P4D
#QCG grant=vecma2020
#QCG nodes=21:24
#QCG stage-in-dir=$HOME/ensemble/data->.
#QCG stage-out-dir=. -> $HOME/runs/urbanair.eagle.${JOB_ID}
#QCG notify=mailto:kulka@man.poznan.pl
#QCG persistent

...
```

### Analysis
Apart from HDF5 output files you can analyse by yourself, there will be PNG with the sensitivity analysis just like below:

![Sensitivity analysis example.](https://raw.githubusercontent.com/vecma-project/VECMAtk/master/VECMAtk_static_tutorials/UrbanAir_no2_sobols_multi.png)
