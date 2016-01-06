if (( LIB_SH__++ == 0 )); then

function extension() {
  # Get the extension of the filename.
  local filename="${1}"
  echo "${filename##*.}"
}
    
fi
