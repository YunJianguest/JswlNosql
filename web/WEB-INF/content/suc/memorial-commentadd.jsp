<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>祭奠-选购</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .bg-zong {
            background: #630601
        }

        .shadow-wai1 {
            box-shadow: 0px 0px 0px rgba(255, 255, 255, .5), /*左边阴影*/ 1px 0px 10px rgba(140, 140, 140, .5), /*右边阴影*/ 0 -1px 5px rgba(140, 140, 140, .5), /*顶部阴影*/ 0 1px 5px rgba(140, 140, 140, .5); /*底边阴影*/
        }

        .border-radius5s {
            border-radius: 5px 5px 0 0;
        }

        .bg-black {
            background-color: black;
        }

        .bg-bai-8 {
            background-color: rgba(225, 225, 225, 0.9);
        }

        .line-green {
            border: 1px solid #45c01a;
        }

        .line-height18 {
            line-height: 18px;
            width: 18px;
            height: 18px;
        }

        .line-bottom-c3c3c6 {
            border-bottom: 1px solid #c3c3c6;
        }
    </style>
    <script>
        var issend = true;
        var fypage = 0;
        var xszf = "";
        var type = "";
        var sel = "";
        var id = "";
        function ajaxjz() {//加载
            if (!issend) {
                return;
            }
            var submitData = {
                type: type,
                sel: sel
            };
            issend = false;
            $.post('${ctx}/suc/memorial!ajaxtribute.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        var xszfleft = $('#ajaxdivleft').html();
                        var xszfright = $('#ajaxdivright').html();
                        if (json.state == 0) {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                if (i & 1 != 0) {
                                    xszfleft += '<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                    + '<div class="position-r" onclick="checktribute(this,' + v[i]._id + ')"><div class="position-a img-wh20 border-radius50 txt-c line-green overflow-hidden" style="top: 5px;left:7px;" >'
                                    + '<font size="1"><il class="fa zi-bai line-height18"></il></font></div>'
                                    + '<img src="${filehttp}/' + v[i].picurl + '" class="width-10 border-radius5s"/>'
                                    + '<div class="position-a width-3" style="top: 0px; right:10px;">'
                                    + '<div class="pt-5 txt-c zi-bai weight500 bg-black">';
                                    if(v[i].bq!=null){
                                    xszfleft+='<font size="1">'+v[i].bq+'</font></div>';
                                    }else{
                                    xszfleft+='<font size="1">免费</font></div>';
                                    } 
                                    xszfleft+= '<img src="${ctx}/img/memor-comm.png" width="100%"/></div>'
                                    + '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                    + '<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                    + '<font size="1"><i class="pr-5">热销:</i>'+v[i].gmnum+'<i class="pl-5">件</i></font>'
                                    + '</div></div></div>'
                                    + '<div class="col-12 div-group-5 zi-6 bg-bai weight500">'
                                    + '<font size="1">'
                                    + '<div class="clear pt-3 pb-5 sl">' + v[i].title + ' </div>'
                                    + '</font></div></div>';

                                } else {
                                    xszfright += '<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                    + '<div class="position-r" onclick="checktribute(this,' + v[i]._id + ')">'
                                    + '<div class="position-a img-wh20 border-radius50 txt-c line-green overflow-hidden" style="top: 5px;left:7px;" >'
                                    + '<font size="1"><il class="fa zi-bai line-height18"></il></font></div>'
                                    + '<img src="${filehttp}/' + v[i].picurl + '" class="width-10 border-radius5s"/>'
                                    + '<div class="position-a width-3" style="top: 0px; right:10px;">'
                                    + '<div class="pt-5 txt-c zi-bai weight500 bg-black">';
                                    if(v[i].bq!=null){
                                    xszfright+='<font size="1">'+v[i].bq+'</font></div>';
                                    }else{
                                    xszfright+='<font size="1">免费</font></div>';
                                    } 
                                    xszfright+= '<img src="${ctx}/img/memor-comm.png" width="100%"/></div>'
                                    + '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                    + '<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                    + '<font size="1"><i class="pr-5">热销:</i>'+v[i].gmnum+'<i class="pl-5">件</i></font>'
                                    + '</div></div></div>'
                                    + '<div class="col-12 div-group-5 zi-6 bg-bai weight500">'
                                    + '<font size="1">'
                                    + '<div class="clear pt-3 pb-5 sl">' + v[i].title + '</div>'
                                    + '</font></div></div>';
                                }
                            }
                            fypage++;
                            $('#ajaxdivleft').html(xszfleft);
                            $('#ajaxdivright').html(xszfright);
                        } else {
                        }
                        issend = true;
                    }, "json")
        }
        function ajaxsel() {
            sel = $('#sel').val().replace('搜索', '');
            fypage = 0;
            $('#ajaxdivleft').html('');
            $('#ajaxdivright').html('');
            ajaxjz();
        }
        function checktribute(v, t) {
            if ($(v).find('il').hasClass('fa-check bg-green')) {
                $(v).find('il').removeClass('fa-check bg-green');
                id = id.replace(t + ",", "");
            } else {
                $(v).find('il').addClass('fa-check bg-green');
                id = id + t + ",";
            }
            if (id == '') {
                $('#next').html("直接致悼念词");
            } else {
                $('#next').html("下一步");
            }
        }
        function seltype(t) {
            type = t;
            fypage = 0;
            $('#ajaxdivleft').html('');
            $('#ajaxdivright').html('');
            ajaxjz();
        }

        function submint() {
            var submitData = {
                id: '${id}',
                tribute: id, 
            };
            $.post('${ctx}/suc/memorial!ajaxcommentadd.action?custid=${custid}&lscode=${lscode}', submitData, function (json) {

                if (json.state == 0) {
                    window.location.href = '${ctx}/suc/memorial!commentsave.action?custid=${custid}&lscode=${lscode}&id=${id}&cid=' + json.value;
                }
            }, "json");

        }

    </script>
</head>
<body class="cmp640 bg-hui-98 lock">
<main>
    <div class="pt-10 pb-10 pr-10 line-bottom-92 overflow-hidden cmp640 bg-bai position-f width-10"
         style="z-index: 99;left: 0px;">
        <div class="size14 zi-6 col-2 txt-c" style="line-height: 32px;" onclick="show_type()">分类<i
                class="fa fa-angle-down pl-5 zi-hui"></i></div>
        <div class="pull-left col-8">
            <div class="clear width-10 maring-a txt-c hang30 mt-5 bg-hui position-r"
                 style="border-radius: 5px 0px 0px  5px ;">
                <input class=" width-10 txt-c pt-6 zi-hui " style="background-color: transparent" type="text"
                       id="sel"
                       value="搜索" onfocus="if(value=='搜索'){value=''}"
                       onblur="if (value ==''){value='搜索'}"/>
            </div>
        </div>
        <div class="col-2 txt-c bg-hui hang30" style="border-radius: 0px 5px 5px 0px ;" onclick="ajaxsel()">
            <i class="fa fa-search pt-8 zi-hui"></i>
        </div>
    </div>
    <div class="hang40 clear"></div>
    <!--产品分类-->
    <div class="pl-5 pt-2 pr-5">
        <div class="col-6" style="padding-right:4px;" id="ajaxdivleft"></div>

        <div class="col-6" style="padding-right:4px;" id="ajaxdivright"></div>

    </div>
</main>
<div class="hang70 clear"></div>

<font size="2">
    <div class=" button_foot bg-hui-tx div-group-5 pl-10 pr-10 shadow-wai cmp640" onclick="submint()">
        <div class="button_group1 weight500 txt-c zi-bai">
            <div class="hang40 line-height40 maring-a border-radius5 btn-green" id="next">
                直接致悼念词
            </div>
        </div>
    </div>
</font>

<!--分类-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="t_type">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_type()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                <a href="javascript:seltype(''),hide_type()">
                    <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        全部
                    </div>
                </a>
                <c:forEach items="${typelist}" var="bean">
                    <c:if test="${empty bean.url}">
                        <a href="javascript:seltype('${bean._id}'),hide_type()">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                ${bean.title}
                            </div>
                        </a>
                    </c:if>
                    <c:if test="${not empty bean.url}">
                        <a href="${bean.url}">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                ${bean.title}
                            </div>
                        </a>
                    </c:if>
                </c:forEach>
            </div>
            <a href="javascript:hide_type()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>
<script>
function hide_type() {
    $('#t_type').hide();
 }
function show_type() {
   $('#t_type').show();
}
ajaxjz();
$(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) { 
           ajaxjz();     
        }
 });
 
</script>
</body>
</html>