Jeu de tests minimal pour le glossaire TEI
==========================================

Fichiers fournis
----------------
- glossaire_tei_test_valide.xml
- glossaire_tei_test_invalide_01_sans_gramGrp.xml
- glossaire_tei_test_invalide_02_mauvais_type_gram.xml
- glossaire_tei_test_invalide_03_sense_et_xr.xml

Logique des tests
-----------------
1. Le fichier valide respecte la structure actuelle de l'ODD compilé :
   - div/@type = "glossaire"
   - entry = une ou plusieurs formes, puis soit sense soit xr
   - form = orth+, gramGrp, cit*
   - gramGrp = pos puis gram*
   - cit = ref + bibl
   - bibl = locus

2. Invalide 01
   - une forme ne contient pas de gramGrp
   - il doit échouer tant que gramGrp est obligatoire dans l'ODD

3. Invalide 02
   - gram/@type vaut "truc"
   - il doit échouer car @type est fermé dans l'ODD

4. Invalide 03
   - entry contient à la fois sense et xr
   - il doit échouer car l'ODD impose un choix entre les deux

Conseil
-------
Place ces fichiers dans le même dossier que glossaire-tei.rnc pour que
l'instruction xml-model pointe vers le bon schéma.
