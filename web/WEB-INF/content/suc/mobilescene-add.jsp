<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/media/js/DT_bootstrap.js"></script>

<script type="text/javascript" src="${contextPath}/js/upload/swfobject.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/jquery.uploadify.v2.1.4.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/upload.js"></script> 
<script type="text/javascript" src="${contextPath}/mvccol/color/jscolor.js"></script>
<script type="text/javascript" src="${contextPath}/mvccol/js/rightmenu.js"></script>
<script src="${ctx }/cmp/js/iscroll-zoom.js"></script>
<script src="${ctx }/cmp/js/jquery.photoClip.js"></script>
<link href="${ctx }/cmp/css/pc_common.css" rel="stylesheet" type="text/css"/>
<script src="${ctx }/cmp/js/hammer.js"></script>

<style type="text/css">
.dialog-600{
 width: 600px;
 margin: 10% auto;
}
.dialog-800{
 width: 800px;
 margin: 7% auto;
}
.dialog-500{
 width: 500px;
 margin: 5% 1% 1% 50%;
}

textarea{ resize:none; width:200px; height:200px;}

  #clipArea {
            height: 500px;
        }
        .file{ position:absolute; top:10px; left:-120px; height:42px; filter:alpha(opacity:0);opacity:0;  }
</style>
<script type="text/javascript"> 
var  styletype;
var  scid;
var  styleid;
var  animaid;
var  animatype;
$(document).ready(function(){
	
	var validator = $("#basicForm1").validate({
		rules: {
			title: {
                required: true
            },
            wwz:{
            	required: true
            },
            summary:{
            	required: true
            },
            bj3:{
            	required: true
            }
			
		},
		messages: {
			
		},
		highlight: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		    },
		    success: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-error');
		    }
		
	});
	var validator = $("#basicForm2").validate({
		rules: {
			title: {
                required: true
            },
            wwz:{
            	required: true
            },
            summary:{
            	required: true
            },
            bj3:{
            	required: true
            }
			
		},
		messages: {
			
		},
		highlight: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		    },
		    success: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-error');
		    }
		
	});
	var validator = $("#basicForm3").validate({
		rules: {
			url1: {
                required: true
            },
            url2:{
            	required: true
            },
            url3:{
            	required: true
            },
            url0:{
            	required: true
            }
			
		},
		messages: {
			
		},
		highlight: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		    },
		    success: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-error');
		    }
		
	});
	var validator = $("#insfuncForm").validate({
		rules: {
			name: {
                required: true
            },
            type:{
            	required: true
            },
            picurl:{
            	required: true
            },
            mb:{
            	required: true
            },
            xs:{
            	required: true
            },
            sort:{
            	required: true,
            	digits:true
            }
			
		},
		messages: {
			
		},
		highlight: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		    },
		    success: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-error');
		    }
		
	});
	
	
});
function share(url) {
	window.open("${contextPath}/weixin/share.action?method="+ encodeURIComponent(url));
}
function checkName(value) {
	var tname = "wx_function";
	//数据库名称
	var pname = "key";
	//当前页面ID名称
	
	var rvalue = "<s:property value='_id'/>";
	
	DwrAjaxServer.checkService(tname,pname,value,rvalue, {
		callback : function(backJson) {
			if(backJson=="yes"){
				$("#key").val("<s:property value='key'/>");
				$("#validmsg").html('编码值已经存在');
			}else{
				$("#validmsg").html('');
			}

		}
	});
}
function footpic(index,value){
	$('#footpic'+index).val(value);
}

function addfunc(){
	$('#funcid').val('');
	$('#funcname').val('');
	$('#key').val('');	
	$('#type').val('');	
	$('#url').val('');	
	$('#mb').val('');	
	$('#picurl').val('');	
	$('#summary').val('');	
	$('#sort').val('');	
	
	$('#insfunc').modal({ 
	    show:true
	});
}
function updfunc(id){
	var submitData = {
			_id:id
	};
	$.post('${ctx}/wx/wxfunc!upd.action', submitData,
		function(json) {
		$('#funcid').val(json._id);
		$('#funcname').val(json.name);
		$('#key').val(json.key);	
		$('#type').val(json.type);	
		$('#url').val(json.url);	
		$('#mb').val(json.mb);	
		$('#uploadresultTwo').val(json.picurl);	
		$('#summary').val(json.summary);	
		$('#sort').val(json.sort);	
		$('#adminurl').val(json.adminurl);	
		$('#xs').val(json.xs);	
		changeurl(json.type);
				
	},"json")
	
	$('#insfunc').modal({ 
	    show:true
	});
}
function addadv(){
	$('#advid').val('');
	$('#advtitle').val('');
	$('#advurl').val('');	
	
	$('#uploadresult').val('');	
	$('#advsort').val('');	
	
	$('#insadv').modal({ 
	    show:true
	});
}

function updadv(id,title,url,picurl,sort){
	$('#advid').val(id);
	$('#advtitle').val(title);
	$('#advurl').val(url);	
	
	$('#uploadresult').val(picurl);	
	$('#advsort').val(sort);	
	
	$('#insadv').modal({ 
	    show:true
	});
}
function addroll(){
   if(!checkid(2)){
    return;
    };
	$('#rollid').val('');
	$('#rolltitle').val('');
	$('#rollurl').val('');	
	$('#rollsort').val('');	
	
	$('#insroll').modal({ 
	    show:true
	});
}
function addnavi(){
   if(!checkid(3)){
    return;
    };
	$('#naviid').val('');
	$('#navititle').val('');
	$('#naviurl').val('');	
	$('#navisort').val('');	
	
	$('#insnavi').modal({ 
	    show:true
	});
}
function addScene(){
    
	$('#sceneid').val('');
	$('#scenetitle').val('');
	$('#sceneurl').val('');	
	$('#scenebj').val('');

	$('#scenesort').val(0);	
	
	$('#insScene').modal({ 
	    show:true
	});
}
function addwxpay(){
	var submitData = {};
	$.post('${ctx}/wx/wxtouser!updpay.action?_id=${entity.toUser}', submitData,
			function(json) {
				$('#partner').val(json.partner);
				$('#partner_key').val(json.partner_key);	
				$('#appkey').val(json.appkey);	
				
	},"json")
	$('#inspay').modal({ 
		    show:true
	});
}

function delfunc(id,tab) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/wx/wxtouser!delfunc.action?funcid="+ id+"&tab="+tab;
	}		
}
function deladv(id,tab) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/wx/wxtouser!deladv.action?_id="+ id+"&tab="+tab;
	}		
}
function delroll(id,tab) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/wx/wxtouser!delroll.action?_id="+ id+"&tab="+tab;
	}		
}
function changeurl(value) {
	if(value=="link"){
		$("#urlcontrol").show();
	}else{
		$("#urlcontrol").hide();
	}
	
}
function getpic(xsvalue) {
	$('#xsvalue').val(xsvalue);
    $('#tubiao').show();
}
function seltb(key){
	var a=$('#xsvalue').val();
	$('#'+a).val(key);
	$('#tubiao').hide();
}
function xzsb() {
    $('#sbtb').show();
}
function close_box(){
	$('#sbtb').hide();
}
function selsb(key,value){
	$('#css').val(key);
	$('#sbtb').hide();
}
function addmb(){

$('#insmb').modal({ 
	    show:true
	});
}

function  changemb(id){ 
  var  subdata={
    mb:id,
    webid:$("#webid").val(),
    comid:'${comid}',
    toUser:'${toUser}'
  
  }; 
  $.post("${ctx}/website/website!ajaxsaveMb.action",subdata,function(json){
     if(json.state==0){ 
     $("#webid").val(json.webid);
     $("#slidewebid").val(json.webid);
     $("#rollwebid").val(json.webid);
     $("#naviwebid").val(json.webid);
     alert("设置成功");
     }else{
     alert("设置失败");
     }
     location.reload();
   },"json");

}
function checkid(v){
  if($('#webid').val()==""){
      alert("请先设置模板");
      $('#li_'+v).removeClass("active");
      $('#tab'+v).removeClass("active");
      $('#li_0').addClass("active");
      $('#tab0').addClass("active");
      return false;
    }
  return true;
}
function checkweb(){
 
    return;
 
}
function delScene(id){

    var submitdata={
    id:id,
    msid:'${msid}'
   };
   $.post("${ctx}/suc/mobilescene!delScene.action?toUser=${toUser}",submitdata,function(json){ 
   
      var  html=""; 
      var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>背景图</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
       for ( var v = 0; v<list.length; v++) {
        
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td>'+list[v].title+'</td>'
		      +'<td><img src="${osshttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>'
		      +'<td class="table-action"><div class="btn-group1"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updScene('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>'
		      +'<li><a href="javascript:getSpirit('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;管理精灵</a></li>'
		      +' <li><a href="javascript:delScene('+list[v]._id+');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'</ul></div></td></tr>';
		            
	      }
	    } 
	     
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btnScene" onclick="addScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加图层</span>';
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('图层管理');
	    document.getElementById('leftmenu').contentWindow.location.reload(true);
    
   
   },"json");
 

}
function gobackScene(){
   var submitdata={
    id:'${msid}'
   };
   $.post("${ctx}/suc/mobilescene!getScene.action?toUser=${toUser}",submitdata,function(json){ 
   
      var  html=""; 
      var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>背景图</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
       for ( var v = 0; v<list.length; v++) {
        
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td>'+list[v].title+'</td>'
		      +'<td><img src="${osshttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>'
		      +'<td class="table-action"><div class="btn-group1"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updScene('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>'
		      +'<li><a href="javascript:getSpirit('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;管理精灵</a></li>'
		      +' <li><a href="javascript:delScene('+list[v]._id+');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'</ul></div></td></tr>';
		            
	      }
	    } 
	     
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btnScene" onclick="addScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加图层</span>';
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('图层管理');
    
   
   },"json");
 
}
function delSpirit(id){ 
   var submitdata={
    id:id,
    toUser:'toUser',
    scid:scid
   };
   $.post("${ctx}/suc/mobilescene!deleteSpirit.action",submitdata,function(json){ 
     
      var  html=""; 
      var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>背景图</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
       for ( var v = 0; v<list.length; v++) {
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td>'+list[v].title+'</td>'
		      +'<td><img src="${osshttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>' 
		      +'<td class="table-action"><div class="btn-group1"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updSpirit('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>' 
		      +'<li><a href="javascript:delSpirit('+list[v]._id+');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'<li><a href="javascript:updSpiritStyle('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;样式</a></li>'
		       +'<li><a href="javascript:updSpiritAnimation('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;动画</a></li>'
		      +'</ul></div></td></tr>';
		           
	      }
	    } 
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btSpirit" onclick="addSpirit();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加精灵</span>'
	    +'<span class="btn btn-darkblue btn-block" id="btSpirit" onclick="gobackScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;返回父层</span>'; 
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('精灵管理');
        document.getElementById('leftmenu').contentWindow.location.reload(true); 
   
   },"json");
}
function getSpirit(id){
  scid=id;
 var submitdata={
    id:id
   };
   $.post("${ctx}/suc/mobilescene!getSpirits.action",submitdata,function(json){ 
   
      var  html=""; 
      var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>背景图</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
       for ( var v = 0; v<list.length; v++) {
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td>'+list[v].title+'</td>'
		      +'<td><img src="${osshttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>' 
		      +'<td class="table-action"><div class="btn-group1"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updSpirit('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>' 
		      +'<li><a href="javascript:delSpirit('+list[v]._id+');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'<li><a href="javascript:updSpiritStyle('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;样式</a></li>'
		       +'<li><a href="javascript:updSpiritAnimation('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;动画</a></li>'
		      +'</ul></div></td></tr>';
		           
	      }
	    } 
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btSpirit" onclick="addSpirit();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加精灵</span>'
	    +'<span class="btn btn-darkblue btn-block" id="btSpirit" onclick="gobackScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;返回父层</span>'; 
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('精灵管理');
  
   
   },"json");
}
function updSpirit(id){
 
  var submitData = {
			id:id,
		 	
	};
	$.post('${ctx}/suc/mobilescene!updateSpirit.action', submitData,
		function(json) { 
		    $('#spiritid').val(json._id); 
			$('#spirittitle').val(json.title);
			$('#spiriturl').val(json.url);
			$('#spirittype').val(json.type);
			$('#spiritsort').val(json.sort);
			$('#uploadresultTwo').val(json.picurl);
			
		   
	},"json");


  $('#insSpririt').modal({ 
	    show:true
 	});
}
function addSpirit(){  
   $('#insSpririt').modal({ 
	    show:true
 	});
}
function AdSpirit(){
   var submitData = {
			id:$('#spiritid').val(),
			scid:scid,
			url:$('#spiriturl').val(),
			title:$('#spirittitle').val(),
			picurl:$('#uploadresultTwo').val(),
			summary:$('spiritsummary').val(),
			sort:$('#spiritsort').val(),  
			type:$('#spirittype').val() 
			
	};
	$.post('${ctx}/suc/mobilescene!updSpirit.action?toUser=${toUser}', submitData,
		function(json) { 
		  document.getElementById('leftmenu').contentWindow.location.reload(true); 
		  var  html=""; 
          var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>图片</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
       for ( var v = 0; v<list.length; v++) {
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td>'+list[v].title+'</td>'
		      +'<td><img src="${osshttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>' 
		      +'<td class="table-action"><div class="btn-group1"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updSpirit('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>' 
		      +' <li><a href="javascript:delSpirit('+list[v]._id+',1);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'<li><a href="javascript:updSpiritStyle('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;样式</a></li>'
		      +'<li><a href="javascript:updSpiritAnimation('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;动画</a></li>'
		      +'</ul></div></td></tr>';
		            
	      }
	    } 
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btSpirit" onclick="addSpirit();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加精灵</span>'
	    +'<span class="btn btn-darkblue btn-block" id="btSpirit" onclick="gobackScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;返回父层</span>'; 
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('精灵管理');
  
		  
		  
	},"json");
 	
   
}
 
function  updScene(id){

var submitData = {
			id:id
	};
	$.post('${ctx}/suc/mobilescene!updateSceneById.action', submitData,
		function(json) {
		$('#sceneid').val(json._id);
		$('#scenetitle').val(json.title);
		$('#sceneurl').val(json.url);
		$('#scenesort').val(json.sort);
		$('#uploadresult').val(json.picurl);
		$('#scenesort').val(json.sort);
		 		
	},"json");
	
	$('#insScene').modal({ 
	    show:true
 	});
}
 
function  updSpiritStyle(id){
  styletype='scene';
  styleid=scid+'-'+id;  
  var submitData = {
			id:'${toUser}'+'-'+styletype+'-'+styleid,
		 	
	};
	$.post('${ctx}/suc/mobilescene!updStyle.action', submitData,
		function(json) {  
			$('#fl').html(json.marginleft),
			$('#ft').html(json.margintop),
			$('#styleh').val(json.height),
			$('#stylew').val(json.width),
			$('#stylecolor').val(json.color),
			$('#border-radius').html(json.radius)
		   
	},"json");
  
  $('#insStyle').modal({ 
	    show:true
	});
}
function updSpiritAnimation(id){
animaid=scid+'-'+id;
animatype='scene';
var submitData = {
			id:'${toUser}'+'-'+animatype+'-'+animaid,
		 	
	}; 
	$.post('${ctx}/suc/mobilescene!updAnima.action', submitData,
		function(json) {  
			$('#animaValue').val(json.value);
			$('#animaiterate').val(json.iterate);
			$('#animaduration').val(json.duration);
			$('#animakeep').val(json.keep);
			 
		   
	},"json");
  


 $('#insAnima').modal({ 
	    show:true
	});
}

function  updMp3(type){
styletype=type;
styleid='${styleid}';
 var submitData = {
			id:'${toUser}'+'-'+styletype+'-'+styleid,
		 	
	}; 
	$.post('${ctx}/suc/mobilescene!updStyle.action', submitData,
		function(json) {  
			$('#fl').html(json.marginleft),
			$('#ft').html(json.margintop/bheight*100),
			$('#styleh').val(json.height),
			$('#stylew').val(json.width),
			$('#stylecolor').val(json.color),
			$('#border-radius').html(json.radius);
			
			 // Basic Slider滑动监听
    jQuery('#slider-float-left').slider({
      range: "min",
      max: 1000,
      value:json.marginleft*10,
      slide: function(event, ui ) {
        $("#fl").html(ui.value/10);
        updStyle(); 
      }
    });
    $("#slider-float-top").slider({
      range: "min",
      max: 1000,
      value:json.margintop+500,
      slide: function(event, ui ) { 
       $("#ft").html(ui.value-500);
       updStyle();
        
      }
    });
    $("#slider-border-radius").slider({
     range:"min",
     max:1000,
     value:json.radius,
     slide:function(event,ui){
      $("#border-radius").html(ui.value);
      updStyle();
     }
    
    });
			
			
		   
	},"json");
  

$('#insStyle').modal({ 
	    show:true
	});
 
}
 
function updStyle(){  
var submitData = {
			id:styleid,
			type:styletype,
			ml:$('#fl').html(),
			mt:$('#ft').html(),
			h:$('#styleh').val(),
			w:$('#stylew').val(),
			color:$('#stylecolor').val(),
			radius:$('#border-radius').html(),
			
	}; 
	$.post('${ctx}/suc/mobilescene!updateStyle.action?toUser=${toUser}', submitData,
		function(json) { 
		  document.getElementById('leftmenu').contentWindow.location.reload(true); 
	},"json");
 	

}
function updAnima(){  
var submitData = {
			id:animaid,
			type:animatype,
			value:$('#animaValue').val(),
			iterate:$('#animaiterate').val(),
			duration:$('#animaduration').val(),
			keep:$('#animakeep').val()
	}; 
	$.post('${ctx}/suc/mobilescene!updateAnima.action?toUser=${toUser}', submitData,
		function(json) { 
		  document.getElementById('leftmenu').contentWindow.location.reload(true); 
	},"json");
 	

}
 
function pz(id,w,h){
$("#clipArea").photoClip({
	    width: w,
	    height: h,
	    file: "#file",
	    view: "#view",
	    ok: "#clipBtn",
	    outputType:"jpg",
	    loadStart: function () {
	        console.log("照片读取中");
	    },
	    loadComplete: function () {
	        console.log("照片读取完成");
	    },
	    clipFinish: function (dataURL) {
	    	upimage(dataURL,id);
	    	$('#clipArea').html('');
	    }
	});

	$('#jqpic').show();
}
function upimage(baseurl,id) {
	  
    var submitData = {
    		baseurl: baseurl
    };

    $.post('${ctx}/web/webajax!upimage.action?toUser=${toUser}', submitData,
    	function (json) {
    	
        	if(json.state==0){
        		
        		$("#"+id).val(json.path);
        		
        		$('#jqpic').hide();
        	}
        },"json")
  
} 
function gb(){
    	$('#tubiao').hide();
    	$('#jqpic').hide();
    	$('#clipArea').html('');
    	
    }
</script>
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>
<input type="hidden" id="xsvalue" value="0" 	name="xsvalue" />
<div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
   
    <div class="pageheader">
      
      <h2><i class="fa fa-eye"></i> 微官网 <span>微官网配置</span></h2>
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-darkblue dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu"> 
            	<li><a href="${contextPath}/suc/mobilescene!web.action?toUser=${toUser}&msid=${msid}&fromUser=oypimjo3Ln36uWtmW6TYWtND0P0o" target="_blank"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;预览</a></li>
            	 
            </ul>
         </div>
      </div>
    </div>
	<div class="contentpanel">
    
                           
	<div class="row" id="hswe">
    	<div class="col-md-5">
        	<div class="big-divice"> 
            	<div class="gongzonghao">${entity.title }</div>
            	<div class="shouji"></div>
            	<div class="shouji_di"></div>
            	<div class="kuang"><iframe name="leftmenu" id="leftmenu"  marginwidth=1 marginheight=10 frameborder=no  width="100%"  height=100% id="myiframe"
                	src='${contextPath}/suc/mobilescene!web.action?toUser=${entity.toUser}&msid=${entity._id}&fromUser=oypimjo3Ln36uWtmW6TYWtND0P0o'scrolling="auto" ></iframe>
               	</div>
        	</div>
    	</div><!-- col-md-5 -->
    	 
		<div class="col-md-7">
			<ul class="nav nav-tabs nav-justified" id="tabs">
          		<li id="li_0" <c:if test='${tab==0}'>class="active"</c:if>><a href="#tab0" data-toggle="tab"><strong>基础设置</strong></a></li>
          		<li id="li_1" <c:if test='${tab==1}'>class="active"</c:if>><a href="#tab1" data-toggle="tab"><strong>图层管理</strong></a></li>
          		
        	</ul>
			<div class="tab-content" id="tabs-body" >
          		<div class="tab-pane <c:if test='${tab==0}'>active</c:if> " id="tab0">
            	  
            		<div class="panel panel-default">
                
                <div class="panel-body">
                    <form id="websiteForm" action="${ctx}/suc/mobilescene!save.action" class="form-horizontal"  method="post">
                	 
                	<input type="hidden" id="tab" name="tab" value="0"/>
                	<input type="hidden" id="_id" value="${msid}" name="_id"/>

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text"  name="title" value="${entity.title }" class="form-control" placeholder="请输入" />
                                  
                                </div>
                                
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">背景音乐: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text"  name="mp3" value="${entity.mp3 }" class="form-control" placeholder="请输入" />
                                  
                                </div>
                                 <div class="col-sm-5">
                                 <a class="btn btn-primary" href="javascript:updMp3('mp3')">样式</a>
                               
                                </div>
                                
                            </div>
                             
                            <div class="form-group">
                                <label class="col-sm-2 control-label">LOGO: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="logo" value="${entity.logo}" id="mslogo" class="form-control" placeholder="图片建议尺寸500*300." />
                                </div>
                                <div class="col-sm-2">
                                   <div  class="button btn-lu " onclick="pz('mslogo','200','200')">
                    						<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                				  </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">封面: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="picurl" value="${entity.picurl}" id="uploadresultThr" class="form-control" placeholder="图片建议尺寸500*300." />
                                </div>
                                 <div class="col-sm-2">
                                   <div  class="button btn-lu " onclick="pz('uploadresultThr','250','450')">
                    						<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                				  </div>
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">描述: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                               
                            <textarea   name="summary" class="form-control" rows="5" placeholder="字数控制在100以内..." >${entity.summary}</textarea>
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">下标: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="foot" value="${entity.foot}" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="sort" value="${entity.sort}" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                        

                    </div>
                    <!-- panel -->
                    
                       <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <button class="btn btn-black btn-block">提&nbsp;&nbsp;交</button>
                                </div>
                            </div>
                      </div>
                </form>
             
                   
                </div><!-- panel-body -->
 

    		</div><!-- panel -->
    </form>
    </div>
    <div class="tab-pane <c:if test='${tab==1}'>active</c:if> " id="tab1">   
        	<div class="table-responsive" id="scene">
             <c:if test="${not empty scenelist }">
            	<table class="table table-striped table-success mb30" >
                	<thead>
                      			<tr>
                      				<th>序号</th>
                        			<th>名称</th> 
									<th>背景图</th>
									<th>背景色</th>
									<th>操作</th>
						
                      			</tr>
                   	</thead>
                    <tbody>
                    <c:forEach items="${scenelist}" var="bean">
						<tr >
												<td>${bean.sort}</td>
												<td>${bean.title}</td> 
												<td><img src="${osshttp}${bean.picurl}" alt="" style="height: 25px;"></td>
												<td>${bean.bg}</td> 
							<td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:updScene('${bean._id}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      		<li><a href="javascript:getSpirit('${bean._id}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;管理精灵</a></li>
                                      <li><a href="javascript:delScene(${bean._id});"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      
                                  </ul>
                              </div>
                          </td>
						</tr>
					    </c:forEach>		
                    </tbody>
                     
 
                </table>
                </c:if>
           <span class="btn btn-darkblue btn-block" id="btnScene" onclick="addScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加图层</span>
		</div>
		
		 
		   
		
		
	 
    </div><!-- panel -->
   
  
    
    </div>
        
   </div>
  
	
  </div>
 </div>
</div>
</section>

<div id="insScene" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 添加内容</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx }/suc/mobilescene!saveScene.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="sceneid" name="id" />
                	<input type="hidden" value="${msid}" name="msid" />
                	<input type="hidden" id="tab" name="tab" value="1"/>

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="scenetitle" name="title" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">图片: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="picurl" id="uploadresult" class="form-control" placeholder="图片建议尺寸500*300." />
                                </div>
                                 <div class="col-sm-2">
                                   <div  class="button btn-lu " onclick="pz('uploadresult','250','450')">
                    						<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                				  </div>
                                </div>
                                
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">描述: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="scenesummary" name="summary" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="scenesort" name="sort" class="form-control" placeholder="请输入" />
                                </div>
                      	     
                               	<!--222-->
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <button class="btn btn-success btn-block">提&nbsp;&nbsp;交</button>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- panel -->
                </form>


            </div>
            <!-- row -->
        </div>
    </div>
</div>
<div id="insSpririt" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="dialog-500 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i>添加内容</h4>
            </div>
            <div class="modal-body"> 
                	<input type="hidden" id="spiritid" name="id" />
                	<input type="hidden" name="tab" value="1"/>

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-3 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="spirittitle" name="spirittitle" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                            <label class="col-sm-3 control-label">缩略图: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                	<input type="text" id="uploadresultTwo" name="spiritpicurl"  class="form-control" />
                                	
                                </div>
                                
                                <div class="col-sm-2">
                                 <div class="btn btn-success btn-block" >直接传</div>
                            		<div style="position: absolute;width: 80px;height: 40px;top:0px;opacity: 0">
                                	<input type="file" name="uploadifyfileTwo" id="uploadifyfileTwo" /> 
									<script>
										uploadTwoImg();
									</script>
									</div>
                                </div>
                            </div>
                            <div class="form-group">
									<label class="col-sm-3 control-label">类型 <span
										class="asterisk">*</span>
									</label>
									 <div class="col-sm-4">
                                     <select class="form-control col-sm-2" id="spirittype" name="spirittype" onchange="">
										<option value="0">普通模板</option>
										<option value="1">一排两个</option>
										<option value="2">一排三个</option>
										<option value="3">一排四 个</option>
									  	
								     </select>
                              </div>
							</div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">链接地址: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="spiriturl" name="spiriturl" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">描述: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="spiritsummary" name="spiritsummary" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="spiritsort" name="spiritsort" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                     
                    </div>
                    <!-- panel -->
                </form>
                  <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                     <button aria-hidden="true" data-dismiss="modal" class="btn btn-primary btn-block" onclick="AdSpirit()">确&nbsp;&nbsp;定</button>
                              
                                </div>
                            </div>
                  </div>
                       

            </div>
            <!-- row -->
        </div>
    </div>
</div>



 


<div id="insStyle" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="dialog-500 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 编辑样式</h4>
            </div>
            <div class="modal-body"> 
                	<input type="hidden" id="styleid" name="id" />  

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-3 control-label">左边距: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                <div id="slider-float-left" class="slider-primary mb20"></div>
                                </div>
                                <div class="col-sm-1">
                            	<span id="fl">0px</span>
                            	</div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">上边距: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                <div id="slider-float-top" class="slider-primary mb20"></div>
                                </div>
                                <div class="col-sm-1">
                            	<span id="ft">0px</span>
                            	</div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">颜色: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                 <input type="text" name="stylecolor" id="stylecolor" class="form-control color"  value="#" />
                            	</div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">高度: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                 <input type="text" name="styleh" id="styleh" class="form-control"  value="0px" />
                            	</div>
                            	 
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">宽度: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                 <input type="text" name="stylew" id="stylew" class="form-control"  value="0px" />
                            	</div>
                            	 
                            </div>
                             <div class="form-group">
                                <label class="col-sm-3 control-label">圆角: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                <div id="slider-border-radius" class="slider-primary mb20"></div>
                                </div>
                                <div class="col-sm-1">
                            	<span id="border-radius">0</span>
                            	</div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-3 control-label">背景颜色: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                 <input type="text" name="stylecolor" id="stylebackgroundcolor" class="form-control color"  value="#" />
                            	</div>
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                         <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                 <button aria-hidden="true" data-dismiss="modal" class="btn btn-primary btn-block" onclick="updStyle()">确&nbsp;&nbsp;定</button>
                                </div>
                            </div>
                        </div>

                    </div>
                 
                   

            </div>
            <!-- row -->
        </div>
    </div>
</div>
 
 
 
 
 <div id="insAnima" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="dialog-500 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 添加动画</h4>
            </div>
            <div class="modal-body"> 
                	<input type="hidden" id="styleid" name="id" />  

                    <div class="panel panel-default">
                        <div class="panel-body">
                           <div class="form-group">
                              <label class="col-sm-3 control-label">动画样式: <span class="asterisk">*</span></label>
                        	  <div class="col-sm-3">
                                     <select class="form-control col-sm-2" id="animaValue" name="animaValue" onchange="onChange(this.value)">
										<option value="tada">抖动</option>
										<option value="bounceInLeft">左闪入</option>
										<option value="bounceInRight">右闪入</option>
										<option value="spinner">旋转</option>
										<option value="fadeOutLeft">左飞出</option>
										<option value="fadeOutRight">右飞出</option>
										<option value="fadeOutUp">上飞出</option>
										<option value="fadeOutDown">下飞出</option>
										<option value="fadeInLeft">左飞入</option>
										<option value="fadeInRight">右飞入</option>
										<option value="fadeInUp">上飞入</option>
										<option value="fadeInDown">下飞入</option>
										<option value="flipOutX">上下翻转</option>
										<option value="flipOutY">左右翻转</option>
									 	
								     </select>
                              </div>
                              <label class="col-sm-3 control-label">持续时间: <span class="asterisk">*</span></label>
                        	  <div class="col-sm-2">
                                 <input type="text" name="animaduration" id="animaduration" class="form-control"  value="0" />    
                              </div>
                             </div>
                             <div class="form-group">
                               <label class="col-sm-3 control-label">保持状态: <span class="asterisk">*</span></label>
                        	  <div class="col-sm-3">
                                     <select class="form-control col-sm-2" id="animakeep" name="animakeep" >
										<option value="0">显示</option>
										<option value="1">不显示</option>
										 
								     </select>
                              </div>
                              <label class="col-sm-3 control-label">迭代次数: <span class="asterisk">*</span></label>
                        	  <div class="col-sm-2">
                                 <input type="text" name="animaiterate" id="animaiterate" class="form-control"  value="0" />       
                              </div>
                             
                             </div>
                             
                            
                            
                        </div>
                        <!-- panel-body -->

                         <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                 <button aria-hidden="true" data-dismiss="modal" class="btn btn-primary btn-block" onclick="updAnima()">确&nbsp;&nbsp;定</button>
                                </div>
                            </div>
                        </div>

                    </div>
                 
                   

            </div>
            <!-- row -->
        </div>
    </div>
</div>


<div class="fullscreen-xz cmp640" style="display:none ;width: 400px;height: 100%;position:absolute;left:65%;z-index:9999;overflow: auto;top:15%" id="jqpic">
	<header class="cmp640 bg-lu hang40 txt-c ">
            <a href="javascript:gb();" class="pull-left pl-10 "  style="position: absolute;left: 5px"><i class="fa fa-chevron-left mr-10"></i>返回</a>
            <span class="size16 zi-bai " >上传图片</span>
            <a href="javascript:gb();" id="cd-menu-trigger" ><i class="fa fa-1dx fa-remove " style="margin-top:8px;margin-right: 2px"></i></a>
	</header>
    <article class="cmp640 bg-hei" style="overflow: hidden;position: relative">
    <div id="clipArea" style="-webkit-user-select: none; overflow: hidden; position: relative;"></div>

    <div id="view" class="t60 touxiang" style="position: absolute;top:10px;left:10px"></div>
    <div class="lock" style="position: absolute;top:15px;left:80px"><span class="zi-bai size14">Logo预览</span></div>
    
	
  
        <div class="div-group-5" style="position: relative;">
            <div class="button_group ">
                <div  class="button btn-lu " >
                    <div class="an-normal "><i class="fa fa-eye  pr-10"></i>选择图片</div>
                </div>
                <input type="file" name="file" class="file" id="file" accept="image/*"  onchange="document.getElementById('textfield').value=this.value" />
            </div>
            <div class="button_group ">
                <div  class="button btn-lu " id="clipBtn">
                    <div class="an-normal "><i class="fa fa-scissors  pr-10"></i>截取上传</div>
                </div>
            </div>
        </div>
  

</article>
</div>

<script type="text/javascript">
 
</script>


<script>
jQuery(document).ready(function() {
 
    "use strict";
    
    // Basic Slider滑动监听
    jQuery('#slider-float-left').slider({
      range: "min",
      max: 1000,
      value:0,
      slide: function(event, ui ) {
        $("#fl").html(ui.value/10);
        updStyle(); 
      }
    });
    $("#slider-float-top").slider({
      range: "min",
      max: 1000,
      value:0,
      slide: function(event, ui ) { 
       $("#ft").html(ui.value-500);
       updStyle();
        
      }
    });
    $("#slider-border-radius").slider({
     range:"min",
     max:1000,
     value:0,
     slide:function(event,ui){
      $("#border-radius").html(ui.value);
      updStyle();
     }
    
    });
   
});		
</script>
 

</body>
</html>
 