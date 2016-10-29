<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- outputs an HTML table giving the numbers of utterances and words
recorded for each identified participant in a text -->

<xsl:output method="html"  encoding="iso-8859-1" />

<xsl:key name="uTab" match="u" use="@who"/>

 <xsl:template match="/">
    <xsl:apply-templates select="//stext" />
 </xsl:template>

<xsl:template match="stext">
<h4>Text <xsl:value-of select="ancestor::bncDoc/@xml:id"/> contains
the following speakers</h4>

<table >
<tr><td>Identifier</td>
<td>Age Group</td>
<td>Sex</td>
<td>Description</td>
<td>Utterances</td>
<td>Words</td>
</tr>

<xsl:for-each select="../teiHeader/profileDesc/particDesc/person">

<xsl:variable name="who">
   <xsl:value-of select="@xml:id"/>
</xsl:variable>

<tr>
<td><xsl:value-of select="@xml:id"/></td>
<td><xsl:value-of select="@ageGroup"/></td>
<td><xsl:value-of select="@sex"/></td>
<td> (<xsl:choose>
  <xsl:when test='persName="None"'>No name</xsl:when>
  <xsl:when test='not(persName)'>No name</xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="persName"/>
  </xsl:otherwise>
  </xsl:choose>, age <xsl:choose>
    <xsl:when test='@ageGroup="X"'>unknown</xsl:when>
    <xsl:otherwise><xsl:value-of select="age"/></xsl:otherwise>
   </xsl:choose>
<xsl:if test="occupation">, <xsl:value-of select="occupation"/></xsl:if>
<xsl:if test="dialect">, <xsl:value-of select="dialect"/>, </xsl:if>
<xsl:if test="persNote">, <xsl:value-of select="persNote"/></xsl:if>) <xsl:choose> 
<xsl:when test='@role="?"'>role unspecified</xsl:when>
<xsl:when test='@role="self"'/>
<xsl:otherwise>
<xsl:value-of select="@role"/>
</xsl:otherwise></xsl:choose>
</td>
<td><xsl:value-of select="count(key('uTab',$who))"/></td>
<td><xsl:value-of select="count(key('uTab',$who)//w)"/></td>
</tr>
</xsl:for-each>
</table>
</xsl:template>


</xsl:stylesheet>
