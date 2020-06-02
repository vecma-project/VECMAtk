#!/bin/bash

# check OS version
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		echo "OS type = Linux"
        curlcmd="curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        echo "OS type = Mac OSX"
        curlcmd="curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
fi


# download Miniconda-installer
if [ ! -f miniconda.sh ]; then
	echo "Downloading miniconda ..."
	eval $curlcmd
fi


# setup VirtualEnv
if [ ! -d VirtualEnv ]; then
	bash miniconda.sh -b -p VirtualEnv
fi



cat <<EOF > load_VECMAtk_ENV.sh
#!/bin/bash

echo "Loading VECMAtk virtualEnv . . ."

eval "\$($PWD/VirtualEnv/bin/conda shell.bash hook)"
export -f activate

pyversion="\$(python -V 2>&1)"
pylocation="\$(which python 2>&1)"
echo "conda python version  = " \$pyversion
echo "conda python location = " \$pylocation

# FabSim Env parameters
export PATH=$PWD/FabSim3/bin:\$PATH
export PYTHONPATH=$PWD/FabSim3:$PWD/VirtualEnv

EOF

# load VirtualEnv
eval "$(VirtualEnv/bin/conda shell.bash hook)"

# update pip version if it is needed
python -m pip install --upgrade pip



# EasyVVUQ installation
pip install easyvvuq
# clone EasyVVUQ github repo
if [ ! -d EasyVVUQ ]; then
	git clone https://github.com/UCL-CCS/EasyVVUQ.git
fi


# clone FabSim3 github repo
if [ ! -d FabSim3 ]; then
	git clone https://github.com/djgroen/FabSim3.git
fi
# FabSim3 installation
cd FabSim3
pip install ruamel.yaml numpy fabric3==1.13.1.post1 cryptography
if [ ! -f deploy/machines_user.yml ]; then
	python3 configure_fabsim.py
fi

cd ..


# clone muscle3 github repo
if [ ! -d muscle3 ]; then
	git clone https://github.com/multiscale/muscle3.git
fi
# MUSCLE3 installation
pip install -U pip setuptools wheel
pip install muscle3


# QCG PilotJob Manager installation
pip install --upgrade git+https://github.com/vecma-project/QCG-PilotJob.git

read -d '' guide << EOF
VECMAtk installation is DONE ...
to load the VirtualEnv, please type

source load_VECMAtk_ENV.sh
EOF

echo "$guide"


conda deactivate 

