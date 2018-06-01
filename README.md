# Lizzie remote setup for google compute

## Introduction

Since I don't own a high-end graphics card, I have found google compute to be a nice alternative for analyzing Go games with https://github.com/gcp/leela-zero/ and https://github.com/featurecat/lizzie

This setup should work for Linux and OS X - sorry Windows-Users :(

## Costs

On Google Compute, you pay precisely by the amount of seconds your instance is running. There is also some overhead for Disk storage, traffic etc, but I think that's almost neglectible compared to the GPU costs. See https://cloud.google.com/compute/pricing#gpus (the preemptible price) for a detailed listing. So for the default setup using a P100, in my region it currently would be 0.73USD/h

Remember that the disk costs will continue even if you don't use Lizzie at all. So if you stop using it altogether, please remember deleting the instance and hard disk!

## Warning/Disclaimer

If somehow the instance keeps running without your knowlwedge, it can get very expensive. So after installation and each time after using lizzie, please visit https://console.cloud.google.com/compute/instances and stop your instance if it isn't being stopped already (the stopping might take a few minutes, but if it prints "stopping" you should be fine).

The run-lizzie.sh script should automatically stop the instance after you close the Lizzie window (but check for yourself!), after the installation I don't stop it for you (because you likely wanna try it out anyways).

Be careful, I will take no responsibility for any costs arising from using this setup. Nor can I guarantee that it really works for you, too.

Also, this guide assumes you have some experience with linux etc. - if you are person without any IT knowledge, please ask someone else to do this for you :)

## Installation Guide

### Requirements

- OS X or Linux
- A Google account
- A credit card or other suitable Google payment method
- Python 2 for gcloud command line tools
- Java for Lizzie

### Choosing a GPU

Currently, Google offers three different types of GPU, ordered by price: Tesla K80, P100, and V100. For me the P100 seems to have the best performance/cost ratio (achieving 1.5k n/s using the best-network.gz), but you can chose whatever you feel is best. See https://cloud.google.com/compute/pricing#gpus for prices, as well as https://browser.geekbench.com/cuda-benchmarks for a benchmark. Weirdly though, the V100 doesn't perform better than the P100 at all for me, not sure why that happens.

### Chosing a Zone

That part is easier, just visit https://cloud.google.com/compute/docs/gpus/#introduction and pick the closest zone which has the gpu you want to use.

### Set up a Google Compute project

Visit https://cloud.google.com/, log in, create a project, register a payment method when you are asked.

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

You can also chose if you want to run the best leela-zero network or the converted Facebook ELF OpenGo one.

### Setup

```./scripts/full-install.sh```

### Running

```./scripts/run-lizzie.sh```

### Lizzie Configuration

After installation, you can change the config.txt file in the lizzie folder however you like. There's a readme.txt file with details in that folder, too.

### Upgrading from previous versions

Since the leela-zero repo and branch as well as the lizzie-repo have changed, the easiest way is deleting your gcloud instance and lizzie folder, then pulling and doing a full install again. You could also manually delete the leela-zero folder on the machine and run the clone and build commands from the remote/setup script as well as the setup-lizzie.sh.

### Contributing

I might need help with:
- Windows support (or a manual for using Windows-Ubuntu maybe?)
- Benchmarks for the different setups. I have no idea what number of CPUS and how much RAM (I currently just use the default for the CPU count) is best for each GPU type, of whether it's more efficent to use e.g. four K80 vs one V100.
- Updates if new CUDA, leela-zero, lizzie versions come out.
- Maybe support for Ubuntu 18 instead of 16?

### License

Do whatever you want with these scripts. Of course there are other licenses for all software being used here.
