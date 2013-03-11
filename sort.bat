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
			| Sort lines to natural order of strings

			| Usage:
			|   sort

			| Examples:
			|   (echo a && echo b && echo a) | sort
			|     a
			|     a
			|     b
		""".stripMargin)
		exit
	}
}

import scala.io._

val lines = Source.stdin.getLines

lines.toSeq.sorted.foreach(println)