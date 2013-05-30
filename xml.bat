::#! 2>/dev/null || echo "
@echo off
call scala -savecompiled %~f0 %*
goto :eof
" >//null 
#!/bin/sh
exec scala -savecompiled "$0" "$@"
::!#

val rootElemName = args match {
	case Array() => None
	case Array(e) => Some(e)
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
  def attributeName  = nameStartChar ~ rep(nameChar)
  def attributeValue = "[\"']".r >> { quote => ("[^" + quote + "]*").r ~ quote ^^ { case content ~ quote => quote + content + quote }}
  def attribute      = attributeName ~ "=" ~ attributeValue                    ^^ { case n1 ~ n ~ eq ~ value => n1 + n.mkString + eq + value }

  def elementName(restrict: Option[String]): Parser[String] = restrict match {
  	case Some(n) => literal(n)
  	case None    => "[^?>\\s]+".r
  }
  def elemShort(restrict: Option[String]) = "<" ~> elementName(restrict) ~ rep("\\s+".r | attribute) ~ "/" <~ ">" ^^ { case name ~ attributes => (name, attributes.mkString) }
  def elemOpen(restrict: Option[String])  = "<" ~> elementName(restrict) ~ rep("\\s+".r | attribute) <~ ">"       ^^ { case name ~ attributes => (name, attributes.mkString) }
  def elemClose(elemName: String) = "<" ~ "/" ~ elemName ~ ">"  

  def elemContent: Parser[String] = rep("[^<]+".r | elem())                                                       ^^ { _.mkString }
  def elem(restrict: Option[String] = None) = elemShort(restrict) | elemOpen(restrict) >> { case (name, attrs) => elemContent <~ elemClose(name)     ^^ { case content => "<" + name + attrs + ">" + content + "</" + name + ">" } }

  def apply(rootElement: Option[String], input: Reader[Char]): Unit = parse(elem(rootElement), input) match {
	  case Success(result, next) => println(result); if (!next.atEnd) apply(rootElement, next)
	  case NoSuccess(_, next) if !next.atEnd => apply(rootElement, next.rest)
	  case _ =>
  }
}
P(rootElemName, new PagedSeqReader(PagedSeq.fromSource(Source.stdin)))
