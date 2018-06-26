<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>
    <script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/media/js/DT_bootstrap.js"></script>

    <script type="text/javascript"> 
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
         function del(id) {
		   if (confirm('确实要删除吗?')) {
			location.href = "${ctx}/suc/datingaudit!delete.action?fypage=${fypage}&_id=" + id;
		   }
		  }
		  function auditOk(id) { 
			location.href = "${ctx}/suc/datingaudit!audit.action?fypage=${fypage}&state=1&_id=" + id; 
	     }
	      function auditFailure(id) { 
			location.href = "${ctx}/suc/datingaudit!audit.action?fypage=${fypage}&state=2&_id=" + id; 
	     }
    </script>
    <style>
        .form-group-20 {
            margin-bottom: 20px;
        }
    </style>
</head>

<body>

<section>

    <%@include file="/webcom/header-bracket.jsp" %>

    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>

        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/suc/memorial.action?">

            <div class="pageheader">

                <h2><i class="fa fa-user"></i>婚恋管理 <span>婚恋审核</span></h2>

                <div class="breadcrumb-wrapper1">
                 <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                            菜单 <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                        
                        </ul>
                    </div>
                    
                </div>
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
         

                    </div>
                </div>
                <!-- panel-body -->
            </div>
            <!-- panel -->

            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-primary table-action mb30">
                                <thead>
                                <tr>
                                    <th class="th1 table-action">图片</th> 
                                    <th class="th5 table-action">上传者</th> 
                                    <th class="th5 table-action">上传类型</th>
                                    <th class="th5 table-action">上传时间</th>
                                    <th class="th5 table-action">状态</th> 
 
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>

                                        <td><img src="${filehttp}/${bean.picurl}" style="height: 25px"/></td>
                                        <td>${bean.nickname}</td>
                                        <td><c:if test="${bean.type==0}">头像</c:if><c:if test="${bean.type==1}">相册</c:if></td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
                                        <td><c:if test="${bean.state==0}">未审核</c:if><c:if test="${bean.state==1}">已审核</c:if><c:if test="${bean.state==2}">审核驳回</c:if></td> 
                                        <td class="table-action">

                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right"> 
                                                    <li><a href="javascript:del('${bean._id}');"><i
                                                            class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                    </li> 
                                                     <li><a href="javascript:auditOk('${bean._id}');"><i
                                                            class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;审核通过</a>
                                                     </li> 
                                                     <li><a href="javascript:auditFailure('${bean._id}');"><i
                                                            class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;审核驳回</a>
                                                     </li> 
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </table>
                            <%@include file="/webcom/bracket-page.jsp" %>

                        </div>
                    </div>
                </div>

            </div>
            <!-- contentpanel -->
        </form>
    </div>
    <!-- mainpanel -->
</section>
<%@ include file="/webcom/share.jsp" %> 
<%@include file="/webcom/cut-img.jsp" %> 
<%@ include file="/webcom/preview.jsp" %>
</body>
</html>
