# require("coffee-script/register")

fs=require('fs')
DocxGen=require('docxtemplater')
expect=require('chai').expect
xmldom=require("xmldom")
fixtures = require("./fixtures/docxData")

fileNames=[
  'linkExample.docx'
  'hasLinksExample.docx'
  'inlineLinkExample.docx'
  'linkLoopExample.docx'
]

# LinkModule=require('../js/index.js')
LinkModule=require('./index.coffee')
docX={}

# -------------------------------------------------
# UTILITIES
# -------------------------------------------------

loadFile=(name)->
  if fs.readFileSync? then return fs.readFileSync(__dirname+"/../examples/"+name,"binary")
  xhrDoc= new XMLHttpRequest()
  xhrDoc.open('GET',"../examples/" + name, false)
  if (xhrDoc.overrideMimeType)
    xhrDoc.overrideMimeType('text/plain; charset=x-user-defined')
  xhrDoc.send()
  xhrDoc.response
# -------------------------------------------------

describe 'link adding with {! link } syntax', ()->
  beforeEach (done) ->
    console.log "Before Block called"
    for name in fileNames
      content=loadFile(name)
      docX[name]=new DocxGen()
      docX[name].loadedContent=content
    done()
  describe "web links", ->
    it 'should work with one link', (done) ->
      sampleLink =
        text: "Don't go here..."
        link: 'http://gotojail.com'
      name='linkExample.docx'
      templateResult = fixtures.linkExample
      linkModule=new LinkModule()
      docX[name].attachModule(linkModule)
      out=docX[name]
        .load(docX[name].loadedContent)
        .setData(link: sampleLink)
        .render()

      zip=out.getZip()

      console.log "Here we have #{sampleLink.link} #{sampleLink.text}"
      relsFile=zip.files['word/_rels/document.xml.rels']
      expect(relsFile?).to.equal(true)
      relsFileContent=relsFile.asText()
      expect(relsFileContent).to.equal(templateResult.rels.replace("__linkData__", sampleLink.link))

      documentFile=zip.files['word/document.xml']
      expect(documentFile?).to.equal(true)
      documentContent=documentFile.asText()
      expect(documentContent).to.equal(templateResult.doc.replace("__linkText__", sampleLink.text))

      fs.writeFile("test.docx", zip.generate({type:"nodebuffer"}));
      done()

    it 'should work when we only pass it a single string as the link', (done) ->
      sampleLink = 'http://gotojail.com'
      name='linkExample.docx'
      templateResult = fixtures.linkExample
      linkModule=new LinkModule()
      docX[name].attachModule(linkModule)
      out=docX[name]
        .load(docX[name].loadedContent)
        .setData(link: sampleLink)
        .render()

      zip=out.getZip()

      relsFile=zip.files['word/_rels/document.xml.rels']
      expect(relsFile?).to.equal(true)
      relsFileContent=relsFile.asText()
      expect(relsFileContent).to.equal(templateResult.rels.replace("__linkData__", sampleLink))

      documentFile=zip.files['word/document.xml']
      expect(documentFile?).to.equal(true)
      documentContent=documentFile.asText()
      expect(documentContent).to.equal(templateResult.doc.replace("__linkText__", sampleLink))

      fs.writeFile("test.docx", zip.generate({type:"nodebuffer"}));
      done()

  describe "email links", ->
    it "should work with a single email link", (done) ->
      sampleLink =
        text: "Steve Jobs"
        link: 'stevejobs@apple.com'
      name='linkExample.docx'
      templateResult = fixtures.linkExample
      linkModule=new LinkModule()
      docX[name].attachModule(linkModule)
      out=docX[name]
        .load(docX[name].loadedContent)
        .setData(link: sampleLink)
        .render()
      zip=out.getZip()

      console.log "Here we have #{sampleLink.link} #{sampleLink.text}"
      relsFile=zip.files['word/_rels/document.xml.rels']
      expect(relsFile?).to.equal(true)
      relsFileContent=relsFile.asText()
      expect(relsFileContent).to.equal(templateResult.rels.replace("__linkData__", "mailto:#{sampleLink.link}"))

      documentFile=zip.files['word/document.xml']
      expect(documentFile?).to.equal(true)
      documentContent=documentFile.asText()
      expect(documentContent).to.equal(templateResult.doc.replace("__linkText__", sampleLink.text))

      fs.writeFile("test.docx", zip.generate({type:"nodebuffer"}));
      done()

    it 'should work when we only pass it a single string as the link', (done) ->
      sampleLink = 'stevejobs@apple.com'
      name='linkExample.docx'
      templateResult = fixtures.linkExample
      linkModule=new LinkModule()
      docX[name].attachModule(linkModule)
      out=docX[name]
        .load(docX[name].loadedContent)
        .setData(link: sampleLink)
        .render()

      zip=out.getZip()

      relsFile=zip.files['word/_rels/document.xml.rels']
      expect(relsFile?).to.equal(true)
      relsFileContent=relsFile.asText()
      expect(relsFileContent).to.equal(templateResult.rels.replace("__linkData__", "mailto:#{sampleLink}"))

      documentFile=zip.files['word/document.xml']
      expect(documentFile?).to.equal(true)
      documentContent=documentFile.asText()
      expect(documentContent).to.equal(templateResult.doc.replace("__linkText__", sampleLink))

      fs.writeFile("test.docx", zip.generate({type:"nodebuffer"}));
      done()

  describe "when the docx has other links and other replacements to make", ->
    describe "web links", ->
      it 'should work with one link', (done) ->
        sampleData =
          link:
            text: "Don't go here..."
            link: 'http://gotojail.com'
          friends: [
            {
              name: "Jason"
              age: 34
              alignment: "evil"
            }
          ]
        name='hasLinksExample.docx'
        templateResult = fixtures.hasLinksExample
        linkModule=new LinkModule()
        docX[name].attachModule(linkModule)
        out=docX[name]
          .load(docX[name].loadedContent)
          .setData(sampleData)
          .render()

        zip=out.getZip()

        # console.log "Here we have #{sampleLink.link} #{sampleLink.text}"
        relsFile=zip.files['word/_rels/document.xml.rels']
        expect(relsFile?).to.equal(true)
        relsFileContent=relsFile.asText()
        expect(relsFileContent).to.equal(templateResult.rels.replace("__linkData__", sampleData.link.link))

        documentFile=zip.files['word/document.xml']
        expect(documentFile?).to.equal(true)
        documentContent=documentFile.asText()
        expect(documentContent).to.equal(templateResult.doc.replace("__linkText__", sampleData.link.text))

        fs.writeFile("test.docx", zip.generate({type:"nodebuffer"}));
        done()

  describe "when we use the loop syntax", ->
    describe "web links", ->
      it 'should work with one link', (done) ->
        sampleData =
          links: [
            {
              text: "Don't go here..."
              link: 'http://gotojail.com'
            }
            {
              text: "Look at me..."
              link: 'http://gowellmyfriend.com'
            }
          ]
        name='linkLoopExample.docx'
        templateResult = fixtures.linkLoopExample
        linkModule=new LinkModule()
        docX[name].attachModule(linkModule)
        out=docX[name]
          .load(docX[name].loadedContent)
          .setData(sampleData)
          .render()

        zip=out.getZip()

        relsFile=zip.files['word/_rels/document.xml.rels']
        expect(relsFile?).to.equal(true)
        relsFileContent=relsFile.asText()
        expect(relsFileContent)
          .to.equal templateResult.rels.replace("__linkData__1__", sampleData.links[0].link).replace("__linkData__2__", sampleData.links[1].link)

        documentFile=zip.files['word/document.xml']
        expect(documentFile?).to.equal(true)
        documentContent=documentFile.asText()
        expect(documentContent)
          .to.equal templateResult.doc.replace("__linkText__1__", sampleData.links[0].text).replace("__linkText__2__", sampleData.links[1].text)

        fs.writeFile("test.docx", zip.generate({type:"nodebuffer"}));
        done()


  # We cant do this because - like docxtemplater-image-module
  # the link "needs to be in its own <w:p>, so that means that
  # you have to put a new line after and before the tag."
  describe.skip "when the web link occurs inline", ->
    describe "web links", ->
      it 'should work with one link', (done) ->
        sampleLink =
          text: "Don't go here..."
          link: 'http://gotojail.com'
        name='inlineLinkExample.docx'
        templateResult = fixtures.inlineLinkExample
        linkModule=new LinkModule()

        # ----------
        # r2d2 = docX[name].getZip().files['word/document.xml'].asText()
        # r2d2 = docX[name].load(docX[name].loadedContent).render().getZip().files['word/document.xml'].asText()
        # console.log "r2d2 is #{r2d2}"
        # ----------

        docX[name].attachModule(linkModule)
        out=docX[name]
          .load(docX[name].loadedContent)
          .setData(firefox: sampleLink)
          # .setData(sampleData)
          .render()

        zip=out.getZip()

        relsFile=zip.files['word/_rels/document.xml.rels']
        expect(relsFile?).to.equal(true)
        relsFileContent=relsFile.asText()
        expect(relsFileContent).to.equal(templateResult.rels.replace("__linkData__", sampleLink.link))

        documentFile=zip.files['word/document.xml']
        expect(documentFile?).to.equal(true)
        documentContent=documentFile.asText()
        expect(documentContent).to.equal(templateResult.doc.replace("__linkText__", sampleLink.text))

        fs.writeFile("test.docx", zip.generate({type:"nodebuffer"}));
        done()
