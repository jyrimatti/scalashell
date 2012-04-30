::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Count lines

Usage:
  lineCount

Examples:
  (echo a && echo b && echo a) | lineCount
    3

"""

import scala.io._

val lines = Source.stdin.getLines

println(lines.size)