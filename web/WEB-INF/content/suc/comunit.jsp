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
		location.href = "${ctx}/suc/comunit!delete.action?_id="+ id;
	}		
}
function add(){
     
		location.href ="${ctx}/suc/comunit!input.action";
}
function upd(id){
   var submitData = {
		id : id
	};
	$.post('${ctx}/suc/comunit!upd.action', submitData, function(json) {
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
		$('#fxtype').val(type);
		$('#fxtitle').val(json.fxtitle);
		$('#fxsummary').val(json.fxsummary);
		$('#oldurl').val(json.oldurl);
		$('#fxurl').val(json.fxurl);
		$('#type').val(json.type);
		$('#uploadresultFour').val(json.fximg);
	}, "json")
	$('#insfx').modal({
		show : true
	});

}
function savefx() {
	var submitData = {
		fxtype : $('#fxtype').val(),
		fxtitle : $('#fxtitle').val(),
		fxsummary : $('#fxsummary').val(),
		oldurl : $('#oldurl').val(),
		fxurl : $('#fxurl').val(),
		fximg : $('#uploadresultFour').val()
	};
	$.post('${ctx}/weixin/sharefx!ajaxsave.action', submitData, function(json) {
		window.location.href='${ctx}/whd/wxmatrix.action'; 
		

	}, "json")
	$('#inszc').modal({
		show : true
	});

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
</script>
</head>

<body>

<section>
  <%@include file="/webcom/header-bracket.jsp"%>
  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/comunit.action" >
    <div class="pageheader">
      <h2><i class="fa fa-user"></i>素材管理 <span>微网站管理</span></h2>
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            	<li><a href="${ctx}/suc/comunit!updatecom.action?"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a></li>
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
                        <th>序号</th>
                      	<th>标题</th>
                      	<th>图片</th>
                      	<th>时间</th>
						<th>操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${comList}" var="bean">
                      <tr>
                      	<td>${bean.sort}</td>
                      	<td>${bean.title}</td>
                      	<td><img src="${bean.picurl}" height="25px"/></td>
                      	<td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
                        <td class="table-action">
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="${ctx}/suc/comunit!updatecom.action?comid=${bean._id}">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li> 
                                      <li><a href="javascript:del('${bean._id}');">
                                      		<i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
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
</body>
</html>
