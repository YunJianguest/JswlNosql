<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>
    <link href="${ctx }/app/css/cmp_xzlb.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript">

        $(document).ready(function () {

            var validator = $("#inscxForm").validate({
                rules: {
                    url: {
                        required: true
                    },
                    newtitle: {
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
            var validator = $("#inszdyForm").validate({
                rules: {
                    url: {
                        required: true
                    },
                    title: {
                        required: true
                    },
                    picurl: {
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
                location.href = "${ctx}/weixin/wxsubscribe!delete.action?type=${type}&_id=" + id;
            }
        }
        function delzdy(id) {
            if (confirm('确实要删除吗?')) {
                location.href = "${ctx}/weixin/wxsubscribe!delzdy.action?type=${type}&_id=" + id;
            }
        }
        function add() {
            $('#_id').val('');
            $('#context').val('');
            $('#newtitle').val('');
            $('#picurl').val('');
            $('#sort').val('');
            $('#url').val('');
            $('#inszc').modal({
                show: true
            });
        }
        function addzdy() {
            $('#zdy_id').val('');

            $('#title').val('');
            $('#picurl').val('');
            $('#zdy-sort').val('');
            $('#zdy-url').val('');
            $('#inszdy').modal({
                show: true
            });
        }

        function upd(id) {
            $('#_id').val(id);
            var submitData = {
                _id: id
            };
            $.post('${ctx}/weixin/wxsubscribe!upd.action', submitData,
                    function (json) {
                        $('#_id').val(json._id);
                        $('#context').val(json.context);
                        $('#newtitle').val(json.newtitle);
                        $('#picurl').val(json.picurl);
                        $('#sort').val(json.sort);
                        $('#url').val(json.url);
                        change(url);
                    }, "json")

            $('#inszc').modal({
                show: true
            });

        }
        function updzdy(id, title, picurl, url, sort) {
            $('#zdy_id').val(id);


            $('#title').val(title);
            $('#picurl').val(picurl);
            $('#zdy-sort').val(sort);
            $('#zdy-url').val(url);

            change(url);
            $('#inszdy').modal({
                show: true
            });

        }
        function change(value) {
            if (value == 'text') {
                $('#divpic').hide();
            }
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
        <div class="pageheader">
            <h2><i class="fa fa-user"></i> 微信管理 <span>${h1 }</span></h2>

            <div class="breadcrumb-wrapper1">
                <div class="input-group ">
                    <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                        <a href="javascript:add();" style="color: #ffffff;line-height:25px;">
                            新增回复语&nbsp;<i class="fa fa-plus" style="line-height:30px;font-size: 14px;"></i>
                        </a>
                    </div>
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
                                <th class="th1 table-action">序号</th>
                                <th class="th12 table-action">标题</th> 
                                <th class="th12 table-action">描述</th>
                                <th class="th5 table-action">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${WxSubscribeList}" var="bean">
                                <tr>
                                    <td>${bean.sort}</td>
                                    <td>${bean.newtitle}</td>  
                                    <td>
                                        <div class="th12 sl">${bean.context}</div>
                                    </td>
                                    <td class="table-action">
                                        <div class="btn-group1">
                                            <a data-toggle="dropdown" class="dropdown-toggle">
                                                <i class="fa fa-cog"></i>
                                            </a>
                                            <ul role="menu" class="dropdown-menu pull-right">
                                                <li><a href="javascript:upd('${bean._id}');">
                                                    <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                                <li><a href="javascript:del('${bean._id}');"><i
                                                        class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
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
                        <i class="weight500 size14 pl-10 line-height50">回复管理</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx }/weixin/wxsubscribe!save.action"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <input type="hidden" id="type" name="type" value="${type}"/>
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">名称：</label>
                                <input type="text" id="newtitle" name="newtitle"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">类型:</label>
                                <select id="url" name="url" class="select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                  <option value="text">文字回复</option>
                                </select> 
                            </div>
                        </div> 
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">描述:</label>
                                <textarea type="text" id="context" name="context"
                                       class="form-control" style="height: 150px"  placeholder="请输入" >${context}</textarea>
                            </div>
                        </div> 
                          
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">序号:</label>
                                <input type="text" id="sort" name="sort"
                                       class="form-control hang40" placeholder="请输入"/>
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
</body>
</html>
