#! /usr/bin/env python

assert __name__ == "__main__"

import sys
from macro import Macro, writeFile

tmpl = """\
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
 <head>
  <title>
   Autoconf Macro: %(name)s
  </title>
  <link rel="stylesheet" type="text/css" href="autoconf-archive.css">
  <meta http-equiv="Content-Type" content="text/html; charset=us-ascii">
 </head>
 <body>
  <table summary="web navigation" style="width:100%%;">
   <tbody>
    <tr>
     <td style="width:33%%;" align="center" valign="top">
      <a href="index.html">Autoconf Archive</a>
     </td>
     <td style="width:33%%;" align="center" valign="top">
      <a href="macros-by-category.html">Macros by Category</a>
     </td>
     <td style="width:33%%;" align="center" valign="top">
      <form method="get" action="http://www.google.com/search">
       <div>
        <input name="sitesearch" value="www.nongnu.org/autoconf-archive/" type=
        "hidden">Search: <input name="q" maxlength="255" type="text">
       </div>
      </form>
     </td>
    </tr>
   </tbody>
  </table>
  <hr>
  <h1>
   %(name)s
  </h1>
%(obsolete)s
  <h2>
   SYNOPSIS
  </h2>
   <p style="white-space:nowrap;">
%(synopsis)s
  </p>
  <h2>
   DESCRIPTION
  </h2>
  <div>
%(description)s
  </div>
  <h2>
   SOURCE CODE
  </h2>
  <p>
   Download <a href=
   "http://git.savannah.gnu.org/gitweb/?p=autoconf-archive.git;a=blob_plain;f=m4/%(name)s.m4">
   %(name)s.m4</a> or browse the <a href=
   "http://git.savannah.gnu.org/gitweb/?p=autoconf-archive.git;a=history;f=m4/%(name)s.m4">
   revision history</a>.
  </p>
  <h2>
   LICENSE
  </h2>
   <p style="white-space:nowrap;">
%(authors)s
   </p>
%(license)s
 </body>
</html>
"""

def quoteHtml(buf):
  return buf.replace('&', "&amp;").replace('<', "&lt;").replace('>', "&gt;")

def formatParagraph(para):
  assert para
  assert para[0]
  assert para[0][0]
  if para[0][0].isspace():
    return "<pre>%s</pre>" % quoteHtml('\n'.join(para))
  else:
    return "<p>%s</p>" % quoteHtml('\n'.join(para))

def formatAuthor(a):
  assert a
  a["year"] = quoteHtml(a["year"])
  a["name"] = quoteHtml(a["name"])
  if "email" in a:
    a["email"] = quoteHtml(a["email"])
    return "Copyright &copy; %(year)s %(name)s &lt;%(email)s&gt;" % a
  else:
    return "Copyright &copy; %(year)s %(name)s" % a

if len(sys.argv) != 3:
  raise Exception("invalid command line syntax: %s" % ' '.join(map(repr, sys.argv)))
(m4File,outFile) = sys.argv[1:]
assert outFile != m4File
m = Macro(m4File)
if m.__dict__.get("obsolete"):
  m.obsolete = "<h2>Obsolete Macro</h2>" + '\n'.join(map(formatParagraph, m.obsolete))
else:
  m.obsolete = ""
m.synopsis = "<br>\n".join([ "<code>%s</code>" % quoteHtml(l) for l in m.synopsis ])
m.description = '\n\n'.join(map(formatParagraph, m.description))
m.description = m.description.replace("</pre>\n\n<pre>", "\n\n")
m.authors = "<br>\n".join(map(formatAuthor, m.authors))
m.license = '\n'.join(map(formatParagraph, m.license))
writeFile(outFile, tmpl % m.__dict__)
