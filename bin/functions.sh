#!/bin/bash

function resolve_mugrc
{
  [ -f $HOME/.mugrc ] && . $HOME/.mugrc && echo "mug local config read"

  local cwd=`pwd`
  local _ret=""

  while [ "$cwd" != "/" ] ; do 
    _ret=$(find "$cwd" -maxdepth 1 -name ".mugrc")
    if [ ! "$_ret" == "" ]; then
      . $_ret
      break
    fi
    cwd=`dirname "$cwd"`
  done

}

