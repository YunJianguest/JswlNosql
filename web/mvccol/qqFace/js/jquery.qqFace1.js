// QQ表情插件
(function($){  
	$.fn.qqFace = function(options){
		var defaults = {
			id : 'facebox',
			path : 'face/',
			assign : 'content',
			tip : 'em_'
		};
		var option = $.extend(defaults, options);
		var assign = $('#'+option.assign);
		var id = option.id;
		var path = option.path;
		var tip = option.tip;
		
		if(assign.length<=0){
			alert('缺少表情赋值对象。');
			return false;
		}
		
		$(this).click(function(e){
			 
	         $("#qqbq").show();   
			 $("#tanchu-tp").hide();
		     $("#tanchu-zhiding").hide();
		     $("#tanchu-yuyin").hide();
		     $("#tanchu-xuanshang").hide(); 
			var strFace, labFace;
			if($('#'+id).length<=0){
				strFace='<div class="hang5 bg-hui-tx clear"></div><div class="div-group-10 pt-5 overflow-hidden clear">';
				
				strFace += '<div id="'+id+'" style="background-color:#FFFFFF">';
				for(var i=1; i<=75; i++){
					labFace = '['+tip+i+']';
					strFace +='<div class="col-1 overflow-hidden">'
						+'<div class="maring-a img-wh25">'
						+'<img  src="'+path+i+'.gif" onclick="$(\'#'+option.assign+'\').setCaret();$(\'#'+option.assign+'\').insertAtCaret(\'' + labFace + '\');" />'; 
					strFace+='</div></div>';
				            
			          
				}
							  
				/*for(var i=1; i<=75; i++){
					labFace = '['+tip+i+']';
					strFace += '<img src="'+path+i+'.gif" onclick="$(\'#'+option.assign+'\').setCaret();$(\'#'+option.assign+'\').insertAtCaret(\'' + labFace + '\');" />';
					if( i % 15 == 0 ) strFace += '';
				}*/
			 
				
				strFace += '</div></div><div class="hang5 bg-hui-tx clear"></div>';
			}
			$("#qqbq").html(strFace);
			$("#qqbq").show();
			var offset = $(this).position();
			var top = offset.top + $(this).outerHeight();
			$('#'+id).css('top',top);
			$('#'+id).css('left','1px');
			$('#'+id).show();
			e.stopPropagation();
		});
        $("#imgup").click(function(){
        	$("#qqbq").hide();
        	$(".pic-list").show();
		});
        
		$("#comcontent").click(function(){ 
			$("#qqbq").hide();
		});
	};

})(jQuery);

jQuery.extend({ 
unselectContents: function(){ 
	if(window.getSelection) 
		window.getSelection().removeAllRanges(); 
	else if(document.selection) 
		document.selection.empty(); 
	} 
}); 
jQuery.fn.extend({ 
	selectContents: function(){ 
		$(this).each(function(i){ 
			var node = this; 
			var selection, range, doc, win; 
			if ((doc = node.ownerDocument) && (win = doc.defaultView) && typeof win.getSelection != 'undefined' && typeof doc.createRange != 'undefined' && (selection = window.getSelection()) && typeof selection.removeAllRanges != 'undefined'){ 
				range = doc.createRange(); 
				range.selectNode(node); 
				if(i == 0){ 
					selection.removeAllRanges(); 
				} 
				selection.addRange(range); 
			} else if (document.body && typeof document.body.createTextRange != 'undefined' && (range = document.body.createTextRange())){ 
				range.moveToElementText(node); 
				range.select(); 
			} 
		}); 
	}, 

	setCaret: function(){ 
		if(!$.browser.msie) return; 
		var initSetCaret = function(){ 
			var textObj = $(this).get(0); 
			textObj.caretPos = document.selection.createRange().duplicate(); 
		}; 
		$(this).click(initSetCaret).select(initSetCaret).keyup(initSetCaret); 
	}, 

	insertAtCaret: function(textFeildValue){ 
		$(this).val($(this).val()+textFeildValue);
		$(this).focus().val($(this).val());
	}, 
	 
     
});