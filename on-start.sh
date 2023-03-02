#!/bin/bash

set -e

# Run in background (to get around timeout)
nohup sudo -b -u ec2-user -i <<'EOF'

# Declare constants
NAME="skylar_env"
PYTHON=3.9
REPO="swritchie/skylar_toolbox"

# Create environment
conda create -n $NAME python=$PYTHON -y 

# Activate it
conda activate $NAME

# Set conda-forge as default channel for speed and consistency
conda config --add channels conda-forge
conda config --set chanel_priority strict 

# Conda install package(s) for Jupyter
conda install ipykernel -y

# Conda install package(s) for AWS as whole
conda install boto3 -y

# Conda install package(s) for AWS SageMaker
conda install sagemaker-python-sdk -y

# Conda install package(s) for AWS SageMaker local mode
conda install docker-compose pyyaml -y

# Conda install package(s) for AWS S3 
conda install \
    fsspec \
    s3fs \
    -y

# Conda install generic data science package(s)
conda install \
    fastparquet \
    openpyxl \
    pandas \
    scikit-learn \
    seaborn \
    -y
    
# Conda install sepcific data science package(s)
conda install \
    catboost \
    scikit-plot \
    -y

# Conda install package for installing from GitHub, etc.
conda install git -y
    
# Pip install toolbox
pip install git+https://github.com/$REPO.git

# List environment
conda list

EOF
