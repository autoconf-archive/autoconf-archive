#! /usr/bin/env bash

set -eu

set_serial_number()
{
  sed >"$1.tmp" -e '/^$/q' "$1"
  echo >>"$1.tmp" "#serial $2"
  echo >>"$1.tmp" ""
  sed >>"$1.tmp" -e '1,/^$/d' -e '/^#serial .*/,+1d' "$1"
  mv "$1.tmp" "$1"
}

for n in "$@"; do
  echo "$n ... "
  # Determine the number of revisions that have occurred to the macro.
  revision=$(git log --oneline 054e8ad8c766afa7059d8cd4a81bbfa99133ef5e..HEAD -- "$n" | wc -l)
  # Check whether git regards the file as "modified" now. If it does,
  # the serial number needs to be bumped one more time.
  if ! git diff --quiet --exit-code HEAD -- "$n"; then
    revision="$((revision + 1))"
  fi
  # Update the serial number in the m4 file.
  set_serial_number "$n" "$revision"
done
