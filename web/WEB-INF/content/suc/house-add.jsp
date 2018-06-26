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
        function pz(id, w, h, tag) {
            $("#clipArea").photoClip({
                width: w,
                height: h,
                file: "#file",
                view: "#view",
                ok: "#clipBtn",
                outputType: "jpg",
                loadStart: function () {
                    console.log("照片读取中");
                },
                loadComplete: function () {
                    console.log("照片读取完成");
                },
                clipFinish: function (dataURL) {
                    upimage(dataURL, id, tag);
                    $('#clipArea').html('');
                }
            });

            $('#jqpic').show();
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
        function chagemb(){
         if($("#mb").val()==0){
            $("#bjq").show();
         }else{
            $("#bjq").hide();
         }
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
                      action="${contextPath}/suc/house!save.action?fypage=${fypage}">
                    <input id="_id" name="_id" value="<s:property value='_id'/>" type="hidden"/>
                    <input type="hidden" id="logo" value="<s:property value='logo'/>" name="logo"/>
                    <input type="hidden" id="keyword" value="<s:property value='keyword'/>" name="keyword"/>
                    <input type="hidden" id="xs" value="<s:property value='xs'/>" name="xs"/>
                    <input  id="createdate" name="createdate" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${createdate}'/>" type="hidden" />
                    <div class="div-group-10 overflow-hidden">
                        <!--左边项目-->
                        <div class="overflow-hidden">
                            <div class=" div-group-10 pb-25 bg-bai border-radius5 overflow-hidden">
                                <div class="clear col-2 overflow-hidden">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        企业logo<i
                                            class="size12 zi-hui">（仅需一张）</i></div>
                                    <div class="line-bottom line-right line-left1 div-group-5 pt-10 pb-10 overflow-hidden">
                                        <div class="col-6">
                                            <c:if test="${empty entity.logo}">
                                                <div class="img-wh60 maring-a border-radius3 line-lu logos">

                                                </div>
                                        </div>
                                        </c:if>
                                        <c:if test="${not empty entity.logo}">
                                            <div class="img-wh60 maring-a border-radius3 line-lu logos">
                                                <img src="${filehttp}/${entity.logo}" class="img-60">
                                            </div>
                                    </div>
                                    </c:if>
                                    <div class="col-6">
                                        <a href="javascript:pz('logo','200','200',false,this)">
                                            <div class="img-wh60 maring-a border-radius3 line-lu">
                                                <div class="div-group-15">
                                                    <img src="${contextPath}/mvccol/img/addimg.png" class="width-10">
                                                </div>
                                            </div>
                                        </a>
                                    </div>

                                </div>
                            </div>

                            <div class="clear pt-25">
                                <div class="col-2 pr-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        企业名称
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="name"
                                               value="<s:property value='name'/>"
                                               name="name"
                                               placeholder="企业名称">
                                    </div>
                                </div>
                                <div class="col-2 pr-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        联系电话
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               id="tel"
                                               value="<s:property value='tel'/>"
                                               name="tel"
                                               placeholder="企业电话">
                                    </div>
                                </div>
                                <div class="col-2 pr-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        展示时间（开始）
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               placeholder="点击输入日期"
                                               value="<fmt:formatDate pattern='yyyy-MM-dd' value='${startdate}'/>" 
                                               readonly="readonly"
                                               name="startdate"
                                               id="startdate">
                                    </div>
                                </div>

                                <div class="col-2 pr-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        展示时间（结束）
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               placeholder="点击输入日期"
                                               value="<fmt:formatDate pattern='yyyy-MM-dd' value='${enddate}'/>"
                                               
                                               readonly="readonly"
                                               name="enddate"
                                               id="enddate">
                                    </div>
                                </div>

                                <div class="col-2 pr-10">
                                    <div class="size14 weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        商家类别
                                    </div>

                                    <div class=" overflow-hidden">
                                        <select id="type" name="type" class="width-10 select2" data-placeholder="请选择">
                                             <option value="">请选择</option>
                                            <c:forEach items="${hylist}" var="bean" varStatus="status">
                                                <option value="${bean.coding}">${bean.title}</option>
                                            </c:forEach>

                                        </select>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="size14 weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        模板
                                    </div>
                                    <div class="overflow-hidden">
                                        <select id="mb" name="mb" class="width-10 select2" data-placeholder="请选择" onchange="chagemb()">
                                            <option value="0">默认模板</option>
                                            <option value="1">高级模板</option>
                                            <option value="2">全屏模板</option>
                                        </select>
                                    </div>
                                </div>
                            </div>


                            <div class="clear pt-25">
                                <div class="col-3">
                                    <div class="pt-10 pb-10 overflow-hidden weight500 size14">
                                        <div class="pull-left  " style="padding-left: 2px;">企业/店铺地址</div>

                                        <div class="pull-right zi-green" onclick="showMap()">选择经纬度</div>

                                    </div>

                                    <div class="col-6 pr-5">
                                        <div class="line-lu hang40 clear">
                                            <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                   type="text"
                                                   id="page_lng" value="${loc[0]}" name="page_lng" placeholder="经度">
                                        </div>
                                    </div>

                                    <div class="col-6 pl-5">
                                        <div class="line-lu hang40 clear">
                                            <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                   type="text"
                                                   id="page_lat" value="${loc[1]}" name="page_lat" placeholder="纬度">
                                        </div>
                                    </div>

                                </div>

                                <div class="col-3 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        详细地址
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               id="address" value="<s:property value='address'/>" name="address"
                                               placeholder="地址">
                                    </div>
                                </div>
                            </div>


                            <div class="col-6 pl-10" id="keywords">

                                <div class="size14 weight500 pt-10 pb-10" style="padding-left: 2px;">关键字</div>

                                <div class="width-2 pull-left">
                                    <div class=" line-top line-bottom line-right line-left1 hang40 width-9 maring-a">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               placeholder="关键字">
                                    </div>
                                </div>

                                <div class="width-2 pull-left">
                                    <div class=" line-top line-bottom line-right line-left1 hang40 width-9 maring-a">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               placeholder="关键字">
                                    </div>
                                </div>

                                <div class="width-2 pull-left">
                                    <div class=" line-top line-bottom line-right line-left1 hang40 width-9 maring-a">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               placeholder="关键字">
                                    </div>
                                </div>

                                <div class="width-2 pull-left">
                                    <div class=" line-top line-bottom line-right line-left1 hang40 width-9 maring-a">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               placeholder="关键字">
                                    </div>
                                </div>

                                <div class="width-2 pull-left">
                                    <div class=" line-top line-bottom line-right line-left1 hang40 width-9 pull-right">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               placeholder="关键字">
                                    </div>
                                </div>


                            </div>


                            <div class="pt-25 clear bg-bai border-radius5 overflow-hidden">
                                <div class="col-1">
                                    <div class="size14 line-bottom weight500 pt-20 pb-10" style="padding-left: 2px;">
                                        序号
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               id="sort" value="<s:property value='sort'/>" name="sort"
                                               placeholder="请输入序号">
                                    </div>
                                </div>

                                <div class="col-3 pl-10">
                                    <div class="size14 line-bottom weight500 pt-20 pb-10" style="padding-left: 2px;">
                                        音乐连接
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               id="mp3" value="<s:property value='mp3'/>" name="mp3" placeholder="音乐连接">
                                    </div>
                                </div>

                                <div class="col-3 pl-10">
                                    <div class="size14 line-bottom weight500 pt-20 pb-10" style="padding-left: 2px;">
                                        外部链接
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                               type="text"
                                               id="url" value="<s:property value='url'/>" name="url" placeholder="外部链接">
                                    </div>
                                </div>

                                <div class="col-5 pl-10">
                                    <div class="size14 line-bottom weight500 pt-20 pb-10" style="padding-left: 2px;">
                                        分享说明
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40">
                                        <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
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
                        <div class="div-group-10 border-radius5 bg-bai">
                            <textarea  name="context" id="context" class="ckeditor" rows="10" cols="38">${context}</textarea>
                            <script id="editor" type="text/plain" style="width:100%;height:300px;">${context}</script>
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
 
<div id="insMap" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button">&times;</button>
                <h4 class="modal-title">
                    <i class="fa fa-automobile"></i> 地图
                </h4>
            </div>
            <div class="modal-body">


                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">

                            <label class="col-sm-1 control-label"></label>

                            <%@include file="/app/tengxmap/Map.jsp" %>

                        </div>
                    </div>
                    <!-- panel-body -->

                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-sm-6 col-sm-offset-3">
                                <button class="btn btn-primary dropdown-toggle col-sm-12" data-dismiss="modal" aria-hidden="true">确&nbsp;&nbsp;定</button>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- panel -->


            </div>
            <!-- row -->
        </div>
    </div>
</div>
<%@include file="/webcom/cut-img1.jsp" %>
<script type="text/javascript">
    init();
    codeLatLng();
    setkeywords();
    $("#mb").val("${mb}");
    chagemb();
    $("#lx").val("${lx}");
    $("#type").val("${entity.type}");

    jQuery(".select2").select2({
        width: '100%'
    });
    jQuery('#enddate').datepicker(); 
    jQuery('#startdate').datepicker(); 
    var editor=CKEDITOR.replace('context');
    function checksubmit() {
        $("#context").val(editor.getData());
        var key = '';
        $("#keywords").find('input').each(function () {
            if ($(this).val() != '') {
                key += $(this).val() + ',';
            }
        });
        $('#keyword').val(key + $('#name').val() + ',');
        $('#custinfoForm').submit();

    }

</script>


</body>
</html>
