#!/usr/bin/env bash
#
# A small utility to remove some known generated files.
#

function remove_files() {
  # Remove all files matched by a pattern
  local pattern="$1"
  files=( $(find . -name ${pattern}) )
  echo "${pattern}: ${files}"
  if [[ ! -z "${files}" ]]; then
      for f in ${files[*]}; do
	  rm -rf "$f"
      done
  fi
}


function main() {
  # Main function
  declare -a temp_pat=(\*~ \*.pyc)
  for pat in ${temp_pat[*]}; do
      (remove_files "${pat}")
  done
}

main 
