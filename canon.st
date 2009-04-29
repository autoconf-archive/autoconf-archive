group formatter;

copyrightLine(author) ::= <<
Copyright (c) <author.year> <author.name><if(author.email)> \<<author.email>\><endif>
>>

canon(m4header, name, synopsis, description, authors, license, body) ::= <<
<m4header>#
# SYNOPSIS
#
#   <synopsis; separator="\n#   ">
#
# DESCRIPTION
#
#   <description:{e| <e; separator="\n#   ">}; separator="\n#\n#   ">
#
# LICENSE
#
#   <authors:copyrightLine(); separator="\n#   ">
#
#   <license:{e| <e; separator="\n#   ">}; separator="\n#\n#   ">

<body; separator="\n">
>>
