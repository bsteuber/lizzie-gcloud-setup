#!/usr/bin/env bash
set -eu
curl -LO https://github.com/featurecat/lizzie/releases/download/0.6/Lizzie.0.6.Mac-Linux.zip
rm -rf ./lizzie
unzip Lizzie.0.6.Mac-Linux.zip
rm -f Lizzie.0.6.Mac-Linux.zip
cp lizzie_config.txt Lizzie/config.txt
