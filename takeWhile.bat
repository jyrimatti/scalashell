::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

args match {
  case Array(regex) => // OK
  case _ => {
    println("""
		| Takes lines as long as they match a given regex

		| Usage:
		|   takeWhile "<regex>"

		| Examples:
		|   (echo a && echo b && echo a) | takeWhile "a.*"
		|     a
    """.stripMargin)
    exit
  }
}

import scala.io._

val lines = Source.stdin.getLines

val Pattern = args(0).r

lines takeWhile { case Pattern() => true; case _ => false } foreach println