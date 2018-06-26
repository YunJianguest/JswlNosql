<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>


<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<link href="${ctx }/cmp/css/cmp_js_yangshibiao.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${contextPath}/js/upload/swfobject.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/jquery.uploadify.v2.1.4.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/upload.js"></script>
<script type="text/javascript">
 
function del(id) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/suc/bbsstick!delete.action?_id="+ id;
	}		
}
function add(){
     
		location.href ="${ctx}/suc/bbsstick!input.action";
}
function upd(id){
   var submitData = {
		id : id
	};
	$.post('${ctx}/suc/bbsstick!upd.action', submitData, function(json) {
		$('#_id').val(json._id);
		$('#title').val(json.title);
		$('#summary').val(json.summary);
		$('#url').val(json.url);
		$('#sort').val(json.sort);
		$('#type').val(json.type);
		$('#uploadresultFour').val(json.picurl);
		

	}, "json")
	 

	$('#insadd').modal({
			show : true
		});
}
 
function updfx(type) {
	var submitData = {
		fxtype : type
	};
	$.post('${ctx}/weixin/sharefx!upd.action', submitData, function(json) {
		$('#fxtitle').val(json.fxtitle);
		$('#fxsummary').val(json.fxsummary);
		$('#oldurl').val(json.oldurl);
		$('#fxurl').val(json.fxurl);
		$('#fxtype').val(json.type);
		$('#fxpicurl').val(json.fximg);
		$('#fxmb').val(json.fxmb);
		

	}, "json")
	$('#insfx').modal({
		show : true
	});

}
function savefx() {
	var submitData = {
		fxtype :'bbs_share',
		fxtitle : $('#fxtitle').val(),
		fxsummary : $('#fxsummary').val(), 
		fxurl : $('#fxurl').val(),
		fximg : $('#fxpicurl').val(),
		fxmb:$('#fxmb').val()
	};
	$.post('${ctx}/weixin/sharefx!ajaxsave.action', submitData, function(json) { 
		window.location.href=window.location.href; 
		 
	}, "json")
	 

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
function share(url) {
	window.open("${contextPath}/weixin/share.action?method="+ encodeURIComponent(url));
}
function  auditcancel(){
  location.href = "${ctx}/suc/bbsstick!auditcancel.action?_id="+ id;
}
function  audit(){
  location.href = "${ctx}/suc/bbsstick!audit.action?_id="+ id;
}
</script>
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/bbs.action" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i>论坛管理 <span>置顶管理</span></h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            
                 <li><a href="javascript:updfx('bbs_share')"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;基本配置</a></li>
                 <li><a href="${ctx}/suc/bbstype.action"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;分类配置</a></li>
            	 <li><a href="${ctx}/suc/bbs!index.action?custid=${custid}&fromUserid=${fromUserid}&type=1" target="_blank"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;预览</a></li>
            	 
            </ul>
         </div>
      </div>
    </div>
   

    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-primary mb30" >
                    <thead>
                      <tr>  
                        <th>用户</th> 
                      	<th>内容</th>
                      	<th>时间</th>
                  		<th>状态</th> 
						<th>操作</th>
						
                      
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${bbsstickList}" var="bean">
                      <tr> 
                      	<td>${bean.wx.nickname}</td>
                      	<td>${bean.content}</td>
                      	<td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
						<td>${bean.state}</td>
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">  
                                      <li><a href="javascript:audit('${bean._id}');">
                                      		<i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;审核通过</a></li>
                                      <li><a href="javascript:auditcancel('${bean._id}');">
                                      		<i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;取消审核</a></li>
                                       
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
  </div><!-- mainpanel -->
</section>
 <div id="insfx" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-leaf"></i> 添加内容</h4>
            </div>
            <div class="modal-body">
                
                <input type="hidden" id="fxtype" value="" />
                   <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">分享名称: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="fxtitle"  class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div> 
                             <div class="form-group">
                                <label class="col-sm-2 control-label">分享图片: <span class="asterisk">*</span></label>
                                <div class="col-sm-3">
									<input type="text" id="fxpicurl" class="form-control"
										value="<s:property value='picurl'/>" name="picurl" />
								</div>
								<div class="col-sm-2">
							      <div  class="button btn-primary" onclick="pz('fxpicurl','200','200')">
                    			  <div class="an-normal "><i class="fa fa-scissors  pr-10"></i>上 传</div>
                			     </div>
						        </div> 
                            	
                            </div>
                           
                            <div class="form-group">
                                <label class="col-sm-2 control-label">分享链接: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="fxurl" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">分享简介: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="fxsummary"  class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">模板: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                  <select class="form-control form-control" id="fxmb" name="mb">
										<option value="1">默认模板</option>
										<option value="2">广告模板</option>
										 
								  </select>
                                </div>
                            	
                            </div>
                           
                           
                            
                        </div>
                        <!-- panel-body -->

                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-12">
                                    <button onclick="savefx()" class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
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
<%@ include file="/webcom/cut-img.jsp"%> 
</body>
</html>
