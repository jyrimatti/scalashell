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
			| Keep only well-formed XML

			| Usage:
			|   xml

			| Examples:
			|   echo "a<b>c</b>d" | ./xml.bat
			|   <b>c</b>
		""".stripMargin)
		exit
	}
}

import scala.util.parsing.combinator._
import scala.util.parsing.input._
import scala.io.Source
import scala.collection.immutable.PagedSeq

object P extends RegexParsers {
  override val skipWhitespace = false

  def nameStartChar  = "[A-Z_a-z:]".r
  def nameChar       = "[A-Z_a-z:.0-9-]".r
  def attributeValue = "[\"']".r >> { quote => ("[^" + quote + "]*").r ~ quote      ^^ { case content ~ quote => quote + content + quote }}
  def attribute      = nameStartChar ~ rep(nameChar) ~ "=" ~ attributeValue         ^^ { case n1 ~ n ~ eq ~ value => n1 + n.mkString + eq + value }

  def elemOpen       = "<" ~> """[^>\s]+""".r ~ rep("\\s+".r | attribute) <~ ">"    ^^ { case name ~ attributes => (name, attributes.mkString) }
  def elemClose(elemName: String) = "<" ~ "/" ~ elemName ~ ">"  

  def elemContent: Parser[String] = rep("[^<]+".r | elem)                           ^^ { _.mkString }
  def elem = elemOpen >> { case (name, attrs) => elemContent <~ elemClose(name)     ^^ { case content => "<" + name + attrs + ">" + content + "</" + name + ">" } }

  def apply(input: Reader[Char]): Unit = parse(elem, input) match {
	  case Success(result, next) => print(result); if (!next.atEnd) apply(next)
	  case NoSuccess(_, next) if !next.atEnd => apply(next.rest)
	  case _ =>
  }
}
P(new PagedSeqReader(PagedSeq.fromSource(Source.stdin)))
