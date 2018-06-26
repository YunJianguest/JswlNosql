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

                location.href = "${contextPath}/suc/slide!delete.action?type=${type}&fypage=${fypage}&width=${width}&height=${height}&_id="
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

        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/suc/slide.action?type=${type}&fypage=${fypage}&width=${width}&height=${height}">

            <div class="pageheader">

                <h2><i class="fa fa-user"></i>微网站 <span>幻灯片管理</span></h2>

                
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">

                        <div class="form-group col-sm-1d">
                            <input type="text" name="title" value="${title}" placeholder="名称" class="form-control"/>
                        </div>

                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
                          <div class="form-group col-sm-1d pull-right"> 
                         <button onclick="add()" type="button" class="btn btn-primary dropdown-toggle form-group pull-right" data-toggle="dropdown">
                                                                                     添加幻灯片<i  class="fa fa-align-center"></i>
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
                            <table class="table table-striped table-action table-primary mb30  table-bordered">
                                <thead>
                                <tr>
                                    <th class="th1 table-action">序号</th>
                                    <th class="th3 table-action">图片</th>
                                    <th class="th5 table-action">名称</th>
                                    <th class="th5 table-action">类型</th>
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        <td>${bean.sort}</td>
                                        <td><img src="${filehttp}${bean.picurl}" style="height:25px;"></td>

                                        <td>${bean.title}</td>
                                        <td>${bean.type}</td>
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
        <div class="pl-10 pr-10 maring-a"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">幻灯片添加</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>


                <form id="inscxForm" action="${ctx }/suc/slide!save.action?fypage=${fypage}&width=${width}&height=${height}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <input type="hidden" id="type" name="type" value="${type}"/>
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
                                <label class="control-label">视频链接：</label>
                                <input type="text" id="mp4url" name="mp4url"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">排序：</label>
                                <input type="text" id="sort" name="sort"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <label class="control-label">图片：</label>
                            <div>
                                <div class="col-sm-9 mb-20" style="padding:   0px;">
                                    <input type="text" id="picurl" name="picurl" class=" form-control"/>
                                </div>
                                <c:if test="${width<=0}">
                                 <div class="col-sm-3 mb-20" style="padding: 0px;position: relative;"
                                     onclick="pz('picurl','450','200',false)">
                                    <div class="btn btn-primary"
                                         style="width: 100%;line-height: 20px;height:40px;">
                                        上传
                                    </div>
                                 </div>
                                </c:if>
                                 <c:if test="${width>0}">
                                 <div class="col-sm-3 mb-20" style="padding: 0px;position: relative;"
                                     onclick="pz('picurl',${width},${height},false)">
                                    <div class="btn btn-primary"
                                         style="width: 100%;line-height: 20px;height:40px;">
                                        上传
                                    </div>
                                 </div>
                                </c:if>
                               
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
