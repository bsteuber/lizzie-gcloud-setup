#!/usr/bin/env bash
set -eu
./scripts/create-instance.sh

echo Add your private SSH key to the instance and press Return.
read

./scripts/setup-instance.sh
./scripts/setup-lizzie.sh
