#!/bin/bash

#if [ -d /docker-entrypoint.d ]; then
#	for f in /docker-entrypoint.d/*.sh; do
#		[ -f "$f" ] && . "$f"
#	done
#fi

eval $( fixuid )

echo "RUN_SSH=$RUN_SSH"
echo "RUN_IN_FOREGROUND=$RUN_IN_FOREGROUND"

if [ "$RUN_SSH" = "true" ]; then
  sudo /etc/init.d/ssh start
fi

if [ "$RUN_IN_FOREGROUND" = "true" ]; then
  tail -f /dev/null
fi

