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
<script type="text/javascript">
function del(id) {
	if (confirm('确实要删除吗?')) {
		location.href = "${contextPath}/suc/vote!delete.action?voteid=${voteid}&fypage=${fypage}&_id="
			+ id;
	}
}
function share(url) {
	window.open("${contextPath}/weixin/share.action?method="+ encodeURIComponent(url));
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
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/vote.action?voteid=${voteid}" >
    <div class="pageheader">
      <h2><i class="fa fa-user"></i> 微网站内容 <span>投票内容</span></h2>
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            	<li><a href="${contextPath}/suc/vote!input.action?voteid=${voteid}&fypage=${fypage}"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;投票报名</a></li>
				<li><a href="${contextPath}/suc/vote!voteexp.action?voteid=${voteid}"><i class="fa fa-mail-reply-all"></i>&nbsp;&nbsp;&nbsp;&nbsp;导出参赛名单</a></li>
            </ul>
         </div>
      </div>
    </div>
   <div class="panelss ">
   <div class="panel-body fu10">
        <div class="row-pad-5">
            <div class="form-group col-sm-1d">
                <input type="text" name="title"  value="${title }" placeholder="标题"  class="form-control" />
            </div>
            <div class="form-group col-sm-1d">
            	 <select id="sortby" name="sortby" class="form-control " data-placeholder="请选择">
            	 	<option value="">请选择</option>
                    <option value="0">序号正序</option>
                    <option value="1">序号倒序</option>
                    <option value="2">票数正序</option>
                    <option value="3">票数倒序</option>
                 </select>
            </div>
            <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
        </div>
    </div><!-- panel-body -->
	</div><!-- panel -->
    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-action table-primary mb30" >
                    <thead>
                      <tr>
                      	<th class="th1 table-action">序号</th>
                        <th class="th5 table-action">图片</th>
						<th class="th12 table-action">标题</th>
						<th class="th5 table-action">得票数</th>
						<th class="th5 table-action">资格</th>
						<th class="th5 table-action">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${voteList}" var="bean">
                      <tr>
                      	<td>${bean.sort}</td>
                      	<td><img src="${filehttp}${bean.picurl}" style="height: 25px "></td>
						<td  title="${bean.title}"><div class="th12 sl">${bean.title}</div></td>
						<td>${bean.count}</td>
						<td><c:if test="${bean.stop==0}">正常</c:if><c:if test="${bean.stop==1}">停止</c:if></td>
                        <td class="table-action">
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="${contextPath}/suc/vote!update.action?_id=${bean._id}&voteid=${voteid}&fypage=${fypage}">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      <li><a href="javascript:del(${bean._id});"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      <li><a href="${contextPath}/suc/vote!getcount.action?voteid=${bean._id}"><i class="fa fa-users"></i>&nbsp;&nbsp;&nbsp;&nbsp;投票人员</a></li>
                                      <%--<li><a href="${contextPath}/suc/vote!votetp.action?_id=${bean._id}"><i class="fa fa-users"></i>&nbsp;&nbsp;&nbsp;&nbsp;投票人员</a></li>--%>
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
<script type="text/javascript">
	$("#sortby").val('${sortby}');
</script>
</body>
</html>
