# [Moreh] Running DDIM on Moreh AI Framework
![](https://badgen.net/badge/Moreh-HAC/passed/green) ![](https://badgen.net/badge/Nvidia-A100/passed/green)

## Prepare

### Data
Data will be downloaded automatically by the program. No preparation needed.

> This repo supports three datasets: cifar10, LSUN (bedroom & church categories)
and CelebA (see in `configs/`). Currently, LSUN and CelebA cannot be downloaded due to their server
side being down. The instructions below only run with cifar10.


### Code
```bash
git clone https://github.com/loctxmoreh/ddim
cd ddim
```

### Environment

#### On A100 VM
Using `a100env.yml` to create a `conda` environment:
```bash
conda create -f a100env.yml
conda activate ddim
```

#### On HAC VM
Using `hacenv.yml` to create a `conda` environment:
```bash
conda create -f hacenv.yml
conda activate ddim
```

After create env by `hacenv.yml`, re-run this command to install `torch` with Moreh:
```bash
conda install -y torchvision torchaudio numpy protobuf==3.13.0 pytorch==1.7.1 cpuonly -c pytorch
```

## Run

### Tuning hyperparameters
With cifar10, edit `configs/cifar10.yml` and change `training.n_epochs` to a
small value for testing

### Training

During training, the program writes running-related data to a separate directory.
From now on, this directory is refered to as the `work_dir`.

First, edit `train.sh` and change `work_dir` to the desired directory.
`work_dir` should have write permission. Then run the training script:

```bash
./train.sh
```

### Sampling images
Edit `sampling.sh` and change `work_dir` to the same one used in training.
Then, run the sampling script:
```bash
./sampling.sh
```

You can either use the local pretrained checkpoints (obtained in the previous
training step), or the pretrained models provided by the authors, to sample new
images. Just edit `sampling.sh` and comment out the irrelevant command.

The generated images are stored in `$work_dir/image_samples`.

## Legacy loading error in experimental `torch==1.10.0+cpuonly.moreh0.2.0`
These are instructions to reproduce legacy loading error.

### Environment
```bash
conda env create -f hacenv2.yml
conda activate ddim
update-moreh --force --driver-only --target 0.2.0
```

### Run
```bash
./sample.py
```
The script will failed when tried to load the downloaded checkpoint stored at
`$HOME/.cache/diffusion_models_converted`.
