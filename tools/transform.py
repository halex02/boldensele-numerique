from saxonche import *

with PySaxonProcessor(license=False) as proc:
    xsltproc = proc.new_xslt30_processor()
    executable = xsltproc.compile_stylesheet(stylesheet_file="../xslt/odt-vers-glossaireXML.xsl")
    document = proc.parse_xml(xml_file_name='../work/transcription_boldensele.fodt')
    output = executable.transform_to_string(xdm_node=document)
    
    with open("../data/glossaire.xml", "w", encoding="utf-8") as f:
        f.write(output)
