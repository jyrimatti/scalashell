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
		| Splits lines around matches of the given regex

		| Usage:
		|   splitLines "<regex>"

		| Examples:
		|   echo abcdef | splitLines "[bce]"
		|     a
		    
		|     d
		|     f

		|   echo abcdef | splitLines "[bce]+"
		|     a
		|     d
		|     f
    """.stripMargin)
    exit
  }
}

import scala.io._

val lines = Source.stdin.getLines

val SplitPattern = args(0).r

lines flatMap { x => SplitPattern.split(x).toIterator } foreach println