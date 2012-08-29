<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:f="http://docbook.org/xslt/ns/extension"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns:m="http://docbook.org/xslt/ns/mode"
		xmlns:t="http://docbook.org/xslt/ns/template"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="db f h m t xs"
                version="2.0">

<xsl:import href="docbook/base/html/docbook.xsl"/>

<xsl:param name="linenumbering" as="element()*">
  <ln path="programlisting" everyNth="0" width="0" separator=" " padchar=" " minlines="-1"/>
</xsl:param>

<xsl:variable name="license" as="element()">
  <div class="license">Licensed under a Creative Commons Attribution-
  <br/>Noncommercial-Share Alike 3.0 Unported License</div>
</xsl:variable>

<xsl:variable name="footer-text" as="element()">
  <div class="content">www.xmlsummerschool.com</div>
</xsl:variable>

<xsl:param name="root.elements">
  <db:slides/>
</xsl:param>

<xsl:param name="docbook.css" select="'css/slides.css'"/>
<xsl:param name="jquery.js" select="'js/jquery-1.6.2.min.js'"/>
<xsl:param name="slides.js" select="'js/slides.js'"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="db:slides">
  <html>
    <head>
      <!-- assume we're going to serialize as utf-8 -->
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <title>
        <xsl:value-of select="db:info/db:title"/>
      </title>

    <link rel="stylesheet" type="text/css" href="{$docbook.css}" />
    <script type="text/javascript" language="javascript" src="{$jquery.js}" />
    <script type="text/javascript" language="javascript" src="{$slides.js}" />
    </head>
    <body>
      <div class="foil titlefoil">
        <xsl:apply-templates select="db:info"/>
        <div class="footer">
          <xsl:sequence select="($license, $footer-text)"/>
        </div>
      </div>

      <xsl:apply-templates select="db:foil"/>

      <div class="foil">
        <div class="page">
          <div class="header">
            <h1>Table of contents</h1>
          </div>
          <div class="body">
            <ul>
              <xsl:for-each select="db:foil">
                <xsl:variable name="sno" select="count(preceding::db:foil)+2"/>
                <li>
                  <span onclick="javascript:goto({$sno})">
                    <xsl:value-of select="db:title"/>
                  </span>
                </li>
              </xsl:for-each>
            </ul>
          </div>
        </div>
        <div class="footer">
          <xsl:sequence select="($license, $footer-text)"/>
        </div>
      </div>
    </body>
  </html>
</xsl:template>

<xsl:template match="db:slides/db:info">
  <div class="page">
    <div class="header">
      <h1><xsl:apply-templates select="db:title/node()"/></h1>
      <h2><xsl:value-of select="format-date(xs:date(db:pubdate), '[D01] [MNn] [Y0001]')"/></h2>
    </div>
    <div class="body">
      <h1><xsl:apply-templates select="db:subtitle/node()"/></h1>
      <xsl:apply-templates select="db:authorgroup|db:author"/>
      <xsl:apply-templates select="db:legalnotice"/>
    </div>
  </div>
</xsl:template>

<xsl:template match="db:authorgroup">
  <div class="authorgroup">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="db:author">
  <div class="author">
    <h2><xsl:apply-templates select="db:personname"/></h2>
    <xsl:if test="db:affiliation/db:orgname">
      <h3><xsl:apply-templates select="db:affiliation/db:orgname"/></h3>
    </xsl:if>
  </div>
</xsl:template>

<xsl:template match="db:legalnotice">
  <div class="legalnotice">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="db:speakernotes">
  <!-- ignored -->
</xsl:template>

<xsl:template match="db:foil">
  <div class="foil">
    <div class="page">
      <div class="header">
        <h1>
          <xsl:apply-templates select="db:title/node()"/>
        </h1>
      </div>
      <div class="body">
        <xsl:apply-templates select="*[not(self::db:title)]"/>
      </div>
    </div>
    <div class="footer">
      <xsl:sequence select="($license, $footer-text)"/>
      <div class="foilnumber">
        <xsl:text>Slide </xsl:text>
        <xsl:value-of select="count(preceding::db:foil)+1"/>
      </div>
    </div>
  </div>
</xsl:template>

<xsl:template match="db:tag[@class='xmlpi']">
  <span class="pi">
    <xsl:text>&lt;?</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>?&gt;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="db:tag[@class='starttag']">
  <!-- hack -->
  <span class="{if (starts-with(., 'xsl:')) then 'xslt' else 'el'}">
    <xsl:text>&lt;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&gt;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="db:tag[@class='emptytag']">
  <span class="{if (starts-with(., 'xsl:')) then 'xslt' else 'el'}">
    <xsl:text>&lt;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>/&gt;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="db:tag[@class='endtag']">
  <span class="{if (starts-with(., 'xsl:')) then 'xslt' else 'el'}">
    <xsl:text>&lt;/</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&gt;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="db:tag[@class='attribute']">
  <span class="att">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="db:tag[@class='attvalue']">
  <span class="attval">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="db:tag[@class='genentity']">
  <span class="ent">
    <xsl:text>&amp;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="db:methodname">
  <span class="func">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="db:varname">
  <span class="var">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="db:parameter">
  <span class="param">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="db:constant">
  <span class="const">
    <xsl:apply-templates/>
  </span>
</xsl:template>

</xsl:stylesheet>
