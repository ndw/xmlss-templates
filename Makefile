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

#/usr/bin/java -Xmx2G -Xss1G -cp /Volumes/Data/github/calabash/out/production/Calabash
#/Volumes/Data/github/calabash/lib/Alternate_XfoJavaCtl.jar
#/Volumes/Data/github/calabash/lib/avalon-framework-4.2.0.jar
#/Volumes/Data/github/calabash/lib/batik-all-1.7.jar
#/Volumes/Data/github/calabash/lib/command.jar
#/Volumes/Data/github/calabash/lib/commons-codec-1.6.jar
#/Volumes/Data/github/calabash/lib/commons-httpclient-3.1.jar
#/Volumes/Data/github/calabash/lib/commons-io-1.3.1.jar
#/Volumes/Data/github/calabash/lib/commons-logging-1.1.1.jar
#/Volumes/Data/github/calabash/lib/htmlparser-1.3.1.jar
#/Volumes/Data/github/calabash/lib/isorelax.jar
#/Volumes/Data/github/calabash/lib/jing.jar
#/Volumes/Data/github/calabash/lib/junit-4.8.1.jar
#/Volumes/Data/github/calabash/lib/msv.jar
#/Volumes/Data/github/calabash/lib/relaxngDatatype.jar
#/Volumes/Data/github/calabash/lib/saxon9ee.jar
#/Volumes/Data/github/calabash/lib/saxon9he.jar
#/Volumes/Data/github/calabash/lib/serializer-2.7.0.jar
#/Volumes/Data/github/calabash/lib/tagsoup-1.2.jar
#/Volumes/Data/github/calabash/lib/xalan-2.7.0.jar
#/Volumes/Data/github/calabash/lib/xcc.jar
#/Volumes/Data/github/calabash/lib/xep.jar
#/Volumes/Data/github/calabash/lib/xercesImpl-2.7.1.jar
#/Volumes/Data/github/calabash/lib/xml-apis-1.3.04.jar
#/Volumes/Data/github/calabash/lib/xml-apis-ext-1.3.04.jar
#/Volumes/Data/github/calabash/lib/xmlgraphics-commons-1.4.jar
#/Volumes/Data/github/calabash/lib/xmlresolver.jar
#/Volumes/Data/github/calabash/lib/xmlunit-1.3.jar
#/Volumes/Data/github/calabash/lib/xsdlib.jar
#/Volumes/Data/github/calabash/lib/xt.jar
#/Volumes/Data/docbook/xslt20/ext/build/classes
#/Volumes/Data/docbook/xslt20/tools/lib/jython.jar
#/Volumes/Data/docbook/xslt20/ext/jython
#/Users/ndw/java
#/Volumes/Data/java/jaxp-1_4_2-20070530/lib/jaxp-api.jar
#/Volumes/Data/github/xmlresolver/out/production/Xmlresolver
#/Volumes/Data/java/apache-httpclient/commons-httpclient-3.1/commons-httpclient-3.1.jar
#/Volumes/Data/java/apache-logging/commons-logging-1.1.1/commons-logging-1.1.1.jar
#/Volumes/Data/java/apache-codec/commons-codec-1.3.jar
#/Volumes/Data/github/great-circle-xslt/build/classes
#/Volumes/Data/github/xmlidfilter/build/classes -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl -Djava.util.logging.config.file=/Users/ndw/java/logging.properties -Dhttp.proxyHost=localhost -Dhttp.proxyPort=8123 com.xmlcalabash.drivers.Main  "-isource=src/dbslides.xml" "-oresult=dbslides.html" "style/dbslides.xpl"
