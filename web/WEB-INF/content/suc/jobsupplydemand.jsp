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

        function del(id) {
            if (confirm('确实要删除吗?')) {

                location.href = "${contextPath}/suc/jobsupplydemand!delete.action?_id="
                + id;

            }
        }
        function add() {
            $('#_id').val('');
            $('#title').val('');
            $('#uploadresultTwo').val('');
            $('#url').val('#');
            $('#logo').val('');
            $('#mb').val(0);
            $('#sort').val(0);
            ps_show('inszc');
        }

        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/suc/slide!upd.action', submitData, function (json) {
                $('#_id').val(json._id);
                $('#title').val(json.title);
                $('#picurl').val(json.picurl);
                $('#url').val(json.url);
                $('#mp4url').val(json.mp4url);
                $('#sort').val(json.sort);


            }, "json")

            ps_show('inszc');
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

        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/suc/jobsupplydemand.action?">

            <div class="pageheader">

                <h2><i class="fa fa-user"></i>微网站 <span>供求信息管理</span></h2>
                   <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                            菜单 <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                            
                            <li><a href="${ctx}/suc/slide!slidehouse.action?type=jobcompany">
                                <i class="fa fa-bullhorn"></i>&nbsp;&nbsp;&nbsp;&nbsp;幻灯片</a>
                            </li>
                            <li><a href="${ctx}/suc/jobtype.action?">
                                <i class="fa fa-cog"></i>&nbsp;&nbsp;&nbsp;&nbsp;分类管理</a>
                            </li>
                            <li><a href="javascript:qrcode('${ctxurl}/suc/jobcompay!commentindex.action?custid=${custid}')"><i
                                    class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;招聘预览</a></li>
                            <li><a href="javascript:qrcode('${ctxurl}/suc/jobcompay!seekindex.action?custid=${custid}')"><i
                                    class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;求职预览</a></li>
                            <li><a href="javascript:qrcode('${ctxurl}/suc/jobcompay!carindex.action?custid=${custid}')"><i
                                    class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;二手汽车</a></li>
                            <li><a href="javascript:qrcode('${ctxurl}/suc/jobcompay!suppindex.action?custid=${custid}')"><i
                                    class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;房屋租赁</a></li>
                            <li><a href="javascript:qrcode('${ctxurl}/suc/jobcompay!web.action?custid=${custid}')"><i
                                    class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;首页</a></li>
                        </ul>
                    </div>
                </div>

                
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">

                        <div class="form-group col-sm-1d">
                            <input type="text" name="title" value="${title}" placeholder="名称" class="form-control"/>
                        </div>

                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>

                    </div>
                </div>
                <!-- panel-body -->
            </div>
            <!-- panel -->

            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-action table-primary mb30">
                                <thead>
                                <tr> 
                                    <th class="th5 table-action">名称</th>
                                    <th class="th5 table-action">时间</th>
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        
                                        <td>${bean.title}</td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
                                        <td class="table-action">

                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                  <li><a href="javascript:del('${bean._id}');">
                                                        <i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
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
<%@ include file="/webcom/preview.jsp" %> 
</body>
</html>
