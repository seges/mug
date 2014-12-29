#!/bin/bash

workdir=$(dirname $0)

. $workdir/functions.sh

if [ $# -ne 1 ]; then
	echo "Which module do you want to push?"
	echo ""
	usage
	exit 42
fi

modules=$(get_modules $1)

for module in $modules; do
	echo -e "\e[1m**** Tagging and pushing module $module\e[0m"
	docker tag mug-$module seges/mug-$module
	docker push seges/mug-$module
	echo -e "\e[1m**** Finished tagging and pushing module $module\e[0m"
done
