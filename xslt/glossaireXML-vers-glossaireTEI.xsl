<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:gls="https://halex02.github.io/boldensele-numerique/ns/glossaire"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    exclude-result-prefixes="xs tei gls dc"
    version="3.0">

    <xsl:output encoding="UTF-8"
        method="xml"
        indent="yes" />
    <xsl:strip-space elements="*" />

    <xsl:variable name="lang-glossaire"
        select="/gls:glossaire/@xml:lang" />

    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <xsl:call-template name="generer-teiHeader" />
            </teiHeader>
            <text>
                <body>
                    <xsl:call-template name="transformer-glossaire" />
                </body>
            </text>
        </TEI>
    </xsl:template>

    <xsl:template name="generer-teiHeader">
        <fileDesc>
            <titleStmt>
                <title>
                    <xsl:value-of select="/gls:glossaire/gls:metadonnees/dc:title" />
                </title>
            </titleStmt>
            <publicationStmt>
                <p>Publié par <xsl:value-of select="/gls:glossaire/gls:metadonnees/dc:creator" />
                </p>
            </publicationStmt>
            <sourceDesc>
                <p>Source : <xsl:value-of select="/gls:glossaire/gls:metadonnees/dc:source" />
                </p>
            </sourceDesc>
        </fileDesc>
    </xsl:template>

    <xsl:template name="transformer-glossaire">
        <div type="glossaire"
            xml:lang="{$lang-glossaire}">
            <xsl:apply-templates select="/gls:glossaire/gls:liste-termes" />
        </div>
    </xsl:template>

    <xsl:template match="gls:liste-termes | gls:liste-formes | gls:liste-attestations">
         <xsl:apply-templates />
        <xsl:apply-templates select="gls:terme" />
    </xsl:template>

    <xsl:template match="gls:terme">
        <entry xml:id="{@id}">
            <xsl:apply-templates select="gls:liste-formes" />
            <xsl:apply-templates select="gls:definition | gls:renvoi" />
        </entry>
    </xsl:template>

    <xsl:template match="gls:definition">
        <sense>
            <def xml:lang="{$lang-glossaire}">
                <xsl:value-of select="normalize-space(.)" />
            </def>
        </sense>
    </xsl:template>

    <xsl:template match="gls:renvoi">
        <xr type="synonyme">
            <ref target="{@idref}" />
        </xr>
    </xsl:template>

    <xsl:template match="gls:forme">
        <form>
            <xsl:if test="@type">
                <xsl:attribute name="type" select="@type" />
            </xsl:if>

            <xsl:apply-templates select="gls:graphie" />
            <xsl:apply-templates select="gls:categorie_grammaticale" />
            <xsl:apply-templates select="gls:liste-attestations" />
        </form>
    </xsl:template>

    <xsl:template match="gls:graphie">
        <orth>
            <xsl:copy-of select="@xml:lang" />
            <xsl:value-of select="normalize-space(.)" />
        </orth>
    </xsl:template>

    <xsl:template match="gls:categorie_grammaticale">
        <gramGrp>
            <xsl:apply-templates />
        </gramGrp>
    </xsl:template>

    <xsl:template match="gls:substantif | gls:adjectif | gls:verbe | gls:adverbe | gls:pronom | gls:preposition | gls:article | gls:interjection">
        <pos>
            <xsl:value-of select="local-name()" />
        </pos>
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="gls:genre | gls:nombre | gls:cas | gls:degre | gls:construction | gls:mode | gls:temps | gls:voix | gls:personne">
        <gram type="{local-name()}">
            <xsl:value-of select="normalize-space(.)" />
        </gram>
    </xsl:template>

    <xsl:template match="gls:absence-attestation" />

    <xsl:template match="gls:attestation">
        <cit type="attestation">
            <ref target="{@idref}" />
            <xsl:apply-templates select="gls:localisation" />
        </cit>
    </xsl:template>

    <xsl:template match="gls:localisation">
        <bibl>
            <locus>
                <xsl:value-of select="concat('f.&#160;', normalize-space(gls:ref-folio), string(gls:ref-folio/@cote))" />
            </locus>
        </bibl>
    </xsl:template>

</xsl:stylesheet>