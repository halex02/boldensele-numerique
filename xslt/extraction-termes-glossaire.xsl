<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="xs office text" version="3.0">
	<xsl:output encoding="UTF-8" method="xml" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<glossaire xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:noNamespaceSchemaLocation="../xml/glossaire.xsd" xml:lang="fr">
			<metadonnees>
				<dc:title>Glossaire</dc:title>
				<dc:creator>Moret Alexandre</dc:creator>
				<dc:language>fr</dc:language>
				<dc:source>Le Roman de Brut</dc:source>
			</metadonnees>
			<liste-termes>
				<xsl:for-each-group select="//text:span[@text:style-name = 'marquage_5f_glossaire']"
					group-by=".">
					<xsl:sort select="."/>
					<xsl:variable name="compteur-occurences" select="count(current-group())"/>
					<terme>
						<xsl:attribute name="id">
							<xsl:value-of
								select="concat('t', format-number(position(), '00'), '-', current-grouping-key())"/>
						</xsl:attribute>
						<lemme xml:lang="fro">
							<xsl:value-of select="current-grouping-key()"/>
						</lemme>
						<nombre-occurences>
							<xsl:value-of select="$compteur-occurences"/>
						</nombre-occurences>
						<definition>À compléter</definition>
						<flexions>
							<traitement_forme_flechie>
								<forme_flechie>À compléter</forme_flechie>
								<positions>
									<xsl:for-each select="current-group()">
										<numero-vers>
											<xsl:value-of
												select="count(ancestor::text:p[matches(@text:style-name, '^P([1-9]|1[12356789]|2[013456789]|3[1-7])$')]/preceding-sibling::text:p[matches(@text:style-name, '^P([1-9]|1[12356789]|2[013456789]|3[1-7])$')])"
											/>
										</numero-vers>
									</xsl:for-each>
								</positions>
							</traitement_forme_flechie>
						</flexions>
					</terme>
				</xsl:for-each-group>
			</liste-termes>
		</glossaire>
	</xsl:template>
</xsl:stylesheet>
