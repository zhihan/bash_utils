#!/usr/bin/env bash
#
# A small utility to remove some known generated files.
#

function remove_files() {
  # Remove all files matched by a pattern
  local pattern="$1"
  return $(find . -name ${pattern} | xargs rm)  
}


function main() {
  # Main function
  declare -a temp_pat=(\*~ \*.pyc)
  for pat in ${temp_pat}; do
    $(remove_files "${pat}")
  done
}

main 
