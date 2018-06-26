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
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript">
    </script>
    <style>
        .form-group-20 {
            margin-bottom: 20px;
        }
        .select2-container .select2-choice {
            line-height: 28px;
        !important;
        }
        .pr-10 {
            padding-right: 10px;
        }
        .pb-10 {
            padding-bottom: 10px;
        }
    </style>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <div class="pageheader">
            <h2>
                <i class="fa fa-user"></i>微官网<span>帮助中心</span>
            </h2>
        </div>
        <div class="contentpanel">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <form class="form-horizontal" id="custinfoForm" method="post"
                              action="${contextPath}/set/help!save.action"
                              onSubmit="return checksubmit()">
                            <input type="hidden" id="_id" value="<s:property value='_id'/>" name="_id"/>

                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="form-group-20">
                                            <label class="control-label">标题</label>
                                            <input type="text" id="title" value="<s:property value='title'/>"
                                                   name="title" placeholder="请输入标题" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group-20">
                                            <label class="control-label">序号</label>
                                            <input type="text" id="sort" value="<s:property value='sort'/>" name="sort"
                                                   placeholder="请输入序号" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group-20">
                                            <label class="control-label">模块</label>
                                            <select id="type" name="type" data-placeholder="请选择" class="select2"
                                                    style="line-height: 28px!important;"
                                                    required data-placeholder="请选择">
                                                <option value="-1">其他帮助</option>
                                                <option value="1">系统帮助</option>
                                                <option value="2">任务帮助</option>
                                                <option value="3">商城帮助</option>
                                                <option value="4">积分帮助</option>
                                            </select>
                                            <label class="error" for="fruits"></label>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group-20">
                                            <label class="control-label">类型</label>
                                            <select id="lx" name="lx" data-placeholder="请选择" class="select2"
                                                    style="line-height: 28px!important;"
                                                    required data-placeholder="请选择">
                                                <option value="0">后台管理</option>
                                                <option value="1">普通用户</option>
                                            </select>
                                            <label class="error" for="fruits"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group-20">
                                            <textarea style="display:none" name="content"
                                                      id="content">${content}</textarea>
                                            <script id="editor" type="text/plain"
                                                    style="width:100%;height:300px;">${content}</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer">
                                    <button class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="/webcom/cut-img.jsp" %>
<script type="text/javascript">
    $('#lx').val('${entity.lx}');
    if ('${type}' != 0) {
        $('#type').val('${type}');
    }
    if ('${entity.type}' != 0) {
        $('#type').val('${entity.type}');
    }
    var ue = UE.getEditor('editor');
    ue.ready(function () {
        UE.getEditor('editor').setHeight(300);
    });
    function checksubmit() {
        $("#content").val(ue.getContent());
    }
    $(function () {
        jQuery(".select2").select2({
            width: '100%',
            minimumResultsForSearch: -1
        });
    });
</script>
</body>
</html>
