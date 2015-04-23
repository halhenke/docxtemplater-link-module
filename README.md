# A plugin for docxtemplater - docxtemplater-link-module

## What

This plugin enables docxtemplater to embed hyperlinks - either emails or URLS
to be embedded in docx files.

### How to Do

- A `docxtemplater` object stores all the files as an array in its `doc.zip.files` property

First module for docxtemplater.

# Installation:

You will need docxtemplater v1: `npm install docxtemplater@beta`

install this module: `npm install docxtemplater-link-module`

# Usage

Your docx should contain the text: `{! link }`

    LinkModule=require(‘docxtemplater-link-module’)

    linkModule=new LinkModule({centered:false})

    docx=new DocxGen()
        .attachModule(linkModule)
        .load(content)
        .setData({
          link: {
            text: "Steve Jobs",
            link: 'stevejobs@apple.com'
          }})
        .render()

    buffer= docx
            .getZip()
            .generate({type:"nodebuffer"})

    fs.writeFile("test.docx",buffer);


# Notice

 For the link-replacer to work, the link tag: `{! link }` needs to be in its own `<w:p>`, so that means that you have to put a new line after and before the tag.

# Building

 You can build the coffee into js by running `gulp` (this will watch the directory for changes)

# Testing

You can test that everything works fine using the command `mocha`. This will also create 3 docx files under the root directory that you can open to check if the docx are correct

# TODO
- [ ] Try to handle links that occur in the midst of other content
- [ ] Settle on a better syntax?
- [ ] Handle a subject field for email links
