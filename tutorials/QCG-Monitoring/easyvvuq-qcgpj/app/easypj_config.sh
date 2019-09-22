#!/bin/bash

# load modules
module load python/3.7.3

# initiate virtualenv
. ~/.virtualenvs/easypj-monitoring/bin/activate

export COOLING_APP=~/tutorial/VECMAtk/tutorials/QCG-Monitoring/easyvvuq-qcgpj/app/cooling

# Do not change anything below

# Set environment variable for use by EasyVVUQ-QCGPJ integrator
export EASYPJ_CONFIG="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
