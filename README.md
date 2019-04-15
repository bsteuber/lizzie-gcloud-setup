# Lizzie remote setup for google compute

## Introduction

Since I don't own a high-end graphics card, I have found Google Compute to be a nice alternative for analyzing Go games with https://github.com/gcp/leela-zero/ and https://github.com/featurecat/lizzie .

This setup should work for macOS and Linux.

## Costs

On Google Compute, you pay precisely by the amount of seconds your instance is running. There is also some overhead for disk storage, traffic etc, but I think that's almost neglectible compared to the GPU costs. See https://cloud.google.com/compute/pricing#gpus (the preemptible price) for a detailed listing. So for the default setup using a V100, in my region it currently would be $0.74/h.

Remember that the disk costs will continue even if you don't use Lizzie at all. So if you stop using it altogether, please remember deleting the instance and hard disk!

## Warning/Disclaimer

If somehow the instance keeps running without your knowledge it can get very expensive. So after installation and each time after using Lizzie, please visit https://console.cloud.google.com/compute/instances and stop your instance if it isn't being stopped already (the stopping might take a few minutes, but if it prints "stopping" you should be fine).

The `run-lizzie.sh` script should automatically stop the instance after you close the Lizzie window (but check for yourself!), after the installation I don't stop it for you (because you likely wanna try it out anyways).

Be careful, I will take no responsibility for any costs arising from using this setup. Nor can I guarantee that it really works for you, too.

Also, this guide assumes you have some experience with Unix - if you are person without any IT knowledge, please ask someone else to do this for you :)

## Installation Guide

### Requirements

- macOS or Linux
- A Google account
- A credit card or other suitable Google payment method
- Python 2 for gcloud command line tools
- Java for Lizzie

### Choosing a GPU

Currently, Google offers three different types of GPU, ordered by price: Tesla K80, P100, and V100. Leela Zero 0.17 supports tensor cores, so a V100 - which does have tensor cores - is the best GPU to use. This requires Ubuntu 18.04 and CUDA 10 and Nvidia drivers version 413 or better. See https://cloud.google.com/compute/pricing#gpus for prices.

### Chosing a Zone

That part is easier; just visit https://cloud.google.com/compute/docs/gpus/#introduction and pick the closest zone which has the GPU you want to use.

### Set up a Google Compute project

Visit https://cloud.google.com/, log in, create a project and register a payment method when you are asked.

### Enable GPU usage for you project

- Visit https://console.cloud.google.com/iam-admin/quotas
- Click on the selector under "metrics", click "none", enter "nvidia" in the search box, click on the one you decided on.
- In the list, select the one from the region you decided on, then click "edit quotas".
- Fill in the form on the right, probably one gpu will suffice for you. You can enter any reason you seem fit, not sure if Google checks it (but why not be honest?). Submit the request.
- Wait until you get a mail about your quota having been accepted. This might take a day or so.

### Set up gcloud command line tools

See https://cloud.google.com/sdk/docs/#install_the_latest_cloud_tools_version_cloudsdk_current_version

### Edit config.sh

You need to set the GPU and Zone you chose above. Also decide on a number of CPUs (not sure what is best, the cost very little compared to the GPU).

You can also choose if you want to run the best leela-zero network or the converted Facebook ELF v2 OpenGo one.

### Setup

#### Create an instance

```./scripts/create-instance.sh```

After, it might take a few seconds before the instance is running and can be set up.

#### Set up an existing instance

```./scripts/setup-instance.sh```

#### Install Lizzie

```./scripts/setup-lizzie.sh```

### Verify

To make sure that Leela Zero uses the tensor cores, ssh to the instance and do

```
gcloud compute ssh "leelazero-v100" --zone "europe-west4-a"
cd /leela
./leelaz -w best-network.gz
```

Look for:

    Selected platform: NVIDIA CUDA
    Selected device: Tesla V100-SXM2-16GB
    with OpenCL 1.2 capability.
    Half precision compute support: No.
    Tensor Core support: Yes.

### Running

```./scripts/run-lizzie.sh```

### Lizzie Configuration

After installation, you can change the config.txt file in the Lizzie folder however you like. There's a README.txt file with details in that folder, too.

### Shell Aliases

Normally, to run the scripts, you have to `cd` to the directory above `scripts` because the scripts read the config.sh that is also in this directory. As a convenience, there is a script that defines aliases for common scripts will do this for you. You have to defined an `ALIAS_PREFIX` in the `config.sh` file.

Then, in your `.bashrc`, you can do

```source /path/to/scripts/print-aliases.sh```

Then, assuming your prefix was `v100-`, you can just use the following command from any directory to run Lizzie remotely:

```v100-run-lizzie```

### License

Do whatever you want with these scripts. Of course there are other licenses for all software being used here.
