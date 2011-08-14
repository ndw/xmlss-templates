<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
<html>
    <xsl:template match="element">
        <p>Found your XML element</p>
        <xsl:apply-templates/>
    </xsl:template>
</html>
</xsl:stylesheet>
