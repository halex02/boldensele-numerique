<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	exclude-result-prefixes="xs office text" version="2.0">


	<xsl:output encoding="UTF-8" method="xml" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<office:document-content xmlns:css3t="http://www.w3.org/TR/css3-text/"
			xmlns:grddl="http://www.w3.org/2003/g/data-view#"
			xmlns:xhtml="http://www.w3.org/1999/xhtml"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:xsd="http://www.w3.org/2001/XMLSchema"
			xmlns:xforms="http://www.w3.org/2002/xforms"
			xmlns:dom="http://www.w3.org/2001/xml-events"
			xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
			xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
			xmlns:math="http://www.w3.org/1998/Math/MathML"
			xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
			xmlns:ooo="http://openoffice.org/2004/office"
			xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
			xmlns:ooow="http://openoffice.org/2004/writer"
			xmlns:xlink="http://www.w3.org/1999/xlink"
			xmlns:drawooo="http://openoffice.org/2010/draw"
			xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dc="http://purl.org/dc/elements/1.1/"
			xmlns:calcext="urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0"
			xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
			xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
			xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2"
			xmlns:tableooo="http://openoffice.org/2009/table"
			xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
			xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
			xmlns:rpt="http://openoffice.org/2005/report"
			xmlns:formx="urn:openoffice:names:experimental:ooxml-odf-interop:xmlns:form:1.0"
			xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
			xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
			xmlns:officeooo="http://openoffice.org/2009/office"
			xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
			xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
			xmlns:loext="urn:org:documentfoundation:names:experimental:office:xmlns:loext:1.0"
			xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
			xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0"
			office:version="1.3">
			<office:scripts/>
			<office:font-face-decls>
				<style:font-face style:name="FreeSans" svg:font-family="FreeSans"
					style:font-family-generic="swiss"/>
				<style:font-face style:name="FreeSans1" svg:font-family="FreeSans"
					style:font-family-generic="system" style:font-pitch="variable"/>
				<style:font-face style:name="Junicode Cond Medium"
					svg:font-family="&apos;Junicode Cond Medium&apos;"
					style:font-adornments="Normal" style:font-pitch="variable"/>
				<style:font-face style:name="Liberation Sans"
					svg:font-family="&apos;Liberation Sans&apos;" style:font-family-generic="swiss"
					style:font-pitch="variable"/>
				<style:font-face style:name="Liberation Serif"
					svg:font-family="&apos;Liberation Serif&apos;" style:font-family-generic="roman"
					style:font-pitch="variable"/>
				<style:font-face style:name="Nimbus Sans" svg:font-family="&apos;Nimbus Sans&apos;"
					style:font-family-generic="system" style:font-pitch="variable"/>
			</office:font-face-decls>
			<office:automatic-styles>
				<style:style style:name="P1" style:family="paragraph"
					style:parent-style-name="index_5f_entree">
					<style:paragraph-properties fo:break-before="page"/>
					<style:text-properties officeooo:paragraph-rsid="000b6723"/>
				</style:style>
				<style:style style:name="T1" style:family="text">
					<style:text-properties officeooo:rsid="0057eb60"/>
				</style:style>
			</office:automatic-styles>
			<office:body>
				<office:text>
					<text:sequence-decls>
						<text:sequence-decl text:display-outline-level="0" text:name="Illustration"/>
						<text:sequence-decl text:display-outline-level="0" text:name="Table"/>
						<text:sequence-decl text:display-outline-level="0" text:name="Text"/>
						<text:sequence-decl text:display-outline-level="0" text:name="Drawing"/>
						<text:sequence-decl text:display-outline-level="0" text:name="Figure"/>
					</text:sequence-decls>
					<xsl:apply-templates select="//terme">
						<xsl:sort select="cle-index" order="ascending"/>
					</xsl:apply-templates>
				</office:text>
			</office:body>
		</office:document-content>
	</xsl:template>

	<xsl:template match="terme">
		<text:p text:style-name="P1">
			<text:span text:style-name="index-glossaire_5f_item_5f_en_5f_adresse">
				<xsl:value-of select="cle-index"/>
			</text:span>
			<xsl:text> </xsl:text>
			<text:span text:style-name="index-glossaire_5f_nombre_5f_occurences">
				<xsl:value-of select="concat('(', nombre-occurences, ')')"/>
			</text:span>
			<xsl:text> : </xsl:text>
			<text:span text:style-name="index-glossaire_5f_description">
				<xsl:apply-templates/>
			</text:span>
			<xsl:text> – </xsl:text>
			<text:span text:style-name="index-glossaire_5f_positions">
				<xsl:for-each select="flexions/traitement_forme_flechie">
					<xsl:variable name="nomCourant1" select="local-name()"/>
					<xsl:value-of select="forme_flechie"/>
					<xsl:text> : </xsl:text>
					<xsl:for-each select="positions/numero-vers">
						<xsl:variable name="nomCourant2" select="local-name()"/>
						<xsl:value-of select="."/>
						<xsl:if test="following-sibling::*[local-name() = $nomCourant2]">
							<xsl:text>, </xsl:text>
						</xsl:if>
					</xsl:for-each>
					<xsl:if test="following-sibling::*[local-name() = $nomCourant1]">
						<xsl:text> ; </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</text:span>
			<xsl:text>.</xsl:text>
		</text:p>
	</xsl:template>
	
	<xsl:template match="titre_oeuvre">
		<xsl:if test="preceding-sibling::text()">
			<xsl:text> </xsl:text>
		</xsl:if>
		<text:span text:style-name="titre_5f_oeuvre">
			<xsl:value-of select="."/>
		</text:span>
		<xsl:if test="following-sibling::text()"></xsl:if>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:value-of select="normalize-space(.)"/>
	</xsl:template>
	
	<xsl:template match="cle-index"/>
	<xsl:template match="nombre-occurences"/>
	<xsl:template match="flexions"/>
	
</xsl:stylesheet>
