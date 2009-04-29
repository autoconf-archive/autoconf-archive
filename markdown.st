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

LICENSE
=======

<authors:copyrightLine(); separator="  \n">

<license:{e| <e; separator="\n">}; separator="\n\n">

M4 SOURCE CODE
==============

~~~~~~~~~~ {.m4}
<body; separator="\n">
~~~~~~~~~~
>>
