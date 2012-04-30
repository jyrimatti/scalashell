::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

List files of a given or current directory

Usage:
  files
  files "<path>"

Examples:
  files
    .\bar.txt

  files "c:\foo"
    c:\foo\bar.txt

"""

import scala.io._

for {
	dir <- (if (args.isEmpty) Array(".") else args)
	file <- new java.io.File(dir).listFiles if file.isFile
} println(file.getPath)