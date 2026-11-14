#! /usr/bin/env python

assert __name__ == "__main__"

import sys
from macro import Macro, writeFile

tmpl = """\
@node %(name)s
@unnumberedsec %(name)s

%(obsolete)s@majorheading Synopsis

%(synopsis)s

@majorheading Description

%(description)s

%(bugs)s@majorheading Source Code

Download the
@uref{http://git.savannah.gnu.org/gitweb/?p=autoconf-archive.git;a=blob_plain;f=m4/%(name)s.m4,latest
version of @file{%(name)s.m4}} or browse
@uref{http://git.savannah.gnu.org/gitweb/?p=autoconf-archive.git;a=history;f=m4/%(name)s.m4,the
macro's revision history}.

@majorheading License

%(authors)s

%(license)s
"""

def quoteTexi(buf):
  return buf.replace('@', "@@").replace('{', "@{").replace('}', "@}")

def formatParagraph(para):
  assert para
  assert para[0]
  assert para[0][0]
  if para[0][0].isspace():
    return "@smallexample\n%s\n@end smallexample" % quoteTexi('\n'.join(para))
  else:
    return quoteTexi('\n'.join(para))

def formatAuthor(a):
  assert a
  a["year"] = quoteTexi(a["year"])
  a["name"] = quoteTexi(a["name"])
  if "email" in a:
    a["email"] = quoteTexi(a["email"])
    return "Copyright @copyright{} %(year)s %(name)s @email{%(email)s}" % a
  else:
    return "Copyright @copyright{} %(year)s %(name)s" % a

if len(sys.argv) != 3:
  raise Exception("invalid command line syntax: %s" % ' '.join(map(repr, sys.argv)))
(m4File,outFile) = sys.argv[1:]
assert outFile != m4File
m = Macro(m4File)
if m.__dict__.get("obsolete"):
  m.obsolete = '\n\n'.join(map(formatParagraph, m.obsolete))
  m.obsolete = m.obsolete.replace("@end smallexample\n@smallexample", "\n")
  m.obsolete = "@majorheading Obsolete Macro\n\n" + m.obsolete + "\n\n"
else:
  m.obsolete = ""
m.synopsis = "@smallexample\n%s\n@end smallexample" % "\n".join(map(quoteTexi, m.synopsis))
m.description = '\n\n'.join(map(formatParagraph, m.description))
m.description = m.description.replace("@end smallexample\n@smallexample", "\n")
if m.bugs:
  m.bugs = '\n\n'.join(map(formatParagraph, m.bugs))
  m.bugs = m.bugs.replace("@end smallexample\n@smallexample", "\n")
  m.bugs = "@majorheading Bugs\n\n" + m.bugs + "\n\n"
else:
  m.bugs = ""
m.authors = " @* ".join([ "@w{%s}" % formatAuthor(a) for a in m.authors ])
m.license = "\n\n".join(map(formatParagraph, m.license))
writeFile(outFile, tmpl % m.__dict__)
