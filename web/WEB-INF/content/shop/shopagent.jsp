<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>
    <script type="text/javascript" src="${contextPath}/mvccol/color/jscolor.js"></script>
    <script type="text/javascript">
      
        function del(id) {
            if (confirm('确实要删除吗?')) {
                location.href = "${ctx}/shop/shopagent!delete.action?fypage=${fypage}&wid=${wid}&_id=" + id;
            }
        }
        
        function set(id,tag) {
            var submitData = {
                id: id,
                state:tag
            };
            $.post('${ctx}/shop/shopagent!ajaxset.action', submitData,
                    function (json) {
                        if (json.state == 0) {
                            window.location.reload();
                        }
                    }, "json");
        }
       function page_submit(num) {
            if (num == -1) {
                $("#fypage").val(0);
            } else if (num == -2) {
                $("#fypage").val($("#fypage").val() - 1);
            } else {
                $("#fypage").val(num);
            }
            $("#custinfoForm").submit();
        }
    </script>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/shop/shopagent.action?wid=${wid}&fypage=${fypage}">
              <div class="pageheader">
                <h2><i class="fa"></i>微网店<span>代理管理</span></h2>
                <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                     
                    </div>
                </div>
            </div>
              <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1d">
                            <input type="text" name="name" value="${name}" placeholder="姓名" class="form-control"/>
                        </div>
                        <div class="form-group col-sm-1d">
                            <input type="text" name="no" value="${no}" placeholder="会员号"
                                   class="form-control"/>
                        </div> 
                        <div class="form-group col-sm-1d">
                            <s:select id="state" cssClass="form-control" name="state"
                                      list="#{'':'请选择','2':'已审核','3':'已拒绝','1':'待审核'}" listKey="key"
                                      listValue="value"/>
                        </div>
                       
                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-action table-primary mb30">
                                <thead>
                                <tr>
                                    <th class="table-action">昵称</th>
                                    <th class="table-action">头像</th>
                                    <th class="table-action">会员号</th>
                                    <th class="table-action">姓名</th>
                                    <th class="table-action">电话</th>
                                    <th class="table-action">状态</th> 
                                    <th class="table-action">可提现佣金</th> 
                                    <th class="table-action">申请时间</th>
                                    <th class="table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        <td>${bean.nickname}</td>
                                        <td><img src="${filehttp}${bean.headimgurl}" height="25px"/></td>
                                        <td>${bean.no}</td>
                                        <td>${bean.name}</td>
                                        <td>${bean.tel}</td>
                                        <td><c:if test="${bean.state==1}">待审核</c:if>
                                        <c:if test="${bean.state==2}">已同意</c:if>
                                        <c:if test="${bean.state==3}">已拒绝</c:if></td>
                                        <td>${bean.sales}</td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li><a href="javascript:set('${bean._id}',2);">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;同意</a>
                                                    </li>
                                                    <li><a href="javascript:set('${bean._id}',3);">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;拒绝</a>
                                                    </li>
                                                    <li><a href="javascript:del('${bean._id}');">
                                                        <i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section> 
<%@ include file="/webcom/preview.jsp" %>
<script type="text/javascript"> 
if('${state}'!=0){
$('#state').val('${state}'); 
} 
  
</script>
</body>
</html>
