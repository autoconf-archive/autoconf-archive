#! /bin/bash

set -eu
shopt -s nullglob

cd "doc/manual/html_node"
destdir="../html"

rm -rf "$destdir"
mkdir -p "$destdir"

for n in *.html; do
  echo fixing "$n"
  case "$n" in
    index.html)
      m="autoconf-archive.html"
      ;;
    *)
      m="${n//_005f/_}"
      ;;
  esac
  sed <"$n" >"$destdir/$m" \
    -e 's|_005f|_|g' \
    -e 's|href="index.html|href="autoconf-archive.html|g' \
    -e 's|href="../index.html|href="index.html|g'
done
