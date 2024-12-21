#!/usr/bin/env bash

# exit on failure
set -euo pipefail

# go home
cd ~

# generate random deployment dir name (prevents race conditions)
function get_deployment_dir {
	DEPLOYMENT_DIR=deploy_$(date +%s)_$RANDOM
}
while
	get_deployment_dir
	[[ -d "$DEPLOYMENT_DIR" ]]
do true; done

# clone git 
git clone --depth 1 "$1" $DEPLOYMENT_DIR

cd $DEPLOYMENT_DIR

./deploy.sh

cd ..

rm -rf $DEPLOYMENT_DIR
