#!/bin/bash

[ "$(ls -A /home/developer/.ivy2)" ] && echo "volume initialized" || mv "/home/developer/.ivy2.tmpl/cache" "/home/developer/.ivy2"
chown -R developer:developer /home/developer/.ivy2

