#!/bin/bash
set -eu
curl -LO https://github.com/featurecat/lizzie/releases/download/0.5/Lizzie.0.5.Mac-Linux.zip
rm -rf ./lizzie
unzip Lizzie.0.5.Mac-Linux.zip
cp lizzie_config.txt lizzie/config.txt
curl -LO https://github.com/bsteuber/lizzie-gcloud-setup/releases/download/0.6-SNAPSHOT/Lizzie.jar
cp Lizzie.jar lizzie
