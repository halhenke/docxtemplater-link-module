SubContent=require('docxtemplater').SubContent
LinkManager=require('./linkManager.coffee')
fs=require('fs')

class LinkModule
  constructor:(@options={})->
    console.log "LinkModule created"
    @linkNumber=1
  handleEvent:(event,eventData)->
    if event=='rendering-file'
      console.log "Rendering File event called..."
      @renderingFileName=eventData
      gen=@manager.getInstance('gen')
      @linkManager=new LinkManager(gen.zip,@renderingFileName)
  get:(data)->
    if data=='loopType'
      templaterState=@manager.getInstance('templaterState')
      # if templaterState.textInsideTag[0]=='%'
      #   return 'image'
      # if templaterState.textInsideTag.match(/\[(.*)\]\((.*)\)/)
      if templaterState.textInsideTag[0]=='!'
        console.log "Matched a hyperlink"
        return 'hyperlink'
    null
  replaceBy:(text,outsideElement)->
    console.log "LinkModule.replaceBy called..."
    xmlTemplater=@manager.getInstance('xmlTemplater')
    templaterState=@manager.getInstance('templaterState')
    subContent=new SubContent(xmlTemplater.content)
      .getInnerTag(templaterState)
      .getOuterXml(outsideElement)
    xmlTemplater.replaceXml(subContent,text)
  handle:(type,data)->
    console.log "LinkModule.handle called..."
    if type=='replaceTag' and data=='hyperlink'
      console.log "LinkModule.handle replaceTag & hyperlink..."
      scopeManager=@manager.getInstance('scopeManager')
      templaterState=@manager.getInstance('templaterState')

      tag = templaterState.textInsideTag.substr(1).trim()
      # tag = templaterState.textInsideTag
      debugger
      linkObject = scopeManager.getValueFromScope(tag)
      if typeof(linkObject) is "object"
        link_data = linkObject.link
        link_display = linkObject.text
      else if typeof(linkObject) is "string"
        link_data = link_display = linkObject
      else
        return @replaceBy('<w:t></w:t>','w:t')
      # if link_data=='undefined' then return @replaceBy('<w:t></w:t>','w:t')
      console.log "links: #{link_data} #{link_display}"

      rId=@linkManager
        .loadLinkRels()
        .addLinkRels(link_data)

      outsideElement='w:p'
      newText=@getLinkXml(rId,link_display)
      @replaceBy(newText,outsideElement)
    null
  getLinkXml:(rId,link_display)->
    """
    <w:p>
      <w:hyperlink r:id="rId#{rId}">
        <w:r>
          <w:rPr>
            <w:i />
            <w:rStyle w:val="Link" /></w:rPr>
          <w:t xml:space="preserve">#{link_display}</w:t>
        </w:r>
      </w:hyperlink>
    </w:p>
    """

module.exports=LinkModule
