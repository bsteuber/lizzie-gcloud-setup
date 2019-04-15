#!/usr/bin/env bash
set -eu
./scripts/start-instance.sh

cd Lizzie
java -jar lizzie.jar

cd ..
echo "Stopping instance in a few seconds; hit Ctrl-C to keep it running"
sleep 20
./scripts/stop-instance.sh
