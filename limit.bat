::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Limit the amount of rows

Usage:
  limit <integer>

Examples:
  (echo a && echo b && echo a) | limit 2
    a
    b

"""

import scala.io._

val lines = Source.stdin.getLines

lines take(args(0).toInt) foreach println