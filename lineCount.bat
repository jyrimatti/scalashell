::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

args match {
	case Array() => // OK
	case _ => {
		println("""
			| Count lines

			| Usage:
			|   lineCount

			| Examples:
			|   (echo a && echo b && echo a) | lineCount
			|     3
		""".stripMargin)
		exit
	}
}

import scala.io._

val lines = Source.stdin.getLines

println(lines.size)