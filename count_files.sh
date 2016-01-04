#!/usr/bin/env bash
#
# A small utilty to count the number of files with certain extension.
#

function extension() {
  # Get the extension of the filename.
  local filename="${1}"
  echo "${filename##*.}"
}

function file_length() {
  # Count the lines in the given file.
  local filename="${1}"
  out=$(wc -l ${filename} | cut -f1 -d' ')
  echo "${out}"
}

function main() {
  declare -A counts
  declare -A line_counts
  local ext=''

  for file in "$@"
  do
    if [[ -f "${file}" ]]; then
      ext=$(extension ${file})
      declare -i n=$(file_length ${file})
      if [[ -z "${counts[$ext]+tested}" ]]; then
        let counts["$ext"]=1
        let line_counts["$ext"]=$n
      else
        let counts["$ext"]=${counts["$ext"]}+1
        let line_counts["$ext"]=${line_counts["$ext"]}+$n
      fi
    fi 
  done

  for ext in "${!counts[@]}"
  do
    echo "${ext}: ${counts[$ext]} file(s), ${line_counts[$ext]} lines."
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
