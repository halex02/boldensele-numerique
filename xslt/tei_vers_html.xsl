<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs">

    <xsl:output
        method="html"
        encoding="UTF-8"
        indent="yes"/>

    <!-- =========================================================
         PARAMÈTRES
         ========================================================= -->

    <xsl:param name="dossier-sortie"
        as="xs:string"
        select="'docs/pages/'"/>

    <!-- =========================================================
         POINT D'ENTRÉE
         ========================================================= -->

    <xsl:template match="/TEI">
        <xsl:apply-templates
            select="text/body/div[
                @type = 'prologue'
                or (@type = 'chapter' and @n = '01')
            ]"
            mode="page"/>
    </xsl:template>

    <!-- =========================================================
         GÉNÉRATION D'UNE PAGE
         ========================================================= -->

    <xsl:template match="div" mode="page">

        <xsl:variable name="titre-page"
            as="xs:string"
            select="
                if (@type = 'prologue')
                then 'Prologue'
                else if (@n)
                then concat('Chapitre ', xs:integer(@n))
                else 'Édition'
            "/>

        <xsl:variable name="nom-fichier"
            as="xs:string"
            select="
                if (@type = 'prologue')
                then 'prologue.html'
                else concat('chapitre-', @n, '.html')
            "/>

        <xsl:result-document href="{$dossier-sortie}{$nom-fichier}">
            <html lang="fr">
                <head>
                    <meta charset="utf-8"/>
                    <meta
                        name="viewport"
                        content="width=device-width, initial-scale=1"/>

                    <title>
                        <xsl:value-of select="$titre-page"/>
                        <xsl:text> — </xsl:text>
                        <xsl:text>Liber de quibusdam ultramarinis partibus</xsl:text>
                    </title>

                    <meta
                        name="description"
                        content="Édition critique numérique du Liber de quibusdam ultramarinis partibus de Guillaume de Boldensele."/>

                    <link
                        rel="stylesheet"
                        href="../css/screen-default.css"
                        media="screen"/>
                </head>

                <body>

                    <nav
                        class="skip-links menu"
                        aria-label="Liens d’évitement">
                        <a href="#main" class="skip-link">Aller au contenu principal</a>
                        <a href="#lien-accueil" class="skip-link">Aller au menu principal</a>
                        <a href="#footer" class="skip-link">Aller au pied de page</a>
                    </nav>

                    <header>
                        <div>
                            <h1>
                                Édition numérique du
                                <cite lang="la">Liber de quibusdam ultramarinis partibus</cite>
                            </h1>
                            <p>
                                Projet d’édition critique numérique du récit
                                de voyage de Guillaume de Boldensele.
                            </p>
                        </div>
                    </header>

                    <nav
                        id="main_menu"
                        aria-label="Menu principal"
                        class="menu">
                        <ul>
                            <li>
                                <a
                                    id="lien-accueil"
                                    href="/boldensele-numerique/">
                                    Accueil
                                </a>
                            </li>

                            <li class="menu-deroulant">
                                <a href="/boldensele-numerique/edition.html">Édition</a>
                                <ul class="submenu">
                                    <li>
                                        <a href="/boldensele-numerique/edition.html">
                                            Sommaire de l’édition
                                        </a>
                                    </li>
                                    <li>
                                        <a href="/boldensele-numerique/pages/prologue.html">
                                            <xsl:if test="@type = 'prologue'">
                                                <xsl:attribute name="aria-current">page</xsl:attribute>
                                            </xsl:if>
                                            Prologue
                                        </a>
                                    </li>
                                    <li>
                                        <a href="/boldensele-numerique/pages/chapitre-01.html">
                                            <xsl:if test="@type = 'chapter' and @n = '01'">
                                                <xsl:attribute name="aria-current">page</xsl:attribute>
                                            </xsl:if>
                                            Chapitre 1
                                        </a>
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <a href="/boldensele-numerique/glossaire.html">Glossaire</a>
                            </li>
                            <li>
                                <a href="/boldensele-numerique/a-propos.html">À propos</a>
                            </li>
                        </ul>
                    </nav>

                    <main id="main" tabindex="-1">
                        <article
                            class="edition"
                            lang="la">

                            <header class="edition-header">
                                <h2>
                                    <xsl:value-of select="$titre-page"/>
                                </h2>
                            </header>

                            <div class="texte-edite">
                                <xsl:apply-templates/>
                            </div>
                        </article>

                        <xsl:if test=".//app or .//note[@type = 'source']">
                            <aside class="apparat" aria-label="Annotations éditoriales">
                                <xsl:if test=".//app">
                                    <h2 id="titre-apparat">Apparat critique</h2>
                                    <ol class="apparat-critique">
                                        <xsl:apply-templates
                                            select=".//app"
                                            mode="apparat"/>
                                    </ol>
                                </xsl:if>

                                <xsl:if test=".//note[@type = 'source']">
                                    <h2 id="titre-sources">Sources</h2>
                                    <ol class="liste-sources">
                                        <xsl:apply-templates
                                            select=".//note[@type = 'source']"
                                            mode="sources"/>
                                    </ol>
                                </xsl:if>
                            </aside>
                        </xsl:if>
                    </main>

                    <footer id="footer" tabindex="-1">
                        <nav aria-label="Liens de retour">
                            <a href="#lien-accueil">Menu principal</a>
                            <a href="#main">Contenu</a>
                        </nav>
                    </footer>

                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- =========================================================
         STRUCTURE DU TEXTE ÉDITÉ
         ========================================================= -->

    <xsl:template match="head">
        <p class="rubrique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- =========================================================
         ÉLÉMENTS ÉDITORIAUX
         ========================================================= -->

    <xsl:template match="ex">
        <em class="expansion">
            <xsl:apply-templates/>
        </em>
    </xsl:template>

    <xsl:template match="hi[@rend = 'rubricated']">
        <span class="rubricated">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="pb">
        <span class="pb" id="folio-{@n}">
            <xsl:text>[fol. </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>

    <!-- =========================================================
         SOURCES
         ========================================================= -->

    <xsl:template match="note[@type = 'source']">
        <xsl:variable name="numero">
            <xsl:number
                level="any"
                count="note[@type = 'source']"
                from="div"/>
        </xsl:variable>

        <sup class="appel-source">
            <a href="#source-{$numero}"
                id="appel-source-{$numero}">
                <xsl:value-of select="concat('src-', $numero)"/>
            </a>
        </sup>
    </xsl:template>

    <xsl:template match="note[@type = 'source']" mode="sources">
        <xsl:variable name="numero">
            <xsl:number
                level="any"
                count="note[@type = 'source']"
                from="div"/>
        </xsl:variable>

        <li id="source-{$numero}">
            <xsl:apply-templates/>
            <xsl:text> </xsl:text>
            <a href="#appel-source-{$numero}"
                class="retour-source"
                aria-label="Retour à l’appel de source {$numero}">↩</a>
        </li>
    </xsl:template>

    <!-- =========================================================
         APPARAT CRITIQUE
         ========================================================= -->

    <!--
        Le lemme est déjà présent dans le texte édité avant <app>.
        L'élément <app> ne produit donc ici qu'un appel d'apparat.
    -->
    <xsl:template match="app">
        <xsl:variable name="numero">
            <xsl:number
                level="any"
                count="app"
                from="div"/>
        </xsl:variable>

        <sup class="appel-apparat">
            <a href="#apparat-{$numero}"
                id="appel-apparat-{$numero}">
                <xsl:value-of select="concat('app-', $numero)"/>
            </a>
        </sup>
    </xsl:template>

    <xsl:template match="app" mode="apparat">
        <xsl:variable name="numero">
            <xsl:number
                level="any"
                count="app"
                from="div"/>
        </xsl:variable>

        <li id="apparat-{$numero}">
            <span class="lemme">
                <xsl:apply-templates select="lem/node()" mode="apparat-texte"/>
            </span>
            <xsl:text>] </xsl:text>

            <xsl:for-each select="rdg">
                <span class="lecture">
                    <xsl:if test="@type = 'addition'">
                        <xsl:text>add. </xsl:text>
                    </xsl:if>

                    <xsl:choose>
                        <xsl:when test="not(node()) or normalize-space(.) = ''">
                            <xsl:text>om.</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="node()" mode="apparat-texte"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:if test="@type = 'corrupt'">
                        <xsl:text> (corrupt.)</xsl:text>
                    </xsl:if>
                    <xsl:if test="@cert = 'low'">
                        <xsl:text> (?)</xsl:text>
                    </xsl:if>

                    <xsl:if test="@wit">
                        <xsl:text> </xsl:text>
                        <span class="temoins">
                            <xsl:value-of select="replace(normalize-space(@wit), '#', '')"/>
                        </span>
                    </xsl:if>
                </span>

                <xsl:if test="position() != last()">
                    <xsl:text>; </xsl:text>
                </xsl:if>
            </xsl:for-each>

            <xsl:text> </xsl:text>
            <a href="#appel-apparat-{$numero}"
                class="retour-apparat"
                aria-label="Retour à l’appel d’apparat {$numero}">↩</a>
        </li>
    </xsl:template>

    <!-- Dans l'apparat, on restitue le texte sans balisage éditorial HTML. -->
    <xsl:mode name="apparat-texte" on-no-match="text-only-copy"/>

</xsl:stylesheet>
