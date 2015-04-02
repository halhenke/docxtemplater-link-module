fs=require('fs')
DocxGen=require('docxtemplater')
expect=require('chai').expect
xmldom=require("xmldom")

fileNames=[
  'linkExample.docx'
	'hasLinksExample.docx'
]

# LinkModule=require('../js/index.js')
LinkModule=require('./index')

docX={}

loadFile=(name)->
	if fs.readFileSync? then return fs.readFileSync(__dirname+"/../examples/"+name,"binary")
	xhrDoc= new XMLHttpRequest()
	xhrDoc.open('GET',"../examples/"+name,false)
	if (xhrDoc.overrideMimeType)
		xhrDoc.overrideMimeType('text/plain; charset=x-user-defined')
	xhrDoc.send()
	xhrDoc.response

for name in fileNames
	content=loadFile(name)
	docX[name]=new DocxGen()
	docX[name].loadedContent=content


describe 'link adding with {! link } syntax', ()->
	it 'should work with one link',()->
		name='linkExample.docx'
		linkModule=new LinkModule({centered:false})
		docX[name].attachModule(linkModule)
		out=docX[name]
			.load(docX[name].loadedContent)
			.setData(link:
        text: "Don't go here..."
        link: 'http://gotojail.com')
			.render()

		zip=out.getZip()

		relsFile=zip.files['word/_rels/document.xml.rels']
		expect(relsFile?).to.equal(true)
		relsFileContent=relsFile.asText()
		expect(relsFileContent).to.equal(
      """
      <?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/><Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header" Target="header1.xml"/><Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer" Target="footer1.xml"/><Relationship Id="rId6" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/><Relationship Id="rId7" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="linkData" TargetMode="External"/></Relationships>
      """)

		documentFile=zip.files['word/document.xml']
		expect(documentFile?).to.equal(true)
		documentContent=documentFile.asText()
		expect(documentContent).to.equal(
      """
      <?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" mc:Ignorable="w14"><w:body><w:p>
        <w:hyperlink r:id="rId7">
          <w:r>
            <w:rPr>
              <w:i />
              <w:rStyle w:val="Link" /></w:rPr>
            <w:t xml:space="preserve">Don't go here...</w:t>
          </w:r>
        </w:hyperlink>
      </w:p><w:sectPr><w:headerReference w:type="default" r:id="rId4"/><w:footerReference w:type="default" r:id="rId5"/><w:pgSz w:w="12240" w:h="15840" w:orient="portrait"/><w:pgMar w:top="2810" w:right="1800" w:bottom="1440" w:left="1800" w:header="720" w:footer="720"/><w:bidi w:val="0"/></w:sectPr></w:body></w:document>

      """)

		fs.writeFile("test.docx",zip.generate({type:"nodebuffer"}));

	# it 'should work with centering',()->
	# 	d=new DocxGen()
	# 	name='imageExample.docx'
	# 	imageModule=new ImageModule({centered:true})
	# 	d.attachModule(imageModule)
	# 	out=d
	# 		.load(docX[name].loadedContent)
	# 		.setData({image:'examples/image.png'})
	# 		.render()

	# 	zip=out.getZip()
	# 	imageFile=zip.files['word/media/image_generated_1.png']
	# 	expect(imageFile?).to.equal(true)
	# 	expect(imageFile.asText().length).to.equal(17417)

	# 	relsFile=zip.files['word/_rels/document.xml.rels']
	# 	expect(relsFile?).to.equal(true)
	# 	relsFileContent=relsFile.asText()
	# 	expect(relsFileContent).to.equal("""<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><Relationships xmlns=\"http://schemas.openxmlformats.org/package/2006/relationships\"><Relationship Id=\"rId1\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles\" Target=\"styles.xml\"/><Relationship Id=\"rId2\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering\" Target=\"numbering.xml\"/><Relationship Id=\"rId3\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings\" Target=\"settings.xml\"/><Relationship Id=\"rId4\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/footnotes\" Target=\"footnotes.xml\"/><Relationship Id=\"rId5\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/endnotes\" Target=\"endnotes.xml\"/><Relationship Id=\"hId0\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/header\" Target=\"header0.xml\"/><Relationship Id=\"rId6\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/image\" Target=\"media/image_generated_1.png\"/></Relationships>""")

	# 	documentFile=zip.files['word/document.xml']
	# 	expect(documentFile?).to.equal(true)
	# 	documentContent=documentFile.asText()
	# 	# expect(documentContent).to.equal("""<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><w:document xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:wx=\"http://schemas.microsoft.com/office/word/2003/auxHint\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:m=\"http://schemas.openxmlformats.org/officeDocument/2006/math\" xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" xmlns:pic=\"http://schemas.openxmlformats.org/drawingml/2006/picture\" xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\"><w:body><w:p>\n\t<w:pPr>\n\t<w:jc w:val=\"center\"/>\n  </w:pPr>\n  <w:r>\n\t<w:rPr/>\n\t<w:drawing>\n\t  <wp:inline distT=\"0\" distB=\"0\" distL=\"0\" distR=\"0\">\n\t\t<wp:extent cx=\"1905000\" cy=\"1905000\"/>\n\t\t<wp:docPr id=\"15\" name=\"rId6.png\"/>\n\t\t<a:graphic>\n\t\t  <a:graphicData uri=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">\n\t\t\t<pic:pic>\n\t\t\t  <pic:nvPicPr>\n\t\t\t\t<pic:cNvPr id=\"15\" name=\"rId6.png\"/>\n\t\t\t\t<pic:cNvPicPr/>\n\t\t\t  </pic:nvPicPr>\n\t\t\t  <pic:blipFill>\n\t\t\t\t<a:blip r:embed=\"rId6\"/>\n\t\t\t\t</pic:blipFill>\n\t\t\t  <pic:spPr>\n\t\t\t\t<a:xfrm>\n\t\t\t\t  <a:off x=\"0\" y=\"0\"/>\n\t\t\t\t  <a:ext cx=\"1905000\" cy=\"1905000\"/>\n\t\t\t\t</a:xfrm>\n\t\t\t\t<a:prstGeom prst=\"rect\">\n\t\t\t\t  <a:avLst/>\n\t\t\t\t</a:prstGeom>\n\t\t\t  </pic:spPr>\n\t\t\t</pic:pic>\n\t\t  </a:graphicData>\n\t\t  </a:graphic>\n\t\t  </wp:inline>\n\t\t  </w:drawing>\n\t</w:r>\n</w:p><w:sectPr><w:headerReference w:type=\"default\" r:id=\"hId0\"/><w:type w:val=\"continuous\"/><w:pgSz w:w=\"12240\" w:h=\"15840\" w:orient=\"portrait\"/><w:pgMar w:top=\"2810\" w:left=\"1800\" w:right=\"1800\" w:bottom=\"1440\"/><w:cols w:num=\"1\" w:sep=\"off\" w:equalWidth=\"1\"/></w:sectPr></w:body></w:document>""")
	# 	#
	# 	# expect(documentContent).to.contain('align')
	# 	# expect(documentContent).to.contain('center')

	# 	fs.writeFile("test_center.docx",zip.generate({type:"nodebuffer"}));


	# it 'should work with loops',()->
	# 	name='imageLoopExample.docx'

	# 	imageModule=new ImageModule({centered:true})
	# 	docX[name].attachModule(imageModule)

	# 	out=docX[name]
	# 		.load(docX[name].loadedContent)
	# 		.setData({images:['examples/image.png','examples/image2.png']})

	# 	out
	# 		.render()

	# 	zip=out.getZip()

	# 	imageFile=zip.files['word/media/image_generated_1.png']
	# 	expect(imageFile?).to.equal(true)
	# 	expect(imageFile.asText().length).to.equal(17417)

	# 	imageFile2=zip.files['word/media/image_generated_2.png']
	# 	expect(imageFile2?).to.equal(true)
	# 	expect(imageFile2.asText().length).to.equal(7177)

	# 	relsFile=zip.files['word/_rels/document.xml.rels']
	# 	expect(relsFile?).to.equal(true)
	# 	relsFileContent=relsFile.asText()
	# 	expect(relsFileContent).to.equal("""<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><Relationships xmlns=\"http://schemas.openxmlformats.org/package/2006/relationships\"><Relationship Id=\"rId1\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles\" Target=\"styles.xml\"/><Relationship Id=\"rId2\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering\" Target=\"numbering.xml\"/><Relationship Id=\"rId3\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings\" Target=\"settings.xml\"/><Relationship Id=\"rId4\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/footnotes\" Target=\"footnotes.xml\"/><Relationship Id=\"rId5\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/endnotes\" Target=\"endnotes.xml\"/><Relationship Id=\"hId0\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/header\" Target=\"header0.xml\"/><Relationship Id=\"rId6\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/image\" Target=\"media/image_generated_1.png\"/><Relationship Id=\"rId7\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/image\" Target=\"media/image_generated_2.png\"/></Relationships>""")

	# 	documentFile=zip.files['word/document.xml']
	# 	expect(documentFile?).to.equal(true)
	# 	documentContent=documentFile.asText()
	# 	# expect(documentContent).to.equal("""<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><w:document xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:wx=\"http://schemas.microsoft.com/office/word/2003/auxHint\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:m=\"http://schemas.openxmlformats.org/officeDocument/2006/math\" xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" xmlns:pic=\"http://schemas.openxmlformats.org/drawingml/2006/picture\" xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\"><w:body><w:p><w:pPr></w:pPr><w:r><w:rPr></w:rPr><w:t xml:space=\"preserve\"></w:t></w:r></w:p><w:p><w:pPr></w:pPr></w:p><w:p><w:pPr></w:pPr><w:r><w:rPr></w:rPr><w:drawing>\n  <wp:inline distT=\"0\" distB=\"0\" distL=\"0\" distR=\"0\">\n    <wp:extent cx=\"1905000\" cy=\"1905000\"/>\n    <wp:effectExtent l=\"0\" t=\"0\" r=\"0\" b=\"0\"/>\n    <wp:docPr id=\"2\" name=\"Image 2\" descr=\"description\"/>\n    <wp:cNvGraphicFramePr>\n      <a:graphicFrameLocks xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" noChangeAspect=\"1\"/>\n    </wp:cNvGraphicFramePr>\n    <a:graphic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">\n      <a:graphicData uri=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">\n        <pic:pic xmlns:pic=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">\n          <pic:nvPicPr>\n            <pic:cNvPr id=\"0\" name=\"Picture 1\" descr=\"description\"/>\n            <pic:cNvPicPr>\n              <a:picLocks noChangeAspect=\"1\" noChangeArrowheads=\"1\"/>\n            </pic:cNvPicPr>\n          </pic:nvPicPr>\n          <pic:blipFill>\n            <a:blip r:embed=\"rId6\">\n              <a:extLst>\n                <a:ext uri=\"{28A0092B-C50C-407E-A947-70E740481C1C}\">\n                  <a14:useLocalDpi xmlns:a14=\"http://schemas.microsoft.com/office/drawing/2010/main\" val=\"0\"/>\n                </a:ext>\n              </a:extLst>\n            </a:blip>\n            <a:srcRect/>\n            <a:stretch>\n              <a:fillRect/>\n            </a:stretch>\n          </pic:blipFill>\n          <pic:spPr bwMode=\"auto\">\n            <a:xfrm>\n              <a:off x=\"0\" y=\"0\"/>\n              <a:ext cx=\"1905000\" cy=\"1905000\"/>\n            </a:xfrm>\n            <a:prstGeom prst=\"rect\">\n              <a:avLst/>\n            </a:prstGeom>\n            <a:noFill/>\n            <a:ln>\n              <a:noFill/>\n            </a:ln>\n          </pic:spPr>\n        </pic:pic>\n      </a:graphicData>\n    </a:graphic>\n  </wp:inline>\n</w:drawing></w:r></w:p><w:p><w:pPr></w:pPr></w:p><w:p><w:pPr></w:pPr><w:r><w:rPr></w:rPr><w:t xml:space=\"preserve\"></w:t></w:r></w:p><w:p><w:pPr></w:pPr></w:p><w:p><w:pPr></w:pPr><w:r><w:rPr></w:rPr><w:drawing>\n  <wp:inline distT=\"0\" distB=\"0\" distL=\"0\" distR=\"0\">\n    <wp:extent cx=\"1905000\" cy=\"1905000\"/>\n    <wp:effectExtent l=\"0\" t=\"0\" r=\"0\" b=\"0\"/>\n    <wp:docPr id=\"2\" name=\"Image 2\" descr=\"description\"/>\n    <wp:cNvGraphicFramePr>\n      <a:graphicFrameLocks xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" noChangeAspect=\"1\"/>\n    </wp:cNvGraphicFramePr>\n    <a:graphic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">\n      <a:graphicData uri=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">\n        <pic:pic xmlns:pic=\"http://schemas.openxmlformats.org/drawingml/2006/picture\">\n          <pic:nvPicPr>\n            <pic:cNvPr id=\"0\" name=\"Picture 1\" descr=\"description\"/>\n            <pic:cNvPicPr>\n              <a:picLocks noChangeAspect=\"1\" noChangeArrowheads=\"1\"/>\n            </pic:cNvPicPr>\n          </pic:nvPicPr>\n          <pic:blipFill>\n            <a:blip r:embed=\"rId7\">\n              <a:extLst>\n                <a:ext uri=\"{28A0092B-C50C-407E-A947-70E740481C1C}\">\n                  <a14:useLocalDpi xmlns:a14=\"http://schemas.microsoft.com/office/drawing/2010/main\" val=\"0\"/>\n                </a:ext>\n              </a:extLst>\n            </a:blip>\n            <a:srcRect/>\n            <a:stretch>\n              <a:fillRect/>\n            </a:stretch>\n          </pic:blipFill>\n          <pic:spPr bwMode=\"auto\">\n            <a:xfrm>\n              <a:off x=\"0\" y=\"0\"/>\n              <a:ext cx=\"1905000\" cy=\"1905000\"/>\n            </a:xfrm>\n            <a:prstGeom prst=\"rect\">\n              <a:avLst/>\n            </a:prstGeom>\n            <a:noFill/>\n            <a:ln>\n              <a:noFill/>\n            </a:ln>\n          </pic:spPr>\n        </pic:pic>\n      </a:graphicData>\n    </a:graphic>\n  </wp:inline>\n</w:drawing></w:r></w:p><w:p><w:pPr></w:pPr></w:p><w:p><w:pPr></w:pPr><w:r><w:rPr></w:rPr><w:t xml:space=\"preserve\"></w:t></w:r><w:bookmarkStart w:id=\"20\" w:name=\"_GoBack\"/><w:bookmarkEnd w:id=\"20\"/></w:p><w:sectPr><w:headerReference w:type=\"default\" r:id=\"hId0\"/><w:type w:val=\"continuous\"/><w:pgSz w:w=\"12240\" w:h=\"15840\" w:orient=\"portrait\"/><w:pgMar w:top=\"2810\" w:left=\"1800\" w:right=\"1800\" w:bottom=\"1440\"/><w:cols w:num=\"1\" w:sep=\"off\" w:equalWidth=\"1\"/></w:sectPr></w:body></w:document>""")

	# 	buffer=zip.generate({type:"nodebuffer"})
	# 	fs.writeFile("test_multi.docx",buffer);

	# # it 'should work with inline images',()->
	# # 	name='imageInlineExample.docx'

	# # 	imageModule=new ImageModule()
	# # 	docX[name].attachModule(imageModule)

	# # 	out=docX[name]
	# # 		.load(docX[name].loadedContent)
	# # 		.setData({firefox:'examples/image2.png'})

	# # 	out
	# # 		.render()
