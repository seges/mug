#!/bin/bash

workdir=$(dirname $0)

. $workdir/functions.sh

if [ $# -lt 1 ]; then
	echo "Which module do you want to build?"
	echo ""
	usage
	exit 42
fi

modules=$(get_modules $1)

for module in $modules; do
	version=$(get_version $module $2)
	[ $? -gt 0 ] && echo $version && exit 42
	
	echo -e "\e[1m**** Building module $module:$version\e[0m"
	
	if [ "$version" == "" ]; then
		docker build --rm -t seges/mug-$module $module
	else
		cp $module/Dockerfile.$version $module/Dockerfile
		docker build --rm -t seges/mug-$module:$version $module
	fi

	if [ -f $module/Dockerfile.$version ]; then
		rm $module/Dockerfile
	fi

	echo -e "\e[1m**** Finished building module $module\e[0m"
done
