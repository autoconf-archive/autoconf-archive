#! /bin/bash

set -eu
shopt -s nullglob

cd "doc/manual/html_node"
destdir="../html"

rm -rf "$destdir"
mkdir -p "$destdir"

for n in *.html; do
  echo fixing "$n"
  out="${n//_005f/_}"
  name="${out%%.html}"
  sed <"$n" \
    -e 's|<html lang="en">|<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN" "http://www.w3.org/TR/html4/strict.dtd"><html lang="en">|' \
    -e "s|<a name=\"${name}\"></a>||" \
    -e 's|_005f|_|g' \
    -e 's|href="../index.html#dir">(dir)</a>|href="http://savannah.nongnu.org/projects/autoconf-archive/">Home Page at Savannah</a>|g' \
  | tidy >"$destdir/${out}" -q --indent yes --indent-spaces 1 -wrap 80 --tidy-mark no --hide-comments yes
done
