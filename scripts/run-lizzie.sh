#!/usr/bin/env bash
set -eu
./scripts/start-instance.sh
cd lizzie
java -jar Lizzie.jar
cd ..
#./scripts/stop-instance.sh
