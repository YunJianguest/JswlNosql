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

                location.href = "${contextPath}/suc/memorial!delete.action?_id="
                + id;

            }
        }
        function add() {
            $('#_id').val('');
            $('#title').val('');
            $('#picurl').val('');
            $('#name').val('');
            $('#nativePlace').val('');
            $('#professional').val('');
            $('#birthAddress').val('');
            $('#burialAddress').val('');
            $('#createdate').val('');
            $('#birthdate').val('');
            $('#burialdate').val('');
            ps_show('inszc');
        }

        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/suc/memorial!upd.action', submitData, function (json) {
                $('#_id').val(json._id);
                $('#title').val(json.title);
                $('#bg').val(json.picurl);
                $('#picurl').val(json.list[0].picurl);
                $('#name').val(json.list[0].name);
                $('#nativePlace').val(json.list[0].nativePlace);
                $('#professional').val(json.list[0].professional);
                $('#birthAddress').val(json.list[0].birthAddress);
                $('#burialAddress').val(json.list[0].burialAddress);
                $('#birthdate').val(json.list[0].birthdate);
                $('#burialdate').val(json.list[0].burialdate);
                $('#summary').val(json.list[0].summary);
                $('#mb').val(json.mb);
                change();


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
        function change() {
            if ($('#mb').val() == 0) {
                $('#llo').hide();
                $('#ppic').show();
            } else if ($('#mb').val() == 1) {
                $('#llo').show();
                $('#ppic').hide();
            }
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

                <h2><i class="fa fa-user"></i>祭奠管理 <span>纪念馆管理</span></h2>

                <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                            <a href="javascript:add()" style="color: #ffffff;line-height:25px;">
                                添加纪念馆&nbsp;<i class="fa fa-plus" style="line-height:30px;font-size: 14px;"></i>
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
                                    <th class="th1 table-action">序号</th>
 
                                    <th class="th5 table-action">名称</th>
                                    <th class="th5 table-action">逝者</th> 
 
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${MemorialList}" var="bean">
                                    <tr>

                                        <td>${bean.sort}</td>
                                        <td>${bean.title}</td>
                                        <td><c:forEach items="${bean.lsdead}" var="beans">${beans.name}</c:forEach></td> 
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
            <!-- contentpanel -->
        </form>
    </div>
    <!-- mainpanel -->
</section>

<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">添加纪念馆</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx}/suc/memorial!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">名称：</label>
                                <input type="text" id="title" name="title"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">姓名：</label>
                                <input type="text" id="name" name="name"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">籍贯：</label>
                                <input type="text" id="nativePlace" name="nativePlace"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">职业：</label>
                                <input type="text" id="professional" name="professional"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">生辰：</label>
                                <input type="text" id="birthdate" name="birthdate"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">忌日：</label>
                                <input type="text" id="burialdate" name="burialdate"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">出生地：</label>
                                <input type="text" id="birthAddress" name="birthAddress"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">模板：</label>
                                <select id="mb" name="mb" class="select2 form-control hang40"
                                        style="line-height: 28px!important;"
                                        required data-placeholder="请选择" onchange="change(this)">
                                    <option value="0">默认</option>
                                    <option value="1">陵园</option>

                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">安葬地：</label>
                                <input type="text" id="burialAddress" name="burialAddress"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">生平事迹：</label>
                                <textarea type="text" id="summary" name="summary"
                                          class="form-control" placeholder="请输入"></textarea>
                            </div>
                        </div>
                        <div class="col-sm-12 display-none" id="llo">
                            <div class="mb-20">
                                <label class="control-label">背景照片：</label>

                                <div>
                                    <div class="col-sm-9 form-group-20 hang40" style="padding:   0px;">
                                        <input type="text" id="bg" name="bg" class=" form-control"/>
                                    </div>
                                    <div class="col-sm-3 form-group-20 hang40" style="padding: 0px;position: relative;"
                                         onclick="pz('bg','450','250',false)">
                                        <div class="btn btn-primary"
                                             style="width: 100%;line-height: 20px;height:40px;">
                                            上传
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12" id="ppic">
                            <div class="mb-20">
                                <label class="control-label">照片：</label>

                                <div>
                                    <div class="col-sm-9 form-group-20 hang40" style="padding:   0px;">
                                        <input type="text" id="picurl" name="picurl" class=" form-control"/>
                                    </div>
                                    <div class="col-sm-3 form-group-20 hang40" style="padding: 0px;position: relative;"
                                         onclick="pz('picurl','130','164',false)">
                                        <div class="btn btn-primary"
                                             style="width: 100%;line-height: 20px;height:40px;">
                                            上传
                                        </div>

                                    </div>
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
<%@ include file="/webcom/share.jsp" %>
<%@ include file="/webcom/cut-img.jsp" %>
<%@ include file="/webcom/preview.jsp" %>
</body>
</html>
