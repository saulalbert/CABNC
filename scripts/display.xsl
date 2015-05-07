<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- This is sample stylesheet converts a BNC text into simple HTML for display -->

<xsl:output method="html"  encoding="iso-8859-1" />

<xsl:key name="setTable" match="setting" use="@n"/>
<xsl:key name="recTable" match="recording" use="@n"/>


  <xsl:template match="/">
    <html>
      <head><title>A sample BNC text</title></head>
      
      <body bgcolor="#FFFFFF">
        <h1>BNC Text no. <xsl:value-of select="bncDoc/teiHeader/fileDesc/publicationStmt/idno"/></h1>
        <h2><xsl:value-of select="bncDoc/teiHeader/fileDesc/titleStmt/title"/>
        </h2>
        <hr/>
	<xsl:apply-templates select="bncDoc/teiHeader"/>
        <hr/>
        <xsl:apply-templates select="bncDoc/stext"/>
        <xsl:apply-templates select="bncDoc/wtext"/>
      </body>
    </html>
  </xsl:template>


  <xsl:template match="teiHeader">
    <xsl:apply-templates select="profileDesc/particDesc"/>
    <xsl:apply-templates select="fileDesc/sourceDesc"/>
  </xsl:template>

<xsl:template match="particDesc">
    <h4>Speakers <xsl:if test="@n">recorded by participant
    no. <xsl:value-of select="@n"/></xsl:if></h4>
<table align="center" >
<xsl:for-each select="person">
 <xsl:variable name="who">
   <xsl:value-of select="@xml:id"/>
</xsl:variable>
<tr>
<td><xsl:value-of select="@xml:id"/>
<xsl:if test='@n'>
  (respondent <xsl:value-of select="@n"/>)
</xsl:if>
</td>
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
<!--<td><xsl:value-of select="count(//u[@who=$who])"/></td>
<td><xsl:value-of select="count(//u[@who=$who]//w)"/></td> -->
</tr>
</xsl:for-each>
</table>
</xsl:template>

  <xsl:template match="sourceDesc">
    <h4>Source of text</h4>    
    <xsl:apply-templates select="recordingStmt|bibl"/>
  </xsl:template>

  <xsl:template match="recordingStmt">
  <xsl:value-of select="count(*)"/> <xsl:text>recordings detailed below</xsl:text>
  </xsl:template>

  

<xsl:template match="recording">
<xsl:if test="not(@date)">unknown date</xsl:if>
<xsl:value-of select="@date"/><xsl:text>:  </xsl:text>
<xsl:apply-templates select="key('setTable',@n)"/>
 </xsl:template>


  <xsl:template match="bibl">
Extracted from
    <xsl:for-each select="*">
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="."/>
    </xsl:for-each>

  </xsl:template>

  <xsl:template match="title">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  <!-- templates for STEXT -->

  <xsl:template match="stext/div">
    <h4><xsl:number/> 
<xsl:if test='@n'> (Tape <xsl:value-of select='@n'/>)</xsl:if></h4>
<h4>Recorded <xsl:apply-templates select="key('recTable',@n)"/></h4>
    <table>
    <xsl:apply-templates/>
</table>
  </xsl:template>

<xsl:template match="setting">
<xsl:value-of select="locale"/>
<xsl:value-of select="name"/>
<xsl:apply-templates select="activity"/>
</xsl:template>

<xsl:template match="stext">
<table>
    <xsl:apply-templates/>
</table>
  </xsl:template>


<xsl:template match="u">
    <tr><td valign="top">
<xsl:value-of select="@who"/>  
    </td>
    <td>
    <xsl:apply-templates/>
  </td></tr>
  </xsl:template>

  <xsl:template match="mw|w|c">
    <xsl:apply-templates/>
    <!--    <sub><xsl:value-of select="@TYPE"/></sub> -->
    <!-- should do mouse-over trick -->
  </xsl:template>

  <xsl:template match="s">
    <xsl:text>[</xsl:text>
<xsl:value-of select="@n"/>  
    <xsl:text>] </xsl:text>
    <xsl:apply-templates/>
    <br/>
  </xsl:template>

  <xsl:template match="pause">
    <xsl:text> ... </xsl:text>
  </xsl:template>

  <xsl:template match="unclear">
    <xsl:text> [...] </xsl:text>
  </xsl:template>

  <xsl:template match="event">
    <xsl:text> [</xsl:text>
<xsl:value-of select="@desc"/>  
    <xsl:text>] </xsl:text>
  </xsl:template>

  <xsl:template match="vocal">
    <xsl:text> [</xsl:text>
<xsl:value-of select="@desc"/>  
    <xsl:text>] </xsl:text>
  </xsl:template>

  <xsl:template match="shift">
    <xsl:text> [</xsl:text>
<xsl:value-of select="@new"/>  
    <xsl:text>] </xsl:text>
  </xsl:template>


  <xsl:template match="text">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="p">
    <p>    <xsl:apply-templates/>
</p>
  </xsl:template>

  <xsl:template match="head">
    <h4>    <xsl:apply-templates/>
</h4>
  </xsl:template>

  <xsl:template match="pb">
    <center><h5>* * * page <xsl:value-of select="@n"/> * * *</h5></center>
  </xsl:template>

  <xsl:template match="div1|div2|div3|div4">
    <p> </p>
    <xsl:apply-templates/>
  </xsl:template>

 <xsl:template match="@*|*">
  <xsl:copy>
   <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>
