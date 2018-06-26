/*
Copyright (c) 2003-2009, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E'; 
	
	config.toolbar = 'MyToolbar'; 
 
	/*	
  config.toolbar_MyToolbar =
    [
        ['Source','-','Preview','-','Templates'],
			['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
			['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
			['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
			'/',
			['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
			['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
			['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
			['BidiLtr', 'BidiRtl'],
			['Link','Unlink','Anchor'],
			['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe'],
			'/',
			['Styles','Format','Font','FontSize'],
			['TextColor','BGColor'],
			['Maximize', 'ShowBlocks','-']
    ];
    */
    
    config.toolbar_MyToolbar =
    [
        ['Source','PasteText','PasteFromWord','Bold','Italic','Underline','Strike','TextColor','Font','FontSize'],
			['JustifyLeft','JustifyCenter','JustifyRight'],
			['BidiLtr', 'BidiRtl'],
			['Link','Unlink'],
			['Image','Flash','HorizontalRule','SpecialChar','Maximize']
    ];
	
	config.language = 'zh-cn';
	config.uiColor = '#DDEDFC'; 

	config.font_names = '宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;'+ config.font_names ;
	
	
	//config.filebrowserImageBrowseUrl = '/ckupload.action';
	
	config.filebrowserImageUploadUrl = '/MyNosql/ckupload.action';
  
  	config.filebrowserFlashUploadUrl = '/MyNosql/ckupload!flashUpload.action';
  	
  	config.filebrowserUploadUrl = '/MyNosql/ckupload!fileUpload.action';  
  
  //config.enterMode = CKEDITOR.ENTER_BR;
  //config.shiftEnterMode = CKEDITOR.ENTER_P;


  /*
	config.toolbar = 'Full';

	config.toolbar_Full =
	[
		['Source','-','Save','NewPage','Preview','-','Templates'],
		['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
		['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
		['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
		['BidiLtr', 'BidiRtl'],
		'/',
		['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
		['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
		['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
		['Link','Unlink','Anchor'],
		['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
		'/',
		['Styles','Format','Font','FontSize'],
		['TextColor','BGColor'],
		['Maximize', 'ShowBlocks','-','About']
	];

	config.toolbar_Basic =
	[
		['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink','-','About']
	];
	*/




};
