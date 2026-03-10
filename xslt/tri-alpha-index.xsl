<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs"
	version="2.0">
	<xsl:output encoding=" UTF-8" method=" xml" indent="yes"/>
	<xsl:strip-space elements="*"/>
	
	<!-- Template générique qui ne fait que copier des éléments.
	Quand on crée un template qui match le motif générique *,
	tout template spécifique va prendre le pas dessus
	-->
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
	
	<!-- Template qui match l’élément racine -->
	<xsl:template match="index">
		<xsl:element name="index">
			<xsl:element name="titre">
				<xsl:value-of select="descendant::titre"/>
			</xsl:element>
			
			<xsl:apply-templates select="descendant::terme">
				<!--  on trie les termes dans l’ordre alphabétique en regardant les éléments cle-index -->
				<xsl:sort order="ascending" select="./cle-index"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	
	<!-- template qui match l’élément terme -->
	<xsl:template match="terme">
		<xsl:element name="terme">
			<xsl:apply-templates/><!-- tous les éléments fils de terme sont gérés par le template générique -->
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
