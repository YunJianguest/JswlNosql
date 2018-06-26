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
        $(document).ready(function () {
            $("#but1").val("${but1}");
            $("#but2").val("${but2}");
            var validator = $("#custinfoForm").validate({
                rules: {
                    title: {
                        required: true
                    }
                    ,
                    mb: {
                        number: true
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
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <div class="pageheader">
            <h2>
                <i class="fa fa-user"></i>系统设置<span>平台条例</span>
            </h2>
        </div>
        <div class="contentpanel">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <form class="form-horizontal" id="custinfoForm" method="post"
                              action="${contextPath}/set/rules!save.action"
                              onSubmit="return checksubmit()">
                            <input type="hidden" id="_id" value="<s:property value='_id'/>" name="_id"/>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group-20">
                                            <label class="control-label">描述</label>
                                            <textarea style="display:none" name="content"
                                                      id="content">${entity.content}</textarea>
                                            <script id="editor" type="text/plain"
                                                    style="width:100%;height:300px;">${entity.content}</script>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    <div class="row">
                                        <div class="col-sm-6 col-sm-offset-5">
                                            <input type="submit" class="btn btn-primary dropdown-toggle"
                                                   value="提&nbsp;&nbsp;交"/> <input type="reset" class="btn btn-primary dropdown-toggle"
                                                                                   value="重&nbsp;&nbsp;置"
                                                                                   onClick="document.form.reset();"/>
                                            <input
                                                    type="reset" class="btn btn-primary dropdown-toggle" value="返&nbsp;&nbsp;回"
                                                    onClick="history.back();"/>
                                        </div>
                                    </div>
                                </div>
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
    $('#mb').val('${entity.mb}');
    var ue = UE.getEditor('editor');
    ue.ready(function () {
        UE.getEditor('editor').setHeight(300);
    });
    function checksubmit() {
        $("#content").val(ue.getContent());
    }
</script>
</body>
</html>
