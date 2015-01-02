#!/bin/bash

if [ -d /docker-entrypoint-initdb.d ]; then
	for f in /docker-entrypoint-initdb.d/*.sh; do
		[ -f "$f" ] && . "$f"
	done
fi

su - developer
