#!/bin/bash

set -e

# Run in background (to get around timeout)
nohup sudo -b -u ec2-user -i <<'EOF'

# Declare constants
NAME="skylar_env"
PYTHON=3.10

# Install GitHub CLI
type -p yum-config-manager >/dev/null || sudo yum install yum-utils -y
sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo yum install gh -y

# Install DVC 
pip install dvc

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
    category_encoders \
    composeml \
    docker-compose \
    fastparquet \
    feature_engine \
    featuretools \
    fsspec \
    python-git \
    openpyxl \
    pandas \
    pyyaml \
    s3fs \
    sagemaker \
    scikit-learn \
    scikit-plot \
    seaborn \
    tqdm \
    woodwork

# Install toolboxes
pip install git+https://github.com/swritchie/skylar-toolbox.git

# List environment
conda list

# Configure Git
git config --global user.name 'Skylar Ritchie'
git config --global user.email skylarwritchie@gmail.com

EOF
