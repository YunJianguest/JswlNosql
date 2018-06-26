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
                location.href = "${ctx}/shop/shopcustservice!delete.action?fypage=${fypage}&wid=${wid}&_id=" + id;
            }
        }  
        function add() {
            $('#_id').val('');
            ps_show('inszc');
        }
       
    </script>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/shop/shopcustservice.action?wid=${wid}">
            <div class="pageheader">
                <h2><i class="fa fa-user"></i> 微网店 <span>网店客服</span></h2>
                  <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                            菜单 <span class="caret"style="color: white;"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                            <li> <a href="javascript:add();">
                                 <i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp; 添加客服</a>
                            </li>
                            
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
                                    <th class="table-action">会员号</th>
                                    <th class="table-action">头像</th>
                                    <th class="table-action">名称</th>
                                    <th class="table-action">时间</th>
                                    <th class="table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${List}" var="bean">
                                    <tr>
                                        <td>${bean.no}</td>
                                        <td><img src="${filehttp}/${bean.headimgurl}" height="25px"/></td>
                                        <td>${bean.nickname}</td> 
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
<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">客服管理</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx }/shop/shopcustservice!save.action?fypage=${fypage}&wid=${wid}"
                      class="form-horizontal" method="post"> 
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">会员号：</label>
                                <input type="text" id="no" name="no"
                                       class="form-control" placeholder="请输入"/>
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
</body>
</html>
