<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="html"
                version="2.0">

<xsl:output method="xhtml" encoding="utf-8" indent="no"
	    omit-xml-declaration="yes"/>

<xsl:strip-space elements="html:div html:body"/>

<xsl:variable name="license" as="element()">
  <div class="license">Licensed under a Creative Commons Attribution-
  <br/>Noncommercial-Share Alike 3.0 Unported License</div>
</xsl:variable>

<xsl:variable name="footer-text" as="element()">
  <div class="content">www.xmlsummerschool.com</div>
</xsl:variable>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="html:head">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
    <link rel="stylesheet" type="text/css" href="css/slides.css"/>
    <script type="text/javascript" language="javascript" src="js/jquery-1.6.2.min.js">
    </script>
    <script type="text/javascript" src="js/slides.js">
    </script>
  </xsl:copy>
</xsl:template>

<xsl:template match="html:body/html:div[contains(@class, 'titlefoil')]" priority="300">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <div class="page">
      <xsl:apply-templates/>
    </div>
    <div class="footer">
      <xsl:sequence select="($license, $footer-text)"/>
    </div>
  </xsl:copy>
</xsl:template>

<xsl:template match="html:body/html:div[contains(@class, 'foil')]" priority="100">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <div class="page">
      <div class="header">
        <xsl:apply-templates select="html:h1"/>
      </div>
      <div class="body">
        <xsl:apply-templates select="*[not(self::html:h1)]"/>
      </div>
    </div>
    <div class="footer">
      <xsl:sequence select="($license, $footer-text)"/>
      <div class="foilnumber">
        <xsl:text>Slide </xsl:text>
        <xsl:value-of select="count(preceding::html:div[contains(@class, 'foil')
                                                        and not(contains(@class, 'titlefoil'))])
                              + 1"/>
      </div>
    </div>
  </xsl:copy>
</xsl:template>

<xsl:template match="*" name="copy">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="comment()|processing-instruction()|text()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
