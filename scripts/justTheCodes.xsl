<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="text" encoding="utf-8" />

  <xsl:template match="teiHeader"/>

  <xsl:template match="wtext|stext">
    <xsl:apply-templates/>
  </xsl:template>


  <xsl:template match="s">
    <xsl:value-of select="ancestor::bncDoc/@xml:id"/><xsl:text>.</xsl:text>
    <xsl:value-of select="@n"/><xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="w|c">
    <xsl:value-of select="@c5"/><xsl:text> </xsl:text>
  </xsl:template>
</xsl:stylesheet>

