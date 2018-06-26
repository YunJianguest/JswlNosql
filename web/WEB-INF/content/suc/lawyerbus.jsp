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

                location.href = "${contextPath}/suc/lawyerbus!delete.action?_id="
                + id;

            }
        }
        function add() {
            $('#_id').val('');
            $('#title').val('');
            $('#picurl').val('');
            $('#url').val('');
            $('#summary').val('');
            $('#content').val('');
            $('#price').val(0);
            $('#sort').val(0);
            $('#icon').val('');
            ps_show('inszc');
        }

        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/suc/lawyerbus!upd.action', submitData, function (json) {
                $('#_id').val(json._id);
                $('#title').val(json.title);
                $('#summary').val(json.summary);
                $('#price').val(json.price);
                $('#url').val(json.url);
                $('#icon').val(json.icon);
                $('#picurl').val(json.picurl);
                $('#content').val(json.content);
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

        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/suc/lawyerbus.action?lid=${lid}">

            <div class="pageheader">

                <h2><i class="fa fa-user"></i>律师管理 <span>服务管理</span></h2>

                
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1d">
                            <input type="text" name="title" value="${title}" placeholder="名称" class="form-control"/>
                        </div>

                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
                          <div class="form-group col-sm-1d pull-right"> 
                         <button type="button" onclick="add()" class="btn btn-primary dropdown-toggle form-group pull-right" data-toggle="dropdown">
                                                                                    服务添加 <i  class="fa fa-plus"></i>
                         </button>
                         
                      </div> 

                    </div>
                </div>
                <!-- panel-body -->
            </div>
            <!-- panel -->

            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-primary table-action mb30 table-bordered">
                                <thead>
                                <tr>
                                    <th class="th1 table-action">序号</th>
                                    <th class="th5 table-action">名称</th>
                                    <th class="th5 table-action">操作</th>
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
                        <i class="weight500 size14 pl-10 line-height50">服务添加</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx}/suc/lawyerbus!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <input type="hidden" id="lid" name="lid" value="${lid}"/>
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">名称：</label>
                                <input type="text" id="title" name="title"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="mb-20">
                                <label class="control-label">图标</label>
                                <input type="text" id="icon" name="icon"
                                       class="form-control" placeholder="请输入"/>
                                 
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="mb-20"> 
                            <label class="control-label">&nbsp;</label>
                              <div class="btn btn-primary  hang40" style="margin-left: -17px"  onclick="init_ioc('icon','inszc')">选择
                              </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">价格：</label>
                                <input type="text" id="price" name="price"
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
                                <label class="control-label">描述：</label>
                                <input type="text" id="summary" name="summary"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">内容：</label>
                                <input type="text" id="content" name="content"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-12">
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
 
<%@include file="/webcom/cut-img.jsp" %>
<%@include file="/webcom/font.jsp" %>


</body>
</html>