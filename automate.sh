#!/usr/bin/env bash

# Currently working on HAC only

set -e

config_file="cifar10.yml"
work_dir="/data/work/ddim"
env_file="hacenv.yml"

mkdir -p $work_dir

env_name=$(grep name: $env_file | awk '{print $NF}')
conda env create -f $env_file
conda run -n $env_name update-moreh --force
#conda run -n $env_name update-moreh --force --driver-only --target 0.2.0

n_epochs=$(grep n_epochs configs/$config_file | awk '{print $NF}')
[[ $n_epochs -gt 10 ]] && echo "N_epoch $n_epochs too large. Abort" && exit 1

conda run -n $env_name python3 main.py \
    --config $config_file \
    --exp $work_dir \
    --doc ddim \
    --ni

# TODO: copy running logs from work dir to current dir, with time annotation

export XDG_CACHE_HOME=$HOME/.cache

# clear previousliy generated images before sampling new images
[[ -d $work_dir/image_samples ]] && rm -rf $work_dir/image_samples
conda run -n $env_name python3 main.py \
    --config $config_file \
    --doc ddim --sample --fid --timesteps 10 --eta 0.1 \
    --exp $work_dir \
    --use_pretrained \
    --ni

# clear previousliy generated images before sampling new images
[[ -d $work_dir/image_samples ]] && rm -rf $work_dir/image_samples
conda run -n $env_name python3 main.py \
    --config $config_file \
    --exp $work_dir \
    --doc ddim --sample --fid --timesteps 10 --eta 0.1 \
    --ni

conda env remove -n $env_name
rm -rf $XDG_CACHE_HOME/diffusion_models_converted
