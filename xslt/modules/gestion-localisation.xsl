<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:amh="urn:alexandre-moret:fonctions-personnalisees"
    exclude-result-prefixes="xs office text amh"
    version="3.0">

    <xsl:template name="generer-localisation">
        <!-- generer-localisation est un wrapper générique qui peut gérer n’importe quelle type de localisation:
    qu’on utilise des références de folio, des vers, ou une pagination (les trois types de références présentes dans le schéma).
    on peut donc étendre les fonctionnalités de ce template pour gérer d’autres types de localisation, en fonction des besoins, sans toucher au code des attestations ou des formes.
    -->
        <xsl:param name="occurrence"
            as="element(text:span)" />

        <localisation>
            <xsl:call-template name="localisation-folio">                <!-- dans ce cas précis, on génère une localisation de type folio en appelant le template dédié -->
                <xsl:with-param name="occurrence"
                    select="$occurrence" />
            </xsl:call-template>
        </localisation>
    </xsl:template>

    <xsl:template name="localisation-folio">
        <!-- template dédié à la génération de références de folio, qui peut être appelé depuis le template de localisation générique -->
        <xsl:param name="occurrence" />

        <xsl:variable name="folio"
            select="amh:folio-brut($occurrence)" />
        <!-- on utilise la fonction d’extraction du texte brut de la foliotation pour récupérer le texte de la foliotation associée à l’occurrence -->
        <xsl:if test="normalize-space($folio) != ''">            <!-- on vérifie que le texte de la foliotation n’est pas vide avant de générer la référence de folio, pour éviter de créer des références vides. -->
            <ref-folio cote="{amh:folio-cote($occurrence)}">                <!-- on utilise la fonction d’extraction du côté du folio pour récupérer le côté (r ou v) du folio, et on l’insère dans l’attribut cote de ref-folio -->
                <xsl:value-of select="amh:folio-numero($occurrence)" />
                <!-- on utilise la fonction d’extraction du numéro de folio pour récupérer le numéro du folio, et on l’insère dans le contenu de ref-folio -->
            </ref-folio>
        </xsl:if>
    </xsl:template>


    <xsl:function name="amh:debut-bloc-foliotation"
        as="element(text:span)?">
        <xsl:param name="n"
            as="element(text:span)?" />

        <xsl:choose>
            <xsl:when test="empty($n)">
                <xsl:sequence select="()" />
            </xsl:when>
            <xsl:when test="amh:est-span-foliotation($n/preceding-sibling::node()[1])">
                <xsl:sequence select="amh:debut-bloc-foliotation($n/preceding-sibling::node()[1])" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$n" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="amh:folio-brut"
        as="xs:string?">
        <xsl:param name="ancre"
            as="element(text:span)" />

        <xsl:variable name="dernier-span"
            as="element(text:span)?"
            select="$ancre/preceding::text:span[@text:style-name = $style-foliotation][1]" />

        <xsl:variable name="debut-bloc"
            as="element(text:span)?"
            select="amh:debut-bloc-foliotation($dernier-span)" />

        <xsl:sequence select="if ($debut-bloc) 
                            then normalize-space(amh:collecter-bloc-foliotation(($debut-bloc, $debut-bloc/following-sibling::node())))
                            else ()" />
    </xsl:function>

    <xsl:function name="amh:folio-brut-normalise"
        as="xs:string">
        <xsl:param name="ancre"
            as="element(text:span)" />

        <xsl:sequence select="normalize-space(replace(amh:folio-brut($ancre), '&#160;', ' '))" />
    </xsl:function>

    <xsl:function name="amh:folio-numero"
        as="xs:string?">
        <!-- Fonction utilitaire pour extraire le numéro de folio d'une ancre, en traitant le texte brut de la foliotation pour isoler le numéro -->
        <xsl:param name="ancre"
            as="element(text:span)" />

        <xsl:variable name="folio"
            select="amh:folio-brut-normalise($ancre)" />
        <xsl:sequence select=" if (matches($folio, $regex-foliotation)) then replace($folio, $regex-foliotation, '$1') else ()" />
        <!-- Utilise une expression régulière pour vérifier si le texte de la foliotation correspond au format attendu 
        (un numéro suivi d'une lettre r ou v), et extrait le numéro si c'est le cas -->
    </xsl:function>

    <xsl:function name="amh:folio-cote"
        as="xs:string?">
        <!-- Fonction utilitaire pour extraire la côté (recto ou verso) d’un folio, en traitant le texte brut de la foliotation 
        pour isoler la lettre (r ou v) -->
        <xsl:param name="ancre"
            as="element(text:span)" />

        <xsl:variable name="folio"
            select="amh:folio-brut-normalise($ancre)" />
        <xsl:sequence select="if (matches($folio, $regex-foliotation)) then replace($folio, $regex-foliotation, '$2') else ()" />
        <!-- Utilise une expression régulière pour vérifier si le texte de la foliotation correspond au format attendu 
        (un numéro suivi d'une lettre r ou v), et extrait la lettre du côté (r ou v) si c'est le cas -->
    </xsl:function>

    <xsl:function name="amh:collecter-bloc-foliotation"
        as="xs:string">
        <xsl:param name="nodes"
            as="node()*" />

        <xsl:choose>
            <xsl:when test="empty($nodes)">
                <xsl:sequence select="''" />
            </xsl:when>
            <xsl:when test="amh:est-span-foliotation($nodes[1])">
                <xsl:sequence select="
                concat(
                    string($nodes[1]),
                    amh:collecter-bloc-foliotation(subsequence($nodes, 2))
                )
            " />
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="''" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>