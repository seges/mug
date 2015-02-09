#!/bin/bash


chown -R developer:developer /home/developer/m2-init.d
[ -d "/home/developer/m2-init.d" ] && cp -Rpv /home/developer/m2-init.d/.* /home/developer/.m2 || echo "No m2 initialization directory present"

[ "$(ls -A /home/developer/.m2)" ] && echo "volume initialized" || mv "/home/developer/.m2.tmpl/repository" "/home/developer/.m2"
chown -R developer:developer /home/developer/.m2

