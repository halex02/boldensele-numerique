import saxonche as saxonc

def apply_xslt_transformation():
    with saxonc.PySaxonProcessor(license=True) as proc:
        print("SaxonC version:", proc.version)

        # Créer le processeur XSLT
        xsltproc = proc.new_xslt30_processor()

        # Charger la feuille de style
        stylesheet_file = r"C:\Users\Alexandre.DESKTOP-FCK9VBL\Github\memM2EdNITL\xslt\odt-vers-glossaireXML.xsl"
        executable = xsltproc.compile_stylesheet(stylesheet_file=stylesheet_file)

        if executable is None:
            print("Erreur lors de la compilation de la feuille de style")
            if xsltproc.exception_occurred:
                print("Message d'erreur:", xsltproc.error_message)
            return

        # Définir les paramètres
        executable.set_parameter("style-name", proc.make_string_value("amh_5f_ancre_5f_glossaire"))
        executable.set_parameter("dc-title", proc.make_string_value("Glossaire"))
        executable.set_parameter("dc-creator", proc.make_string_value("Moret Alexandre"))
        executable.set_parameter("dc-language", proc.make_string_value("fr"))
        executable.set_parameter("dc-source", proc.make_string_value("Le Roman de Brut"))

        # Charger le document source
        source_file = r"c:\Users\Alexandre.DESKTOP-FCK9VBL\Github\memM2EdNITL\work\transcription_boldensele.fodt"
        document = proc.parse_xml(xml_file_name=source_file)

        if document is None:
            print("Erreur lors du chargement du document source")
            return

        # Appliquer la transformation
        executable.set_initial_match_selection(xdm_value=document)

        # Obtenir le résultat
        result = executable.apply_templates_returning_string()

        # Écrire le résultat dans un fichier
        output_file = r"c:\Users\Alexandre.DESKTOP-FCK9VBL\Github\memM2EdNITL\work\glossaire-output.xml"
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(result)

        print("Transformation terminée. Résultat sauvegardé dans:", output_file)

if __name__ == "__main__":
    apply_xslt_transformation()