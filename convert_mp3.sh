#!/usr/bin/env bash
#
# A small utility to convert mp3
#

current_dir=$(dirname $0)
source "${current_dir}/lib.sh" || exit 1

function main() {
    for file in $@; do
        local base_file=$(remove_extension "$file")
        local mp3_file="$base_file.mp3"
        ffmpeg -i ${file} -acodec libmp3lame -ab 160k ${mp3_file}
    done
}

main $@
