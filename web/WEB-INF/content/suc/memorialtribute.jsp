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

                location.href = "${contextPath}/suc/memorialtribute!delete.action?_id="
                + id;

            }
        }
        function add() {
            $('#_id').val('');
            $('#title').val('');
            $('#picurl').val('');
            $('#price').val(0);
            $('#url').val('');
            $('#summary').val('');
            $('#type').val(0);
            $('#sort').val(0); 
            $('#num').val(0); 
            $('#gmnum').val(0);
            $('#value').val(0);
            $('#logo').val('');  
            ps_show('inszc');
        }

        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/suc/memorialtribute!upd.action', submitData, function (json) {
                $('#_id').val(json._id);
                $('#title').val(json.title);
                $('#type').val(json.type);
                $('#num').val(json.num);
                $('#price').val(json.price); 
                $('#picurl').val(json.picurl);
                $('#price').val(json.price.toFixed(2));
                $('#sort').val(json.sort);
                $('#logo').val(json.logo);
                $('#gmnum').val(json.gmnum);
                $('#value').val(json.value);


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

        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/suc/memorialtribute.action?">

            <div class="pageheader">

                <h2><i class="fa fa-user"></i>祭奠管理 <span>贡品管理</span></h2>
                   <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                                      菜单 <span class="caret"style="color: white;"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                        <li><a href="javascript:updfx('memorial_web')"><i class="fa fa-home"></i>&nbsp;&nbsp;首页分享配置</a></li>
                        <li><a href="javascript:updfx('memorial_my')"><i class="fa fa-user"></i>&nbsp;&nbsp;个人分享配置</a></li>
                        <li><a href="javascript:updfx('memorial_detail')"><i class="fa fa-user"></i>&nbsp;&nbsp;祭奠详情分享配置</a></li>
                            <li><a href="javascript:add()"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;添加贡品</a></li>
                            <li><a href="${ctx}/suc/memorial.action"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;纪念馆管理</a></li>
                            <li><a href="${ctx}/suc/memorialtributetype.action"><i class="fa fa-list-ol"></i>&nbsp;&nbsp;&nbsp;&nbsp;类别添加</a></li> 
                            <li><a href="javascript:qrcode('${ctxurl}/suc/memorial!web.action?custid=${custid}')" ><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;效果预览</a></li>
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
                            <table class="table table-striped table-primary table-action mb30">
                                <thead>
                                <tr>
                                    <th class="th1 table-action">序号</th>
                                    <th class="th5 table-action">名称</th>
                                    <th class="th5 table-action">图片</th>
                                    <th class="th5 table-action">价格</th>
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                    
                                        <td>${bean.sort}</td>
                                        <td>${bean.title}</td>
                                        <td><img src="${filehttp}/${bean.picurl}" height="25px"/></td>
                                        <td><fmt:formatNumber value='${bean.price}' pattern="0.0#"/></td>
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
                        <i class="weight500 size14 pl-10 line-height50">分类添加</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx}/suc/memorialtribute!save.action?fypage=${fypage}"
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
                                <label class="control-label">价格：</label>
                                <input type="text" id="price" name="price"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">分类：</label>
                                <select id="type" name="type" class="select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                        <c:forEach items="${typelist}" var="bean">
                                         <option value="${bean._id}">${bean.title}</option>
                                        </c:forEach>
                                 
                                </select> 
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">标签：</label>
                                <select id="bq" name="bq" class="select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择"> 
                                         <option value="免费">免费</option> 
                                         <option value="半价">半价</option> 
                                </select> 
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">库存：</label>
                                <input type="text" id="num" name="num"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">售量：</label>
                                <input type="text" id="gmnum" name="gmnum"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">亲情值：</label>
                                <input type="text" id="value" name="value"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">排序：</label>
                                <input type="text" id="sort" name="sort"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">图片：</label>
                                <div>
                                    <div class="col-sm-9 form-group-20 hang40" style="padding:   0px;">
                                        <input type="text" id="picurl" name="picurl" class=" form-control"/>
                                    </div>
                                    <div class="col-sm-3 form-group-20 hang40" style="padding: 0px;position: relative;" onclick="pz('picurl','200','200',false)">
                                        <div class="btn btn-primary"
                                                style="width: 100%;line-height: 20px;height:40px;">
                                                上传
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>  
                         <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">缩略图：</label>
                                <div>
                                    <div class="col-sm-9 form-group-20 hang40" style="padding:   0px;">
                                        <input type="text" id="logo" name="logo" class=" form-control"/>
                                    </div>
                                    <div class="col-sm-3 form-group-20 hang40" style="padding: 0px;position: relative;" onclick="pz('logo','50','50',false)">
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
<%@ include file="/webcom/share.jsp"%>
<%@ include file="/webcom/cut-img.jsp"%>
<%@ include file="/webcom/preview.jsp"%>
</body>
</html>
