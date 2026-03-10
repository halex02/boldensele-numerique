<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	exclude-result-prefixes="xs office text"
	version="3.0">
	<xsl:output encoding="UTF-8" method="xml" indent="yes"/>
	<xsl:strip-space elements="*"/>
	
	<!-- Ce script a été généré via ChatGPT pour extraire des termes indexables (i.e. des noms propres)
		du fichier content.xml d’un package ODF, avant d’être complété et commenté. -->
	<xsl:template match="/">
		<index xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:noNamespaceSchemaLocation="index.xsd" >
			<titre>Index des noms propres</titre>
			
			<!-- for-each-group va itérer sur des groupes d’éléments constitués à partir de l’expression XPATH @select.
				Ici on travaille sur les éléments text:span dont l’attribut @text:style-name a pour valeur "marquage_5f_index" ;
				cette valeur correspond au style personnalisé marquage_index, défini dans le document ODT.
				On regroupe ces text:span, via la condition définie dans @group-by, en fonction de leur contenu (c’est ce qu’indique le « . »).
				la fonction normalize-space sert à supprimer les espaces superflus pour éviter les doublons sur ce contenu:
				par exemple ( ici le _ représente les espace) "_Gauvain", "Gauvain", "Gauvain_" et "_Gauvain_" seront tous traités comme étant «Gauvain».
			-->
			<!--<xsl:for-each-group select="//text:span[@text:style-name='marquage_5f_index']" group-by="normalize-space(.)">-->
			<!-- Le normalize-space() de l’IA pose cependant un problème, vu qu’il masque une potentielle erreur humaine
				qu’il faudrait de toute façon corriger: il vaut mieux le retirer.
			-->
			<xsl:for-each-group select="//text:span[@text:style-name='marquage_5f_index']" group-by=".">
				<!-- les termes ne sont pas triés, il faut faire un tri avec une autre feuille de style -->
				<terme>
					<cle-index>
						<!-- current-grouping-key() renvoie la valeur de groupage.
						En conservant le même exemple cela permettrait de récupérer "Gauvain" dans l’élément clé-index,
						qu’on réutilisera comme item en adresse pour la mise en forme de l’index-->
						<xsl:value-of select="current-grouping-key()"/>
					</cle-index>
					<nombre-occurences>
						<!-- On compte le nombre d’éléments dans le groupe. 
							Pour Gauvain, le texte de base comporte la clé 3 fois -->
						<xsl:value-of select="count(current-group())"/>
					</nombre-occurences>
					<description>
						<xsl:text>À compléter</xsl:text>
					</description>
					<flexions>
							<!-- le traitement des formes fléchies va nécessiter un ajustement manuel -->
							<traitement_forme_flechie>
								<forme_flechie>
									<xsl:text>A compléter</xsl:text>
								</forme_flechie>
								<positions>
									<!-- On boucle au sein du groupe pour récupérer tous les numéros de vers où le terme a été trouvé -->
									<xsl:for-each select="current-group()">
									<numero-vers>
										<!-- ancestor::text:p fait remonter au text:p (le vers donc) comportant le terme.
										Le fonctions matches() permet d’ignorer les lignes vides.
										preceding-sibling::text-p va permettre de compter tous les vers précédents
									on ajoute +1 au comptage parce que le premier vers est le vers 0 pour la machine -->
										<xsl:value-of select="count(ancestor::text:p[matches(@text:style-name, '^P(1[2457]|[1-9]|10|11|12)$')]/preceding-sibling::text:p[matches(@text:style-name, '^P(1[2457]|[1-9]|10|11|12)$')]) + 1"/>
									</numero-vers>
									</xsl:for-each>
								</positions>
							</traitement_forme_flechie>
					</flexions>
					<!--<position>
						<!-\- On boucle au sein du groupe pour récupérer tous les numéros de vers où le terme a été trouvé -\->
						<xsl:for-each select="current-group()">
								<numero-vers>
									<!-\- ancestor::text:p fait remonter au text:p (le vers donc) comportant le terme.
										Le fonctions matches() permet d’ignorer les lignes vides.
										preceding-sibling::text-p va permettre de compter tous les vers précédents
									on ajoute +1 au comptage parce que le premier vers est le vers 0 pour la machine -\->
									<xsl:value-of select="count(ancestor::text:p/preceding-sibling::text:p)+1"/>
								</numero-vers>
						</xsl:for-each>
					</position>-->
				</terme>
			</xsl:for-each-group>
		</index>
	</xsl:template>
	
</xsl:stylesheet>
