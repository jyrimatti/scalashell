::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

val enc = args match {
	case Array() => "UTF-8"
	case Array(fileEncoding) => fileEncoding
	case _ => {
		println("""
			| Read lines from files

			| Usage:
			|   lines
			|   lines "<file_encoding>"

			| Examples:
			|   (echo bar.txt && echo baz.txt) | lines
			|     first line in bar
			|     second line in bar
			|     first line in baz
			|     second line in baz

			|   (echo bar.txt && echo baz.txt) | lines "ISO-8859-1"
			|     first line in bar
			|     second line in bar
			|     first line in baz
			|     second line in baz
		""".stripMargin)
		exit
	}
}

import scala.io._

val lines = Source.stdin.getLines

for {
	file <- lines
	line <- Source.fromFile(file, enc).getLines
} println(line)