#!/usr/bin/env bash

OLDDIR=$(pwd)

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$SCRIPTDIR/.."
DIR="$(pwd)"

source ./config.sh

readarray -t <<URLS
run-lizzie
ssh-to-instance
start-instance
stop-instance
update-best-network
URLS

for i in "${MAPFILE[@]}"
do
    alias ${ALIAS_PREFIX}$i='cd $DIR; ./scripts/$i.sh'
done

cd "$OLDDIR"
