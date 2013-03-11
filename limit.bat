::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

args match {
	case Array(maxRows) if maxRows matches "\\d+" => // OK
	case _ => {
		println("""
			| Limit the amount of rows

			| Usage:
			|   limit <positive_integer>

			| Examples:
			|   (echo a && echo b && echo a) | limit 2
			|     a
			|     b
		""".stripMargin)
		exit
	}
}

import scala.io._

val lines = Source.stdin.getLines

lines take(args(0).toInt) foreach println