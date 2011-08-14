XSLT=saxon
XPROC=calabash

all: slides.html dbslides.html

slides.html: src/slides.xml
	$(XSLT) $< style/slides.xsl $@

dbslides.html: src/dbslides.xml style/dbslides.xsl bin/prettyprint.pl \
               src/example.xml src/example.xsl src/example.xsd
	$(MAKE) -C src
	$(XPROC) -isource=$< -oresult=$@ style/dbslides.xpl
