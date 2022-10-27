#!/bin/bash

set -e

work_dir="/data/work/ddim"
[[ ! -d $work_dir ]] && echo "The directory ${work_dir} not found" && exit 1

# set up cachedir to download pretrained models
export XDG_CACHE_HOME=$HOME/.cache

# use pretrained models provided by authors
/usr/bin/env python main.py \
        --config cifar10.yml \
        --doc ddim --sample --fid --timesteps 10 --eta 0.1 \
        --exp /data/work/ddim \
        --use_pretrained \
        --ni

# use local pretrained checkpoints
# /usr/bin/env python main.py \
#         --config cifar10.yml \
#         --exp /data/work/ddim \
#         --doc ddim --sample --fid --timesteps 10 --eta 0.1 \
#         --ni
