::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Keep only lines that don't match a given regex

Usage:
  filterNot "<regex>"

Examples:
  (echo a && echo b && echo a) | filterNot "b.*"
    a
    a

"""

import scala.io._

val lines = Source.stdin.getLines

val FilterPattern = args(0).r

lines filterNot { case FilterPattern() => true; case _ => false } foreach println