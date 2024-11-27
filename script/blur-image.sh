#!/usr/bin/env bash

set -o nounset
set -o errexit

blur-image() {
  if [[ $# != 2 ]]; then
    echo -e "Usage:\n$ ${FUNCNAME[0]} <input> <output>"
    exit 1
  fi

  input=$1
  output=$2

  magick $input -blur "50x30" $output
}

blur-image "$@"
