#! /bin/bash

set -eu
shopt -s nullglob

cd "doc/manual/html_node"
destdir="../html"

rm -rf "$destdir"
mkdir -p "$destdir"

for n in *.html; do
  echo fixing "$n"
  sed <"$n" >"$destdir/${n//_005f/_}" \
    -e 's|_005f|_|g' \
    -e 's|href="../index.html#dir">(dir)</a>|href="http://savannah.nongnu.org/projects/autoconf-archive/">Home Page at Savannah</a>|g'
done
