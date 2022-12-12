#!/bin/bash

set -e

work_dir="/data/work/ddim"

# set up cachedir to download pretrained models
export XDG_CACHE_HOME=$HOME/.cache

# use pretrained models provided by authors
/usr/bin/env python main.py \
        --config cifar10.yml \
        --doc ddim --sample --fid --timesteps 10 --eta 0.1 \
        --exp $work_dir \
        --use_pretrained \
        --ni

# use local pretrained checkpoints
[[ ! -f $work_dir/logs/ddim/ckpt.pth ]] \
    && echo "No checkpoint found in $work_dir" && exit 1

/usr/bin/env python main.py \
        --config cifar10.yml \
        --exp $work_dir \
        --doc ddim --sample --fid --timesteps 10 --eta 0.1 \
        --ni
