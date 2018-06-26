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

                location.href = "${contextPath}/pub/color!delete.action?_id="
                + id;
            }
        }
        function add() {
            $('#_id').val('');
            $('#title').val('');
            $('#picurl').val('');
            $('#value').val('');
            ps_show('inszc');
        }
        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/pub/color!upd.action', submitData, function (json) {
                $('#_id').val(json._id);
                $('#title').val(json.title);
                $('#value').val(json.value);
                $('#picurl').val(json.picurl);
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
        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/pub/color.action?">
            <div class="pageheader">
                <h2><i class="fa fa-user"></i>系统管理<span>图标背景色管理</span></h2>
                <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                            <a href="javascript:add();" style="color: #ffffff;line-height:25px;">
                                添加内容&nbsp;<i class="fa fa-plus" style="line-height:30px;font-size: 14px;"></i>
                            </a>
                        </div>
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
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-primary table-action mb30">
                                <thead>
                                <tr>
                                    <th class="th1 table-action">名称</th>
                                    <th class="th5 table-action">颜色</th>
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${colorList}" var="bean">
                                    <tr>
                                        <td>${bean.title}</td>
                                        <td><img src="${filehttp}/${bean.picurl}" height="25px"/></td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li><a href="javascript:upd('${bean._id}');">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                                    <li><a href="javascript:del(${bean._id});"><i
                                                            class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
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
        </form>
    </div>
</section>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">图标背景色上传</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx }/pub/color!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
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
                                <label class="control-label">色值：</label>
                                <input type="text" id="value" name="value"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <label class="control-label">图片：</label>
                            <div>
                                <div class="col-sm-9 mb-20" style="padding:   0px;">
                                    <input type="text" id="picurl" name="picurl" class=" form-control"/>
                                </div>
                                <div class="col-sm-3 mb-20" style="padding: 0px;position: relative;">
                                        <button class="btn btn-primary"
                                                style="width: 100%;line-height: 20px;height:40px;">
                                            上传
                                        </button>
                                        <input class="form-control fileInput"
                                               style="position:absolute; top: 0px;left: 0px; filter: alpha(opacity=0);-moz-opacity: 0;-khtml-opacity: 0;opacity: 0;"
                                               type="file" id="file" value="上传图片">
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
<%@include file="/webcom/cut-img.jsp" %>
<script src="${contextPath}/mvccol/lrz/exif.js"></script>
<script type="text/javascript" src="${contextPath}/mvccol/lrz/index_no.js"></script>
<script type="text/javascript" src="${contextPath}/mvccol/lrz/lrz_no.js"></script>
<script type="text/javascript">
    fileInput("fileInput", "picurl");
</script>
</body>
</html>
