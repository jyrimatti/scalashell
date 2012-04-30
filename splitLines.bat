::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Splits lines around matches of the given regex

Usage:
  splitLines "<regex>"

Examples:
  echo abcdef | splitLines "[bce]"
    a
    
    d
    f

  echo abcdef | splitLines "[bce]+"
    a
    d
    f

"""

import scala.io._

val lines = Source.stdin.getLines

val SplitPattern = args(0).r

lines flatMap { x => SplitPattern.split(x).toIterator } foreach println