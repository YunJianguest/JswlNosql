<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<script src="${contextPath}/bracket/js/jquery.tagsinput.min.js"></script>
<link rel="stylesheet" href="${contextPath}/bracket/css/jquery.tagsinput.css" />
<%@include file="/webcom/jquery.validate_js.jsp"%> 
<link href="${ctx }/app/css/cmp_xzlb.css" rel="stylesheet" type="text/css"/>
 
<script type="text/javascript">
	
$(document).ready(function(){
	jQuery('#key').tagsInput({width:'auto'});
		var validator = $("#inscxForm").validate({
			rules: {
				key: {
	                required: true
	            },
	            msgType: {
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
		var validator = $("#inszdyForm").validate({
			rules: {
				url: {
	                required: true
	            },
	            title: {
	                required: true
	            },
	            picurl: {
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
		
	});
function del(id) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/weixin/wxmessage!delete.action?type=${type}&_id="+ id;
	}		
}
function delzdy(id) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/weixin/wxmessage!delzdy.action?type=${type}&_id="+ id;
	}		
}
function add(){
	$('#key').importTags('');
	
	$('#_id').val('');

	
	$('#msgType').val('');	
	$('#content').val('');
		
	$('#inszc').modal({ 
	    show:true
	});
}
function addzdy(){
	$('#zdy_id').val('');
	
	$('#title').val('');	
	$('#uploadresultTwo').val('');
	$('#zdy-sort').val('');	
	$('#zdy-url').val('');	
	$('#inszdy').modal({ 
	    show:true
	});
}

function upd(id){
	var submitData = {
			_id:id
	};
	$.post('${ctx}/weixin/wxmessage!upd.action', submitData,
		function(json) {
			$('#_id').val(json._id);
			$('#key').importTags('');
			$('#key').importTags(json.key);
			$('#content').val(json.content);
			changeurl(json.msgType);
			if(json.msgType=="huifu"||json.msgType=="java"||json.msgType=="wxsign"||json.msgType=="zidingyi"){
				$('#msgType').val(json.msgType);
			}else{
				$('#msgType').val(json.content+":"+json.msgType);
			}
				
			$('#sort').val(json.sort);
				
	},"json")
	
	
		
	$('#inszc').modal({ 
	    show:true
	});
	
}
function updzdy(id,title,picurl,url,sort){
	
	$('#zdy_id').val(id);


	$('#title').val(title);	
	$('#uploadresultThr').val(picurl);
	$('#zdy-sort').val(sort);		
	$('#zdy-url').val(url);	
	

	$('#inszdy').modal({ 
	    show:true
	});
	
}
function changeurl(value) {
	if(value=="huifu"||value=="java"||value=="wxsign"){
		$("#urlcontrol").show();
	}else{
		$("#urlcontrol").hide();
	}
	
}

function page_submit(num){
	
	if(num==-1){
		$("#fypage").val(0);	
	}else if(num==-2){
		$("#fypage").val($("#fypage").val()-1);	
	}else{
		$("#fypage").val(num);	
	}

	$("#custinfoForm").submit();
}	
 
</script>
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/wx/wxmessage.action" >
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 微信管理 <span>关键字回复</span></h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
            <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                <a href="javascript:add();"style="color: #ffffff;line-height:25px;">
                    新增回复语&nbsp;<i class="fa fa-plus"style="line-height:30px;font-size: 14px;"></i>
                </a>
            </div>
         </div>
      </div>
    </div>
   	<div class="panelss ">
   <div class="panel-body fu10">
        <div class="row-pad-5">
            
          
            <div class="form-group col-sm-1d">
                <input type="text" name="selkey"  value="${selkey }" placeholder="关键字"  class="form-control" />
            </div>
            
            
           
            <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>

        </div>
    </div><!-- panel-body -->
	</div><!-- panel -->

    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-primary mb30" >
                    <thead>
                      <tr>
                        <th class="th20">关键字</th>
						<th class="th5">消息类型</th>
						<th class="th12">消息内容</th>
						<th class="th5">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${WxMessageList}" var="bean">
                      <tr>
                      	<c:if test="${bean.msgType=='zidingyi'}">
                      	<td><div class="th20 sl"><a href="${contextPath}/weixin/wxmessage.action?wid=${bean._id}">${bean.key}</a></div></td>
                        </c:if>
                      	<c:if test="${bean.msgType!='zidingyi'}">
                      	<td><div class="th20 sl">${bean.key}</div></td>
                        </c:if>
                      	<td>${bean.msgType}</td>
                      	
			
					    <td><div class="th12 sl">${bean.content}</div></td>
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                        
                                      <li><a href="javascript:upd('${bean._id}');">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      
                                      <li><a href="javascript:del('${bean._id}');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      <c:if test="${bean.msgType=='zidingyi'}">
                                      <li><a href="${contextPath}/weixin/wxmessage.action?wid=${bean._id}">
                                      		<i class="fa fa-commenting-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;回复内容</a></li>
                                      </c:if>
											
                                  </ul>
                              </div>
                          </td>
                      </tr>
                      </c:forEach>

                </table>
                <%@include file="/webcom/bracket-page.jsp"%>
                
            </div>
        </div>
      </div>
	
    </div><!-- contentpanel -->
    </form>
    <c:if test="${not empty wid}">
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 回复消息</h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">

            <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                <a href="javascript:addzdy();"style="color: #ffffff;line-height:25px;">
                    新增回复语&nbsp;<i class="fa fa-plus"style="line-height:30px;font-size: 14px;"></i>
                </a>
            </div>

        	<%--<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">--%>
                      	<%--菜单 <span class="caret"></span>--%>
            <%--</button>--%>
            <%--<c:if test="${fn:length(zdylist)<4}">--%>
            <%--<ul class="dropdown-menu pull-right" role="menu">--%>
            	<%--<li><a href="javascript:addzdy();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增回复内容</a></li>--%>
            <%--</ul>--%>
            <%--</c:if>--%>
         </div>
      </div>
    </div>
    
    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-primary mb30" >
                    <thead>
                      <tr>
                  
                        <th class="th1">序号</th> 
						<th class="th12">名称</th>
						<th class="th12">链接</th>
						
						<th class="th5">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${zdylist}" var="bean">
                      <tr>
                      	<td>${bean.sort}</td> 
                      	<td><div class="th12 sl">${bean.title}</div></td>

						<td><div class="th6 sl">${bean.url}</div></td>
			
                      
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:updzdy('${bean._id}','${bean.title}','${bean.picurl}','${bean.url}','${bean.sort}');">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                     
                                      <li><a href="javascript:delzdy('${bean._id}');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                  </ul>
                              </div>
                          </td>
                      </tr>
                      </c:forEach>

                </table>
                
                
            </div>
        </div>
      </div>
		
    </div><!-- contentpanel -->
	</c:if>
  </div><!-- mainpanel -->
</section>
<div id="inszc" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title">维护关键字</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx }/weixin/wxmessage!save.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="_id" name="_id" />
                	
                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">关键字(,隔开): <span class="asterisk">*</span></label>
                                <div class="col-sm-9">
                                   
                                   <input type="text" id="key" name="key" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">回复内容: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">

                                   <select  id="msgType"  name="msgType" class="form-control mb15" onchange="changeurl(this.value)"> 
            	 						<option value="huifu">回复文本</option>
            	 						<option value="zidingyi">自定义回复</option>   
                 					</select>
                                </div>
                            	
                            </div>
                            
                            
                            
                            <div class="form-group" hidden="true" id="urlcontrol">
                                <label class="col-sm-2 control-label">回复文本: <span class="asterisk">*</span></label>
                                <div class="col-sm-9">
                                   <textarea rows="3" class="form-control" placeholder="字数控制在100以内..." name="content" id="content">${content }</textarea>
                                   
                                </div>
                            	
                            </div>
                            
                            
                        </div>
                        <!-- panel-body -->

                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-12">
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
 
<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszdy" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">添加内容</i>
                    </div>
                    <a href="javascript:ps_hide('inszdy')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>


                <form id="inscxForm" action="${ctx }/weixin/wxmessage!savezdy.action"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="zdy_id" name="_id" />
                	<input type="hidden" id="lx" name="lx" value="0"/>
                	<input type="hidden" id="wid" name="wid" value="${wid }"/>
                    <%--row--%>
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">名称：</label>
                                <input type="text" id="title" name="title"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">链接：</label>
                                <input type="text" id="zdy-url" name="url"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>  
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">排序：</label>
                                <input type="text" id="zdy-sort" name="sort"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <label class="control-label">图片：</label>
                            <div>
                                <div class="col-sm-9 mb-20" style="padding:   0px;">
                                    <input type="text" id="picurl" name="picurl" class=" form-control"/>
                                </div>
                                <div class="col-sm-3 mb-20" style="padding: 0px;position: relative;"
                                     onclick="pz('picurl','450','200',false)">
                                    <div class="btn btn-primary"
                                         style="width: 100%;line-height: 20px;height:40px;">
                                        上传
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;">
                        <button class="btn btn-primary width-10 maring-a clear weight500 hang40">提 交
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>
 <%@include file="/webcom/cut-img.jsp"%>
 
</body>
</html>
