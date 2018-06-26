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
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/lang/zh-cn/zh-cn.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/> 
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
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
    <script type="text/javascript">
        $(document).ready(function () {
            var validator = $("#custinfoForm").validate({
                rules: {},
                messages: {},
                highlight: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                },
                success: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-error');
                }
            });
        });
        function savelogo() {
            var submitData = {
                logo: $("#logo").val(),
                ewmurl: $("#ewmurl").val(),
                summary:$("#summary").val(),
                ewmxs:$("#ewmxs").val(),
                zsjf:$("#zsjf").val(),
                tsjf:$("#tsjf").val()
            };
            $.post('${ctx}/suc/comunit!ajaxsaveewm.action', submitData, function (json) {
                if (json.state == 0) {
                    alert("保存成功！");
                    location.reload();
                }

            }, "json")

        }
        function saveewmurl() {
            var submitData = {
                ewmurl: $("#ewmurl").val()
            };
            $.post('${ctx}/suc/comunit!ajaxsaveewm.action', submitData, function (json) {
                if (json.state == 0) {
                    alert("保存成功！");
                    location.reload();
                }

            }, "json")

        }
    </script>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <div class="pageheader">
            <h2>
                <i class="fa fa-user"></i>系统管理<span>关注配置</span>
            </h2>
        </div>
        <div class="contentpanel">
            <div class="row">
                <div class="col-md-12">

                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="row col-sm-6">
                                <label class="control-label col-sm-12">logo</label>
                                <div>
                                    <div class="col-sm-8 form-group-20">
                                        <input type="text" id="logo" class="form-control hang40" value="${entity.logo}"
                                               name="logo"/>
                                    </div>
                                    <div class="col-sm-4 form-group-20" onclick="pz('logo','200','200')">
                                        <div class="btn btn-primary" style="width: 100%;line-height: 20px;">
                                            上传
                                        </div>
                                    </div>
                                  
                                </div>
                            </div>
                            <div class="row col-sm-6">
                                <label class="control-label col-sm-12">二维码</label>
                                <div>
                                    <div class="col-sm-8 form-group-20">
                                        <input type="text" id="ewmurl" class="form-control hang40"
                                               value="${entity.ewmurl}" name="ewmurl"/>
                                    </div>
                                    <div class="col-sm-4 form-group-20" onclick="pz('ewmurl','200','200')">
                                        <div class="btn btn-primary" style="width: 100%;line-height: 20px;">
                                            上传
                                        </div>
                                    </div>
                                
                                </div>
                            </div>
                            <div class="row col-sm-6">
                                <label class="control-label col-sm-12">关注语</label>
                                <div>
                                    <div class="col-sm-8 mb-20">
                                        <input type="text" id="summary" class="form-control hang40"
                                               value="${entity.summary}" name="ewmurl"/>
                                    </div>
                                   
                                </div>
                            </div>
                            <div class="row col-sm-6">
                                <label class="control-label col-sm-12">是否显示</label>
                                <div>
                                    <div class="col-sm-8 mb-20">
                                    <select id="ewmxs" name="ewmxs" class="select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                    <option value="0">显示</option>
                                    <option value="1">不显示</option> 
                                    </select>
                                    </div>
                                   
                                </div>
                            </div>
                            
                             <div class="row col-sm-6">
                                <label class="control-label col-sm-12">首次登陆赠送积分</label>
                                <div>
                                    <div class="col-sm-8 mb-20">
                                        <input type="text" id="zsjf" class="form-control hang40"
                                               value="${entity.zsjf}" name="zsjf"/>
                                    </div>
                                   
                                </div>
                            </div>
                             <div class="row col-sm-6">
                                <label class="control-label col-sm-12">赠送积分提示</label>
                                <div>
                                    <div class="col-sm-8 mb-20">
                                        <input type="text" id="tsjf" class="form-control hang40"
                                               value="${entity.tsjf}" name="tsjf"/>
                                    </div>
                                   
                                </div>
                            </div>
                             <div class="row col-sm-12">  
                                   <div class="col-sm-12 mb-20" onclick="savelogo()">
                                        <div class="btn btn-primary" style="width: 100%;line-height: 20px;">
                                           提交
                                        </div>
                                    </div>
                                 
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@ include file="/webcom/cut-img.jsp" %>
<script type="text/javascript">
$("#ewmxs").val('${entity.ewmxs}');
</script>
</body>
</html>
