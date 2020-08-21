function all_modules {
	local modules="$(find . -maxdepth 1 ! -path . -type d | cut -c -2 --complement)"
	echo "$modules"
}

function usage {
	echo -e "\e[1mUsage:\e[0m"
	echo "$(basename $0) <module> [<version>]"
	echo ""
	echo -e "\e[1mAvailable modules:\e[0m"
	local modules=$(all_modules)
	echo -e "\e[31mall\e[0m"
	echo "$modules"
}

function get_modules {
	local modules=""
	if [ "$1" == "all" ]; then
		modules=$(all_modules)
	else
		modules=$1
	fi

	echo "$modules"
}

function get_version {
	module=$1
	potential_version=$2

	if [ "$module" == "all" ]; then
		echo "Not implemented"
		exit 42
	fi
	
	if [ "$potential_version" == "" ]; then
		echo "Please specify version of the module to be built"
		echo ""
		usage
		exit 42
	fi
	echo "$potential_version"
}
