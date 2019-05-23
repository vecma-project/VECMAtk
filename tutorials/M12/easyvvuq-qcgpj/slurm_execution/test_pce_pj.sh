#!/bin/bash

## job name
#SBATCH --job-name=easyvvuq_pj

## stdout file
#SBATCH --output=output-%j.txt

## stderr file
#SBATCH --error=error-%j.txt

## wall time in format MINUTES:SECONDS
#SBATCH --time=10:00

## number of nodes
#SBATCH --nodes=1

## tasks per node
#SBATCH --tasks-per-node=4

## queue name
#SBATCH --partition=fast

## grant
#SBATCH --account=vecma2019

module load python/3.7.3
. ~/.virtualenvs/easyvvuq-qcgpj/bin/activate

python3 test_pce_pj.py
