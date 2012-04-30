::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Reverse the collection of lines

Usage:
  reverse

Examples:
  (echo a && echo b && echo c) | reverse
    c
    b
    a

"""

import scala.io._

val lines = Source.stdin.getLines

lines.toStream.reverse.foreach(println)