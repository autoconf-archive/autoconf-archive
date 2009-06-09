group formatter;

copyrightLine(author) ::= <<
Copyright (c) <author.year> <author.name><if(author.email)> \\\<<author.email>\\\><endif>
>>

canon(m4header, name, synopsis, description, authors, license, body) ::= <<
% <name>
% <authors:{e|<e.name>}; separator=", ">
%

SYNOPSIS
========

    <synopsis; separator="\n">

DESCRIPTION
===========

   <description:{e| <e; separator="\n">}; separator="\n\n">

SOURCE CODE
===========

Download [ac_check_class.m4](http://git.savannah.gnu.org/gitweb/?p=autoconf-archive.git;a=blob_plain;f=<name>.m4)
or browse the [revision history](http://git.savannah.gnu.org/gitweb/?p=autoconf-archive.git;a=history;f=<name>.m4).

LICENSE
=======

<authors:copyrightLine(); separator="  \n">

<license:{e| <e; separator="\n">}; separator="\n\n">
>>
