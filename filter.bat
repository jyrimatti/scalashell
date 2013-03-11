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
			| Keep only lines matching the given regex

			| Usage:
			|   filter "<regex>"

			| Examples:
			|   (echo a && echo b && echo a) | filter "b.*"
			|     b
		""".stripMargin)
		exit
	}
}

import scala.io._

val lines = Source.stdin.getLines

val FilterPattern = args(0).r

lines collect { case x@FilterPattern() => x } foreach println