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

    <script src="${contextPath}/bracket/js/jquery.tagsinput.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/bracket/css/jquery.tagsinput.css"/>

    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=okxlYE9HTRadFAnCltenxU6G"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/lang/zh-cn/zh-cn.js"></script> 
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="${contextPath}/mvccol/color/jscolor.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            jQuery('#keyword').tagsInput({height: '40px'});
            var validator = $("#custinfoForm").validate({
                rules: {
                    title: {
                        required: true
                    },
                    logo: {
                        required: true
                    },
                    jpnum1: {
                        number: true
                    }
                    ,
                    jpnum2: {
                        number: true
                    }
                    ,
                    jpnum3: {
                        number: true
                    },
                    jpnum4: {
                        number: true
                    },
                    jpnum5: {
                        number: true
                    },
                    jpnum6: {
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
   
        function changelx() {
            var ls = $("#lx").val();
            if (ls == 2) {
                $(".zj").hide();
                $(".jz").show();
            } else {
                $(".zj").show();
                $(".jz").hide();
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

            <h2><i class="fa fa-user"></i> 微活动 <span>大转盘</span></h2>

        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12">
                    <form class="form-horizontal" id="custinfoForm" method="post"
                          action="${contextPath}/suc/luckydraw!save.action?fypage=${fypage}">
                        <input type="hidden" id="_id" value="<s:property value='_id'/>" name="_id"/>
                        <input type="hidden" id="type" value="${type}" name="type"/>
                        <input type="hidden" id="picurl" value="<s:property value='picurl'/>" name="picurl"/>
                        <input type="hidden" id="counts" name="counts"/>

                        <div class="div-group-10 overflow-hidden">
                            <!--左边项目-->
                            <div class="overflow-hidden">
                                <div class=" div-group-10 pb-25 bg-bai border-radius5 overflow-hidden">
                                    <div class="clear col-2 overflow-hidden">
                                        <div class="size14 line-bottom weight500 pt-10 pb-10"
                                             style="padding-left: 2px;">
                                            分享图片<i
                                                class="size12 zi-hui">（仅需一张）</i></div>
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
                                                        <img src="${filehttp}/${entity.picurl}" class="img-60">
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
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="title"
                                                       value="<s:property value='title'/>"
                                                       name="title"
                                                       placeholder="活动名称">
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10">
                                            <div class="size14 weight500 line-bottom pt-10 pb-10"
                                                 style="padding-left: 2px;">
                                                模板
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <select id="lx" name="lx" class="hang40 width-10"
                                                        data-placeholder="请选择" onchange="changelx()">
                                                    <option value="">选请择</option>
                                                    <option value="0">大转盘</option>
                                                    <option value="1">刮刮乐</option>
                                                    <option value="2">0元抢</option>
                                                    <option value="3">摇一摇</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10 zj">
                                            <div class="size14 weight500 line-bottom pt-10 pb-10"
                                                 style="padding-left: 2px;">
                                                活动频率
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <select id="rate" name="rate" class="hang40 width-10"
                                                        data-placeholder="请选择">
                                                    <option value="">选请择</option>
                                                    <option value="0">仅一次</option>
                                                    <option value="1">每日一次</option>
                                                    <option value="2">每日二次</option>
                                                    <option value="3">每日三次</option>
                                                    <option value="9">每日九次</option>
                                                    <option value="4">不限次数</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10 zj">
                                            <div class="size14 weight500 line-bottom pt-10 pb-10"
                                                 style="padding-left: 2px;">
                                                中奖频率
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <select id="djcs" name="djcs" class="hang40 width-10"
                                                        data-placeholder="请选择">
                                                    <option value="">选请择</option>
                                                    <option value="0">不限得奖</option>
                                                    <option value="1">仅得一次奖</option> 
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10">
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
                                        <div class="col-2 pr-10 jz">
                                            <div class="size14 weight500 line-bottom pt-10 pb-10"
                                                 style="padding-left: 2px;">
                                                参团人数
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <select id="pcount" name="pcount" class="hang40 width-10"
                                                        data-placeholder="请选择">
                                                    <option value="">选请择</option>
                                                    <option value="10">10人</option>
                                                    <option value="20">20人</option>
                                                    <option value="50">50人</option>
                                                    <option value="100">100人</option>
                                                    <option value="300">300人</option>
                                                    <option value="500">500人</option>
                                                    <option value="1000">1000人</option>
                                                    <option value="2000">2000人</option>
                                                    <option value="3000">3000人</option>
                                                    <option value="5000">5000人</option>
                                                    <option value="10000">10000人</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-2 jz">
                                            <div class="size14 line-bottom weight500 pt-10 pb-10"
                                                 style="padding-left: 2px;">
                                                发起单位
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="unit" value="${entity.unit}" name="unit"
                                                       placeholder="请输入单位名称">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clear pt-25 ">
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
                                                兑奖截止日期
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                       type="text"
                                                       placeholder="点击输入日期"
                                                       value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${djenddate}'/>"
                                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
                                                       readonly="readonly"
                                                       name="djenddate"
                                                       id="djenddate">
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10">
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
                                         <div class="col-2 pr-10">
                                            <div class="size14 weight500 line-bottom pt-10 pb-10"
                                                 style="padding-left: 2px;">
                                                中奖概率
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <select id="zjl" name="zjl" class="hang40 width-10"
                                                        data-placeholder="请选择">
                                                    <option value="">选请择</option>
                                                    <option value="500">最高</option>
                                                    <option value="1000">特高</option>
                                                    <option value="2000">极高</option>
                                                    <option value="3000">高</option>
                                                    <option value="5000">普通</option>
                                                    <option value="8000">低</option>
                                                    
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="size14 line-bottom weight500 pt-10 pb-10"
                                                 style="padding-left: 2px;">
                                                背景颜色
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100 color"
                                                       type="text"
                                                       id="bgcolor" value="<s:property value='bgcolor'/>" name="bgcolor"
                                                       placeholder="背景颜色">
                                            </div>
                                        </div>
                                         <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-10 pb-10"
                                                 style="padding-left: 2px;">
                                                消耗积分
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jfxh" value="<s:property value='jfxh'/>" name="jfxh"
                                                       placeholder="消耗积分">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="pt-10 clear">
                                <div class="div-group-10 pb-20 overflow-hidden border-radius5 bg-bai"> 
                                    <div class="clear">
                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品一
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jp0" value="${reward[0].jp}" name="jp0"
                                                       placeholder="例：一等奖">
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品数量
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jpnum0" value="${reward[0].total}" name="jpnum0"
                                                       placeholder="请输入数字">
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品二
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jp1" value="${reward[1].jp}" name="jp1"
                                                       placeholder="例：二等奖">
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品数量
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jpnum1" value="${reward[1].total}" name="jpnum1"
                                                       placeholder="请输入数字">
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品三
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jp2" value="${reward[2].jp}" name="jp2"
                                                       placeholder="例：三等奖">
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品数量
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jpnum2" value="${reward[2].total}" name="jpnum2"
                                                       placeholder="请输入数字">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clear pt-25">

                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品四
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jp3" value="${reward[3].jp}" name="jp3"
                                                       placeholder="例：四等奖">
                                            </div>
                                        </div>

                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品数量
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jpnum3" value="${reward[3].total}" name="jpnum3"
                                                       placeholder="请输入数字">
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品五
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jp4" value="${reward[4].jp}" name="jp4"
                                                       placeholder="例：五等奖">
                                            </div>
                                        </div>

                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品数量
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jpnum4" value="${reward[4].total}" name="jpnum4"
                                                       placeholder="请输入数字">
                                            </div>
                                        </div>
                                        <div class="col-2 pr-10">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品六
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jp5" value="${reward[5].jp}" name="jp5"
                                                       placeholder="例：六等奖">
                                            </div>
                                        </div>

                                        <div class="col-2">
                                            <div class="size14 line-bottom weight500 pt-20 pb-10"
                                                 style="padding-left: 2px;">
                                                奖品数量
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40">
                                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100"
                                                       type="text"
                                                       id="jpnum5" value="${reward[5].total}" name="jpnum5"
                                                       placeholder="请输入数字">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <!--下部编辑器-->
                            <div class="pt-10 clear">
                                <div class="div-group-10 border-radius5 bg-bai">
                                    <textarea style="display:none" name="context"
                                              id="context">${entity.context}</textarea>
                                    <script id="editor" type="text/plain"
                                            style="width:100%;height:300px;">${entity.context}</script>
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
                <!-- row -->

            </div>
            <!-- contentpanel -->
        </div>
    </div>
</section>
<%@ include file="/webcom/cut-img1.jsp" %>

<script type="text/javascript">
    $("#lx").val("${entity.lx}");
    $("#pcount").val("${entity.pcount}");
    $("#djcs").val("${entity.djcs}");
    $("#rate").val("${entity.rate}"); 
    $("#zjl").val("${entity.zjl}"); 
    changelx();

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');

    ue.ready(function () {
        UE.getEditor('editor').setHeight(300);
    });

    function checksubmit() {
        $("#context").val(ue.getContent());
        var counts = Number($("#jpnum0").val())+Number($("#jpnum1").val()) + Number($("#jpnum2").val()) + Number($("#jpnum3").val()) + Number($("#jpnum4").val()) + Number($("#jpnum5").val());
        $("#counts").val(counts);
        $('#custinfoForm').submit();

    }


</script>


</body>
</html>
