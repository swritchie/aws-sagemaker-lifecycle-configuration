#!/bin/bash

set -e

# Run in background (to get around timeout)
nohup sudo -b -u ec2-user -i <<'EOF'

# Declare constants
NAME="skylar_env"
PYTHON=3.9

# Create environment
conda create \
    -n $NAME \
    -c conda-forge \
    python=$PYTHON \
    ipykernel \
    -y
    
# Activate it
conda activate $NAME

# Install packages
pip install \
    catboost \
    docker-compose \
    dvc \
    fastparquet \
    fsspec \
    github-cli \
    python-git \
    openpyxl \
    pandas \
    pyyaml \
    s3fs \
    sagemaker \
    scikit-learn \
    scikit-plot \
    seaborn 

# Install toolboxes
pip install git+https://github.com/swritchie/skylar-toolbox.git

# List environment
conda list

# Configure Git
git config --global user.name 'Skylar Ritchie'
git config --global user.email skylarwritchie@gmail.com

EOF
