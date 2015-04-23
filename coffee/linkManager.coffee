DocUtils=require('./docUtils.coffee')

module.exports = class LinkManager
  constructor:(@zip,@fileName)->
    @endFileName=@fileName.replace(/^.*?([a-z0-9]+)\.xml$/,"$1")

  setLink:(fileName,data,options={})->
    @zip.remove(fileName)
    @zip.file(fileName,data,options)

  loadLinkRels: () ->
    console.log "loadLinkRels called..."
    file=@zip.files["word/_rels/#{@endFileName}.xml.rels"]
    if file==undefined then return
    content= DocUtils.decode_utf8 file.asText()
    @xmlDoc= DocUtils.Str2xml content
    RidArray = ((parseInt tag.getAttribute("Id").substr(3)) for tag in @xmlDoc.getElementsByTagName('Relationship')) #Get all Rids
    @maxRid=DocUtils.maxArray(RidArray)
    @linkRels=[]
    this

  addLinkRels: (linkData) -> #Adding an image and returns it's Rid
  # addLinkRels: (linkName,linkData,i=0) -> #Adding an image and returns it's Rid
    console.log "addLinkRels called..."
    debugger
    # NOTE: Seems to be if we have 2 files with the same name
    # realLinkName=if i==0 then linkName else linkName+"(#{i})"
    # if @zip.files["word/media/#{realImageName}"]?
    #   return @addLinkRels(linkName,linkData,i+1)
    @maxRid++
    relationships= @xmlDoc.getElementsByTagName("Relationships")[0]
    newTag= @xmlDoc.createElement 'Relationship' #,relationships.namespaceURI
    newTag.namespaceURI= null
    newTag.setAttribute('Id',"rId#{@maxRid}")
    newTag.setAttribute('Type','http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink')
    # newTag.setAttribute('Target',"media/#{realImageName}")
    newTag.setAttribute('Target', linkData)
    newTag.setAttribute('TargetMode',"External")
    relationships.appendChild newTag
    @setLink("word/_rels/#{@endFileName}.xml.rels",DocUtils.encode_utf8 DocUtils.xml2Str @xmlDoc)
    console.log "MaxID is #{@maxRid}"
    @maxRid
