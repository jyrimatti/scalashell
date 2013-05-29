::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

val params = args map { new java.io.File(_) }

val dirs = params match {
	case Array()          => Array(new java.io.File("."))
	case a if a.forall{_.isDirectory} => a
	case a => {
		a filter {!_.isDirectory} foreach {f => println(f + " is not a directory!")}
		println("""
			| List files of the current directory or all the given directories, non-recursively

			| Usage:
			|   files
			|   files "<path>" ...

			| Examples:
			|   files
			|     .\bar.txt

			|   files "c:\foo" "c:\bar"
			|     c:\foo\bar.txt
			|     c:\bar\baz.txt
		""".stripMargin)
		exit
	}
}

import scala.io._

for {
	dir <- dirs
	file <- dir.listFiles
} println(file.getPath)