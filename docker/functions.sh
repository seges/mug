function all_modules {
	local modules="$(find . -maxdepth 1 ! -path . -type d | cut -c -2 --complement)"
	echo "$modules"
}

function usage {
	echo -e "\e[1mUsage:\e[0m"
	echo "$(basename $0) <module>"
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
