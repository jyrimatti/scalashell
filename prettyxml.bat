::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

val (width,step) = args match {
	case Array() => (120,2)
	case Array(w) => (w.toInt, 2)
	case Array(w,s) => (w.toInt,s.toInt)
	case _ => {
		println("""
			| Pretty-print XML, leave non-XML lines as-is

			| Usage:
			|   prettyxml

			| Examples:
			|   (echo A && echo "<a><b>c</b></a>") | ./prettyxml.bat
			|   A
			|   <a>
			|     <b>c</b>
			|   </a>
		""".stripMargin)
		exit
	}
}

import scala.xml.{XML,PrettyPrinter}
import scala.io.Source

val pp = new PrettyPrinter(width, step)
Source.stdin.getLines map { line =>
	try {
		pp.format(XML.loadString(line))
	} catch {
		// line was not well-formed XML
		case e => line
	}
} foreach println