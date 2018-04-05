<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.talkbank.org/ns/talkbank" xsi:schemaLocation="http://www.talkbank.org/ns/talkbank http://talkbank.org/software/talkbank.xsd">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:variable name="racine" select="/bncDoc"/>
	<xsl:template match="/">
		<xsl:apply-templates select="/bncDoc/teiHeader/fileDesc/sourceDesc/recordingStmt/recording"/>
	</xsl:template>
	<xsl:template match="/bncDoc/teiHeader/fileDesc/sourceDesc/recordingStmt/recording">
		<xsl:variable name="nID">
			<xsl:value-of select="./@n"/>
		</xsl:variable>
		<xsl:variable name="speakers">
			<xsl:value-of select="$racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/@who"/>
		</xsl:variable>
		<xsl:variable name="sp">
			<xsl:text> </xsl:text>
		</xsl:variable>
<!--		<xsl:result-document method="xml" href="./ConvResults/file_{@xml:id}-CHAT.xml">-->
<xsl:if test="$racine/stext/div[@n = $nID]">
		<xsl:result-document method="xml" href="./file_{@xml:id}-CHAT.xml">
			<xsl:element name="CHAT">
				<xsl:attribute name="xsi:schemaLocation">http://www.talkbank.org/ns/talkbank http://talkbank.org/software/talkbank.xsd</xsl:attribute>
				<xsl:attribute name="Media"><!--<xsl:value-of select="./@xml:id"></xsl:value-of><xsl:value-of select="$sp"/><xsl:value-of select="./@n"></xsl:value-of><xsl:value-of select="$sp"/>--><xsl:if test="$racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/audioFile"><xsl:value-of select="$racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/audioFile"></xsl:value-of></xsl:if><xsl:if test="not($racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/audioFile)"><xsl:value-of select="@xml:id"></xsl:value-of></xsl:if></xsl:attribute>
				<xsl:attribute name="Mediatypes">audio</xsl:attribute>
				<xsl:attribute name="PID"><xsl:value-of select="./@xml:id"></xsl:value-of></xsl:attribute>
				<xsl:attribute name="Version">2.5.0</xsl:attribute>
				<xsl:attribute name="Lang">eng</xsl:attribute>
				<!--<xsl:attribute name="Corpus"><xsl:value-of select="$racine/teiHeader/fileDesc/titleStmt/title"></xsl:value-of></xsl:attribute>-->
				<xsl:attribute name="Corpus">CABNC</xsl:attribute>
				<xsl:attribute name="Date"><xsl:value-of select="$racine/teiHeader/profileDesc/creation"></xsl:value-of></xsl:attribute>
				<xsl:element name="Participants">
					<!--<xsl:for-each select="$racine/teiHeader/profileDesc/particDesc/person[contains($speakers, ./@xml:id)]">-->
					<xsl:for-each select="$racine/teiHeader/profileDesc/particDesc/person[./@xml:id = distinct-values($racine/stext/div[@n = $nID]/u/@who)]">
						<xsl:element name="participant">
							<xsl:attribute name="custom-field"><xsl:value-of select="./@ageGroup"></xsl:value-of></xsl:attribute>
							<xsl:if test="./@educ">
								<xsl:attribute name="education"><xsl:value-of select="./@educ"></xsl:value-of></xsl:attribute>
							</xsl:if>
							<xsl:attribute name="id"><xsl:value-of select="./@xml:id"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="role">Unidentified</xsl:attribute>
							<xsl:attribute name="custom-field"><xsl:value-of select="concat(upper-case(substring(./@role,1,1)),substring(./@role, 2))"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="sex"><xsl:if test="./@sex = 'f'">female</xsl:if><xsl:if test="./@sex = 'm'">male</xsl:if><xsl:if test="./@sex = 'u'">male</xsl:if></xsl:attribute>
							<xsl:attribute name="SES"><xsl:value-of select="./@soc"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="language"><!--<xsl:value-of select="./@dialect"></xsl:value-of><xsl:text>,</xsl:text><xsl:value-of select="./dialect"></xsl:value-of>-->eng</xsl:attribute>
							<xsl:if test="./age">
								<xsl:attribute name="age">P<xsl:value-of select="replace(./age, '[^0-9]', '')"></xsl:value-of>Y1M1D</xsl:attribute>
							</xsl:if>
							<xsl:if test="not(./age)">
								<xsl:attribute name="age">P1Y1M1D</xsl:attribute>
							</xsl:if>
							<xsl:attribute name="name"><xsl:value-of select="./persName"></xsl:value-of></xsl:attribute>
							<xsl:if test="./occupation">
								<xsl:attribute name="group"><xsl:value-of select="./occupation"></xsl:value-of></xsl:attribute>
							</xsl:if>
							<xsl:if test="not(./occupation)">
								<xsl:attribute name="group">Unidentified</xsl:attribute>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
				<xsl:if test="$racine/teiHeader/fileDesc/titleStmt/respStmt/name">
				<xsl:element name="comment">
					<xsl:attribute name="type">Transcriber</xsl:attribute>
					<xsl:value-of select="$racine/teiHeader/fileDesc/titleStmt/respStmt/name"/>
				</xsl:element></xsl:if>
				<xsl:if test="$racine/teiHeader/fileDesc/sourceDesc/recordingStmt/recording[@n = $nID]/@dur">
				<xsl:element name="comment">
					<xsl:attribute name="type">Time Duration</xsl:attribute>
					<xsl:value-of select="$racine/teiHeader/fileDesc/sourceDesc/recordingStmt/recording[@n = $nID]/@dur"/>
				</xsl:element></xsl:if>
				<xsl:if test="$racine/teiHeader/fileDesc/sourceDesc/recordingStmt/recording[@n = $nID]/@type">
				<xsl:element name="comment">
					<xsl:attribute name="type">Recording Quality</xsl:attribute>
					<xsl:value-of select="$racine/teiHeader/fileDesc/sourceDesc/recordingStmt/recording[@n = $nID]/@type"/>
				</xsl:element></xsl:if>
				<xsl:if test="$racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/placeName">
				<xsl:element name="comment">
					<xsl:attribute name="type">Location</xsl:attribute>
					<xsl:value-of select="$racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/placeName"/>
				</xsl:element></xsl:if>
				<xsl:if test="$racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/locale">
				<xsl:element name="comment">
					<xsl:attribute name="type">Room Layout</xsl:attribute>
					<xsl:value-of select="$racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/locale"/>
				</xsl:element></xsl:if>
				<xsl:if test="$racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/activity">
				<xsl:element name="comment">
					<xsl:attribute name="type">Situation</xsl:attribute>
					<xsl:value-of select="$racine/teiHeader/profileDesc/settingDesc/setting[@n = $nID]/activity"/>
				</xsl:element></xsl:if>
				<xsl:element name="comment">
					<xsl:attribute name="type">Date</xsl:attribute>
					<xsl:call-template name="formatdate">
						<xsl:with-param name="datestr" select="$racine/teiHeader/profileDesc/creation"/>
					</xsl:call-template>
				</xsl:element>
				<xsl:for-each select="$racine/stext/div[@n = $nID]">
					<xsl:element name="comment">
						<xsl:attribute name="type">New Episode</xsl:attribute>
					</xsl:element>
					<xsl:for-each select="./u">
						<xsl:element name="u">
							<xsl:attribute name="who"><xsl:value-of select="./@who"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="uID"><xsl:value-of select="concat('u',position())"></xsl:value-of></xsl:attribute>
							<xsl:apply-templates select="s"/>
							<xsl:if test="./s and ./s/w">
							<xsl:text>&#xd;&#xa;</xsl:text><t type="p">
								<mor type="mor">
									<mt type="p"/>
									<gra type="gra" index="11" head="1" relation="PUNCT"/>
								</mor>
							</t>
							</xsl:if>
							<xsl:if test="not(./s) or not(./s/w)">
								<e><action/></e>
								<t type="p"></t>
							</xsl:if>
							
							<postcode>dia</postcode>
							<xsl:element name="media">
								<xsl:if test="./s">
								
									<xsl:attribute name="start"><xsl:if test="matches(./s[1]/@startTime,'[0-9\.]+')"><xsl:value-of select="./s[1]/@startTime"></xsl:value-of></xsl:if><xsl:if test="matches(./s[1]/@startTime,'[^0-9]+')">0</xsl:if><xsl:if test="matches(./s[1]/@startTime,'^$')">0</xsl:if></xsl:attribute>
								
									<xsl:attribute name="end"><xsl:if test="matches(./s[last()]/@endTime,'[0-9\.]+')"><xsl:value-of select="./s[last()]/@endTime"></xsl:value-of></xsl:if><xsl:if test="matches(./s[last()]/@endTime,'[^0-9]+')">1</xsl:if><xsl:if test="matches(./s[last()]/@endTime,'^$')">1</xsl:if></xsl:attribute>
									
									
									<xsl:attribute name="unit"><xsl:text>s</xsl:text></xsl:attribute>
								</xsl:if>
								<xsl:if test="not(./s)">
									<xsl:attribute name="start">0</xsl:attribute>
									<xsl:attribute name="end">1</xsl:attribute>
									<xsl:attribute name="unit"><xsl:text>s</xsl:text></xsl:attribute>
								</xsl:if>
							</xsl:element>
							<xsl:if test="not(./s) and not(./vocal)">
								<a type="gesture">unidentified</a> 
							</xsl:if>
							<xsl:if test="not(./s) and ./vocal">
								<a type="gesture"><xsl:value-of select="./vocal/@desc"></xsl:value-of></a> 
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:element>
		</xsl:result-document>
</xsl:if>	
	</xsl:template>
	<xsl:template match="s">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="w">
		<xsl:element name="w">
			<xsl:value-of select="."/>
			<xsl:element name="mor">
				<xsl:attribute name="type">mor</xsl:attribute>
				<xsl:element name="mw">
					<xsl:element name="pos">
						<xsl:element name="c">
							<xsl:value-of select="./@pos"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="stem">
						<xsl:value-of select="./@hw"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="gra">
					<xsl:attribute name="type">gra</xsl:attribute>
					<xsl:attribute name="index"><xsl:value-of select="position()"></xsl:value-of></xsl:attribute>
					<xsl:attribute name="head"><xsl:value-of select="position()"></xsl:value-of></xsl:attribute>
					<xsl:attribute name="relation"><xsl:value-of select="./@c5"></xsl:value-of></xsl:attribute>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="c">
		<!--<xsl:element name="t">
			<xsl:attribute name="type">technical break TCU continuation</xsl:attribute>
			<xsl:element name="mor">
				<xsl:attribute name="type">mor</xsl:attribute>
				<xsl:element name="mt">
					<xsl:attribute name="type">p</xsl:attribute>
				</xsl:element>
				<xsl:element name="gra">
					<xsl:attribute name="type">gra</xsl:attribute>
					<xsl:attribute name="index"><xsl:value-of select="position()"></xsl:value-of></xsl:attribute>
					<xsl:attribute name="head"><xsl:value-of select="position()"></xsl:value-of></xsl:attribute>
					<xsl:attribute name="relation"><xsl:value-of select="./@c5"></xsl:value-of></xsl:attribute>
				</xsl:element>
			</xsl:element>
		</xsl:element>-->
	</xsl:template>
	<xsl:template name="formatdate">
		<xsl:param name="datestr"/>
		<!-- input format mmddyyyy -->
		<!-- output format mm/dd/yyyy -->
		<xsl:variable name="yyyy">
			<xsl:value-of select="substring($datestr,1,4)"/>
		</xsl:variable>
		<xsl:variable name="mm">
			<xsl:value-of select="substring($datestr,6,2)"/>
		</xsl:variable>
		<xsl:variable name="dd">
			<xsl:value-of select="substring($datestr,9,2)"/>
		</xsl:variable>
		<xsl:value-of select="$dd"/>
		<xsl:value-of select="'-'"/>
		  <xsl:choose>
			<xsl:when test="$mm = '01'"><xsl:text>JAN</xsl:text></xsl:when>
			<xsl:when test="$mm = '02'"><xsl:text>FEB</xsl:text></xsl:when>
			<xsl:when test="$mm = '03'"><xsl:text>MAR</xsl:text></xsl:when>
			<xsl:when test="$mm = '04'"><xsl:text>APR</xsl:text></xsl:when>
			<xsl:when test="$mm = '05'"><xsl:text>MAY</xsl:text></xsl:when>
			<xsl:when test="$mm = '06'"><xsl:text>JUN</xsl:text></xsl:when>
			<xsl:when test="$mm = '07'"><xsl:text>JUL</xsl:text></xsl:when>
			<xsl:when test="$mm = '08'"><xsl:text>AUG</xsl:text></xsl:when>
			<xsl:when test="$mm = '09'"><xsl:text>SEP</xsl:text></xsl:when>
			<xsl:when test="$mm = '10'"><xsl:text>OCT</xsl:text></xsl:when>
			<xsl:when test="$mm = '11'"><xsl:text>NOV</xsl:text></xsl:when>
			<xsl:when test="$mm = '12'"><xsl:text>DEC</xsl:text></xsl:when>
		  </xsl:choose>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$yyyy"/>
	</xsl:template>
	<xsl:template match="text()"/>
</xsl:stylesheet>
