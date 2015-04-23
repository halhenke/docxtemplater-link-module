
# templateResult =
  # rels:
  #   """
  #   <?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/><Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header" Target="header1.xml"/><Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer" Target="footer1.xml"/><Relationship Id="rId6" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/><Relationship Id="rId7" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="__linkData__" TargetMode="External"/></Relationships>
  #    """
  # doc:
  #   """
  #   <?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" mc:Ignorable="w14"><w:body><w:p>
  #     <w:hyperlink r:id="rId7">
  #       <w:r>
  #         <w:rPr>
  #           <w:i />
  #           <w:rStyle w:val="Link" /></w:rPr>
  #         <w:t xml:space="preserve">__linkText__</w:t>
  #       </w:r>
  #     </w:hyperlink>
  #   </w:p><w:sectPr><w:headerReference w:type="default" r:id="rId4"/><w:footerReference w:type="default" r:id="rId5"/><w:pgSz w:w="12240" w:h="15840" w:orient="portrait"/><w:pgMar w:top="2810" w:right="1800" w:bottom="1440" w:left="1800" w:header="720" w:footer="720"/><w:bidi w:val="0"/></w:sectPr></w:body></w:document>
  #
  #   """



module.exports =
  linkExample:
    rels:
      """
      <?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/><Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header" Target="header1.xml"/><Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer" Target="footer1.xml"/><Relationship Id="rId6" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/><Relationship Id="rId7" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="__linkData__" TargetMode="External"/></Relationships>
       """
    doc:
      """
      <?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" mc:Ignorable="w14"><w:body><w:p>
        <w:hyperlink r:id="rId7">
          <w:r>
            <w:rPr>
              <w:i />
              <w:rStyle w:val="Link" /></w:rPr>
            <w:t xml:space="preserve">__linkText__</w:t>
          </w:r>
        </w:hyperlink>
      </w:p><w:sectPr><w:headerReference w:type="default" r:id="rId4"/><w:footerReference w:type="default" r:id="rId5"/><w:pgSz w:w="12240" w:h="15840" w:orient="portrait"/><w:pgMar w:top="2810" w:right="1800" w:bottom="1440" w:left="1800" w:header="720" w:footer="720"/><w:bidi w:val="0"/></w:sectPr></w:body></w:document>

      """
  hasLinksExample:
    rels:
      """
      <?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/><Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="http://www.apple.com" TargetMode="External"/><Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="mailto:friendo@gmail.com?subject=I%2520would%2520like%2520to%2520be%2520friends..." TargetMode="External"/><Relationship Id="rId6" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header" Target="header1.xml"/><Relationship Id="rId7" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer" Target="footer1.xml"/><Relationship Id="rId8" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/><Relationship Id="rId9" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="__linkData__" TargetMode="External"/></Relationships>
      """
    doc:
      """
      <?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" mc:Ignorable="w14"><w:body><w:p>
        <w:hyperlink r:id="rId9">
          <w:r>
            <w:rPr>
              <w:i />
              <w:rStyle w:val="Link" /></w:rPr>
            <w:t xml:space="preserve">__linkText__</w:t>
          </w:r>
        </w:hyperlink>
      </w:p><w:p><w:pPr><w:pStyle w:val="Body A"/><w:rPr><w:sz w:val="22"/><w:szCs w:val="22"/><w:rtl w:val="0"/></w:rPr></w:pPr></w:p><w:p><w:pPr><w:pStyle w:val="Body A"/></w:pPr><w:hyperlink r:id="rId4" w:history="1"><w:r><w:rPr><w:rStyle w:val="Hyperlink.0"/><w:rFonts w:ascii="Helvetica" w:cs="Arial Unicode MS" w:hAnsi="Arial Unicode MS" w:eastAsia="Arial Unicode MS"/><w:color w:val="0000ff"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:u w:val="single" w:color="0000ff"/><w:rtl w:val="0"/><w:lang w:val="en-US"/></w:rPr><w:t>Hi there fella</w:t></w:r></w:hyperlink></w:p><w:p><w:pPr><w:pStyle w:val="Body A"/></w:pPr></w:p><w:p><w:pPr><w:pStyle w:val="Body A"/></w:pPr></w:p><w:p><w:pPr><w:pStyle w:val="Body A"/></w:pPr><w:hyperlink r:id="rId5" w:history="1"><w:r><w:rPr><w:rStyle w:val="Hyperlink.0"/><w:rFonts w:ascii="Helvetica" w:cs="Arial Unicode MS" w:hAnsi="Arial Unicode MS" w:eastAsia="Arial Unicode MS"/><w:color w:val="0000ff"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:u w:val="single" w:color="0000ff"/><w:rtl w:val="0"/><w:lang w:val="en-US"/></w:rPr><w:t>friendo</w:t></w:r></w:hyperlink></w:p><w:p><w:pPr><w:pStyle w:val="Body A"/></w:pPr></w:p><w:p><w:pPr><w:pStyle w:val="Body A"/><w:rPr><w:sz w:val="22"/><w:szCs w:val="22"/><w:rtl w:val="0"/><w:lang w:val="en-US"/></w:rPr></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Helvetica" w:cs="Arial Unicode MS" w:hAnsi="Arial Unicode MS" w:eastAsia="Arial Unicode MS"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:rtl w:val="0"/><w:lang w:val="en-US"/></w:rPr><w:t></w:t></w:r></w:p><w:p><w:pPr><w:pStyle w:val="Body A"/><w:rPr><w:sz w:val="22"/><w:szCs w:val="22"/><w:rtl w:val="0"/><w:lang w:val="en-US"/></w:rPr></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Helvetica" w:cs="Arial Unicode MS" w:hAnsi="Arial Unicode MS" w:eastAsia="Arial Unicode MS"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:rtl w:val="0"/><w:lang w:val="en-US"/></w:rPr><w:t xml:space="preserve">   Jason - 34</w:t></w:r></w:p><w:p><w:pPr><w:pStyle w:val="Body A"/><w:rPr><w:sz w:val="22"/><w:szCs w:val="22"/><w:rtl w:val="0"/><w:lang w:val="en-US"/></w:rPr></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Helvetica" w:cs="Arial Unicode MS" w:hAnsi="Arial Unicode MS" w:eastAsia="Arial Unicode MS"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:rtl w:val="0"/><w:lang w:val="en-US"/></w:rPr><w:t xml:space="preserve">   evil</w:t></w:r></w:p><w:p><w:pPr><w:pStyle w:val="Body A"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Helvetica" w:cs="Arial Unicode MS" w:hAnsi="Arial Unicode MS" w:eastAsia="Arial Unicode MS"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:rtl w:val="0"/><w:lang w:val="en-US"/></w:rPr><w:t></w:t></w:r></w:p><w:sectPr><w:headerReference w:type="default" r:id="rId6"/><w:footerReference w:type="default" r:id="rId7"/><w:pgSz w:w="12240" w:h="15840" w:orient="portrait"/><w:pgMar w:top="2810" w:right="1800" w:bottom="1440" w:left="1800" w:header="720" w:footer="720"/><w:bidi w:val="0"/></w:sectPr></w:body></w:document>

      """
  # inlineLinkExample:
  # linkLoopExample:
