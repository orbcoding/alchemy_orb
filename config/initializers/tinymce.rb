# config/initializers/tinymce.rb
return if AlchemyOrb::RakeParser.running_solo_task?

Alchemy::Tinymce.init = {
  content_css: AlchemyOrb::AssetPathFinder.from_manifest('tinymce_content.css'),
  toolbar: [
    'bold italic underline | strikethrough subscript superscript | numlist bullist indent outdent | removeformat | fullscreen',
    'pastetext | formatselect | charmap code | undo redo | alchemy_link unlink'
  ],
  elementpath: false,
  block_formats: "Heading 2=h2;Paragraph=p",
  formats: {
    alignleft: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'text-left'},
    aligncenter: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'text-center'},
    alignright: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'text-right'},
    alignfull: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'text-justify'},
    bold: {inline: 'span', 'classes': 'text-bold'},
    italic: {inline: 'span', 'classes': 'text-italic'},
    underline: {inline: 'span', 'classes': 'text-underline', exact: true},
    strikethrough: {inline: 'del'},
    forecolor: {inline: 'span', classes: 'text-forecolor', styles: {color: '%value'}},
    hilitecolor: {inline: 'span', classes: 'text-hilitecolor', styles: {backgroundColor: '%value'}},
  },
}
