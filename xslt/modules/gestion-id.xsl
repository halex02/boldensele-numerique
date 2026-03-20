<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:amh="urn:alexandre-moret:fonctions-personnalisees"
    exclude-result-prefixes="xs office text amh"
    version="3.0">

    <xsl:function name="amh:generer-id"
        as="xs:string">
        <xsl:param name="prefixe-id"
            as="xs:string" />
        <xsl:param name="compteur"
            as="xs:integer" />

        <xsl:sequence select="concat($prefixe-id, '-', format-number($compteur, '0000'))" />
        <!-- Génère un identifiant unique en combinant un préfixe et un compteur formaté avec des zéros, sous la forme gls-0001 dans le cas present -->
    </xsl:function>

    <xsl:function name="amh:id-attestation"
        as="xs:string">
        <xsl:param name="ancre"
            as="element(text:span)" />
        <xsl:variable name="rang"
            as="xs:integer"
            select="count($ancre/preceding::text:span[@text:style-name = $style-ancre-glossaire]) + 1" />

        <xsl:sequence select="amh:generer-id($prefix-id-mot, $rang)" />
    </xsl:function>

</xsl:stylesheet>