#!/bin/bash

workdir=$(dirname $0)

. $workdir/functions.sh

if [ $# -ne 1 ]; then
	echo "Which module do you want to build?"
	echo ""
	usage
	exit 42
fi

modules=$(get_modules $1)

for module in $modules; do
	echo -e "\e[1m**** Building module $module\e[0m"
	docker build --rm -t seges/mug-$module $module
	echo -e "\e[1m**** Finished building module $module\e[0m"
done
