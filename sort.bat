::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Sort lines to natural order of strings

Usage:
  sort

Examples:
  (echo a && echo b && echo a) | sort
    a
    a
    b

"""

import scala.io._

val lines = Source.stdin.getLines

lines.sorted.foreach(println)