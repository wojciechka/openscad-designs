#!/bin/bash

set -eu -o pipefail

readonly openscad_command="${OPENSCAD_COMMAND:-openscad}"
readonly convert_command="${CONVERT_COMMAND:-convert}"

generateStlFile() {
  local src="${1:?Source file required}"
  local dest="${2:?Dest file required}"

  local dir="$(dirname "${src}")"

  local width=1280
  local height=720

  local args=""

  if [ -f "${dest}.args" ] ; then
    args="$(cat "${dest}.args")"
  elif [ -f "${dir}/.png.args" ] ; then
    args="$(cat "${dir}/.png.args")"
  else
    args=""
  fi

  # append arguments to the command
  ${openscad_command} -o "${dest}" "${src}" --imgsize "$(expr ${width} '*' 4),$(expr ${height} '*' 4)" ${args}

  rm -f "${dest}.tmp.png"
  cp "${dest}" "${dest}.tmp.png"
  ${convert_command} "${dest}.tmp.png" -resize "${width}x${height}" "${dest}"

  rm -f "${dest}.tmp.png"
}

newerThan() {
  local src="${1:?Source file required}"
  local dest="${2:?Dest file required}"

  if [ ! -f "${dest}" ] ; then
    return 0
  fi

  local srcMtime="$(stat "${src}" -c%Y)"
  local destMtime="$(stat "${dest}" -c%Y)"

  if [ "${srcMtime}" -gt "${destMtime}" ] ; then
    return 0
  fi

  return 1
}

main() {
  local src
  local dest

  echo "Generating PNG files..."

  # TODO: support handling filenames with spaces
  for src in $(find "." -name '*.scad') ; do
    dest="${src%.scad}.png"
    if newerThan "${src}" "${dest}" ; then
      echo "  Generating PNG file ${dest} ..."
      generateStlFile "${src}" "${dest}"
    fi
  done
}

main "$@"
