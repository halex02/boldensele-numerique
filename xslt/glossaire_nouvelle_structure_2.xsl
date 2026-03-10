<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
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

	<xsl:template match="lemme">
		<lemme>
			<xsl:attribute name="xml:lang"><xsl:text>fro</xsl:text></xsl:attribute>
		<xsl:choose>
			<xsl:when test="lemme = ancestor::terme/flexions/traitement_forme_flechie/forme_flechie">
				<xsl:copy-of select="ancestor::terme/flexions/traitement_forme_flechie"/>
			</xsl:when>
			<xsl:otherwise>
				<traitement_forme_flechie>
					<forme_flechie>
						<xsl:attribute name="xml:lang">fro</xsl:attribute>
						<xsl:value-of select="."/>
					</forme_flechie>
					<categorie_grammaticale>
						<xsl:if test="@nature = 'substantif'">
							<substantif>
								<xsl:if test="@genre">
									<genre><xsl:value-of select="@genre"/></genre>
								</xsl:if>
								<xsl:if test="@nombre">
									<nombre><xsl:value-of select="@nombre"/></nombre>
								</xsl:if>
								<xsl:if test="@cas">
									<cas><xsl:value-of select="@cas"/></cas>
								</xsl:if>
							</substantif>
						</xsl:if>
						<xsl:if test="@nature = 'adjectif'">
							<xsl:if test="@genre">
								<genre><xsl:value-of select="@genre"/></genre>
							</xsl:if>
							<xsl:if test="@nombre">
								<nombre><xsl:value-of select="@nombre"/></nombre>
							</xsl:if>
							<xsl:if test="@cas">
								<cas><xsl:value-of select="@cas"/></cas>
							</xsl:if>
							<xsl:if test="@construction">
								<construction><xsl:value-of select="@construction"/></construction>
							</xsl:if>
						</xsl:if>
						<xsl:if test="@nature = 'verbe'">
							<verbe>
								<xsl:if test="@mode">
									<mode><xsl:value-of select="@mode"/></mode>
								</xsl:if>
								<xsl:if test="@temps">
									<temps><xsl:value-of select="@temps"/></temps>
								</xsl:if>
								<xsl:if test="@voix">
									<voix><xsl:value-of select="@voix"/></voix>
								</xsl:if>
								<xsl:if test="@personne">
									<personne><xsl:value-of select="@personne"/></personne>
								</xsl:if>
								<xsl:if test="@construction">
									<construction><xsl:value-of select="@construction"/></construction>
								</xsl:if>
								<xsl:if test="@genre">
									<genre><xsl:value-of select="@genre"/></genre>
								</xsl:if>
								<xsl:if test="@nombre">
									<nombre><xsl:value-of select="@nombre"/></nombre>
								</xsl:if>
								<xsl:if test="@cas">
									<cas><xsl:value-of select="@cas"/></cas>
								</xsl:if>
							</verbe>
						</xsl:if>
						<xsl:if test="@nature = 'adverbe'">
							<adverbe/>
						</xsl:if>
						<xsl:if test="@nature = 'pronom'">
							<pronom/>
						</xsl:if>
						<xsl:if test="@nature = 'preposition'">
							<preposition>
								<xsl:if test="@construction">
									<construction><xsl:value-of select="@construction"/></construction>
								</xsl:if>
							</preposition>
						</xsl:if>
						<xsl:if test="@nature = 'article'">
							<article/>
						</xsl:if>
						<xsl:if test="@nature = 'interjection'">
							<interjection/>
						</xsl:if>
					</categorie_grammaticale>
					<positions>
						<absence-forme/>
					</positions>
				</traitement_forme_flechie>
			</xsl:otherwise>
		</xsl:choose>
		</lemme>
	</xsl:template>

</xsl:stylesheet>
