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
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=okxlYE9HTRadFAnCltenxU6G"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/lang/zh-cn/zh-cn.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript">
        $(document).ready(function () { 
            var validator = $("#custinfoForm").validate({
                rules: {
                    name: {
                        required: true
                    },
                    logo: {
                        required: true
                    },
                    page_lng: {
                        isFloat: true
                    },
                    page_lat: {
                        isFloat: true
                    },
                    mb: {
                        required: true
                    },
                    enddate: {
                        required: true
                    },
                    startdate: {
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
        function cke() {
            var str = "";
            var tmp = document.getElementsByName("ch_type");

            for (var i = 0; i < tmp.length; i++) {
                if (tmp[i].checked) {
                    str += tmp[i].value + ","

                }
            }
            $("#type").val(str);

        }
        function setcke() {
            var str = "${type}";
            var tmp = str.split(",");

            for (var i = 0; i < tmp.length; i++) {
                $("#" + tmp[i]).attr("checked", "checked");
            }
        }
        ;
        function xzsb() {
            $('#tubiao').show();
        }
        function close_box() {
            $('#tubiao').hide();
        }
        function selsb(key, value) {
            $('#css').val(key);
            $('#tubiao').hide();
        }

        function showMap() {
            $('#insMap').modal({
                show: true
            });

        }
        function setkeywords() {
            var key = '${entity.keyword}';
            var keys = key.replace('${entity.name},', '').split(",");
            $("#keywords").find('input').each(function (i, e) {
                $(this).val(keys[i]);
            });
        }

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
            <h2><i class="fa fa-user"></i> 微网站内容 <span>企业管理</span></h2>
        </div>
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal" id="custinfoForm" method="post"
                      action="${contextPath}/suc/votelm!save.action?fypage=${fypage}">
                    <input id="_id" name="_id" value="<s:property value='_id'/>" type="hidden"/>
                    <input type="hidden" id="picurl" value="<s:property value='picurl'/>" name="picurl"/>


                    <div class="div-group-10 overflow-hidden">
                        <!--左边项目-->
                        <div class="overflow-hidden">
                            <div class=" div-group-10 pb-25 bg-bai border-radius5 overflow-hidden">
                                <div class="clear col-2 overflow-hidden">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">

                                        分享图片填写<i class="size12 zi-hui">（仅需一张）</i></div>

                                    <div class="line-bottom line-right line-left1 div-group-5 pt-10 pb-10 overflow-hidden">

                                        <c:if test="${empty entity.picurl}">
                                            <div class="col-6">
                                                <div class="img-wh60 maring-a border-radius3 line-lu logos">
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty entity.picurl}">
                                            <div class="col-6">
                                                <div class="img-wh60 maring-a border-radius3 line-lu logos">
                                                    <img src="${filehttp}/${entity.picurl}" class="width-10">
                                                </div>
                                            </div>
                                        </c:if>

                                        <div class="col-6">
                                            <a href="javascript:pz('picurl','200','200',false,this)">
                                                <div class="img-wh60 maring-a border-radius3 line-lu">
                                                    <div class="div-group-15">
                                                        <img src="${contextPath}/mvccol/img/addimg.png"
                                                             class="width-10">
                                                    </div>
                                                </div>
                                            </a>
                                        </div>

                                    </div>
                                </div>

                                <div class="clear pt-25">
                                    <div class="col-2 pr-10">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            活动名称
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                   type="text"
                                                   id="title"
                                                   value="<s:property value='title'/>"
                                                   name="title"
                                                   placeholder="活动名称">
                                        </div>
                                    </div>

                                    <div class="col-2 pr-10">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            报名截止日期
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                   type="text"
                                                   placeholder="点击输入日期"
                                                   value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bmenddate}'/>"
                                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
                                                   readonly="readonly"
                                                   name="bmenddate"
                                                   id="bmenddate">
                                        </div>
                                    </div>

                                    <div class="col-2 pr-10">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            开始日期
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                   type="text"
                                                   placeholder="点击输入日期"
                                                   value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${startdate}'/>"
                                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
                                                   readonly="readonly"
                                                   name="startdate"
                                                   id="startdate">
                                        </div>
                                    </div>

                                    <div class="col-2 pr-10">
                                        <div class="size14 weight500 line-bottom pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            截止日期
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                   type="text"
                                                   placeholder="点击输入日期"
                                                   value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${enddate}'/>"
                                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
                                                   readonly="readonly"
                                                   name="enddate"
                                                   id="enddate">
                                        </div>
                                    </div>
                                    <div class="col-2 pr-10">
                                        <div class="size14 weight500 line-bottom pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            模板
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <select id="mb" name="mb" class="hang40 width-10" data-placeholder="请选择">
                                                <option value="">请选择</option>
                                                <option value="0">默认模板</option>
                                                <option value="1">果乡助农</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            序号
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                   type="text"
                                                   id="sort" value="<s:property value='sort'/>" name="sort"
                                                   placeholder="请输入序号">
                                        </div>
                                    </div>
                                </div>


                                <div class="clear pt-25">


                                    <div class="col-2 pr-10">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            频率
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <select class="hang40 width-10" id="frequency" name="frequency">
                                                <option value="">请选择</option>
                                                <option value="0">仅一次</option>
                                                <option value="1">每日一次</option>
                                                <option value="2">每日二次</option>
                                                <option value="3">每日三次</option>
                                            </select>

                                        </div>
                                    </div>
                                    <div class="col-2 pr-10">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            未开始提示语
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                   type="text"
                                                   id="startclues" value="<s:property value='startclues'/>"
                                                   name="startclues"
                                                   placeholder="请输入未开始提示语">
                                        </div>
                                    </div>
                                    <div class="col-2 pr-10">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            已结束提示语
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                   type="text"
                                                   id="endclues" value="<s:property value='endclues'/>" name="endclues"
                                                   placeholder="请输入已结束提示语">
                                        </div>
                                    </div>
                                    <div class="col-2 pr-10">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            外部链接
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                   type="text"
                                                   id="url" value="<s:property value='url'/>" name="url"
                                                   placeholder="外部链接">
                                        </div>
                                    </div>

                                    <div class="col-4">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            分享说明
                                        </div>
                                        <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                            <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                   type="text"
                                                   id="summary" value="<s:property value='summary'/>" name="summary"
                                                   placeholder="分享说明">
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <!--下部编辑器-->
                        <div class="pt-10 clear">
                            <div class="size14 line-bottom weight500 pt-20 pb-10" style="padding-left: 2px;">
                                活动与奖项设置说明
                            </div>
                            <div class="div-group-10 border-radius5 bg-bai">
                                <textarea style="display:none" name="content" id="content">${entity.content}</textarea>
                                <script id="editor" type="text/plain"
                                        style="width:100%;height:300px;">${entity.content}</script>
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
    $("#mb").val("${entity.mb}");
    $("#frequency").val("${entity.frequency}");
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');

    ue.ready(function () {
        UE.getEditor('editor').setHeight(300);
    });

    function checksubmit() {
        $("#content").val(ue.getContent());
        $('#custinfoForm').submit();
    }

</script>


</body>
</html>
