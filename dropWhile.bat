::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Drop lines as long as they match a given regex

Usage:
  dropWhile "<regex>"

Examples:
  (echo a && echo b && echo a) | dropWhile "a.*"
    b
    a

"""

import scala.io._

val lines = Source.stdin.getLines

val Pattern = args(0).r

lines dropWhile { case Pattern() => true; case _ => false } foreach println