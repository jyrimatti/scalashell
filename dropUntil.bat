::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Drop lines as long as they don't match a given regex

Usage:
  dropUntil "<regex>"

Examples:
  (echo a && echo b && echo a) | dropUntil "b.*"
    b
    a

"""

import scala.io._

val lines = Source.stdin.getLines

val Pattern = args(0).r

lines dropWhile { case Pattern() => false; case _ => true } foreach println