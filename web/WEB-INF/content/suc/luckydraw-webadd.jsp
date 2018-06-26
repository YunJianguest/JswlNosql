<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>${title}</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/mvccol/mui-css/app.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/mvccol/mui-css/mui.picker.min.css"/>
    <style>
        .zi-6 {
            color: #666666
        }

        .xzb {
            border: solid 1px #00c44e;
            background-color: #00c44e;
            color: #ffffff;
        }

        .xz {
            border: solid 1px #ccc;
            background-color: #ffffff;
            color: #ffffff;
        }

        .bfcss {
            background-color: #eee;
            color: #666;
        }

        .bfcss:hover {
            background-color: #ddd;
            color: #666;
        }

        .bfcss:active {
            background-color: #ddd;
            color: #666;
        }

        .titlex {
            background-color: #00c44e;
            position: relative;
        }

        .titlex {
            color: #ffffff;
        }

        .file {
            position: absolute;
            z-index: 100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            background-color: bisque;
        }

        .fa-spin1 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }

        .yListr2 .biankuang .div2 {
            background-color: #00c44e;
            position: relative;
            color: #ffffff;
        }

        .line-32d9c0 {
            border: 2px solid #00c44e;
            color: #00c44e;
        }

        .line-height46 {
            line-height: 46px;
        }
        .line-right-32d9c0 {
            border-right: 2px solid #00c44e;
        }
    </style>
    <script>
        var jsl = 0;
        function shopping_xiaoshi() {
            $('#shopping_tanchu').hide();
        }
        function shopping_xianshi() {
            $('#shopping_tanchu').show();
        }
        function xieyi_xiaoshi() {
            $('#xieyi_tanchu').hide();
        }
        function xieyi_xianshi() {
            $('#xieyi_tanchu').show();
        }
        function jiangxiang_xiaoshi() {
            $('#jiangxiang_tanchu').hide();
        }
        function jiangxiang_xianshi() {
            $('#jiangxiang_tanchu').show();
        }
        var isplay = false;
        function bf() {
            if (!isplay) {
                $("#bfid").addClass("bfcss");
                $("#xzid").addClass("xz");
                isplay = true;
            } else {
                $("#bfid").removeClass("bfcss");
                $("#xzid").removeClass("xz");
                isplay = false;
            }

        }

        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("biankuang").siblings().removeClass("biankuang");
            })
        })
        function submint() {
            if ($('title').val() == "活动标题") {
                alert("请输入标题");
                return;
            }
            if ($('summary').val() == "请输入活动简介") {
                alert("请输入标题");
                return;
            }
            if ($('fromUsername').val() == "发起人姓名/单位名称") {
                alert("请输入标题");
                return;
            }
            if ($('fromUsertel').val() == "联系电话") {
                alert("请输入标题");
                return;
            }
            if ($('pcount').val() == "请输入参赛人数") {
                alert("请输入标题");
                return;
            }
            if ($('jpsl1').val() == "活动标题（选填）") {
                alert("请输入标题");
                return;
            }
            if ($('jpsl2').val() == "活动标题（选填）") {
                alert("请输入标题");
                return;
            }
            if ($('jpsl3').val() == "活动标题（选填）") {
                alert("请输入标题");
                return;
            }
            if ($('jpsl4').val() == "活动标题（选填）") {
                alert("请输入标题");
                return;
            }
            if ($('jpsl5').val() == "活动标题（选填）") {
                alert("请输入标题");
                return;
            }
            if ($('jpsl6').val() == "活动标题（选填）") {
                alert("请输入标题");
                return;
            }
            var picurl = '';
            var imgurl = '';
            $(".pic-list .col-3").each(function (index, el) {
                if (typeof($(el).attr("name")) != "undefined") {
                    imgurl += $(el).attr("name") + ',';
                }

            });
            picurl = imgurl.substring(0, imgurl.indexOf(','));

            if (picurl.length < 2) {
                alert('请上传图片');
                return;
            }
            if ($('#startdate').html() == '开始时间') {
                alert('请选择开始时间');
                return;
            }
            if ($('#enddate').html() == '结束时间') {
                alert('请选择结束时间');
                return;
            }
            var submitData = {
                title: $('title').val(),
                summary: $('summary').val(),
                content: $('content').val(),
                fromUsername: $('fromUsername').val(),
                fromUsertel: $('fromUsertel').val(),
                fromUserqq: $('fromUserqq').val(),
                startdate: $('#startdate').html(),
                enddate: $('#enddate').html(),
                picurl: $('picurl').val(),
                pcount: $('pcount').val(),
                imgurl: imgurl,
                lx: 1


            };
            $.post('${ctx}/suc/luckydraw!ajaxadd.action?custid=${custid}&fromUserid=${fromUserid}', submitData,

                    function (json) {
                        if (json.state == 0) {
                            window.location.href = "${ctx}/suc/luckydraw!web.action?custid=${custid}&lucid=" + json.value;
                        }
                    }, "json");

        }
        function addjiangx() {
            jsl++;
            var s = jsl + 3;
            $('#jiangxiang' + s).show();
        }
    </script>

</head>
<body>

<main class="cmp640">
    <div class="div-group-5 pl-10 pr-10">

        <div class="size14 weight500 pt-15 pb-10" style="padding-left: 2px;">活动选择</div>

        <font size="2">
            <div class=" width-10 bg-bai maring-a overflow-hidden weight500 yListr2 line-32d9c0">
                <li class="col-4 biankuang line-right-32d9c0">
                    <div class="div2 txt-c hang40 line-height46">
                        摇奖活动
                    </div>
                </li>
                <li class="col-4 line-right-32d9c0">
                    <div class="div2 txt-c hang40 line-height46">
                        投票活动
                    </div>
                </li>
                <li class="col-4">
                    <div class="div2 txt-c hang40 line-height46">
                        刮刮乐活动
                    </div>
                </li>
            </div>
        </font>

        <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">照片资料<i
                class="size12 zi-hui">（活动照片）</i></div>
        <div class="line-bottom line-right line-left1 div-group-5 pt-10 pb-10 overflow-hidden pic-list">

            <div class="col-3 display-none" id="jdt">
                <div class="img-wh60 img-bj maring-a border-radius3 overflow-hidden"
                     style="background-image:url(img/a1.png)">
                    <div class="img-wh60 bg-hui zi-hui  txt-c">
                        <i class="fa fa-spinner fa-1dx fa-spin1" style="line-height:60px;"></i>
                    </div>
                </div>
            </div>

            <div class="col-3">
                <a href="#">
                    <div class="img-wh60 maring-a border-radius3 line-lu">
                        <div class="position-r">
                            <div class="div-group-15">
                                <img src="${contextPath}/mvccol/img/addimg.png" class="width-10">
                            </div>
                            <input type="file" accept="image/*" class="file cameraInput" name="cameraInput">
                        </div>
                    </div>
                </a>
            </div>

        </div>


        <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">活动信息</div>
        <div class="line-bottom col-6 line-left1 hang50 pt-10 dates">
            <div class="width-10 size14 zi-6 hang30  pl-10 pr-10 weight500 datevalue" id="startdate">开始时间</div>
        </div>
        <div class="line-bottom col-6 line-right line-left1 hang50 pt-10 dates ">
            <div class="width-10 size14 zi-6 hang30  pl-10 pr-10 weight500 datevalue" id="enddate">结束时间</div>
        </div>
        <div class="line-bottom line-right line-left1 hang50 pt-10">
            <input id="title" class="width-10 size14 zi-hui hang30  pl-10 pr-10 weight500" type="text"
                   value="活动标题" onfocus="if(this.value=='活动标题（选填）'){this.value=''};this.style.color='black';"
                   onblur="if(this.value==''||this.value=='活动标题（选填）'){this.value='活动标题（选填）';this.style.color='#aaa';}">
        </div>

        <div class="line-bottom line-right line-left1 hang80">
            <form>
                <textarea id="summary" type="text"
                          value="请输入活动简介" onfocus="if(this.value=='请输入活动简介'){this.value=''};this.style.color='black';"
                          onblur="if(this.value==''||this.value=='请输入活动简介'){this.value='请输入活动简介';this.style.color='#aaa';}"
                          rows="5" class="size14 weight500 zi-hui"
                          style="height:80px;border-radius:10px; line-height: 20px;">请输入活动简介</textarea>
            </form>
        </div>

        <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">发起人/企业资料</div>

        <div class="line-bottom line-right line-left1 hang50 pt-10">
            <input id="fromUsername" class="width-10 size14 zi-hui hang30 pl-10 pr-10 weight500" type="text"
                   value="发起人姓名/单位名称" onfocus="if(this.value=='发起人姓名/单位名称'){this.value=''};this.style.color='black';"
                   onblur="if(this.value==''||this.value=='发起人姓名/单位名称'){this.value='发起人姓名/单位名称';this.style.color='#aaa';}">
        </div>

        <div class="line-bottom line-right line-left1 hang50 pt-10">
            <input id="fromUsertel" class="width-10 size14 zi-hui hang30 pl-10 pr-10 weight500" type="text"
                   value="联系电话" onfocus="if(this.value=='联系电话'){this.value=''};this.style.color='black';"
                   onblur="if(this.value==''||this.value=='联系电话'){this.value='联系电话';this.style.color='#aaa';}">
        </div>

        <div class="line-bottom line-right line-left1 hang50 pt-10">
            <input id="fromUserqq" class="width-10 size14 zi-hui hang30 pl-10 pr-10 weight500" type="text"
                   value="QQ号码/微信号码" onfocus="if(this.value=='QQ号码/微信号码'){this.value=''};this.style.color='black';"
                   onblur="if(this.value==''||this.value=='QQ号码/微信号码'){this.value='QQ号码/微信号码';this.style.color='#aaa';}">
        </div>

        <div class="size14 line-bottom weight500 pt-10 pb-10 overflow-hidden"
             style="padding-left: 2px;padding-right: 2px;">
            <div class="pull-left">
                奖项设置
            </div>
            <a href="javascript:addjiangx()">
                <div class="pull-right zi-green">
                    添加更多奖项<i class="fa fa-plus pl-5"></i>
                </div>
            </a>
        </div>


        <div class="line-bottom line-right line-left1 txt-c hang50 weight500 overflow-hidden clear"
             style="line-height: 55px;">
            <div class="col-3 weight500 txt-l pl-10 zi-6">
                一等奖:
            </div>

            <div class="col-9 pt-10 txt-c pr-10">
                <div class="hang30 pt-5 bg-hui border-radius3">
                    <input id="jpsl1" class="pl-10 pr-10 width-10 bg-hui pr-5 size14 zi-hui hang20 weight500"
                           style="line-height: 25px;"
                           type="text"
                           value="请输入奖品数量"
                           onfocus="if(this.value=='请输入奖品数量'){this.value=''};this.style.color='black';"
                           onblur="if(this.value==''||this.value=='请输入奖品数量'){this.value='请输入奖品数量';this.style.color='#aaa';}">
                </div>
            </div>
        </div>

        <div class="line-bottom line-right line-left1 txt-c hang50 weight500 overflow-hidden clear"
             style="line-height: 55px;">
            <div class="col-3 weight500 txt-l pl-10 zi-6">
                二等奖:
            </div>

            <div class="col-9 pt-10 txt-c pr-10">
                <div class="hang30 pt-5 bg-hui border-radius3">
                    <input id="jpsl2" class="pl-10 pr-10 width-10 bg-hui pr-5 size14 zi-hui hang20 weight500"
                           style="line-height: 25px;"
                           type="text"
                           value="请输入奖品数量"
                           onfocus="if(this.value=='请输入奖品数量'){this.value=''};this.style.color='black';"
                           onblur="if(this.value==''||this.value=='请输入奖品数量'){this.value='请输入奖品数量';this.style.color='#aaa';}">
                </div>
            </div>
        </div>


        <div class="line-bottom line-right line-left1 txt-c hang50 weight500 overflow-hidden clear"
             style="line-height:55px;">
            <div class="col-3 weight500 txt-l pl-10 zi-6">
                三等奖:
            </div>

            <div class="col-9 pt-10 txt-c pr-10">
                <div class="hang30 pt-5 bg-hui border-radius3">
                    <input id="jpsl3" class="pl-10 pr-10 width-10 bg-hui pr-5 size14 zi-hui hang20 weight500"
                           style="line-height: 25px;"
                           type="text"
                           value="请输入奖品数量"
                           onfocus="if(this.value=='请输入奖品数量'){this.value=''};this.style.color='black';"
                           onblur="if(this.value==''||this.value=='请输入奖品数量'){this.value='请输入奖品数量';this.style.color='#aaa';}">
                </div>
            </div>
        </div>


        <div id="jiangxiang4" class=" display-none">
            <div class="line-bottom line-right line-left1 txt-c hang50 weight500 overflow-hidden clear"
                 style="line-height:55px;">
                <div class="col-3 weight500 txt-l pl-10 zi-6">
                    四等奖:
                </div>

                <div class="col-9 pt-10 txt-c pr-10">
                    <div class="hang30 pt-5 bg-hui border-radius3">
                        <input id="jpsl4" class="pl-10 pr-10 width-10 bg-hui pr-5 size14 zi-hui hang20 weight500"
                               style="line-height: 25px;"
                               type="text"
                               value="请输入奖品数量"
                               onfocus="if(this.value=='请输入奖品数量'){this.value=''};this.style.color='black';"
                               onblur="if(this.value==''||this.value=='请输入奖品数量'){this.value='请输入奖品数量';this.style.color='#aaa';}">
                    </div>
                </div>
            </div>

        </div>
        <div id="jiangxiang5" class=" display-none">
            <div class="line-bottom line-right line-left1 txt-c hang50 weight500 overflow-hidden clear"
                 style="line-height:55px;">
                <div class="col-3 weight500 txt-l pl-10 zi-6">
                    五等奖:
                </div>

                <div class="col-9 pt-10 txt-c pr-10">
                    <div class="hang30 pt-5 bg-hui border-radius3">
                        <input id="jpsl5" class="pl-10 pr-10 width-10 bg-hui pr-5 size14 zi-hui hang20 weight500"
                               style="line-height: 25px;"
                               type="text"
                               value="请输入奖品数量"
                               onfocus="if(this.value=='请输入奖品数量'){this.value=''};this.style.color='black';"
                               onblur="if(this.value==''||this.value=='请输入奖品数量'){this.value='请输入奖品数量';this.style.color='#aaa';}">
                    </div>
                </div>
            </div>

        </div>

        <div id="jiangxiang6" class=" display-none">
            <div class="line-bottom line-right line-left1 txt-c hang50 weight500 overflow-hidden clear"
                 style="line-height:55px;">
                <div class="col-3 weight500 txt-l pl-10 zi-6">
                    六等奖:
                </div>

                <div class="col-9 pt-10 txt-c pr-10">
                    <div class="hang30 pt-5 bg-hui border-radius3">
                        <input id="jpsl6" class="pl-10 pr-10 width-10 bg-hui pr-5 size14 zi-hui hang20 weight500"
                               style="line-height: 25px;"
                               type="text"
                               value="请输入奖品数量"
                               onfocus="if(this.value=='请输入奖品数量'){this.value=''};this.style.color='black';"
                               onblur="if(this.value==''||this.value=='请输入奖品数量'){this.value='请输入奖品数量';this.style.color='#aaa';}">
                    </div>
                </div>
            </div>

        </div>


        <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">领奖说明</div>
        <div class="line-bottom line-right line-left1 hang80">
            <form>
                <textarea id="content" type="text"
                          value="奖品领取说明与领取地址和时间"
                          onfocus="if(this.value=='奖品领取说明与领取地址和时间'){this.value=''};this.style.color='black';"
                          onblur="if(this.value==''||this.value=='奖品领取说明与领取地址和时间'){this.value='奖品领取说明与领取地址和时间';this.style.color='#aaa';}"
                          rows="5" class="size14 weight500 zi-hui"
                          style="height:80px;border-radius:10px; line-height: 20px;">奖品领取说明与领取地址和时间</textarea>
            </form>
        </div>

    </div>

    <div class="div-group-10 pt-15">

        <div class="pb-25  pl-5 overflow-hidden">
            <a href="javascript:bf();">
                <div id="xzid" class="txt-c pull-left size12 weight900 xzb border-radius3"
                     style="width: 20px; height: 20px;line-height:20px;">
                    √
                </div>
            </a>

            <div class="pull-left size12 pl-5 zi-hei pt-5">我已阅读并同意<a href="javascript:xieyi_xianshi()"><i
                    class="zi-hei" style="border-bottom: 1px solid #000000">《投票活动协议》</i></a></div>
        </div>

        <div class="pb-25 pl-5 zi-6 clear weight500">
            <font size="2">
                上述均不能让您满意请联系我们<a href="tel:15091531186"><i class="zi-green pl-5">15091531186</i></a>
            </font>
        </div>

        <a onclick="submint()">
            <div id="bfid"
                 class=" btn-green zi-bai div-group-10 maring-a size14 txt-c weight500 border-radius5 lock">活动预览
            </div>
        </a>
    </div>

    <!--参赛人数及奖项设置-->
    <div class="pt-10">
        <div class=" div-group-5 pt-8 pl-10 zi-bai pull-left pr-20 bg-green "
             style="border-radius: 0px 100px 100px 0px;">
            <font size="2">活动设置建议</font>
        </div>
    </div>
    <div class="zi-6 div-group-10 pt-20 clear weight500" style="line-height:20px;">
        <font size="2">
            <div>把奖项人数的设置做一个简单的简介让用户更加理性的去填写奖项设置</div>

        </font>
    </div>
    <!--结束-->

    <!--弹出层参赛人数添加分类-->
    <div class="fullscreen cmp640 bg-hei-5 display-none lock" id="shopping_tanchu">
        <div class="position-r overflow-hidden width-10">
            <a href="javascript:shopping_xiaoshi()">
                <div class="width-10 overflow-hidden" style="height:1000px;">

                </div>
            </a>

            <div class="position-a width-5" style="top:10%;left:25%;">
                <div class=" width-10 maring-a overflow-hidden size14 border-radius5 bg-bai pb-15 "
                     style="overflow: auto; height:300px;">
                    <div class=" weight500 pt-15 size16 zi-hei ml-5" style="padding-left: 2px;">人数选择</div>
                    <a href="javascript:setpcount(50)">
                        <div class="zi-lan pl-10 weight100 btn-bai  pt-5 pb-5">0-50人</div>
                    </a>
                    <a href="javascript:setpcount(100)">
                        <div class="zi-lan pl-10 weight100 btn-bai  pt-5 pb-5">51-100人</div>
                    </a>
                    <a href="javascript:setpcount(50)">
                        <div class="zi-lan pl-10 weight100 btn-bai  pt-5 pb-5">101-200人</div>
                    </a>
                    <a href="javascript:setpcount(50)">
                        <div class="zi-lan pl-10 weight100 btn-bai  pt-5 pb-5">201-300人</div>
                    </a>
                    <a href="#">
                        <div class="zi-lan pl-10 weight100 btn-bai  pt-5 pb-5">301-400人</div>
                    </a>
                    <a href="#">
                        <div class="zi-lan pl-10 weight100 btn-bai  pt-5 pb-5">401-500人</div>
                    </a>
                    <a href="#">
                        <div class="zi-lan pl-10 weight100 btn-bai  pt-5 pb-5">501-600人</div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!--结束-->

    <!--弹出层商户协议-->
    <div class="fullscreen cmp640 bg-hei-5 display-none lock" id="xieyi_tanchu">
        <div class="position-r overflow-hidden width-10">
            <a href="javascript:xieyi_xiaoshi()">
                <div class="width-10 overflow-hidden" style="height:1000px;"></div>
            </a>

            <div class="position-a width-9" style="top:7%;left:5%;">
                <div class=" width-10 maring-a overflow-hidden size14 border-radius5 div-group-10 bg-bai pb-15 "
                     style="overflow: auto; height:400px;">
                    <div class="pb-20 weight500 txt-c  size18">商户发起活动协议</div>
                    <div style="line-height:20px;" class="pb-5 size14 txt-c display-none">呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵</div>
                    <div class="size12 pb-30 pl-5 pr-5" style="line-height:19px;">
                        我平台仅提供技术支持，发起人所有行为与我平台无关。发起人如有违反法律法规等行为我平台均会关闭活动。
                    </div>
                    <a href="javascript:xieyi_xiaoshi()">
                        <div class="btn-green div-group-5 maring-a size14 zi-bai txt-c weight500 border-radius5 lock">
                            关闭退出
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!--结束-->

</main>

<!-- Return to the top -->
<div id="gotop" class="gotop">
    <a href="javascript:this.blur();">
        <div class=" maring-a clear img-wh40 bg-hei-8 zi-bai txt-c border-radius50">
            <i class="fa fa-arrow-up pt-3 fa-2x"></i>
        </div>
    </a>
</div>

<script src="${contextPath}/mvccol/lrz/exif.js"></script>
<script src="${contextPath}/mvccol/lrz/lrz.js"></script>
<script src="${contextPath}/mvccol/lrz/mobileFix.mini.js"></script>
<script src="${contextPath}/mvccol/lrz/index3.js"></script>
<script src="${contextPath}/mvccol/mui-js/mui.min.js"></script>
<script src="${contextPath}/mvccol/mui-js/mui.dtpicker.js"></script>

<script src="${contextPath}/mvccol/mui-js/mui.picker.min.js"></script>
<script>
    (function ($) {
        $.init();
        var result = $('.datevalue');
        var btns = $('.dates');
        btns.each(function (i, btn) {
            btn.addEventListener('tap', function () {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                var id = this.getAttribute('id');
                /*
                 * 首次显示时实例化组件
                 * 示例为了简洁，将 options 放在了按钮的 dom 上
                 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
                 */
                var picker = new $.DtPicker(options);
                picker.show(function (rs) {
                    /*
                     * rs.value 拼合后的 value
                     * rs.text 拼合后的 text
                     * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
                     * rs.m 月，用法同年
                     * rs.d 日，用法同年
                     * rs.h 时，用法同年
                     * rs.i 分（minutes 的第二个字母），用法同年
                     */
                    result[i].innerText = rs.text;
                    /*
                     * 返回 false 可以阻止选择框的关闭
                     * return false;
                     */
                    /*
                     * 释放组件资源，释放后将将不能再操作组件
                     * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
                     * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
                     * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
                     */
                    picker.dispose();
                });
            }, false);
        });
    })(mui);
</script>
</body>
</html>