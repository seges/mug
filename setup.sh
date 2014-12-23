#!/bin/bash

cd /usr/local
if [ -x /usr/local/mug ]; then
	cd mug
	git pull
else
	git clone https://github.com/seges/mug.git
fi

[ ! -x /usr/local/bin/mug ] && ln -s /usr/local/mug/bin/mug /usr/local/bin/mug || echo "mug already linked"
