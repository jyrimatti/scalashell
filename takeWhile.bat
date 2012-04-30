::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Takes lines as long as they match a given regex

Usage:
  takeWhile "<regex>"

Examples:
  (echo a && echo b && echo a) | takeWhile "a.*"
    a

"""

import scala.io._

val lines = Source.stdin.getLines

val Pattern = args(0).r

lines takeWhile { case Pattern() => true; case _ => false } foreach println