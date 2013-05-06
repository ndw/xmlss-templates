CP=lib/calabash.jar:lib/commons-httpclient-3.1.jar:lib/commons-io-1.3.1.jar:lib/commons-logging-1.1.1.jar:lib/jython.jar:lib/dbpygments.jar:lib/saxon9he.jar:lib/xmlresolver.jar:lib
PYTHONPATH := lib/python2.6/site-packages/Pygments-1.5-py2.6.egg:lib/jython-2.5.2/Lib:__classpath__:__pyclasspath__/
RM=rm -f
VPATH=src

# As a build convenience, the plain HTML flavor of slides isn't supported here anymore

TARGETS=dbslides.html

all: $(TARGETS)

clean::
	$(RM) $(TARGETS)

.SUFFIXES: .xml .html .fo .pdf

.xml.html: style/dbslides.xsl style/dbslides.xpl
	@echo Building $@
	@java -cp $(CP) \
             -Dpython.path=$(PYTHONPATH) \
             -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl \
             com.xmlcalabash.drivers.Main -isource=$< -oresult=$@ style/dbslides.xpl

.xml.fo: style/pdf.xsl style/dbpdf.xpl
ifeq ($(FO2PDF),)
		@echo ERROR: You must specify the FO2PDF processor: make FO2PDF=xxx ...
else
		@echo Building $@
		@java -cp $(CP) \
                  -Dpython.path=$(PYTHONPATH) \
                  -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl \
                  com.xmlcalabash.drivers.Main -isource=$< -oresult=$@ style/dbpdf.xpl
endif

.fo.pdf:
	@echo Building $@ with $(FO2PDF)
ifeq ($(FO2PDF),)
		@echo ERROR: You must specify the FO2PDF processor: make FO2PDF=xxx ...
else
		$(FO2PDF) $< $@
endif
