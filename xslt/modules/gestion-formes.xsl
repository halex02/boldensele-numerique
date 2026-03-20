<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:amh="urn:alexandre-moret:fonctions-personnalisees"
    exclude-result-prefixes="xs office text amh"
    version="3.0">

    <xsl:template name="generer-formes">
        <xsl:param name="lemme"
            as="xs:string" />
        <xsl:param name="occurrences"
            as="element(text:span)*" />

        <liste-formes>
            <xsl:call-template name="generer-forme-lemme">
                <xsl:with-param name="lemme"
                    select="$lemme" />
                <!-- on passe le lemmme en paramètre pour l’insérer dans graphie-->
                <xsl:with-param name="occurrences"
                    select="$occurrences" />
                <!-- on passe les occurrences en paramètre pour pouvoir générer les attestations -->
            </xsl:call-template>
            <xsl:call-template name="generer-forme-flexion">
                <xsl:with-param name="lemme"
                    select="$lemme" />
                <!-- on passe le lemme en paramètre pour le comparer aux formes fléchies afin de ne pas l'inclure deux fois -->
                <xsl:with-param name="occurrences"
                    select="$occurrences" />
                <!-- on passe les occurrences en paramètre pour pouvoir générer les attestations -->
            </xsl:call-template>
        </liste-formes>
    </xsl:template>

    <xsl:template name="generer-forme-lemme">
        <xsl:param name="lemme"
            as="xs:string" />
        <xsl:param name="occurrences"
            as="element(text:span)*" />

        <xsl:variable name="occurrences-lemme"
            as="element(text:span)*"
            select="$occurrences[amh:normaliser-graphie(amh:forme-attestee(.)) = $lemme]" />
        <!-- On filtre les occurrences pour ne garder que celles dont le contenu correspond exactement au lemme, 
        afin de générer les attestations uniquement pour la forme lemme et pas pour les formes fléchies 
        qui peuvent être présentes dans les mêmes occurrences -->

        <forme type="lemme">
            <graphie xml:lang="{$lang-formes}">                <!-- Il s’agit de la langue de la forme, à différencier de la langue principale du glossaire -->
                <xsl:value-of select="$lemme" />
            </graphie>
            <categorie_grammaticale>
                <xsl:text>À compléter</xsl:text>
            </categorie_grammaticale>
            <xsl:call-template name="generer-attestations">
                <xsl:with-param name="occurrences"
                    select="$occurrences-lemme" />
                <!-- on passe les occurrences du lemme en paramètre pour générer les attestations -->
            </xsl:call-template>
        </forme>
    </xsl:template>

    <xsl:template name="generer-forme-flexion">
        <xsl:param name="lemme"
            as="xs:string" />
        <xsl:param name="occurrences"
            as="element(text:span)*" />

        <xsl:for-each-group select="$occurrences[normalize-space(amh:forme-attestee(.)) != '']"
            group-by="amh:normaliser-graphie(amh:forme-attestee(.))">

            <xsl:sort select="lower-case(current-grouping-key())" />

            <xsl:if test="current-grouping-key() != $lemme">
                <forme type="flexion">
                    <graphie xml:lang="{$lang-formes}">
                        <xsl:value-of select="current-grouping-key()" />
                    </graphie>

                    <categorie_grammaticale>
                        <xsl:text>À compléter</xsl:text>
                    </categorie_grammaticale>

                    <xsl:call-template name="generer-attestations">
                        <xsl:with-param name="occurrences"
                            select="current-group()" />
                    </xsl:call-template>
                </forme>
            </xsl:if>
        </xsl:for-each-group>
    </xsl:template>

    <xsl:template name="generer-attestations">
        <!-- template générique pour générer les attestations, qui peut être appelé depuis n’importe quelle forme (lemme ou flexion) -->
        <xsl:param name="occurrences"
            as="element(text:span)*" />

        <liste-attestations>
            <xsl:choose>
                <xsl:when test="empty($occurrences)">                    <!-- Si la séquence d’occurrences est vide, on génère une attestation d’absence pour indiquer que le terme n’est pas attesté dans le texte source, c’est important dans le cas des lemmes -->
                    <absence-attestation />
                </xsl:when>
                <xsl:otherwise>                    <!-- Sinon, on génère une attestation pour chaque occurrence, en appelant un template de génération de localisation pour chaque occurrence afin d’insérer les localisations associées à chaque attestation -->
                    <xsl:for-each select="$occurrences">
                        <attestation idref="#{amh:id-attestation(.)}">
                            <xsl:call-template name="generer-localisation">
                                <xsl:with-param name="occurrence"
                                    select="." />
                            </xsl:call-template>
                        </attestation>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </liste-attestations>
    </xsl:template>

    <xsl:function name="amh:normaliser-graphie"
        as="xs:string">
        <xsl:param name="s"
            as="xs:string" />

        <xsl:variable name="minuscules"
            as="xs:string"
            select="translate(
            normalize-space($s),
            'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
            'abcdefghijklmnopqrstuvwxyz'
        )" />

        <xsl:sequence select="
        translate($minuscules, 'vj', 'ui')
    " />
    </xsl:function>

</xsl:stylesheet>