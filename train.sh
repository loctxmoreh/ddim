#!/bin/bash

work_dir='/data/work/ddim'
mkdir -p $work_dir

/usr/bin/env python main.py \
        --config cifar10.yml \
        --exp $work_dir \
        --doc ddim \
        --ni
