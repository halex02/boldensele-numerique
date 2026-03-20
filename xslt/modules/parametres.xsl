<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <!-- ========================= -->
    <!-- PARAMÈTRES GÉNÉRAUX -->
    <!-- ========================= -->

    <!-- Styles ODF -->
    <xsl:param name="style-ancre-glossaire"
        as="xs:string"
        select="'amh_5f_ancre_5f_glossaire'" />

    <xsl:param name="style-foliotation"
        as="xs:string"
        select="'amh_5f_foliotation'" />

    <!-- Préformatage des identifiants -->
    <xsl:param name="prefix-id-terme"
        as="xs:string"
        select="'gls'" />

    <xsl:param name="prefix-id-mot"
        as="xs:string"
        select="'w'" />

    <!-- REGEX -->
    <xsl:param name="regex-separateur-mot"
        as="xs:string"
        select="'[ \t\r\n,.;:!?()\[\]«»&quot;“”]'" />
    <!-- Définit les caractères considérés comme des séparateurs de mot, utilisés pour isoler les formes attestées dans les ancres. -->

    <xsl:param name="regex-foliotation"
        as="xs:string"
        select="'^\[f\.\s*([0-9]+)([rv])\]$'" />

    <!-- Métadonnées du glossaire -->
    <xsl:param name="meta-title"
        as="xs:string"
        select="'Glossaire'" />

    <xsl:param name="meta-creator"
        as="xs:string"
        select="'Moret Alexandre'" />

    <xsl:param name="meta-language"
        as="xs:string"
        select="'fr'" />

    <xsl:param name="meta-source"
        as="xs:string"
        select="'Guillaume de Boldensele'" />

    <!-- Langues -->
    <xsl:param name="lang-glossaire"
        as="xs:string"
        select="'fr'" />

    <xsl:param name="lang-formes"
        as="xs:string"
        select="'la'" />

</xsl:stylesheet>