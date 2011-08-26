<?xml version="1.0" encoding="utf-8"?>
<!-- Converts Norm's XHTML slide markup to S5-style XHTML. -->
<!-- Author: Tony Graham -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="html"
    version="2.0">

<xsl:import href="slides.xsl" />

<xsl:strip-space elements="html:div html:body"/>

<xsl:variable name="license" as="element()">
  <div class="license">Licensed under a Creative Commons Attribution-
  <br/>Noncommercial-Share Alike 3.0 Unported License</div>
</xsl:variable>

<xsl:variable name="footer-text" as="element()">
  <div class="content">www.xmlsummerschool.com</div>
</xsl:variable>

<xsl:template match="html:head">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
    <meta name="version" content="S5 1.1" />
    <meta name="defaultView" content="slideshow" />
    <meta name="controlVis" content="hidden" />
    <link
	rel="stylesheet" href="ui/xmlss/slides.css"
	type="text/css" media="projection"
	id="slideProj" />
    <link rel="stylesheet" href="ui/xmlss/outline.css"
	  type="text/css" media="screen"
	  id="outlineStyle" />
    <link rel="stylesheet" href="ui/xmlss/print.css"
	  type="text/css" media="print"
	  id="slidePrint" />
    <link rel="stylesheet" href="ui/xmlss/opera.css"
	  type="text/css" media="projection"
	  id="operaFix" />
    <script src="ui/xmlss/slides.js" type="text/javascript"></script>
  </xsl:copy>
</xsl:template>

<xsl:template match="html:body">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <div class="layout">
      <div id="controls"></div>
      <div id="currentSlide"></div>
      <div id="header"></div>
      <div id="footer">
	<xsl:sequence select="($license, $footer-text)"/>
      </div>
    </div>
    <div class="presentation">
      <xsl:apply-templates />
    </div>
  </xsl:copy>
</xsl:template>

<xsl:template match="html:body/html:div" priority="100">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="class" select="'slide'" />
    <xsl:apply-templates select="html:h1"/>
    <div class="slidecontent">
      <xsl:apply-templates select="*[not(self::html:h1)]"/>
    </div>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
