::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Join lines with an optional separator

Usage:
  join
  join "<separator>"

Examples: (ignore the additional space due to 'echo'...)
  (echo a1 && echo b2 && echo a3) | join
    a1 b2 a3

  (echo a1 && echo b2 && echo a3) | join "**"
    a1 **b2 **a3 **

"""
import scala.io._

val lines = Source.stdin.getLines

val separator = if (args.length == 0) "" else args(0)

lines foreach(x => {print(x); print(separator)})