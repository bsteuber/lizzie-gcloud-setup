#!/usr/bin/env bash
set -eu
curl -LO https://github.com/featurecat/lizzie/releases/download/0.7/Lizzie.0.7.Mac-Linux.zip
rm -rf ./Lizzie
unzip Lizzie.0.7.Mac-Linux.zip
mv Lizzie.0.7.Mac-Linux/Lizzie ./
rm -rf Lizzie.0.7.Mac-Linux.zip Lizzie.0.7.Mac-Linux
cp lizzie_config.txt Lizzie/config.txt
