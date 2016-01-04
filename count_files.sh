#!/usr/bin/env bash
#
# A small utilty to count the number of files with certain extension.
#

function extension() {
  local filename="${1}"
  echo "${filename##*.}"
}


function main() {
  declare -A counts
  local ext=''

  for file in "$@"
  do
    if [[ -f "${file}" ]]; then
      ext="$(extension ${file})"
      if [[ -z "${counts[$ext]+tested}" ]]; then
        let counts["$ext"]=1
      else
        let counts["$ext"]=${counts["$ext"]}+1
      fi
    fi 
  done

  for ext in "${!counts[@]}"
  do
    echo "${ext}: ${counts[$ext]}"
  done
}

if (($# > 0)); then
  # If a list of files is given, use it to count files.
  main $@
else
  # Default option
  # Invoke the find command to list all files in
  files=$(find . -not -path "./.git/*") 
  main $files
fi
