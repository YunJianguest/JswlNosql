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
                location.href = "${ctx}/shop/shopmsg!delete.action?fypage=${fypage}&wid=${wid}&_id=" + id;
            }
        }
       
    </script>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/shop/shopmsg.action?wid=${wid}">
            <div class="pageheader">
                <h2><i class="fa fa-user"></i> 微网店 <span>网店消息</span></h2>
                  <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                            菜单 <span class="caret"style="color: white;"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                           
                        </ul>
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
                                    <th class="table-action">头像</th>
                                    <th class="table-action">名称</th>
                                    <th class="table-action">内容</th>
                                    <th class="table-action">时间</th>
                                    <th class="table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${List}" var="bean">
                                    <tr>
                                        <td><img src="${bean.headimgurl}"/></td>
                                        <td>${bean.nickname}</td>
                                        <td>${bean.msg }
                                        </td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm'
                                                            value='${bean.createdate}'/></td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li><a href="javascript:del('${bean._id}');">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
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
 
</body>
</html>
