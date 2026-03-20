<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:amh="urn:alexandre-moret:fonctions-personnalisees"
    exclude-result-prefixes="xs office text amh"
    version="3.0">

    <xsl:function name="amh:extraction-ancres" as="element(text:span)*">
    <xsl:param name="racine" as="node()"/> <!-- Racine de la recherche -->
    <xsl:param name="nom-style" as="xs:string"/>

    <xsl:sequence select="$racine//text:span[@text:style-name = $nom-style]"/>
    <!-- Retourne les éléments span avec le style spécifié.
    Fonction générique qui permet d'extrait les ancres du glossaire ici, mais peut être utilisée pour celles des index-->
</xsl:function>

    <xsl:function name="amh:est-ancre-technique"
        as="xs:boolean">
        <xsl:param name="n"
            as="node()?" />

        <xsl:sequence select="
        exists(
            $n/self::text:span[
                starts-with(@text:style-name, 'amh_5f_ancre_5f_')
            ]
        )
    " />
    </xsl:function>

    <xsl:function name="amh:est-note"
        as="xs:boolean">
        <xsl:param name="n"
            as="node()?" />

        <xsl:sequence select="
        exists($n/self::text:note)
        or exists($n/descendant-or-self::text:note)
    " />
    </xsl:function>

     <xsl:function name="amh:est-span-foliotation"
        as="xs:boolean">
        <xsl:param name="n"
            as="node()?" />

        <xsl:sequence select="
        exists($n[self::text:span[@text:style-name = $style-foliotation]])
    " />
    </xsl:function>

        <xsl:function name="amh:texte-noeud"
        as="xs:string">
        <!-- Fonction utilitaire pour extraire le texte d'un nœud-->
        <xsl:param name="n"
            as="node()?" />
        <xsl:sequence select="string($n)" />
    </xsl:function>

    <xsl:function name="amh:collecter-forme"
        as="xs:string">
        <!-- Fonction récursive pour collecter les éléments de texte consécutifs d'une ancre, jusqu'à rencontrer un séparateur ou la fin des éléments -->
        <xsl:param name="noeuds"
            as="node()*" />
        <xsl:param name="acc"
            as="xs:string" />

        <xsl:choose>
            <xsl:when test="empty($noeuds)">
                <xsl:sequence select="$acc" />
                <!-- Cas de base : si la séquence de nœuds est vide, on retourne l'accumulateur qui contient la forme collectée jusqu'à présent -->
            </xsl:when>

            <!-- une ancre technique marque la fin de la forme -->
            <xsl:when test="amh:est-ancre-technique($noeuds[1])">
                <xsl:sequence select="$acc" />
            </xsl:when>

            <!-- une note est ignorée -->
            <xsl:when test="amh:est-note($noeuds[1])">
                <xsl:sequence select="amh:collecter-forme(subsequence($noeuds, 2), $acc)" />
            </xsl:when>

            <xsl:otherwise>
                <xsl:variable name="texte"
                    as="xs:string"
                    select="amh:texte-noeud($noeuds[1])" />
                <!-- On extrait le texte du premier nœud de la séquence pour l'analyser -->

                <!-- on enlève les espaces initiaux tant qu’on n’a pas encore commencé -->
                <xsl:variable name="texte-nettoye"
                    as="xs:string"
                    select="if ($acc = '') then replace($texte, '^\s+', '') else $texte" />

                <!-- partie avant premier séparateur -->
                <xsl:variable name="fragment"
                    as="xs:string"
                    select="
                    if (matches($texte-nettoye, '^[^\s,.;:!?()\[\]«»&quot;“”]'))
                    then replace($texte-nettoye, '^([^\s,.;:!?()\[\]«»&quot;“”]+).*$','$1')
                    else ''
                " />

                <xsl:variable name="nouvel-acc"
                    as="xs:string"
                    select="concat($acc, $fragment)" />

                <xsl:choose>
                    <!-- rien trouvé dans ce nœud : on passe au suivant -->
                    <xsl:when test="$fragment = '' and $acc = ''">
                        <xsl:sequence select="amh:collecter-forme(subsequence($noeuds, 2), '')" />
                    </xsl:when>

                    <!-- on a rencontré un séparateur dans ce nœud : on s’arrête -->
                    <xsl:when test="matches($texte-nettoye, '[ \t\r\n,.;:!?()\[\]«»&quot;“”]')">
                        <xsl:sequence select="$nouvel-acc" />
                    </xsl:when>

                    <!-- sinon on continue -->
                    <xsl:otherwise>
                        <xsl:sequence select="amh:collecter-forme(subsequence($noeuds, 2), $nouvel-acc)" />
                        <!-- Appel récursif : on continue à collecter la forme en passant à la séquence de nœuds suivante
                     et en mettant à jour l'accumulateur avec le nouveau fragment collecté -->
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="amh:forme-attestee"
        as="xs:string">
        <xsl:param name="ancre"
            as="element(text:span)" />

        <xsl:sequence select="amh:collecter-forme($ancre/following-sibling::node(), '')" />
    </xsl:function>


    </xsl:stylesheet>