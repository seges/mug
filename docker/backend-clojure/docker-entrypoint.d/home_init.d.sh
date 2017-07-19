#!/bin/bsh

chown -R developer:developer /home/developer/home-init.d
[ -d "/home/developer/home-init.d" ] && cp -Rpv /home/developer/home-init.d/.* /home/developer/ || echo "No home initialization directory present"

