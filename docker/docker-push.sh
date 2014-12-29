#!/bin/bash

workdir=$(dirname $0)

. $workdir/functions.sh

if [ $# -ne 1 ]; then
	echo "Which module do you want to push?"
	echo ""
	usage
	exit 42
fi

module=$1
docker tag mug-$module seges/mug-$module
docker push seges/mug-$module
