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
<script type='text/javascript' src='${contextPath }/dwr/engine.js'></script>
<script type='text/javascript' src='${contextPath }/dwr/util.js'></script>
<script type='text/javascript'src='${contextPath }/dwr/interface/DwrAjaxServer.js'></script>
<script type="text/javascript" src="${contextPath}/js/upload/swfobject.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/jquery.uploadify.v2.1.4.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/upload.js"></script>
<link href="${ctx }/app/css/cmp_xzlb.css" rel="stylesheet" type="text/css"/>
<link href="${ctx }/app/css/pc_common.css" rel="stylesheet" type="text/css"/>
<script src="${ctx }/app/js/iscroll-zoom.js"></script>
<script src="${ctx }/app/js/hammer.js"></script>
<script src="${ctx }/app/js/jquery.photoClip.js"></script>
<style>
	#clipArea { height: 500px; }
	.file{ position:absolute; top:10px; left:-120px; height:42px; filter:alpha(opacity:0);opacity:0;  }
</style>
<link href="${ctx }/cmp/css/font-awesome.min.css" rel="stylesheet">
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
            },
            sort:{
            	digits:true,
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
	$('#funcsort').val(0);	
	
	$('#insfunc').modal({ 
	    show:true
	});
}
function updfunc(id){
	var submitData = {
			id:id
	};
	$.post('${ctx}/suc/comunit!updfunc.action', submitData,
		function(json) {
		$('#funcid').val(json._id);
		$('#funcname').val(json.name);
		$('#key').val(json.key);	
		$('#type').val(json.type);	
		$('#url').val(json.url);	
		$('#mb').val(json.mb);	
		$('#uploadresultTwo').val(json.picurl);	
		$('#summary').val(json.summary);	
		$('#funcsort').val(json.sort);	
		$('#adminurl').val(json.adminurl);	
		$('#xs').val(json.xs);	
		$('#tb').val(json.tb);	
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
	$('#advsort').val(0);	
	
	$('#insadv').modal({ 
	    show:true
	});
}
function addfoot(){
	$('#footid').val('');
	$('#foottitle').val('');
	$('#footurl').val('');
	$('#foottype').val('1');
	$('#foottb').val('');
	$('#footparentid').val('${footparentid}');
	  
	$('#footsort').val(0);	
	
	$('#insfoot').modal({ 
	    show:true
	});
}
function updfoot(id,title,url,picurl,sort,parentid,type,ioc){
	$('#footid').val(id);
	$('#foottitle').val(title);
	$('#footurl').val(url);
	$('#footparentid').val(parentid);
	$('#foottype').val(type);	
	$('#footioc').val(ioc);
	$('#uploadresultfoot').val(picurl);	
	$('#footsort').val(sort);	
	
	$('#insfoot').modal({ 
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
	$('#rollid').val('');
	$('#rolltitle').val('');
	$('#rollurl').val('');	
	$('#rollsort').val(0);	
	
	$('#insroll').modal({ 
	    show:true
	});
}
 
function addwxpay(id,title,url,sort){
	$('#rollid').val(id);
	$('#rolltitle').val(title);
	$('#rollurl').val(url);	

	$('#rollsort').val(sort);	
	
	$('#insroll').modal({ 
	    show:true
	});
}
function addwxpay(){
	var submitData = {};
	$.post('${ctx}/suc/comunit!updpay.action?_id=${entity.toUser}', submitData,
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
		location.href = "${ctx}/suc/comunit!delfunc.action?funcid="+ id+"&tab="+tab;
	}		
}
function deladv(id,tab) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/suc/comunit!deladv.action?_id="+ id+"&tab="+tab;
	}		
}
function delfoot(id,tab) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/suc/comunit!delfoot.action?_id="+ id+"&tab="+tab;
	}		
}
function delroll(id,tab) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/suc/comunit!delroll.action?_id="+ id+"&tab="+tab;
	}		
}
function changeurl(value) {  
	if(value=="link"){
		$("#urlcontrol").show();
	}else{
		$("#urlcontrol").hide();
	}
	
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
function pz(picid){
	$("#picid").val(picid);
	$('#jqpic').show();
}
function upimage(baseurl) {
	  
    var submitData = {
    		baseurl: baseurl
    };
	var p=$("#picid").val();
    $.post('${ctx}/wwz/wwzajax!upimage.action?toUser=${toUser}', submitData,
    	function (json) {
    		
        	if(json.state==0){
        		$("#"+p).val(json.path);
        		$('#jqpic').hide();
        	}
        },"json")
  
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
        $('#jqpic').hide(); 
    	$('#tubiao').hide(); 
    	$('#sbtb').hide();
    	$('#clipArea').html('');
    	
    }
</script>
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>
<input type="hidden" id="xsvalue" value="0" 	name="xsvalue" />
<input type="hidden" id="picid" value="0" 	name="picid" />
<div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
   
    <div class="pageheader">
      
      <h2><i class="fa fa-eye"></i> 微官网 <span>微官网配置</span></h2>
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn  btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            	<li><a  href="javascript:share('${ctxurl}/suc/comunit!webIndex.action?custid=${entity._id}')"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;单点分享</a></li>
            	
            	<li><a href="${contextPath}/suc/comunit!fabu.action?"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;发布</a></li>
            
            	<c:if test='${entity.qx==1}'><li><a href="javascript:addwxpay();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;结算设置</a></li></c:if>
            </ul>
         </div>
      </div>
    </div>
	<div class="contentpanel">

	<div class="row">
    	<div class="col-md-5">
        	<div class="big-divice">
            	<div class="gongzonghao">${entity.title }</div>
            	<div class="shouji"></div>
            	<div class="shouji_di"></div>
            	<div class="kuang"><iframe name="leftmenu" marginwidth=10 marginheight=10 frameborder=no  width="100%"  height=100% id="myiframe"
                	src='${ctx}/suc/comunit!webIndex.action?custid=${custid}'scrolling="auto" ></iframe>
               	</div>
        	</div>
    	</div><!-- col-md-5 -->
		<div class="col-md-7">
			<ul class="nav nav-tabs nav-justified" id="tabs">
          		<li  id="li_0" <c:if test='${tab==0}'>class="active"</c:if> ><a href="#tab0" data-toggle="tab"><strong>基础信息</strong></a></li>
          		<li id="li_1" <c:if test='${tab==1}'>class="active"</c:if>><a href="#tab1" data-toggle="tab"><strong>微信设置</strong></a></li>
          		<li id="li_2" <c:if test='${tab==2}'>class="active"</c:if>><a href="#tab2" data-toggle="tab"><strong>菜单管理</strong></a></li>
          		<li id="li_3" <c:if test='${tab==3}'>class="active"</c:if>><a href="#tab3" data-toggle="tab"><strong>底部菜单</strong></a></li>
          		
          		<li id="li_4" <c:if test='${tab==4}'>class="active"</c:if>><a href="#tab4" data-toggle="tab"><strong>幻灯片</strong></a></li>
          		<li id="li_5" <c:if test='${tab==5}'>class="active"</c:if>><a href="#tab5" data-toggle="tab"><strong>滚动字幕</strong></a></li>
          		
        	</ul>
			<div class="tab-content" id="tabs-body" >
          		<div class="tab-pane <c:if test='${tab==0}'>active</c:if> " id="tab0">
            		<form id="basicForm1" action="${contextPath}/suc/comunit!savebase.action" class="form-horizontal">
            		<input type="hidden" id="tab" value="0" name="tab" /> 
            		<div class="panel panel-default">
                
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">企业名称: <span class="asterisk">*</span></label>
                        <div class="col-sm-4">
                            <input type="text" name="title" data-required="1"  value="${entity.title }" class="form-control"  />

                        </div>
                        <label class="col-sm-2 control-label">网站模板: <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                            <select class="form-control" id="mb" name="mb" tabindex="1" >
 
										<option value="index30">微官网</option> 
										<option value="index15">政务模板</option> 
										<option value="index99">直接跳转</option>
                                        <option value="index100">电视台</option> 
										

									</select>

                            <label class="error" for="fruits"></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">LOGO图: <span class="asterisk">*</span></label>
                        <div class="col-sm-5">
                            <input type="text" id="uploadresultThr" name="logo" class="form-control" value="${entity.logo}" placeholder="图片建议尺寸96*96像素PNG图片"  />
                        </div> 
                        <div class="col-sm-2">
							<div  class="button btn-primary" onclick="pz('uploadresultThr','200','200')">
                    			<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                			</div>
						</div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">背景图: <span class="asterisk">*</span></label>
                        <div class="col-sm-5">
                            <input type="text" id="bjt" name="bjt" class="form-control" value="${entity.bjt}" placeholder="图片建议尺寸96*96像素PNG图片"  />
                        </div> 
                        <div class="col-sm-2">
							<div  class="button btn-primary" onclick="pz('bjt','250','450')">
                    			<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                			</div>
						</div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">背景音乐: <span class="asterisk">*</span></label>
                        <div class="col-sm-5">
                            <input type="text" id="uploadresultMp3" name="mp3" class="form-control" value="${entity.mp3}" placeholder=""  />
                        </div>
                       
                        
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">下标: </label>
                        <div class="col-sm-4">
                            <div class="input-group mb20">
                                <span class="input-group"></span>
                                <input type="text" name="foot" data-required="1" value="${entity.foot }" class="form-control" />
                            </div>
                        </div>
                        <label class="col-sm-2 control-label">样式色调: <span class="asterisk">*</span></label>
                        <div class="col-sm-3 mb20">
                        	<input type="text" id="css" name="css" data-required="1" value="${entity.css }" readonly="readonly" onclick="xzsb()" class="form-control" />
                           
                        </div>
                    </div>
					<div class="form-group">
                        <label class="col-sm-2 control-label">币种: </label>
                        <div class="col-sm-4">
                            <div class="input-group mb20">
                                <span class="input-group"></span>
                                <input type="text" name=jfbs data-required="1" value="${entity.jfbs}" class="form-control" />
                            </div>
                        </div>
                        
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">企业简介 <span class="asterisk">*</span></label>
                        <div class="col-sm-9">
                            <textarea  name="summary" class="form-control" rows="5" placeholder="字数控制在100以内..." >${entity.summary}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">序号: </label>
                        <div class="col-sm-4">
                            <div class="input-group mb20">
                                <span class="input-group"></span>
                                <input type="text" name=sort id="sort" value="${entity.sort}" class="form-control" />
                            </div>
                        </div>
                        
                    </div>
            </div><!-- panel-body -->

            <div class="panel-footer">
                <div class="row">
                    <div class="col-sm-9 col-sm-offset-3">
                        <button class="btn btn-success btn-block">提&nbsp;&nbsp;交</button>
                    </div>
                </div>
            </div>

    		</div><!-- panel -->
    </form>
    </div>
    <div class="tab-pane <c:if test='${tab==1}'>active</c:if> " id="tab1">
    	<form id="basicForm2" action="${contextPath}/suc/comunit!savewx.action" class="form-horizontal">
        <input type="hidden" id="tab" value="1" 	name="tab" /> 
        	<div class="panel panel-default">
                
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">原始ID: <span class="asterisk">*</span></label>
                        <div class="col-sm-4">
                            <input type="text" id="toUser" name="toUser" class="form-control" value="${toUser}" readonly="readonly"/>
                        </div>
                        <label class="col-sm-2 control-label">账号类型: <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                            <select class="form-control" id="zhlx" name="zhlx" tabindex="1" class="form-control" >
										<option value="0">未认证</option>
										<option value="1">订阅号已认证</option>
										<option value="2">服务号已认证</option>
										
							</select>
                            <label class="error" for="fruits"></label>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-sm-3 control-label">AppID: <span class="asterisk">*</span></label>
                        <div class="col-sm-9">
                            <input type="text" id="appid" name="appid" class="form-control" value="${entity.appid }"  placeholder="请输入&nbsp;AppID(应用ID)"  />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">AppSecret: <span class="asterisk">*</span></label>
                        <div class="col-sm-9">
                            <input type="text" id="secret" name="secret" class="form-control" value="${entity.secret }" placeholder="请输入&nbsp;AppSecret(应用密钥)"  />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">结算方式: <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                            <select class="form-control" id="qx" name="qx" tabindex="1">
										<option value="0">不结算</option>
										<option value="1">本公众号结算</option>
										<option value="2">父类结算</option>
									</select>
                        </div>
                         <label class="col-sm-3 control-label">授权方式: <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                            <select class="form-control" id="sqlx" name="sqlx" tabindex="1">
										<option value="0">本公众号授权</option>
										<option value="1">父类授权</option> 
									</select>
                        </div>
                       
                    </div>
                    <div class="form-group">
                       <label class="col-sm-3 control-label">开通客服: <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                            <select class="form-control" id="kf" name="kf" tabindex="1">
										<option value="0">不开通</option>
										<option value="1">开通</option>
									</select>
                        </div>
                        <label class="col-sm-3 control-label">账号类型: <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                            <select class="form-control" id="isjh" name="isjh" tabindex="1">
										<option value="0">默认账户</option>
										<option value="1">普通账号</option>
										
									</select>
                        </div>
                        
                    </div>

            </div><!-- panel-body -->

            <div class="panel-footer">
                <div class="row">
                    <div class="col-sm-9 col-sm-offset-3">
                        <button class="btn btn-success btn-block">提&nbsp;&nbsp;交</button>
                    </div>
                </div>
            </div>
		</div>
		 </form>
    </div><!-- panel -->
   

    <div class="tab-pane <c:if test='${tab==2}'>active</c:if> " id="tab2">
    	<div class="col-md-12">
        	<div class="table-responsive">
            	<table class="table table-striped table-success mb30" >
                	<thead>
                      			<tr>
                      				<th class="th1">序号</th>
                        			<th>名称</th>
									<th>编码</th>
									<th>类型</th>
									<th>显示</th>
									<th>模板</th>
									<th>图标</th>
									<th>操作</th>
						
                      			</tr>
                   	</thead>
                    <tbody>
                    <c:forEach items="${wxfuncList}" var="bean">
						<tr >
												<td>${bean.sort}</td>
												<td>${bean.name}</td>

												<td>${bean.key}</td>
												<td>${bean.type}</td>
												<td>${bean.xs}</td>
												<td>${bean.mb}</td>
												<td><i class="fa ${bean.tb} "><img src="${osshttp}${bean.picurl}" alt="" style="height: 25px;"/>
												</td>
							<td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:updfunc('${bean._id}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      <li><a href="javascript:delfunc(${bean._id},2);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      <li><a href="${contextPath}/rf/fromuseradmin.action?wid=${bean.type}"><i class="fa fa-comment-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;管理员</a></li>
                                      <li><a href="${contextPath}/news/advertisement.action?cate_id=5555&type=${bean.key}"><i class="fa fa-comment-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;广告管理</a></li>
                                  </ul>
                              </div>
                          </td>
						</tr>
					    </c:forEach>		
                    </tbody>
                     
 
                </table>
                 <span class="btn btn-darkblue btn-block" id="btnScene" onclick="addfunc();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加菜单</span>
                
            </div>
        </div>
    </div>
     <div class="tab-pane <c:if test='${tab==3}'>active</c:if> " id="tab3">
    	<div class="col-md-12">
        	<div class="table-responsive">
            	<table class="table table-striped table-success mb30" >
                	<thead>
                      			<tr>
                      				<th >序号</th>
                        			<th>标题</th>
									<th>图片</th>
									<th>链接</th>
									
									<th>操作</th>
						
                      			</tr>
                   	</thead>
                    <tbody>
                    <c:forEach items="${footList}" var="bean">
						<tr >
												<td>${bean.sort}</td>
												<td title="${bean.title}"><div class="th10 sl"> ${bean.title}</div></td>

												<td><img src="${osshttp}${bean.picurl}" alt="" style="height: 25px;"></td>
												<td><div class="th20 sl">${bean.url}</div></td>
												
							<td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:updfoot(${bean._id},'${bean.title}','${bean.url}','${bean.picurl}','${bean.sort}','${bean.parentid}','${bean.type}','${bean.ioc}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      <li><a href="javascript:delfoot(${bean._id},3);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      
                                  </ul>
                              </div>
                          </td>
						</tr>
					    </c:forEach>		
                    </tbody>
                     

                </table>
                  <span class="btn btn-darkblue btn-block" id="btnScene" onclick="addfoot();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加底部菜单</span>
                
            </div>
        </div>
    </div>
    <div class="tab-pane <c:if test='${tab==4}'>active</c:if> " id="tab4">
    	<div class="col-md-12">
        	<div class="table-responsive">
            	<table class="table table-striped table-success mb30" >
                	<thead>
                      			<tr>
                      				<th >序号</th>
                        			<th>标题</th>
									<th>图片</th>
									<th>链接</th>
									
									<th>操作</th>
						
                      			</tr>
                   	</thead>
                    <tbody>
                    <c:forEach items="${advlist}" var="bean">
						<tr >
												<td>${bean.sort}</td>
												<td title="${bean.title}"><div class="th10 sl"> ${bean.title}</div></td>

												<td><img src="${osshttp}${bean.picurl}" alt="" style="height: 25px;"></td>
												<td><div class="th20 sl">${bean.url}</div></td>
												
							<td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:updadv(${bean._id},'${bean.title}','${bean.url}','${bean.picurl}','${bean.sort}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      <li><a href="javascript:deladv(${bean._id},4);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      
                                  </ul>
                              </div>
                          </td>
						</tr>
					    </c:forEach>		
                    </tbody>
                     

                </table>
                  <span class="btn btn-darkblue btn-block" id="btnScene" onclick="addadv();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加幻灯片</span>
                
            </div>
        </div>
    </div>
    <div class="tab-pane <c:if test='${tab==5}'>active</c:if> " id="tab5">
    	<div class="col-md-12">
        	<div class="table-responsive">
            	<table class="table table-striped table-success mb30" >
                	<thead>
                      			<tr>
                      				<th >序号</th>
                        			<th>标题</th>
									
									<th>链接</th>
									
									<th>操作</th>
						
                      			</tr>
                   	</thead>
                    <tbody>
                    <c:forEach items="${rolllist}" var="bean">
						<tr >
												<td>${bean.sort}</td>
												<td>${bean.title}</td>

												
												<td>${bean.url}</td>
												
							<td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:updroll(${bean._id},'${bean.title}','${bean.url}','${bean.sort}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      <li><a href="javascript:delroll(${bean._id},5);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      
                                  </ul>
                              </div>
                          </td>
						</tr>
					    </c:forEach>		
                    </tbody>
                     

                </table>
                
                 <span class="btn btn-darkblue btn-block" id="btnScene" onclick="addroll();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加滚动</span>
            </div>
        </div>
    </div>
    </div>
        
   </div>
  
	
		</div>
	</div>
</div>
</section>
<div id="insfunc" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i>网站菜单</h4>
            </div>
            <div class="modal-body">
                <form id="insfuncForm" action="${ctx }/suc/comunit!savefunc.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="funcid" name="_id" /> 
                	<input type="hidden" id="tab" value="2" 	name="tab" />

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">菜单名称: <span class="asterisk">*</span></label>
                                <div class="col-sm-3">
                                   <input type="text" id="funcname" name="name"  class="form-control" />
                                </div>
                            	<label class="col-sm-1 control-label">编码: <span class="asterisk">*</span></label>
                                <div class="col-sm-3">
                                   <input type="text" id="key" name="key" maxlength="15"  onblur="checkName(this.value)" class="form-control" /><span class="help-inline" id="validmsg" ></span>
                                   
                                </div>
                               
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">类型: <span class="asterisk">*</span></label>
                                <div class="col-sm-2">
                                   
                                   <select class="form-control" id="type" name="type" tabindex="1"  onchange="changeurl(this.value)">
										
                    					<option value="link">直接跳转</option>
                    					<option value="news">图文栏目</option>
                    					<option value="video">视频栏目</option>
                    					 
								   </select>
                                 
                                </div>
                            	<label class="col-sm-2 control-label">模板: <span class="asterisk">*</span></label>
                                <div class="col-sm-2">
                                   
                                   <select class="form-control" id="mb" name="mb" tabindex="1" >
										
                    					<option value="1">模板1</option>
                    					<option value="2">模板2</option>
                    					<option value="3">模板3</option>
                    					<option value="4">模板4</option>
                    					<option value="5">模板5</option>
                    					
										
								   </select>
                                </div>
                                <label class="col-sm-2 control-label">显示: <span class="asterisk">*</span></label>
                                <div class="col-sm-2">
                                   
                                   <select class="form-control" id="xs" name="xs" tabindex="1" >
										<option value="0">全显示</option>
                    					<option value="1">首页不显示</option>
                    					<option value="2">菜单不显示</option>
                    					<option value="3">全不显示</option>
                    					
                    					
										
								   </select>
                                </div>
                                
                                
                            </div>
                            <div class="form-group">
                                
                                <label class="col-sm-2 control-label">缩略图: <span class="asterisk">*</span></label>
                                <div class="col-sm-3">
                                	<input type="text" id="uploadresultTwo" name="picurl"  class="form-control" />
                                	
                                </div>
                                
                                <div class="col-sm-2">
										<div  class="button btn-lu " onclick="pz('uploadresultTwo','200','200')">
                    						<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                						</div>
								</div>
								<label class="col-sm-1 control-label">图标: <span class="asterisk">*</span></label>
								<div class="col-sm-2">
										<input type="text" id="tb" name="tb" maxlength="15"  class="form-control" />
                                   
								</div>
                                
                                
                            </div>
                        	
                            
                            <div class="form-group" id="urlcontrol" style="display: none">
                                
                                <label class="col-sm-2 control-label">链接地址: <span class="asterisk">*</span></label>
                                <div class="col-sm-5"> 
                                   <input type="text" id="url"  name="url"  class="form-control" />
                                </div>
                                <label class="col-sm-2 control-label">管理地址: <span class="asterisk">*</span></label>
                                <div class="col-sm-3"> 
                                   <input type="text" id="adminurl"  name="adminurl"  class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                        		<label class="col-sm-2 control-label">简介 <span class="asterisk">*</span></label>
                        		<div class="col-sm-9">
                            		<textarea id="summary" name="summary" class="form-control" rows="5" placeholder="字数控制在100以内..." >${entity.summary}</textarea>
                        		</div>
                    		</div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="funcsort" name="sort"  class="form-control"  />
                                </div>
                            	
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <button class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
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
<div id="insadv" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i>广告信息</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx }/suc/comunit!saveadv.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="advid" name="_id" /> 
                	<input type="hidden" id="tab" name="tab" value="4"/>

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="advtitle" name="title" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">广告图片: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="picurl" id="uploadresult" class="form-control" placeholder="图片建议尺寸500*300." />
                                </div>
                               <div class="col-sm-2">
                                   <div  class="button btn-lu " onclick="pz('uploadresult','500','300')">
                    						<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                				  </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">链接地址: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="advurl" name="url" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="advsort" name="sort" value="0" class="form-control"  />
                                </div>
                            	
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <button class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
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

<div id="insfoot" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i>底部菜单</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx }/suc/comunit!savefoot.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="footid" name="id" /> 
                	<input type="hidden" id="tab" name="tab" value="3"/>
                	<input type="hidden" id="footparentid" name="parentid" />

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="foottitle" name="title" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">图片: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="url" id="uploadresultfoot" class="form-control" placeholder="图片建议尺寸500*300." />
                                </div>
                               <div class="col-sm-2">
                                   <div  class="button btn-lu " onclick="pz('uploadresultfoot','100','100')">
                    						<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                				  </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">图标: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="ioc" id="footioc" class="form-control" placeholder="图片建议尺寸500*300." />
                                </div>
                                
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">链接地址: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="footurl" name="url" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                             <label class="col-sm-2 control-label">显示: <span class="asterisk">*</span></label>
                                <div class="col-sm-2">
                                   
                                   <select class="form-control" id="foottype" name="type" tabindex="1" >
										<option value="1">直接跳转</option>
                    					<option value="2">一级菜单</option>
                    				  
										
								   </select>
                                </div>
                            
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="footsort" name="sort" value="0" class="form-control"  />
                                </div>
                            	
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <button class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
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
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 滚动字幕</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx }/suc/comunit!saveroll.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="rollid" name="_id" /> 
                	<input type="hidden" id="tab" name="tab" value="5"/>

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
                                   
                                   <input type="text" id="rollsort" name="sort" class="form-control" value="0"  />
                                </div>
                            	
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <button class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
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
<div id="inspay" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 结算信息</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx }/suc/comunit!savepay.action" class="form-horizontal"  method="post" >
                	

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">财付通商户号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="partner" name="partner" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                         
                            <div class="form-group">
                                <label class="col-sm-2 control-label">财付通密钥: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="partner_key" name="partner_key" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                             
                            
                        </div>
                        <!-- panel-body -->

                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <button class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
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

<div class="fullscreen-xz cmp640" style="display: none;width: 400px;height: 100%;position:absolute;left:65%;  overflow: auto;" id="sbtb">
    <%@ include file="/marker/set/dict2.html"%>
</div>
<script type="text/javascript">
		$("#mb").val("${entity.mb}");
		$("#qx").val("${entity.qx}");
		$("#zhlx").val("${entity.zhlx}");
		$("#kf").val("${entity.kf}");
		$("#sqlx").val("${entity.sqlx}");
		$("#isjh").val("${entity.isjh}");
		
</script>
<%@ include file="/webcom/cut-img.jsp"%> 
</body>
</html>
