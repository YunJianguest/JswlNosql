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
<script type="text/javascript" src="${ctx}/mvccol/js/jquery.form.js"></script>
<script type="text/javascript">
function del(id) {
	if (confirm('确实要删除吗?')) {
		location.href = "${contextPath}/suc/luckydraw!delete.action?fypage=${fypage}&_id="
				+ id;
	}
}
function deljp(id) {
		if (confirm('确实要删除吗?删除后不可恢复')) {
			location.href = "${contextPath}/suc/luckydraw!deletejp.action?_id="
					+ id;
		}
	}
function add(){
	 window.location.href='${contextPath}/suc/luckydraw!input.action?fypage=${fypage}';
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
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/luckydraw.action" >
    <div class="pageheader">
      <h2><i class="fa fa-user"></i> 微活动 <span>抽奖素材</span></h2>
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
                <li><a href="javascript:updfx('activity_share')"><i class="fa fa-share-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享填写</a></li>
            	<li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;添加新活动</a></li>
            	<li><a href="${ctx}/suc/slide.action?type=activity"><i class="fa fa-photo"></i>&nbsp;&nbsp;添加总活动幻灯片</a></li> 
            	<li><a href="javascript:qrcode('${ctxurl}/suc/totalactivity!web.action?custid=${custid}&type=1')"><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;摇奖预览</a></li>
            	<li><a href="javascript:qrcode('${ctxurl}/suc/totalactivity!web.action?custid=${custid}&type=3')"><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;刮刮乐预览</a></li>
            	<li><a href="javascript:qrcode('${ctxurl}/suc/totalactivity!web.action?custid=${custid}&type=4')"><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;0元抢预览</a></li>
            	<li><a href="javascript:qrcode('${ctxurl}/suc/luckydraw!reward.action?custid=${custid}')"><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;兑奖二维码</a></li>
            </ul>
         </div>
      </div>
    </div>
   <div class="panelss ">
   <div class="panel-body fu10">
        <div class="row-pad-5">
            <div class="form-group col-sm-1d">
            <input type="text" name="name"  value="${name }" placeholder="名称"  class="form-control" />
            </div>
            <div class="form-group col-sm-1d">
              <s:select  cssClass="form-control"  name="lx" list="#{'':'请选择','0':'大转盘','1':'刮刮乐','2':'0元抢','3':'摇一摇'}" listKey="key" listValue="value" />
            </div>
            <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
        </div>
    </div>
	</div>
    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-primary table-action mb30" >
                    <thead>
                      <tr>
                       <th class="th3 table-action">LOGO</th>
						<th class="th12 table-action">标题</th>
				     	<th class="th14 table-action">活动日期</th>
				        <th class="th8 table-action">兑奖日期</th>
						<th class="th4 table-action">类别</th>
						<th class="th6 table-action">频率</th> 
						<th class="th5 table-action">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${DrawboxList}" var="bean">
                      <tr>
                      	<td><img src="${filehttp}${bean.picurl}" style="height: 25px;"></td>
						<td  title="${bean.title}"><div class="th12 sl">${bean.title}</div></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
														value="${bean.startdate}" />至<fmt:formatDate
														pattern="yyyy-MM-dd HH:mm" value="${bean.enddate}" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${bean.djenddate}" /></td>
						<td><c:if test="${bean.lx==0}">大转盘</c:if> <c:if test="${bean.lx==1}">刮刮乐 </c:if><c:if test="${bean.lx==2}">0元抢 </c:if><c:if test="${bean.lx==3}">摇一摇 </c:if></td>
						<td><c:if test="${bean.rate==0}">仅一次</c:if><c:if test="${bean.rate==1}">每日一次</c:if>
							<c:if test="${bean.rate==2}">每日二次</c:if>
							<c:if test="${bean.rate==3}">每日三次</c:if>
							<c:if test="${bean.rate==4}">不限次数</c:if>
							<c:if test="${bean.rate==5}">每日五次</c:if>
							<c:if test="${bean.rate==8}">每日八次</c:if>
							<c:if test="${bean.rate==10}">每日十次</c:if></td> 
                        <td class="table-action">
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right"> 
                                      <li><a href="${contextPath}/suc/luckydraw!update.action?_id=${bean._id}">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                       <li><a href="${ctx}/suc/slide.action?type=luckydraw-${bean._id}">
                                      		<i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;添加幻灯片</a></li>
                                        <li><a href="javascript:del(${bean._id});"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                         <li><a href="javascript:deljp(${bean._id});">
                                      		<i class="fa fa-undo"></i>&nbsp;&nbsp;&nbsp;&nbsp;清空中奖名单</a></li>
                                        <li><a href="${contextPath}/suc/luckydraw!hdtj.action?hdid=${bean._id}">
                                      		<i class="fa fa-pie-chart"></i>&nbsp;&nbsp;&nbsp;&nbsp;中奖名单</a></li>
                                        <c:if test="${empty bean.toUserid}">
                                      	<li><a href="javascript:qrcode('${ctxurl}/suc/luckydraw!web.action?lucid=${bean._id}&custid=${bean.custid}&fromUserid=${fromUserid}')" ><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;查看预览</a></li>
                                        </c:if>
                                        <c:if test="${not empty bean.ewmurl}">
                                        <li><a href="${filehttp}/${bean.ewmurl}" target="_blank"><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;生成兑奖二维码</a></li>
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
    </div>
	</form>
  </div>
</section>
<%@ include file="/webcom/share.jsp"%>
<%@include file="/webcom/cut-img.jsp"%>
<%@ include file="/webcom/preview.jsp"%> 
</body>
</html>
