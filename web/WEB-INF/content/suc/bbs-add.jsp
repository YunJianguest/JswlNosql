<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>
    <script src="${contextPath}/bracket/js/jquery.tagsinput.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/bracket/css/jquery.tagsinput.css"/>
    <script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/ckeditor/ckeditor.js"></script> 
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript">
        $(document).ready(function () {
            //jQuery('#keyword').tagsInput({height: '40px'});
            var validator = $("#custinfoForm").validate({
                rules: { 
                    type: {
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
       

    </script>
    <style type="text/css">

        .fa-spin1 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }

        .img-60 {
            width: 60px;
            height: 60px;
        }

    </style>
</head>

<body>

<section>

    <%@include file="/webcom/header-bracket.jsp" %>

    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>


        <div class="pageheader">

            <h2><i class="fa fa-user"></i> 帖子管理 <span>新增帖子</span></h2>


        </div>
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal" id="custinfoForm" method="post"
                      action="${contextPath}/suc/bbs!save.action?fypage=${fypage}">
                    <input id="_id" name="_id" value="${entity._id}" type="hidden"/> 
                    <div class="div-group-10 overflow-hidden">
                        <!--左边项目-->
                        <div class="overflow-hidden">
                              
                            <div class="div-group-10 pb-25 bg-bai border-radius5 overflow-hidden">
                                <div class="col-2 pr-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        标题
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="title"
                                               value="${entity.title}"
                                               name="title"
                                               placeholder="标题">
                                    </div>
                                </div>
                            
                                <div class="col-2 pr-10">
                                    <div class="size14 weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        类别
                                    </div>

                                    <div class=" overflow-hidden">
                                        <select id="type" name="type" class="width-10 select2" data-placeholder="请选择">
                                             <option value="">请选择</option>
                                            <c:forEach items="${bbstype}" var="bean" varStatus="status">
                                                <option value="${bean.type}">${bean.title}</option>
                                            </c:forEach>

                                        </select>
                                    </div>
                                </div>
                             
                            </div>

 
 

                           
                        </div>
                    </div>

                    <!--下部编辑器-->
                    <div class="pt-10 clear">
                        <div class="div-group-10 border-radius5 bg-bai">
                            <textarea  name="content" id="content" class="ckeditor" rows="10" cols="38">${entity.content}</textarea>
                            <script id="editor" type="text/plain" style="width:100%;height:300px;">${entity.content}</script>
                        </div>
                        <a href="javascript:checksubmit()">
                            <div class="pt-20 pb-20 clear">
                                <div class="col-sm-12 btn btn-primary dropdown-toggle">
                                            提交
                                </div>
                            </div>
                        </a>
                    </div>
                </form>

            </div>

        </div>
    </div>
    <!-- mainpanel -->
</section>
 
<%@include file="/webcom/cut-img1.jsp" %>
<script type="text/javascript">  
    $("#type").val("${entity.type}");

    jQuery(".select2").select2({
        width: '100%'
    }); 
    var editor=CKEDITOR.replace('content');
    function checksubmit() {
        $("#content").val(editor.getData()); 
        $('#custinfoForm').submit();

    }

</script>


</body>
</html>
