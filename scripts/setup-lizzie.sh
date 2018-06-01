#!/bin/bash
set -eu
curl -LO https://github.com/featurecat/lizzie/releases/download/0.5/Lizzie.0.5.Mac-Linux.zip
unzip Lizzie.0.5.Mac-Linux.zip
cp scripts/leelaz lizzie/
cp lizzie_config.txt lizzie/config.txt
