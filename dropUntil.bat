::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

args match {
	case Array(lineRegex) => // OK
	case _ => {
		println("""
			| Drop lines as long as they don't match a given regex
			|
			| Usage:
			|   dropUntil "<regex>"

			| Examples:
			|   (echo a && echo b && echo a) | dropUntil "b.*"
			|     b
			|     a
		""".stripMargin)
		exit
	}
}

import scala.io._

val lines = Source.stdin.getLines

val Pattern = args(0).r

lines dropWhile { case Pattern() => false; case _ => true } foreach println