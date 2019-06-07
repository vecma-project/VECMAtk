#!/bin/bash

# initiate virtualenv
. ~/.virtualenvs/easyvvuq-qcgpj/bin/activate

export PCE_APP=~/tutorial/VECMAtk/tutorials/M12/easyvvuq-qcgpj/app/pce

# Do not change anything below

# Set environment variable for use by EasyVVUQ-QCGPJ integrator
export EASYPJ_CONF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
