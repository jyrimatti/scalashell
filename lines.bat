::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Read lines from files

Usage:
  lines 

Examples:
  (echo bar.txt && echo baz.txt) | lines
    first line in bar
    second line in bar
    first line in baz
    second line in baz

"""

import scala.io._

val lines = Source.stdin.getLines

for {
	file <- lines
	line <- Source.fromFile(file, "ISO-8859-1").getLines
} println(line)