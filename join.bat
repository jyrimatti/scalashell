::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

val separator = args match {
	case Array() => ""
	case Array(separatorString) => separatorString
	case _ => {
		println("""
			| Join lines with an optional separator

			| Usage:
			|   join
			|   join "<separator>"

			| Examples: (ignore the additional space due to 'echo'...)
			|   (echo a1 && echo b2 && echo a3) | join
			|     a1 b2 a3

			|   (echo a1 && echo b2 && echo a3) | join "**"
			|     a1 **b2 **a3 **
		""".stripMargin)
		exit
	}
}

import scala.io._

val lines = Source.stdin.getLines

lines foreach(x => {print(x); print(separator)})