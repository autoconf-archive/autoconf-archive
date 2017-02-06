#! /usr/bin/env python

assert __name__ == "__main__"

import sys
from macro import Macro, writeFile

tmpl = """\
%(url)s
#
%(obsolete)s# SYNOPSIS
#
%(synopsis)s
#
# DESCRIPTION
#
%(description)s
#
# LICENSE
#
%(authors)s
#
%(license)s

#serial %(serial)d

%(body)s
"""

def formatParagraph(para):
  assert para
  assert para[0]
  assert para[0][0]
  if para[0][0].isspace():
    return "#   " + "\n#   ".join(para)
  else:
    return "#   " + "\n#   ".join(para)

def formatAuthor(a):
  assert a
  if "email" in a:
    return "#   Copyright (c) %(year)s %(name)s <%(email)s>" % a
  else:
    return "#   Copyright (c) %(year)s %(name)s" % a

def countSpaces(line):
  for i in range(len(line)):
    if not line[i].isspace():
      break
  return i

if len(sys.argv) != 3:
  raise Exception("invalid command line syntax: %s" % ' '.join(map(repr, sys.argv)))
(m4File,outFile) = sys.argv[1:]
assert outFile != m4File
m = Macro(m4File, computeSerialNumber=True)
for i in range(len(m.description)):
  para = m.description[i]
  if para[0][0].isspace():
    spaces = min(list(map(countSpaces, para)))
    if spaces > 1:
      m.description[i] = ['  ' + l[spaces:] for l in para]
url = "https://www.gnu.org/software/autoconf-archive/%s.html" % m.name
lineLen = max(len(url) + 2, 75)
m.url = "# %s\n# %s\n# %s" % ('=' * lineLen, (' ' * int((lineLen - len(url)) / 2)) + url, '=' * lineLen)
if m.__dict__.get("obsolete"):
  m.obsolete = "# OBSOLETE MACRO\n#\n" + '\n#\n'.join(map(formatParagraph, m.obsolete)) + "\n#\n"
else:
  m.obsolete = ""
m.synopsis = "\n".join([ "#   %s" % l for l in m.synopsis ])
m.description = '\n#\n'.join(map(formatParagraph, m.description))
m.authors = "\n".join(map(formatAuthor, m.authors))
m.license = '\n#\n'.join(map(formatParagraph, m.license))
m.body = '\n'.join(m.body)

writeFile(outFile, tmpl % m.__dict__)
