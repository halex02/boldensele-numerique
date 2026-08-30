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

    <!-- Dossier de sortie des pages de l'édition -->
    <xsl:param name="dossier-sortie"
        as="xs:string"
        select="'docs/pages/'"/>

    <!-- =========================================================
         POINT D'ENTRÉE
         ========================================================= -->

    <xsl:template match="/TEI">

        <!--
            Pour le moment, seule la division correspondant
            au prologue est générée.

            À terme, il suffira par exemple de remplacer cette
            sélection par :
                text/body/div
        -->
        <xsl:apply-templates
            select="text/body/div[@type = 'prologue']"
            mode="page"/>

    </xsl:template>

    <!-- =========================================================
         GÉNÉRATION D'UNE PAGE
         ========================================================= -->

    <xsl:template match="div" mode="page">

        <!-- Titre court destiné à l'interface -->
        <xsl:variable name="titre-page"
            as="xs:string"
            select="
                if (@type = 'prologue')
                then 'Prologue'
                else if (@n)
                then concat('Chapitre ', @n)
                else 'Édition'
            "/>

        <xsl:result-document
            href="{$dossier-sortie}prologue.html">

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

                    <!-- Liens d'évitement -->
                    <nav
                        class="skip-links menu"
                        aria-label="Liens d’évitement">
                        <a href="#main" class="skip-link">Aller au contenu principal</a>
                        <a href="#lien-accueil" class="skip-link">Aller au menu principal</a>
                        <a href="#footer" class="skip-link">Aller au pied de page</a>
                    </nav>

                    <!-- En-tête -->
                    <header>
                        <div>
                            <h1>
                                Édition numérique du
                                <span lang="la">Liber de quibusdam ultramarinis partibus</span>
                            </h1>
                            <p>
                                Projet d’édition critique numérique du récit
                                de voyage de Guillaume de Boldensele.
                            </p>
                        </div>
                    </header>

                    <!-- Menu principal -->
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
                                        <a
                                            href="/boldensele-numerique/pages/prologue.html"
                                            aria-current="page">
                                            Prologue
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

                    <!-- Contenu édité -->
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
                        <aside class="apparat" aria-labelledby="titre-apparat">
                            <h2 id="titre-apparat">Apparat critique</h2>
                            <ol class="apparat-critique">
                                <xsl:apply-templates select=".//app" mode="apparat"/>
                            </ol>
                            <h2 id="titre-sources">Sources</h2>
                            <ol class="liste-sources">
                                <xsl:apply-templates select=".//note[@type='source']" mode="sources"/>
                            </ol>
                        </aside>
                    </main>

                    <!-- Pied de page -->
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

    <!--
        Le head TEI n'est pas transformé en h2,
        puisque le titre fonctionnel de la page est déjà produit
        dans l'en-tête de l'article.
    -->
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

    <!-- Développement d'abréviation -->
    <xsl:template match="ex">
        <em class="expansion">
            <xsl:apply-templates/>
        </em>
    </xsl:template>

    <!-- Rubrication -->
    <xsl:template match="hi[@rend = 'rubricated']">
        <span class="rubricated">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Changement de page / folio -->
    <xsl:template match="pb">
        <span class="pb" id="folio-{@n}">
            <xsl:text>[fol. </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>

    <!-- Notes et Apparat-->
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
                <xsl:value-of select="string-join('src-',$numero)"/>
            </a>
        </sup>
    </xsl:template>

</xsl:stylesheet>
