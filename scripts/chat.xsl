<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<!-- This stylesheet converts a BNC XML text into a CHAT-CA file for re-transcription -->

<xsl:output encoding="utf-8" method="text" indent="no"/>
<xsl:key match="setting" name="setTable" use="@n"/>
<xsl:key match="recording" name="recTable" use="@n"/>
<xsl:strip-space elements="*"/>
<xsl:template match="/">
<xsl:apply-templates select="bncDoc/stext"/>
</xsl:template>
<xsl:template match="recording">
	<xsl:if test="not(@date)">unknown date</xsl:if>
	<xsl:value-of select="@date"/>
	<xsl:text>:  </xsl:text>
	<xsl:apply-templates select="key('setTable',@n)"/>
</xsl:template>
<!-- templates for STEXT -->
<xsl:template match="stext/div">
<xsl:for-each select="/bncDoc/stext/div">
<xsl:variable name="docName" select="/bncDoc/@xml:id"/>
<xsl:result-document href="../cabnc_chat/{$docName}_{position()}.cha">@Begin
@Font:  CAfont:13:0
@UTF8
@Languages:     eng
@Options:	CA
@Date:	<xsl:apply-templates select="key('recTable',@n)"/>
<xsl:apply-templates/>
@End
</xsl:result-document>
</xsl:for-each>
</xsl:template>

<xsl:template match="setting">
<xsl:if test="locale">
@Location:	<xsl:value-of select="locale"/>
@Situation:	<xsl:value-of select="name"/>
</xsl:if>
<xsl:apply-templates select="activity"/>
<xsl:if test="audioFile">
@Media: <xsl:value-of select="audioFile"/>, audio </xsl:if>
@Tanscriber:	AudioBNC project (https://saulalbert.github.io/CABNC/)<!--<xsl:value-of select="@who"/>-->
@Participants:	<xsl:variable name="doc1" select="/"/><xsl:for-each select="tokenize(@who, ' ')"><!--<xsl:value-of select="."/>-->
<xsl:variable name="speakerID2" select="." />
<xsl:choose>
				<xsl:when test="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/persName=&#34;None&#34;">UNK Unknown Unknown</xsl:when>
				<xsl:when test="not($doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/persName)">UNK Unknown Unknown</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="shortName" select="translate($doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/persName, 'abcdefghijklnmopqrstuvwxyz', 'ABCDEFGHIJKLNMOPQRSTUVWXYZ')"/>
					<xsl:value-of select="substring($shortName,1,3)"/></xsl:otherwise>
			</xsl:choose><xsl:text> </xsl:text>
<xsl:value-of  select="translate($doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/persName, ' ', '_')"/><xsl:text> </xsl:text>
<xsl:value-of  select="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@role"/><xsl:choose><xsl:when test="position() != last()"><xsl:text>, </xsl:text></xsl:when></xsl:choose>
</xsl:for-each>

<xsl:for-each select="tokenize(@who, ' ')">
<xsl:variable name="speakerID2" select="." />
@ID: eng|AudioBNC|<xsl:choose>
				<xsl:when test="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/persName=&#34;None&#34;">UNK|</xsl:when>
				<xsl:when test="not($doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/persName)">UNK|</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="shortName" select="translate($doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/persName, 'abcdefghijklnmopqrstuvwxyz', 'ABCDEFGHIJKLNMOPQRSTUVWXYZ')"/>
					<xsl:value-of select="substring($shortName,1,3)"/>|</xsl:otherwise>
			</xsl:choose><xsl:choose>
				<xsl:when test="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@ageGroup=&#34;X&#34;">unknown</xsl:when>
				<xsl:when test="not($doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@ageGroup)">unknown</xsl:when>
				<xsl:otherwise>~<xsl:value-of select="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/age"/>;|</xsl:otherwise>
			</xsl:choose> |<xsl:value-of select="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@sex"/>|<xsl:value-of select="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@ageGroup"/>| <xsl:if test="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/occupation">|<xsl:value-of select="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/occupation"/>
			</xsl:if>|<xsl:choose>
				<xsl:when test="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@role=&#34;?&#34;">role unspecified</xsl:when>
				<xsl:when test="not($doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@role)">role unspecified</xsl:when>
				<xsl:when test="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@role=&#34;self&#34;"/>
				<xsl:otherwise>
					<xsl:value-of select="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@role"/>
				</xsl:otherwise>
			</xsl:choose>|<xsl:value-of select="$speakerID2"/>
			<!--<xsl:if test="@n"> (respondent <xsl:value-of select="@n"/>) </xsl:if>-->
			<xsl:variable name="who">
				<xsl:value-of select="$doc1/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID2]/@xml:id"/>
			</xsl:variable>
			<xsl:text>|</xsl:text>
</xsl:for-each>
<xsl:if test="audioFile">
@Comment:	audio available at: http://bnc.phon.ox.ac.uk/data/<xsl:value-of select="audioFile"/></xsl:if>
@Comment:	conversation #<xsl:number/> (Tape <xsl:value-of select="@n"/>)</xsl:template>
<xsl:template match="stext"><xsl:apply-templates/></xsl:template>
<xsl:template match="u"><xsl:variable name="speakerID" select="@who" />
*<xsl:value-of  select="substring(translate(/bncDoc/teiHeader/profileDesc/particDesc/person[@xml:id=$speakerID]/persName, 'abcdefghijklnmopqrstuvwxyz', 'ABCDEFGHIJKLNMOPQRSTUVWXYZ'),1,3)"/><xsl:text>:	</xsl:text>	<xsl:apply-templates/></xsl:template>
<xsl:template match="mw|w|c"><xsl:apply-templates/><!--    <sub><xsl:value-of select="@TYPE"/></sub> --><!-- should do mouse-over trick --></xsl:template>
<!--<xsl:template match="s"><xsl:text>[</xsl:text><xsl:value-of select="@n"/><xsl:text>] </xsl:text><xsl:apply-templates/></xsl:template>-->
<xsl:template match="pause"><xsl:text> (.) </xsl:text></xsl:template>
<xsl:template match="unclear"><xsl:text> (        ) </xsl:text></xsl:template>
<xsl:template match="event"><xsl:text> ((</xsl:text><xsl:value-of select="@desc"/><xsl:text>))</xsl:text></xsl:template>
<xsl:template match="vocal"><xsl:text> ((</xsl:text><xsl:value-of select="@desc"/><xsl:text>)) </xsl:text></xsl:template>
<xsl:template match="shift"><xsl:text> [</xsl:text><xsl:value-of select="@new"/><xsl:text>] </xsl:text></xsl:template>
<xsl:template match="text"><xsl:apply-templates/></xsl:template>
<xsl:template match="p"><xsl:apply-templates/></xsl:template>
<xsl:template match="head"><xsl:apply-templates/></xsl:template>
<xsl:template match="pb">* * * page <xsl:value-of select="@n"/> * * *</xsl:template>
<xsl:template match="div1|div2|div3|div4"><xsl:apply-templates/></xsl:template>
<xsl:template match="@*|*"><xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy></xsl:template>
</xsl:stylesheet>
