/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.allowedContent = true;
	config.forcePasteAsPlainText =false //不去除
	config.pasteFromWordIgnoreFontFace = false; //默认为忽略格式
	config.pasteFromWordRemoveStyle = false;
	config.filebrowserUploadUrl="http://vivo.jushengwang.cn/pub/ckeditor.action";
	CKEDITOR.on('dialogDefinition', function(ev) {
        // Take the dialog name and its definition from the event data
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;
        var editor = ev.editor;
        if (dialogName == 'image') {
           dialogDefinition.onOk = function(e) {
              var imageSrcUrl = e.sender.originalElement.$.src;
              var imgHtml = CKEDITOR.dom.element.createFromHtml("<img src='" + imageSrcUrl + "' alt=''/>");
              editor.insertElement(imgHtml);
           };
        }
    });
};
