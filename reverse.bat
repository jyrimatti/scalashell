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
			| Reverse the collection of lines

			| Usage:
			|   reverse

			| Examples:
			|   (echo a && echo b && echo c) | reverse
			|     c
			|     b
			|     a
		""".stripMargin)
		exit
	}
}

import scala.io._

val lines = Source.stdin.getLines

lines.toSeq.reverse.foreach(println)