CP=lib/calabash.jar:lib/commons-httpclient-3.1.jar:lib/commons-io-1.3.1.jar:lib/commons-logging-1.1.1.jar:lib/jython.jar:lib/dbpygments.jar:lib/saxon9he.jar:lib/xmlresolver.jar:lib

all: slides.html dbslides.html

slides.html: src/slides.xml
	java -cp lib/saxon9he.jar net.sf.saxon.Transform \
             -o:$@ -s:$< style/slides.xsl \
             use.extensions="1" chunker.output.quiet="1"

dbslides.html: src/dbslides.xml style/dbslides.xsl \
               src/example.xml src/example.xsl src/example.xsd
	java -cp $(CP) \
             -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl \
             com.xmlcalabash.drivers.Main -isource=$< -oresult=$@ style/dbslides.xpl

