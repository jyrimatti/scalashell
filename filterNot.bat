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
			| Keep only lines that don't match the given regex

			| Usage:
			|   filterNot "<regex>"

			| Examples:
			|   (echo a && echo b && echo a) | filterNot "b.*"
			|     a
			|     a
		""".stripMargin)
		exit
	}
}

import scala.io._

val lines = Source.stdin.getLines

val FilterPattern = args(0).r

lines filterNot { case FilterPattern() => true; case _ => false } foreach println