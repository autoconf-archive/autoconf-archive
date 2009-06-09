from SCons.Script import *
import os.path as path
from macro import Macro, writeFile
from stringtemplate3 import StringTemplateGroup, StringTemplate

__formatters = { "canon.st"    : StringTemplateGroup(fileName = "canon.st")
               , "markdown.st" : StringTemplateGroup(fileName = "markdown.st")
               }

def formatMacro(target, source, env):
  assert len(target) == 1
  outFile = target[0]
  (m4File,stFile) = source
  m = Macro(m4File.path, env["inputEncoding"])
  f = __formatters[stFile.path].getInstanceOf("canon")
  for (k,v) in m.__dict__.items():
    f[k] = v
  writeFile(outFile.path, env["outputEncoding"], f.toString().strip() + '\n')

##### Build Script #####

m4dir = "m4"
stagedir = "stage"

cssfile = "autoconf-archive.css"
cssfile = Command(path.join(stagedir, cssfile), cssfile, Copy("$TARGET", "$SOURCE"))

for m in Glob(path.join(m4dir, "*.m4")):
  t = path.join(stagedir, path.basename(m.path))
  s = Command(t, [m, "canon.st"], formatMacro, inputEncoding = "latin1", outputEncoding = "latin1")
  AddPostAction(s, "@diff -u $SOURCE $TARGET")
  t = path.splitext(t)[0] + ".mdown"
  s = Command(t, [s, "markdown.st"], formatMacro, inputEncoding = "latin1", outputEncoding = "utf-8")
  t = path.splitext(t)[0] + ".html"
  s = Command(t, [s, cssfile, "header.html"], "pandoc --standalone --title-prefix='Autoconf Macro: ' --include-before-body=header.html --css=autoconf-archive.css --from=markdown --to=html -o $TARGET $SOURCE")
  AddPostAction(s, "@tidy -quiet --indent yes --indent-spaces 1 --write-back yes --tidy-mark no -wrap 80 --hide-comments yes $TARGET")

Clean(".", [stagedir])
