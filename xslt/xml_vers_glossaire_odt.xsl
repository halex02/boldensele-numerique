<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:math="http://www.w3.org/2005/xpath-functions/math"
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	exclude-result-prefixes="xs math office" version="3.0">

	<xsl:output encoding="UTF-8" method="xml" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<office:document-content xmlns:css3t="http://www.w3.org/TR/css3-text/"
			xmlns:grddl="http://www.w3.org/2003/g/data-view#" xmlns:xhtml="http://www.w3.org/1999/xhtml"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xforms="http://www.w3.org/2002/xforms"
			xmlns:dom="http://www.w3.org/2001/xml-events"
			xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
			xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
			xmlns:math="http://www.w3.org/1998/Math/MathML"
			xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
			xmlns:ooo="http://openoffice.org/2004/office"
			xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
			xmlns:ooow="http://openoffice.org/2004/writer" xmlns:xlink="http://www.w3.org/1999/xlink"
			xmlns:drawooo="http://openoffice.org/2010/draw" xmlns:oooc="http://openoffice.org/2004/calc"
			xmlns:dc="http://purl.org/dc/elements/1.1/"
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
					svg:font-family="&apos;Junicode Cond Medium&apos;" style:font-adornments="Normal"
					style:font-pitch="variable"/>
				<style:font-face style:name="Liberation Sans" svg:font-family="&apos;Liberation Sans&apos;"
					style:font-family-generic="swiss" style:font-pitch="variable"/>
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
						<xsl:sort select="lemme//forme_flechie" order="ascending"/>
					</xsl:apply-templates>
				</office:text>
			</office:body>
		</office:document-content>
	</xsl:template>

	<xsl:template match="terme">
		<text:p text:style-name="P50">
			<xsl:apply-templates select="lemme"/>
			<xsl:apply-templates select="nombre-occurences"/>
			<xsl:text> : </xsl:text>
			<xsl:apply-templates select="definition"/>
			<xsl:if test="./flexions">
				<xsl:text> – </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="flexions"/>
		</text:p>
	</xsl:template>

	<xsl:template match="lemme">
		<xsl:apply-templates select="./traitement_forme_flechie"/>
	</xsl:template>
	
	<xsl:template match="traitement_forme_flechie">
		<xsl:choose>
			<xsl:when test="ancestor::lemme">
				<text:span text:style-name="item_5f_en_5f_adresse">
					<xsl:value-of select="./forme_flechie"/>
					<xsl:if test=".//absence-forme">
						<xsl:text>*</xsl:text>
					</xsl:if>
					<xsl:text> </xsl:text>
				</text:span>
			</xsl:when>
			<xsl:when test="ancestor::flexions">
				<text:span text:style-name="forme_5f_flechie">
					<xsl:value-of select="./forme_flechie"/>
					<xsl:text> </xsl:text>
				</text:span>
			</xsl:when>
		</xsl:choose>
		<xsl:apply-templates select="./categorie_grammaticale"/>
		<xsl:if test="not(.//absence-forme)">
			<xsl:text> </xsl:text>
			<text:span text:style-name="positions">
				<xsl:text>[</xsl:text>
				<xsl:choose>
					<xsl:when test="count(.//numero-vers) = 1">
						<xsl:text>v.</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>vv.</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select=".//numero-vers"/>
				<xsl:text>] </xsl:text>
			</text:span>
		</xsl:if>
		<xsl:if test="following-sibling::traitement_forme_flechie">
			<xsl:text> ; </xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="categorie_grammaticale">
		<text:span text:style-name="indication_5f_grammaticale">
			<xsl:text>(</xsl:text>
			<xsl:choose>
				<xsl:when test="substantif">
					<xsl:apply-templates select="substantif"/>
				</xsl:when>
				<xsl:when test="adjectif">
					<xsl:apply-templates select="adjectif"/>
				</xsl:when>
				<xsl:when test="verbe">
					<xsl:apply-templates select="verbe"/>
				</xsl:when>
				<xsl:when test="adverbe">
					<xsl:apply-templates select="adverbe"/>
				</xsl:when>
			</xsl:choose>
			<xsl:text>)</xsl:text>
		</text:span>
		<xsl:text> </xsl:text>

	</xsl:template>
	<xsl:template match="substantif | adjectif">
		<xsl:value-of select="local-name()"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="genre"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="nombre"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="cas"/>
	</xsl:template>
	<xsl:template match="cas">
		<xsl:choose>
			<xsl:when test=". = 'sujet'">
				<xsl:text>CS</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'régime'">
				<xsl:text>CR</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="genre">
		<xsl:choose>
			<xsl:when test=". = 'masculin'">
				<xsl:text>m.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'féminin'">
				<xsl:text>f.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'neutre'">
				<xsl:text>n.</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="nombre">
		<xsl:choose>
			<xsl:when test=". = 'singulier'">
				<xsl:text>sg.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'pluriel'">
				<xsl:text>pl.</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="verbe">
		<xsl:value-of select="local-name()"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="mode"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="temps"/>
		<xsl:if test="not(./mode = 'infinitif' or ./mode = 'participe')">
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="personne"/>
		</xsl:if>

		<xsl:if test="./mode = 'participe'">
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="genre"/>
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="nombre"/>
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="cas"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="mode">
		<xsl:choose>
			<xsl:when test=". = 'infinitif'">
				<xsl:text>inf.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'indicatif'">
				<xsl:text>ind.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'impératif'">
				<xsl:text>imp.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'subjonctif'">
				<xsl:text>subj.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'participe'">
				<xsl:text>part.</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="temps">
		<xsl:choose>
			<xsl:when test=". = 'présent'">
				<xsl:text>pst.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'passé simple'">
				<xsl:text>p.s.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'imparfait'">
				<xsl:text>impft.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'futur I'">
				<xsl:text>fut. I</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'futur II'">
				<xsl:text>fut. II</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'futur antérieur'">
				<xsl:text>fut. ant.</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'forme en -ant'">
				<xsl:text>f. -ant</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'plus-que-parfait'">
				<xsl:text>p. q. p.</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="personne">
		<xsl:value-of select="concat('p', .)"/>
	</xsl:template>
	<xsl:template match="adverbe">
		<xsl:text>adverbe</xsl:text>
	</xsl:template>

	<xsl:template match="numero-vers">
		<xsl:text> </xsl:text>
		<xsl:value-of select="."/>
		<xsl:if test="following-sibling::numero-vers">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="nombre-occurences">
		<text:span text:style-name="nombre_5f_occurences">
			<xsl:text>(</xsl:text>
			<xsl:value-of select="concat(., ' occ.')"/>
			<xsl:text>)</xsl:text>
		</text:span>
	</xsl:template>

	<xsl:template match="definition">
		<text:span text:style-name="definition">
			<xsl:value-of select="."/>
		</text:span>
	</xsl:template>
</xsl:stylesheet>
