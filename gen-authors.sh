#! /usr/bin/env bash

set -eu

trap 'rm -f AUTHORS-m4.tmp AUTHORS-git.tmp' 0

sed -n -e 's/# *Copyright (c) [0-9,-]* *//p' m4/*.m4 >AUTHORS-m4.tmp
git log | sed -n -e 's/^Author: *//p' >AUTHORS-git.tmp

echo '# Copyright (c) 2018 Autoconf Archive Maintainers <autoconf-archive-maintainers@gnu.org>'
echo '#'
echo '# Copying and distribution of this file, with or without modification, are'
echo '# permitted in any medium without royalty provided the copyright notice and this'
echo '# notice are preserved. This file is offered as-is, without any warranty.'
echo ''

cat AUTHORS-m4.tmp AUTHORS-git.tmp \
  | sed -e 's/ *<.*>.*//' \
        -e 's/^2015 //' \
        -e 's/^Bogdan$/Bogdan Drozdowski/' \
        -e 's/Fabien COELHO/Fabien Coelho/' \
        -e 's/Dustin Mitchell/Dustin J. Mitchell/' \
        -e 's/Alain BARBET/Alain Barbet/' \
        -e 's/Mats Kindahl of Sun Microsystems/Mats Kindahl/' \
        -e 's/Perceval ANICHINI/Perceval Anichini/' \
        -e 's/Rafa Rzepecki/Rafal Rzepecki/' \
        -e 's/Diego Elio Pettenò/Diego Elio Petteno`/' \
        -e 's/Václav Haisman/Vaclav Haisman/' \
        -e 's/Cristian Rodríguez/Cristian Rodriguez/' \
        -e 's/Mikael Lepistö/Mikael Lepisto/' \
        -e '/Zmanda Inc./d' \
        -e 's/Daniel Richard G$/Daniel Richard G./' \
        -e 's/Avionic Design GmbH$/Thierry Reding/' \
        -e 's/Bastien Roucaries/Bastien Roucariès/' \
        -e 's/Bastien ROUCARIES/Bastien Roucariès/' \
        -e 's/Bastien ROUCARIÈS/Bastien Roucariès/' \
        -e 's/Bastien Roucariès .*/Bastien Roucariès/' \
        -e 's/Daniel Mullner/Daniel Müllner/' \
        -e 's/Daniel M"ullner/Daniel Müllner/' \
        -e 's/Karlson2k (Evgeny Grin)/Evgeny Grin/' \
  | sort \
  | uniq
