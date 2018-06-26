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
<style type="text/css">
.dialog-600{
 width: 600px;
 margin: 10% auto;
}
.dialog-800{
 width: 800px;
 margin: 7% auto;
}


textarea{ resize:none; width:200px; height:200px;}
</style>
<script type="text/javascript"> 
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
function getSpirit(id){
  $("#btnSpirit").show();
  $("#btnScene").hide();
}
function getScene(id){
  $("#btnSpirit").hide();
  $("#btnScene").show();
}
function  delSlide(id,tab){
 if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/website/website!delSlide.action?id="+ id+"&webid=${webid}&tab="+tab;
	}		
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
function  delRoll(id,tab){
 if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/website/website!delRoll.action?id="+ id+"&webid=${webid}&tab="+tab;
	}		
}
function  updRoll(id){

var submitData = {
			id:id
	};
	$.post('${ctx}/website/website!updRoll.action', submitData,
		function(json) {
		$('#rollid').val(json._id);
		$('#rolltitle').val(json.title);
		$('#rollurl').val(json.url);
		$('#rollsort').val(json.sort); 
		 		
	},"json")
	
	$('#insroll').modal({ 
	    show:true
	});
}
function  delNavi(id,tab){
 if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/website/website!delNavi.action?id="+ id+"&webid=${webid}&tab="+tab;
	}		
}
function  updNavi(id){ 
var submitData = {
		id:id
	};
	$.post('${ctx}/website/website!updNavi.action', submitData,
	
		function(json) { 
		$('#naviid').val(json._id);
		$('#navititle').val(json.title);
		$('#naviurl').val(json.url);
		$('#navisort').val(json.sort);
		$('#navicoding').val(json.coding); 
		 		
	},"json");
	
	$('#insnavi').modal({ 
	    show:true
	});
}
function  changeType(value){
 if(value==1){
  $("#naviurls").show();
 }else{
  $("#naviurls").hide();
 }
}

function  updateNavi(id){
   var submitdata={
    id:id
   };
   $.post("${ctx}/website/website!getNavis.action",submitdata,function(json){ 
    if(json.state==0){
      var  html=""; 
      var  list=json.list;
       for ( var v = 0; v<list.length; v++) {
		  html+='<tr><td>'+list[v].sort+'</td>'
		       +'<td>'+list[v].title+'</td>'
		       +'<td class="table-action">'
		       +'<div class="btn-group1">'
		       +'<a data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog"></i></a>'
		       +'<ul role="menu" class="dropdown-menu pull-right">'
		       +'<li><a href="javascript:updNavi('+list[v]._id+')">'
		       +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>'
		       +'<li><a href="javascript:delNavi('+list[v]._id+',3);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>';
		       if(list[v].type==2){
		         html+='<li><a href="javascript:updateNavi('+list[v]._id+')"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;内容</a></li>';
		       }
		       html+='</ul></div></td></tr>';
		        
	    }
	    $('#navi').html('');
	    $('#navi').html(html);
	    $('#nvaifather').val(json.naviid);
    }else{
      $('#navi').html(''); 
	  $('#nvaifather').val(json.naviid);
    }
   
   },"json");
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
       	 <div class="panel-body">
              <div id="slider-primary" class="slider-primary mb20"></div>
              <div id="slider-range-success" class="slider-success mb20"></div>
              <div id="slider-range-danger" class="slider-danger mb20"></div>
              <div id="slider-range-warning" class="slider-warning mb20"></div>
              <div id="slider-range-info" class="slider-info"></div>
            </div><!-- panel-body -->

                           
	<div class="row">
    	<div class="col-md-5">
        	<div class="big-divice"> 
            	<div class="gongzonghao">${entity.title }</div>
            	<div class="shouji"></div>
            	<div class="shouji_di"></div>
            	<div class="kuang"><iframe name="leftmenu"  marginwidth=10 marginheight=10 frameborder=no  width="100%"  height=100% id="myiframe"
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
                                <label class="col-sm-2 control-label">LOGO: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="picurl" value="${entity.picurl}" id="uploadresultThr" class="form-control" placeholder="图片建议尺寸500*300." />
                                </div>
                                <div class="col-sm-2">
                                	<input type="file" name="uploadifyfileThr" id="uploadifyfileThr" /> 
                                   <script>
										uploadThrImg();
									</script>
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">底部广告: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                               
                            <textarea   name="foot" class="form-control" rows="5" placeholder="字数控制在100以内..." >${entity.foot}</textarea>
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
        	<div class="table-responsive">
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
                                      <li><a href="javascript:delSlide(${bean._id},1);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      
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
		
		 
		   	<div class="table-responsive">
              <c:if test="${not empty spiritlist }">
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
                    <c:forEach items="${spiritlist}" var="bean">
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
                                      		<li><a href="javascript:getScene('${bean.scid}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;返回管理层</a></li>
                                      <li><a href="javascript:delSlide(${bean._id},1);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      
                                  </ul>
                              </div>
                          </td>
						</tr>
					    </c:forEach>		
                    </tbody>
                    
                </table> 
             </c:if>
           <span class="btn btn-darkblue btn-block" id="btSpirit" onclick="addSpirit();"style="display: none"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加精灵</span>
		
		</div>
	 
    </div><!-- panel -->
   

    <div class="tab-pane <c:if test='${tab==2}'>active</c:if> " id="tab2">
    	<div class="col-md-12">
        	<div class="table-responsive">
        	
        	   <c:if test="${not empty rollList }">
            	<table class="table table-striped table-success mb30" >
                	<thead>
                      			<tr>
                      				<th class="th1">序号</th>
                        			<th>名称</th> 
									<th>操作</th>
						
                      			</tr>
                   	</thead>
                    <tbody>
                    <c:forEach items="${rollList}" var="bean">
						<tr >
												<td>${bean.sort}</td>
												<td>${bean.title}</td>
 
							<td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:updRoll('${bean._id}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      <li><a href="javascript:delRoll(${bean._id},2);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                       
                                  </ul>
                              </div>
                          </td>
						</tr>
					    </c:forEach>		
                    </tbody>
                     
 
                </table>
                </c:if>
               <span class="btn btn-darkblue btn-block" onclick="addroll();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加滚动字幕</span>   
            </div>
        </div>
    </div>
     
    <div class="tab-pane <c:if test='${tab==3}'>active</c:if> " id="tab3">
    	<div class="col-md-12">
        	<div class="table-responsive"> 
        	<c:if test="${not empty naviList}">
            	<table class="table table-striped table-success mb30" >
                	<thead>
                      			<tr>
                      				<th>序号</th>
                        			<th>标题</th> 
									 
									<th>操作</th>
						
                      			</tr>
                   	</thead>
                    <tbody id="navi">
                    <c:forEach items="${naviList}" var="bean">
						<tr >
												<td>${bean.sort}</td>
												<td>${bean.title}</td>
 
												
							<td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:updNavi(${bean._id})">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      <li><a href="javascript:delNavi(${bean._id},3);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      <c:if test="${bean.type==2}"><li><a href="javascript:updateNavi(${bean._id})">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;内容</a></li></c:if>
                                      
                                  </ul>
                              </div>
                          </td>
						</tr>
					    </c:forEach>		
                    </tbody>
                     

                </table>
                </c:if>
              <span class="btn btn-darkblue btn-block" onclick="addnavi();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加导航</span>  
            </div>
        </div>
    </div>
    
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
                                	<input type="file" name="uploadifyfile" id="uploadifyfile" /> 
                                   <script>
										uploadOneImg();
									</script>
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
<div id="insroll" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="dialog-800 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 添加滚动</h4>
            </div>
            <div class="modal-body">
                <form id="slideForm" action="${ctx }/website/website!saveRoll.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="rollid" name="id" />
                	<input type="hidden" name="tab" value="2"/> 
                	<input type="hidden" id="rollwebid" value="${webid}" name="webid" /> 

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="rolltitle" name="title" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                         
                            <div class="form-group">
                                <label class="col-sm-2 control-label">链接地址: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="rollurl" name="url" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="rollsort" name="sort" class="form-control" placeholder="请输入" />
                                </div>
                            	
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



<div id="insmb" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="dialog-800 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 模板预览</h4>
            </div>
            <div class="modal-body">
                 
                    <div class="panel panel-default">
                        <div class="panel-body">
                        	 <div class="well">

        <div class="row">

                <div class="col-xs-6 col-sm-4 col-md-4">

                    <a href="javascript:changemb(1);" class="thumbnail">

                    <img src="${ctx}/mvccol/images/mb1.jpg" alt="模板1" style="height: 150px;width: 200px;">

                    </a>

                </div>
                <div class="col-xs-6 col-sm-4 col-md-4">

                    <a href="javascript:changemb(2);" class="thumbnail">

                    <img src="${ctx}/mvccol/images/mb2.jpg" alt="模板1" style="height: 150px;width: 200px;">

                    </a>

                </div>
                <div class="col-xs-6 col-sm-4 col-md-4">

                    <a href="javascript:changemb(3);" class="thumbnail">

                    <img src="${ctx}/mvccol/images/mb3.jpg" alt="模板1" style="height: 150px;width: 200px;">

                    </a>

                </div>
                <div class="col-xs-6 col-sm-4 col-md-4">

                    <a href="#" class="thumbnail">

                    <img src="${ctx}/mvccol/images/mb1.jpg" alt="模板1" style="height: 150px;width: 200px;">

                    </a>

                </div>
                <div class="col-xs-6 col-sm-4 col-md-4">

                    <a href="#" class="thumbnail">

                    <img src="${ctx}/mvccol/images/mb1.jpg" alt="模板1" style="height: 150px;width: 200px;">

                    </a>

                </div>
                
 
       </div>

    </div>
                            
   </div>
 <!-- panel-body -->

  </div>
    <!-- panel -->
                
                       <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <button class="btn btn-success btn-block" data-dismiss="modal" >确&nbsp;&nbsp;定</button>
                                </div>
                            </div>
                        </div>

            </div>
            <!-- row -->
        </div>
    </div>
</div>



<div id="insnavi" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="dialog-800 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 添加导航条</h4>
            </div>
            <div class="modal-body">
                <form id="slideForm" action="${ctx }/website/website!saveNavi.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="naviid" name="id" />
                	<input type="hidden" id="tab" name="tab" value="3"/>
                	<input type="hidden" id="naviwebid" value="${webid}" name="webid"/>
                	<input type="hidden" id="nvaifather" name="naviid"/>

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="navititle" name="title" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                              <label class="col-sm-2 control-label">类型: <span class="asterisk">*</span></label>
                                <div class="col-sm-2">
                                 <select class="form-control form-control" id="nvaitype" name="type" tabindex="1" onchange="changeType(this.value)">
										<option value="1">直接连接</option>
										<option value="2">一级菜单</option>
									 	
								 </select>
                                </div>
                            	
                            </div>
                            <div class="form-group">
                              <label class="col-sm-2 control-label">编号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="navicoding" name="coding" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                         
                            <div class="form-group" id="naviurls">
                                <label class="col-sm-2 control-label">链接地址: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="naviurl" name="url" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="navisort" name="sort" class="form-control" placeholder="请输入" />
                                </div>
                            	
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

<div class="big_box" id="tubiao" style="display: none;width: 400px;height: 100%;position:absolute;left:65%;  overflow: auto;">
    
</div>
<div class="fullscreen-xz cmp640" style="display: none;width: 400px;height: 100%;position:absolute;left:65%;  overflow: auto;" id="sbtb">
    
</div>
<script>
jQuery(document).ready(function() {
    
    "use strict";
    
    // Basic Slider
    jQuery('#slider').slider({
      range: "min",
      max: 100,
      value: 50
    });
    
    // Basic Slider: Primary
    jQuery('#slider-primary').slider({
      range: "min",
      max: 100,
      value: 43
    });
    
    // Basic Slider: Success
    jQuery('#slider-success').slider({
      range: "min",
      max: 100,
      value: 60
    });
    
    // Basic Slider: Warning
    jQuery('#slider-warning').slider({
      range: "min",
      max: 100,
      value: 37
    });
    
    // Basic Slider: Danger
    jQuery('#slider-danger').slider({
      range: "min",
      max: 100,
      value: 45
    });
    
    // Basic Slider: Info
    jQuery('#slider-info').slider({
      range: "min",
      max: 100,
      value: 55
    });
    
    // Range Slider
    jQuery('#slider-range').slider({
      range: true,
      max: 100,
      values: [25,75]
    });
    
    // Range Slider: Success
    jQuery('#slider-range-success').slider({
      range: true,
      max: 100,
      values: [35,65]
    });
    
    // Range Slider: Danger
    jQuery('#slider-range-danger').slider({
      range: true,
      max: 100,
      values: [25,75]
    });
    
    // Range Slider: Warning
    jQuery('#slider-range-warning').slider({
      range: true,
      max: 100,
      values: [40,60]
    });
    
    // Range Slider: Info
    jQuery('#slider-range-info').slider({
      range: true,
      max: 100,
      values: [20,80]
    });
    
    // Range Slider Maximum
    jQuery('#slider-max').slider({
      range: 'max',
      max: 100,
      value: 50
    });
    
    // Range Slider Maximum
    jQuery('#slider-min').slider({
      range: 'min',
      max: 100,
      value: 50
    });
    
    // Vertical Slider
    jQuery('#vslider').slider({
      orientation: 'vertical',
      range: "min",
      max: 100,
      value: 50
    });
    
    // Vertical Slider: Primary
    jQuery('#vslider-primary').slider({
      orientation: 'vertical',
      range: "min",
      max: 100,
      value: 43
    });
    
    // Vertical Slider: Success
    jQuery('#vslider-success').slider({
      orientation: 'vertical',
      range: "min",
      max: 100,
      value: 60
    });
    
    // Vertical Slider: Warning
    jQuery('#vslider-warning').slider({
      orientation: 'vertical',
      range: "min",
      max: 100,
      value: 37
    });
    
    // Vertical Slider: Danger
    jQuery('#vslider-danger').slider({
      orientation: 'vertical',
      range: "min",
      max: 100,
      value: 45
    });
    
    // Vertical Slider: Info
    jQuery('#vslider-info').slider({
      orientation: 'vertical',
      range: "min",
      max: 100,
      value: 55
    });
    
    // Range Vertical Slider
    jQuery('#vslider-range').slider({
      orientation: 'vertical',
      range: true,
      max: 100,
      values: [25,75]
    });
    
    // Range Vertical Slider: Success
    jQuery('#vslider-range-success').slider({
      orientation: 'vertical',
      range: true,
      max: 100,
      values: [35,65]
    });
    
    // Range Vertical Slider: Danger
    jQuery('#vslider-range-danger').slider({
      orientation: 'vertical',
      range: true,
      max: 100,
      values: [25,75]
    });
    
    // Range Vertical Slider: Warning
    jQuery('#vslider-range-warning').slider({
      orientation: 'vertical',
      range: true,
      max: 100,
      values: [40,60]
    });
    
    // Range Vertical Slider: Info
    jQuery('#vslider-range-info').slider({
      orientation: 'vertical',
      range: true,
      max: 100,
      values: [20,80]
    });
    
    
  
});		
</script>
<script type="text/javascript">
		$("#wwz").val("${entity.wwz}");
		$("#qx").val("${entity.qx}");
		$("#zhlx").val("${entity.zhlx}");
		$("#kf").val("${entity.kf}");
		
		$("#isjh").val("${entity.isjh}");


</script>

</body>
</html>
 