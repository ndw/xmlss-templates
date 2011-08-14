PP=../bin/prettyprint.pl

all: example.xsd.fmt example.xsl.fmt example.xml.fmt

example.xsd.fmt: example.xsd $(PP)
	perl $(PP) -r "xml schema" $< > $@

example.xsl.fmt: example.xsl $(PP)
	perl $(PP) -r "xml xslt" $< > $@

example.xml.fmt: example.xml $(PP)
	perl $(PP) -r "xml" $< > $@
