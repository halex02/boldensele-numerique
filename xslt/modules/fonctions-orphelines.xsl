<!-- des fonctions devenues inutiles, mais que je préfères garder au cas où -->
<xsl:function name="amh:texte-utile-noeud" as="xs:string">
    <xsl:param name="n" as="node()"/>

    <xsl:sequence select="string-join($n/descendant-or-self::text()[not(ancestor::text:note)],'')"/>
</xsl:function>

<xsl:function name="amh:avant-separateur" as="xs:string">
<!-- Fonction utilitaire pour extraire la partie d'une chaîne de caractères avant le premier séparateur de mot défini par la regex -->
    <xsl:param name="texte" as="xs:string"/>

    <xsl:sequence select=" if (matches($texte, '^[^\s,.;:!?()\[\]«»&quot;“”]')) then replace($texte, '^([^\s,.;:!?()\[\]«»&quot;“”]+).*$', '$1') else ''"/>
    <!-- Utilise la fonction replace pour capturer la partie de la chaîne qui précède le premier séparateur, en utilisant une expression régulière qui s'appuie sur le regex défini pour les séparateurs de mot -->
</xsl:function>

<xsl:function name="amh:contient-separateur" as="xs:boolean">
<!-- Fonction utilitaire pour vérifier si une chaîne de caractères contient un séparateur de mot défini par la regex -->
    <xsl:param name="texte" as="xs:string"/>
    <xsl:sequence select="matches($texte, $regex-separateur-mot)"/>
    <!-- Retourne true si la chaîne contient un séparateur, false sinon -->
</xsl:function>