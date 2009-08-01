#! /usr/bin/env python

from __future__ import with_statement
from contextlib import closing
import re
import os.path as path
import sys
import textwrap

def loadFile(path):
  with closing( open(path) ) as fd:
    return fd.read()

def writeFile(path, buffer):
  with closing( open(path, "w") ) as fd:
    fd.write(buffer)

def splitSections(buffer):
  while buffer:
    assert len(buffer) >= 3
    name = buffer.pop(0).lower()
    assert buffer.pop(0) == ''
    body = []
    while buffer:
      line = buffer.pop(0)
      if line == '' or line[0].isspace():
        body.append(line[2:])
      else:
        buffer.insert(0, line)
        yield (name, body)
        body = []
        break
  if body:
    yield (name, body)

def collapseText(lines, width = 72):
  wrapper = textwrap.TextWrapper( width = width
                                , expand_tabs = False
                                , break_on_hyphens = False
                                , break_long_words = False
                                )
  body = []
  prev = None
  for line in lines:
    if line == '':
      prev = None
    elif line[0].isspace():
      if prev == "quote":
        body[-1].append(line)
      else:
        body.append([line])
        prev = "quote"
    else:
      if prev == "text":
        newtext = ' '.join(body[-1]) + ' ' + line
        body[-1] = wrapper.wrap(newtext)
      else:
        body.append(wrapper.wrap(line))
        prev = "text"
  return body

class Macro:
  def __init__(self, filePath):
    self.name = path.splitext(path.basename(filePath))[0]
    # header and body are separated by an empty line.
    (header,body) = loadFile(filePath).split("\n\n", 1)
    self.body = body.split('\n')
    # drop initial header (if present)
    header = re.sub(r"^\n*# =+\n#[^\n]*\n# =+\n(#\n)+", '', header, 1)
    # split buffer into lines and drop initial "# " prefix in the process
    header = map(lambda l: l[2:], header.split('\n'))
    # set defaults
    self.authors = []
    url = "http://www.nongnu.org/autoconf-archive/%s" % (self.name + ".html")
    lineLen = max(75,len(url) + 2)
    separator = '=' * lineLen
    padding = ' ' * ((lineLen - len(url)) / 2)
    self.m4header = "# %s\n"*3 % (separator, padding + url, separator)
    # parse each section in the remaining list
    for (key, body) in splitSections(header):
      # drop empty lines at beginning and end of body
      while body[0]  == '': body.pop(0)
      while body[-1] == '': body.pop(-1)
      # each section has its own parser
      if key == "synopsis":
        if '' in body:
          raise Exception("%s: malformed synopsis section" % filePath)
      elif key == "description":
        body = collapseText(body)
      elif key == "license":
        while True:
          match = re.match(r"Copyright \(c\) ([0-9.,-]+) (.*)", body[0])
          if not match: break
          (year,name) = (match.group(1), match.group(2))
          match = re.match(r"(.*) <(.*)>", name)
          if match:
            (name,email) = (match.group(1), match.group(2))
            self.authors.append(dict(year = year, name = name, email = email))
          else:
            self.authors.append(dict(year = year, name = name))
          body.pop(0)
        assert self.authors
        if body.pop(0) != '':
          raise Exception("%s: malformed license section" % filePath)
        body = collapseText(body)
      elif key == "obsolete macro":
        key = "obsolete"
        if '' in body:
          raise Exception("%s: malformed obsoleted section" % filePath)
      elif key == "description":
        body = collapseText(body)
      else:
        raise Exception("%s: unknown section %r in macro" % (filePath, key))
      self.__dict__[key] = body

  def __repr__(self):
    return repr(self.__dict__)
