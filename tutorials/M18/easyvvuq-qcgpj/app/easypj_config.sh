#!/bin/bash

# load modules
module load python/3.7.3

# initiate virtualenv
. ~/.virtualenvs/easyvvuq-qcgpj-m18/bin/activate

export COOLING_APP=~/tutorial/VECMAtk/tutorials/M18/easyvvuq-qcgpj/app/cooling

# Do not change anything below

# Set environment variable for use by EasyVVUQ-QCGPJ integrator
export EASYPJ_CONFIG="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
