::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Transform lines to more lines based on groups of a regex.
Each group in each match becomes a new line.

Usage:
  map "<regex>"

Examples:
  (echo a1a2 && echo b3b4) | map "[a-z]([^3])"
    1
    2
    4

"""

import scala.io._

val lines = Source.stdin.getLines

val MapPattern = args(0).r

lines flatMap { x => for (m <- MapPattern.findAllIn(x).matchData) yield m.subgroups.filter(_ != null).mkString } filter {!_.isEmpty} foreach println