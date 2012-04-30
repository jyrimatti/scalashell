::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Keep only lines matching a given regex

Usage:
  filter "<regex>"

Examples:
  (echo a && echo b && echo a) | filter "b.*"
    b

"""

import scala.io._

val lines = Source.stdin.getLines

val FilterPattern = args(0).r

lines collect { case x@FilterPattern() => x } foreach println