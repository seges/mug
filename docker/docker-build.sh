#!/bin/bash

workdir=$(dirname $0)

. $workdir/functions.sh

if [ $# -ne 1 ]; then
	echo "Which module do you want to build?"
	echo ""
	usage
	exit 42
fi

module=$1
docker build --rm -t seges/mug-$module $module
