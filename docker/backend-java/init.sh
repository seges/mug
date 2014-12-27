#!/bin/bash

[ "$(ls -A /home/developer/.m2)" ] && echo "volume initialized" || mv "/home/developer/.m2.tmpl/repository" "/home/developer/.m2"
chown -R developer:developer /home/developer/.m2

su - developer
