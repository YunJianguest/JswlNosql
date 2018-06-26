<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>

    <script type="text/javascript">
        $(document).ready(function () {
            var validator = $("#inscxForm").validate({
                rules: {
                    picurl: {
                        required: true
                    },
                    type: {
                        required: true
                    },
                    name: {
                        required: true
                    },
                    sort: {
                        digits: true,
                        required: true
                    }
                },
                messages: {},
                highlight: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                },
                success: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-error');
                }
            });
        });
        function del(id) {
            if (confirm('确实要删除吗?')) {
                location.href = "${ctx}/pub/fromuserfunc!delete.action?fypage=${fypage}&_id=" + id;
            }
        }
        function add() {
            $('#_id').val('');
            $('#title').val('');
            $('#color').val('');
            $('#url').val('');
            $('#ioc').val('');
            $('#sort').val(0);
            ps_show('inszc');
        }
        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/pub/fromuserfunc!upd.action', submitData,
                    function (json) {
                        $('#_id').val(json._id);
                        $('#sort').val(json.sort);
                        $('#title').val(json.title);
                        $('#url').val(json.url);
                        $('#ioc').val(json.ioc);
                        $('#color').val(json.color);
                    }, "json");
           ps_show('inszc');  
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
        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/pub/fromuserfunc.action">
            <div class="pageheader">
                <h2><i class="fa fa-user"></i>系统管理<span>个人中心菜单</span></h2>

                <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <div class="input-group ">
                            <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                                <a href="javascript:add();" style="color: #ffffff;line-height:25px;">
                                    新增&nbsp;<i class="fa fa-plus" style="line-height:30px;font-size: 14px;"></i>
                                </a>
                            </div>
                        </div>
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
                                    <th class="table-action">序号</th>
                                    <th class="table-action">名称</th>
                                    <th class="table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        <td>${bean.sort}</td>
                                        <td>${bean.title}</td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li><a href="javascript:upd('${bean._id}');">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>

                                                    <li><a href="javascript:del('${bean._id}');"><i
                                                            class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
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
                        <i class="weight500 size14 pl-10 line-height50">标题放置处</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx }/pub/fromuserfunc!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <%--row--%>

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
                                <label class="control-label">链接：</label>
                                <input type="text" id="url" name="url"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">图标：</label>
                                <input type="text" id="ioc" name="ioc"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">颜色：</label>
                                <select id="color" name="color" class="select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                    <option value="bg-cheng">橙色</option>
                                    <option value="bg-green">绿色</option>
                                    <option value="bj-lu1">绿色(一)</option>
                                    <option value="bj-lu2">绿色(二)</option>
                                    <option value="bj-lu3">绿色(三)</option>
                                    <option value="bj-lu4">绿色(四)</option>
                                    <option value="bj-zi">紫色</option>
                                    <option value="bj-lan1">蓝色(一)</option>
                                    <option value="bj-lan1">蓝色(二)</option>
                                    <option value="bj-lan1">蓝色(三)</option>
                                    <option value="bj-hong1">红色(一)</option>
                                    <option value="bj-hong2">红色(二)</option>
                                </select>
                                <label class="error" for="color"></label>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">排序：</label>
                                <input type="text" id="sort" name="sort"
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
