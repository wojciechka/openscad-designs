#!/bin/bash

set -eu -o pipefail

readonly openscad_command="${OPENSCAD_COMMAND:-openscad}"

generateStlFile() {
  local src="${1:?Source file required}"
  local dest="${2:?Dest file required}"

  ${openscad_command} -o "${dest}" "${src}"
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

  echo "Generating STL files..."

  # TODO: support handling filenames with spaces
  for src in $(find . -name '*.scad') ; do
    dest="${src%.scad}.stl"
    if newerThan "${src}" "${dest}" ; then
      echo "  Generating STL file ${dest} ..."
      generateStlFile "${src}" "${dest}"
    fi
  done
}

main "$@"
