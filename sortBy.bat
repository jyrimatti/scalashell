::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

val method = args match {
  case Array(regex) => None
  case Array(regex, "num") => Some("num")
  case _ => {
    println("""
      | Sort lines based on a group in a given regex.
      | If an optional 'num' parameter is given, sorting assumes the sort key is numeric.
      | Otherwise the sorting is based on natural order of strings.

      | Usage:
      |   sortBy "<regex>"
      |   sortBy "<regex>" num

      | Examples:
      |   (echo a1 && echo b3 && echo c22) | sortBy "[a-z](\d*).*"
      |     a1
      |     c22
      |     b3

      |   (echo a1 && echo b3 && echo c22) | sortBy "[a-z](\d*).*" num
      |     a1
      |     b3
      |     c22
    """.stripMargin)
    exit
  }
}

import scala.io._

val lines = Source.stdin.getLines

val SortPattern = args(0).r

implicit val ordering = (method match {
	case Some("num") => implicitly[Ordering[Double]]
	case None => implicitly[Ordering[String]]
}).asInstanceOf[Ordering[Any]]

lines.toSeq.sortBy { case SortPattern(x) => method match {
	case Some("num") => x.toDouble
	case None => x
}} foreach println