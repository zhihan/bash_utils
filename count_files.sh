#!/usr/bin/env bash
#
# A small utilty to count the number of files with certain extension.
#

current_dir=$(dirname $0)
source "${current_dir}/lib.sh" || exit 1

function file_length() {
  # Count the lines in the given file.
  local filename="${1}"
  out=$(wc -l ${filename} | sed -e 's/^[ ]*//' | cut -f1 -d' ')
  echo "${out}"
}

function main() {
  declare -A counts
  declare -A line_counts

  declare -A known_types
  known_types[py]="Python source"
  known_types[sh]="Bash script"
  known_types[md]="Markdown file"
  known_types[java]="Java source"
  known_types[groovy]="Groovy source"
  known_types[scala]="Scala source"
  known_types[m]="Matlab source"
  
  local ext=''

  for file in "$@"
  do
    if [[ -f "${file}" ]]; then
      ext=$(extension ${file})
      if [[ ! -z "${known_types[$ext]}" ]]; then  
        declare -i n=$(file_length ${file})
        if [[ -z "${counts[$ext]+tested}" ]]; then
          let counts["$ext"]=1
          let line_counts["$ext"]=$n
        else
          let counts["$ext"]=${counts["$ext"]}+1
          let line_counts["$ext"]=${line_counts["$ext"]}+$n
        fi
      fi
    fi 
  done

  for ext in "${!counts[@]}"
  do
    echo -e "\033[32m${known_types[$ext]}:\033[m"
    echo "${counts[$ext]} file(s), ${line_counts[$ext]} lines."
  done
}

if (($# > 0)); then
  # If a list of files is given, use it to count files.
  main $@
else
  # Default option
  # Invoke the find command to list all files in
    files=$(find . \
                 -not -path "*.git/*" \
                 -not -path "*/target/*") 
  main $files
fi
