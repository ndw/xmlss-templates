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

<xsl:import href="plain.xsl"/>

<xsl:template match="db:foil">
  <div class="{ if (parent::db:slides and preceding-sibling::db:foilgroup)
                then 'foil titlefoil foilgroup'
                else 'foil' }">
    <div class="page">
      <div class="header">
        <h1>
          <xsl:apply-templates select="db:info/db:title/node()|db:title/node()"/>
        </h1>
      </div>
      <div class="body">
        <xsl:call-template name="t:clicknav">
          <xsl:with-param name="prev" select="concat('#', f:slideno(.)-1)"/>
          <xsl:with-param name="next"
                          select="if (following::db:foil) then concat('#', f:slideno(.)+1) else ()"/>
        </xsl:call-template>

        <div class="foil-body">
            <xsl:apply-templates select="*[not(self::db:title) and not(self::db:speakernotes)]"/>
            <xsl:if test=".//db:footnote">
              <div class="footnote">
                <sup>*</sup>
                <xsl:apply-templates select=".//db:footnote/db:para/node()"/>
              </div>
            </xsl:if>
        </div>

        <div class="foil-notes">
          <div class="foilinset">
            <xsl:apply-templates select="*[not(self::db:title) and not(self::db:speakernotes)]"/>
          </div>

          <xsl:choose>
            <xsl:when test="db:speakernotes">
              <xsl:apply-templates select="db:speakernotes"/>
            </xsl:when>
            <xsl:otherwise>
              <p>No speaker notes for this foil.</p>
            </xsl:otherwise>
          </xsl:choose>
        </div>
      </div>
    </div>
    <xsl:call-template name="t:slide-footer"/>
  </div>
</xsl:template>

</xsl:stylesheet>

