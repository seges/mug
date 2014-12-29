function usage {
	echo -e "\e[1mUsage:\e[0m"
	echo "$(basename $0) <module>"
	echo ""
	echo -e "\e[1mAvailable modules:\e[0m"
	echo "$(find . -maxdepth 1 ! -path . -type d | cut -c -2 --complement)"
}

