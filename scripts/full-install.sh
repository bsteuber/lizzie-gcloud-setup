#!/bin/bash
set -eu
./scripts/create-instance.sh
./scripts/setup-instance.sh
./scripts/setup-lizzie.sh
