<?xml version="1.0" encoding="UTF-8"?>
<!--
Feuille de transformation XSLT refactorée et mise à jour avec l’assistance d’une intelligence artificielle
(ChatGPT, modèle GPT-5.3, OpenAI).

L’architecture générale, l’organisation des templates et la factorisation des paramètres ont été
reprises et clarifiées dans ce cadre.

La fonction `amh:forme-attestee`, ainsi que les fonctions auxiliaires qui lui sont associées
(`amh:collecter-forme`, `amh:avant-separateur`, `amh:contient-separateur`, etc.), ont été
générées par l’intelligence artificielle.

L’ensemble du reste de la feuille s’inscrit dans le modèle éditorial défini pour le glossaire.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:amh="urn:alexandre-moret:fonctions-personnalisees"
    exclude-result-prefixes="xs office text dc amh"
    version="3.0">
    <!-- xmlns:amh est un espace de noms personnalisé dont on a besoin pour créer des fonctions
    personnalisées, afin d’éviter les conflits de noms. C’est obligatoire. -->

    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <!-- L’ordres des includes est important. Il tient compte des relations de dépendance entre les différents modules -->
    <xsl:include href="modules/parametres.xsl"/>
    <xsl:include href="modules/traitement-odt.xsl"/>
    <xsl:include href="modules/gestion-id.xsl"/>
    <xsl:include href="modules/gestion-localisation.xsl"/>
    <xsl:include href="modules/gestion-formes.xsl"/>

    <xsl:template match="/">
        <glossaire xmlns="https://halex02.github.io/boldensele-numerique/ns/glossaire"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="https://halex02.github.io/boldensele-numerique/ns/glossaire https://raw.githubusercontent.com/halex02/boldensele-numerique/main/schemas/glossaire-v4.xsd"
        xml:lang="{$lang-glossaire}"><!-- la langue du glossaire est paramétrée en début de fichier, ce qui permet de la modifier facilement sans toucher au code du template -->
            <metadonnees><!-- les métadonnées (dublin core) sont remplies à partir des paramètres définis en début de fichier, 
            ce qui permet de les modifier facilement sans toucher au code du template -->
                <dc:title><xsl:value-of select="$meta-title"/></dc:title><!-- le titre du glossaire -->
                <dc:creator><xsl:value-of select="$meta-creator"/></dc:creator><!-- le créateur du glossaire -->
                <dc:language><xsl:value-of select="$meta-language"/></dc:language><!-- la langue principale du glossaire -->
                <dc:source><xsl:value-of select="$meta-source"/></dc:source><!-- la source du texte dont le glossaire est extrait -->
            </metadonnees>

            <liste-termes>
                <xsl:call-template name="generer-termes"/>
            </liste-termes>
        </glossaire>
    </xsl:template>

    <xsl:template name="generer-termes">
        <xsl:for-each-group select="amh:extraction-ancres(/, $style-ancre-glossaire)" group-by="amh:normaliser-graphie(amh:forme-attestee(.))"> 
        <!-- le select appelle la fonction d’extraction des ancres du glossaire, et le group-by permet de regrouper les éléments par leur contenu normalisé et donc d’éliminer les doublons -->
            <xsl:sort select="lower-case(current-grouping-key())"/> <!-- Trie les groupes par leur clé de regroupement, c’est-à-dire les lemmes contenus dans les ancres -->

            <xsl:variable name="compteur-occurences" as="xs:integer" select="count(current-group())"/> <!-- Compte le nombre d’occurrences de chaque terme, c’est-à-dire le nombre d’ancres dans chaque groupe -->

            <xsl:variable name="id-terme" as="xs:string" select="amh:generer-id($prefix-id-terme, position())"/>
            <!-- Génère un identifiant unique pour chaque terme en utilisant la fonction de génération d’identifiants personnalisée, avec le préfixe défini et le numéro de position du groupe.
            L’appel à position() permet de numéroter les groupes, ça équivaut ici à récupérer l’index d’un tableau/dictionnaire dans un langage de programmation-->

            <terme id="{$id-terme}">
            <xsl:call-template name="generer-formes">
            <!-- on passe le lemmme et les occurrences en paramètres pour les répercuter dans les templates suivants. 
            Voir les commentaires dans le template generer-formes -->
                <xsl:with-param name="lemme" select="current-grouping-key()"/> <!-- on passe la clé de regroupement, c’est-à-dire le contenu des ancres, comme lemme du terme -->
                <xsl:with-param name="occurrences" select="current-group()"/> <!-- on passe les occurrences du groupe, c’est-à-dire les ancres elles-mêmes, pour pouvoir générer les attestations associées à chaque forme dans les templates suivants -->
            </xsl:call-template>
            <nombre-occurrences>
                <xsl:value-of select="$compteur-occurences"/>
                </nombre-occurrences>
            <definition>À compléter</definition>
            </terme>
        </xsl:for-each-group>
    </xsl:template>



    </xsl:stylesheet>