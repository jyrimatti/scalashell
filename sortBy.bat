::#!
@echo off
for /f "tokens=*" %%a in ('where %0') do @set loc=%%a 
call scala -savecompiled %loc% %*
goto :eof
::!#
"""

Sort lines based on a group in a given regex.
If an optional 'num' parameter is given, sorting assumes the sort key is numeric.
Otherwise the sorting is based on natural order of strings.

Usage:
  sortBy "<regex>"
  sortBy "<regex>" num

Examples:
  (echo a1 && echo b3 && echo c22) | sortBy "[a-z](\d*).*"
    a1
    c22
    b3

  (echo a1 && echo b3 && echo c22) | sortBy "[a-z](\d*).*" num
    a1
    b3
    c22

"""

import scala.io._

val lines = Source.stdin.getLines

val SortPattern = args(0).r
val method = if (args.length == 1) None else Some(args(1))

implicit val ordering = (method match {
	case Some("num") => implicitly[Ordering[Double]]
	case None => implicitly[Ordering[String]]
}).asInstanceOf[Ordering[Any]]

lines.toStream.sortBy { case SortPattern(x) => method match {
	case Some("num") => x.toDouble
	case None => x
}} foreach println