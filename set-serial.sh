#! /bin/bash

set -eu

set-serial-number()
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
  revision=$(git log --oneline -- "$n" | wc -l)
  # Update the serial number in the m4 file.
  set-serial-number "$n" "$revision"
  # Check whether git regards the file as "modified" now. If it does,
  # the serial nmuber needs to be bumped one more time.
  if git >/dev/null status -- "$n"; then
    set-serial-number "$n" "$((revision + 1))"
  fi
done
