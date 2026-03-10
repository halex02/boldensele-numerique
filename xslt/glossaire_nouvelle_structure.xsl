<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:math="http://www.w3.org/2005/xpath-functions/math"
	
	exclude-result-prefixes="xs math"
	version="3.0">
	
	<xsl:output method="xml" indent="yes"/>
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="*">
		<xsl:element name="{local-name()}">
			<xsl:for-each select="attribute::*">
				<xsl:attribute name="{local-name()}">
					<xsl:value-of select="."/>
				</xsl:attribute>
			</xsl:for-each>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<xsl:template match="traitement_forme_flechie">
	<xsl:element name="{local-name()}">
	<forme_flechie>
		<xsl:attribute name="xml:lang">fro</xsl:attribute>
		<xsl:value-of select="forme_flechie"/></forme_flechie>
	<categorie_grammaticale>
		<xsl:if test="forme_flechie/@nature = 'substantif'">
			<substantif>
				<xsl:if test="forme_flechie/@genre">
				<genre><xsl:value-of select="forme_flechie/@genre"/></genre>
				</xsl:if>
				<xsl:if test="forme_flechie/@nombre">
					<nombre><xsl:value-of select="forme_flechie/@nombre"/></nombre>
				</xsl:if>
				<xsl:if test="forme_flechie/@cas">
					<cas><xsl:value-of select="forme_flechie/@cas"/></cas>
				</xsl:if>
			</substantif>
		</xsl:if>
		<xsl:if test="forme_flechie/@nature = 'adjectif'">
			<xsl:if test="forme_flechie/@genre">
				<genre><xsl:value-of select="forme_flechie/@genre"/></genre>
			</xsl:if>
			<xsl:if test="forme_flechie/@nombre">
				<nombre><xsl:value-of select="forme_flechie/@nombre"/></nombre>
			</xsl:if>
			<xsl:if test="forme_flechie/@cas">
				<cas><xsl:value-of select="forme_flechie/@cas"/></cas>
			</xsl:if>
			<xsl:if test="forme_flechie/@construction">
				<construction><xsl:value-of select="forme_flechie/@construction"/></construction>
			</xsl:if>
		</xsl:if>
		<xsl:if test="forme_flechie/@nature = 'verbe'">
			<verbe>
				<xsl:if test="forme_flechie/@mode">
					<mode><xsl:value-of select="forme_flechie/@mode"/></mode>
				</xsl:if>
				<xsl:if test="forme_flechie/@temps">
					<temps><xsl:value-of select="forme_flechie/@temps"/></temps>
				</xsl:if>
				<xsl:if test="forme_flechie/@voix">
					<voix><xsl:value-of select="forme_flechie/@voix"/></voix>
				</xsl:if>
				<xsl:if test="forme_flechie/@personne">
					<personne><xsl:value-of select="forme_flechie/@personne"/></personne>
				</xsl:if>
				<xsl:if test="forme_flechie/@construction">
					<construction><xsl:value-of select="forme_flechie/@construction"/></construction>
				</xsl:if>
				<xsl:if test="forme_flechie/@genre">
					<genre><xsl:value-of select="forme_flechie/@genre"/></genre>
				</xsl:if>
				<xsl:if test="forme_flechie/@nombre">
					<nombre><xsl:value-of select="forme_flechie/@nombre"/></nombre>
				</xsl:if>
				<xsl:if test="forme_flechie/@cas">
					<cas><xsl:value-of select="forme_flechie/@cas"/></cas>
				</xsl:if>
			</verbe>
		</xsl:if>
		<xsl:if test="forme_flechie/@nature = 'adverbe'">
			<adverbe/>
		</xsl:if>
		<xsl:if test="forme_flechie/@nature = 'pronom'">
			<pronom/>
		</xsl:if>
		<xsl:if test="forme_flechie/@nature = 'preposition'">
			<preposition>
				<xsl:if test="forme_flechie/@construction">
					<construction><xsl:value-of select="forme_flechie/@construction"/></construction>
				</xsl:if>
			</preposition>
		</xsl:if>
		<xsl:if test="forme_flechie/@nature = 'article'">
			<article/>
		</xsl:if>
		<xsl:if test="forme_flechie/@nature = 'interjection'">
			<interjection/>
		</xsl:if>
	</categorie_grammaticale>
		<xsl:apply-templates/>
	</xsl:element>
</xsl:template>
	<xsl:template match="forme_flechie"/>
</xsl:stylesheet>