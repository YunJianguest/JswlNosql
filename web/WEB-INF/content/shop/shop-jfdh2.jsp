<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
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
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/style_0.css" rel="stylesheet"> 
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx }/mvccol/js/mtlb.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/swipe.js"></script>
    <script>
        $(function () {
            new Swipe(document.getElementById('banner_box'), {
                speed: 500,
                auto: 3000,
                callback: function () {
                    var lis = $(this.element).next("ol").children();
                    lis.removeClass("on").eq(this.index).addClass("on");
                }
            });
        });
        function xiaoshi() {
            $('#tanchu').hide();
        }
        function xianshi() {
            $('#tanchu').show();
        }
        function fl_xiaoshi() {
            $('#fl_tanchu').hide();
        }
        function fl_xianshi() {
            $('#fl_tanchu').show();
        }
        $(function () {
            $(".yListr3 li").click(function () {
                $(this).addClass("zhiding").siblings().removeClass("zhiding");
            })
        })
    </script>
    <script>
        var issend = true;
        var fypage = 0;
        var xszf = "";
        var type = "";
        var lx = "";
        var sel = "";
        function ajaxjz() {//加载
            if (!issend) {
                return;
            }
            var submitData = {
                "cid": '${entity._id}',
                "lx": lx,
                "sel": sel
            };
            issend = false;
            $.post('${ctx}/shop/shop!ajaxweb.action?custid=${custid}&agid=${agid}&fypage=' + fypage, submitData,
                    function (json) {
                        var xszfleft = $('#ajaxdivleft').html();
                        var xszfright = $('#ajaxdivright').html();
                        if (json.state == 0) {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                            if (i & 1 != 0) {
                                    xszfleft += '<a href="${ctx}/shop/shop!shopproduct.action?custid=${custid}&agid=${agid}&lscode=${lscode}&pid=' + v[i]._id + '"><div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                    + '<div class="position-r"><img src="${filehttp}' + v[i].logo + '" class="width-10 border-radius5s">';
                                    if(v[i].bq==11){
                                        xszfleft +='<div class="position-a width-3" style="top: 0px; right:10px;">'
                                        + '<div class="pt-5 txt-c zi-bai weight500 bg-zong">'
                                        + '<font  size="1">积分兑换</font>'
                                        + '</div> <div class="">'
                                        + '<img src="${ctx}/mvccol/img/shop.png" width="100%"></div></div>';
                                    } 
                                    xszfleft += '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                    + '<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                    + '<font size="1"><i class="pr-5">剩余:</i>' + v[i].num + '<i class="pl-5">件</i></font>'
                                    + '</div></div></div>'
                                    + '<div class="col-12 div-group-5 zi-6 bg-bai weight500">'
                                    + '<font size="1"><div class="clear sl">' + v[i].ptitle + '</div>' 
                                    + '<div class="pt-3"> 积分:' + v[i].jfdh.toFixed(2) 
                                    + '</div></font></div></div></a>';
                                } else {
                                    xszfright += '<a href="${ctx}/shop/shop!shopproduct.action?custid=${custid}&agid=${agid}&lscode=${lscode}&pid=' + v[i]._id + '"><div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                    + '<div class="position-r">'
                                    + '<img src="${filehttp}' + v[i].logo + '" class="width-10 border-radius5s">';
                                    if(v[i].bq==11){
                                        xszfright +='<div class="position-a width-3" style="top: 0px; right:10px;">'
                                        + '<div class="pt-5 txt-c zi-bai weight500 bg-zong">'
                                        + '<font  size="1">积分兑换</font>'
                                        + '</div> <div class="">'
                                        + '<img src="${ctx}/mvccol/img/shop.png" width="100%"></div></div>';
                                    }
                                    
                                    xszfright +=  '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                    + '<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                    + '<font size="1"><i class="pr-5">剩余:</i>' + v[i].num + '<i class="pl-5">件</i></font>'
                                    + '</div></div></div>'
                                    + '<div class="col-12 div-group-5 zi-6 bg-bai weight500">'
                                    + '<font size="1"><div class="clear sl">' + v[i].ptitle + '</div>'
                                    + '<div class="pt-3"> 积分:' + v[i].jfdh.toFixed(2) 
                                    + '</div></font></div></div></a>';
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
        function ajaxtg() {
            var submitData = {
                "comid": '${entity._id}'
            };
            $.post('${ctx}/shop/shop!ajaxgettg.action?custid=${custid}&agid=${agid}&fypage=' + fypage, submitData,
                    function (json) {
                        var sxfs = $('#ajaxtg').html();
                        if (json.state == 0) {
                            var v = json.list;
                            for (var i = 0; i < v.length; i+=3) {
                                sxfs+='<div class="width-10 overflow-hidden">';
                                if(v[i].lx==1){
                                    sxfs+='<div class="col-6 line-bottom line-right overflow-hidden" style="height:180px;">'
                                    +'<font size="2">'
                                    +'<div class="pt-5 pl-5 hang20">'
                                    +'<div class=" weight500" style="color: #333333;">四字真言</div>'
                                    +'</div></font>'
                                    +'<font size="1">'
                                    +'<div class="pt-5 pl-5 hang20 zi-hui-tq">'
                                    +'<div class=" weight500">四字真言</div>'
                                    +'</div></font>'
                                    +'<div class=" maring-a" style="width:140px;height:140px;"><img src="img/mote2.png" width="100%"></div>'
                                    +'</div>';
                                }
                                sxfs+='<div class="col-6 line-bottom line-right overflow-hidden" style="height:180px;">';
                                if(v[i].lx==2){
                                    sxfs+='<div class="clear hang90 line-bottom"><div class="col-6 pl-5">'
                                    +' <font size="2">'
                                    +'<div class="pt-5 hang30">'
                                    +'<div class="width-10 sl weight500" style="color: #333333;">标题标题标题1</div></div></font>'
                                    +'<font size="1">'
                                    +'<div class=" hang30 zi-hui-tq">'
                                    +'<div class="width-10 sl weight500">简介简介简介1</div>'
                                    +'</div></font></div>'
                                    +'<div class="col-6 div-group-5">'
                                    +'<div class="img-wh80 pull-right">'
                                    +'<img src="img/mote2.png" width="100%"></div></div></div>';
                                }
                                if(v[i].lx==3){
                                    sxfs+='<div class="clear hang90 line-bottom">'
                                    +'<div class="col-6 pl-5">'
                                    +'<font size="2">'
                                    +'<div class="pt-5 hang30">'
                                    +'<div class="width-10 sl weight500" style="color: #333333;">标题标题标题2</div></div></font>'
                                    +'<font size="1"><div class="pt-5 hang30 zi-hui-tq"> <div class="width-10 sl weight500">简介简介简介2</div></div></font></div>'
                                    +' <div class="col-6 div-group-5">'
                                    +'<div class="img-wh80 pull-right">'
                                    +'<img src="img/mote2.png" width="100%"></div></div></div>';
                                }
                                sxfs+='</div></div>';
                            }
                            fypage++;
                            $('#ajaxtg').html(sxfs);
                        } else {
                        }
                    }, "json");
        }
        function fxsel(v) {
            $('#fl_tanchu').hide();
            lx = v;
            fypage = 0;
            $('#ajaxdivleft').html('');
            $('#ajaxdivright').html('');
            ajaxjz();
        }
        function ajaxsel() {
            sel = $('#sel').val().replace('搜索', '');
            fypage = 0;
            $('#ajaxdivleft').html('');
            $('#ajaxdivright').html('');
            ajaxjz();
        }
    </script>
    <style>
        .bg-zong {
            background: #630601
        }
        .border-radius5s {
            border-radius: 5px 5px 0 0;
        }
        .yListr3 .zhiding .div3 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }
        .bg-zong {
            background: #630601
        }
        .shadow-wai1 {
            box-shadow: 0px 0px 0px rgba(255, 255, 255, .5), /*左边阴影*/ 1px 0px 10px rgba(140, 140, 140, .5), /*右边阴影*/ 0 -1px 5px rgba(140, 140, 140, .5), /*顶部阴影*/ 0 1px 5px rgba(140, 140, 140, .5); /*底边阴影*/
        }
        .line-left-green {
            border-left: 5px solid #ec5254;
        }
        .sc-hong {
            background-color: #ec5254
        }
        .line-height35 {
            line-height: 35px;
        }
    </style>
</head>
<body class="cmp640 bg-hui-98 lock">
<main style="position: relative">
    <c:if test="${empty entity.searchcolor }">
        <div class="pt-5 pb-5 pr-5 overflow-hidden pl-5 bg-hui-qj cmp640 position-f width-10"
             style="z-index: 99;left: 0px;">
            <div class=" overflow-hidden border-radius5 bg-hui-qj line-lu">
                <div class="col-10 bg-bai" style="height: 25px;">
                    <input class=" width-10 txt-c line-height35 zi-hui" style="background-color: transparent;line-height: 25px;"
                           type="text" id="sel" value="搜索" onfocus="if(value=='搜索'){value=''}"
                           onblur="if (value ==''){value='搜索'}">
                </div>
                <a href="javascript:ajaxsel()">
                    <div class="col-2 txt-c bg-bai" style="height: 25px;">
                        <i class="fa fa-search zi-hui" style="line-height: 25px;"></i>
                    </div>
                </a>
            </div>
        </div>
    </c:if>
    <c:if test="${not empty entity.searchcolor }">
        <div class="pt-5 pb-5 pr-5 overflow-hidden pl-5 cmp640 position-f width-10"
             style="z-index: 99;left: 0px;background-color:#${entity.searchcolor}">
            <div class=" overflow-hidden border-radius5 bg-hui-qj line-lu">
                <div class="col-10 bg-bai" style="height: 25px;">
                    <input class=" width-10 txt-c line-height35 zi-hui" style="background-color: transparent;line-height: 25px;"
                           type="text" id="sel" value="搜索" onfocus="if(value=='搜索'){value=''}"
                           onblur="if (value ==''){value='搜索'}">
                </div>
                <a href="javascript:ajaxsel()">
                    <div class="col-2 txt-c bg-bai" style="height: 25px;">
                        <i class="fa fa-search zi-hui" style="line-height: 25px;"></i>
                    </div>
                </a>
            </div>
        </div>
    </c:if>
    <div class="clear" style="height: 37px;"></div>
    <c:if test="${not empty slide}">
        <div id="banner_box" class="box_swipe overflow-hidden position-r" style="width:100%">
            <ul>
                <c:forEach items="${slide}" var="bean">
                  <li> 
                     <c:if test="${empty bean.mp4url}">
                         <a href="${bean.url}">
                            <img src="${filehttp}/${bean.picurl}" alt="1" style="width:100%;"/>
                         </a>
                        </c:if>
                        <c:if test="${not empty bean.mp4url}">
                          <iframe frameborder="0" width="500" height="375" src="${bean.mp4url}" allowfullscreen></iframe>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <script>
            $(function () {
                new Swipe(document.getElementById('banner_box'), {
                    speed: 500,
                    auto: 3000,
                    callback: function () {
                        var lis = $(this.element).next("ol").children();
                        lis.removeClass("on").eq(this.index).addClass("on");
                    }
                });
                  $('#banner_box').find('iframe').load(function(){
                  var mainwidth =$(document.body).width();
                  var mainheight=mainwidth*9/16;
                  $(this).width(mainwidth);
                  $(this).height(mainheight);
                 });
            });
        </script>
    </c:if>
    <c:if test="${not empty typelist}">
	<div class="page--index export  pb-15" >
    	<div class="hero-gallery js-flickity pb-5" data-js-module="hero-gallery">
            <div class="hero-gallery__cell hero-gallery__cell overflow-hidden">
                <div class="width-10">
                    <div class="overflow-hidden border-radius5"> 
           				<c:forEach items="${typelist}" var="bean"  begin="0" end="7">
                         <c:if test="${not empty bean.url}">
                        <div class="col-3 mt-10" onclick="window.location.href='${bean.url}'"> 
                                <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                     <img src="${filehttp }${bean.picurl}" width="100%" height="100%"></img> 
                                </div>
                                <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                         </div>
                       </c:if>
                      <c:if test="${empty bean.url}"> 
                         <div class="col-3 mt-10" onclick="fxsel('${bean.type}')">
                               <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                    <img src="${filehttp }${bean.picurl}" width="100%" height="100%"></img> 
                                </div>
                                <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                         </div>
                     </c:if>
                     </c:forEach>
            		</div> 
                </div>
            </div>
             <c:if test="${fn:length(typelist)>8}">
             <div class="hero-gallery__cell hero-gallery__cell overflow-hidden">
                <div class="width-10">
                    <div class="overflow-hidden border-radius5"> 
           				<c:forEach items="${typelist}" var="bean"  begin="8" end="15">
                         <c:if test="${not empty bean.url}">
                        <div class="col-3 mt-10" onclick="window.location.href='${bean.url}'"> 
                                <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                    <img src="${filehttp }${bean.picurl}" width="100%" height="100%"></img> 
                                </div>
                                <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                         </div>
                       </c:if>
                      <c:if test="${empty bean.url}"> 
                         <div class="col-3 mt-10" onclick="fxsel('${bean.type}')">
                               <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                    <img src="${filehttp }${bean.picurl}" width="100%" height="100%"></img> 
                                </div>
                                <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                         </div>
                     </c:if>
                     </c:forEach>
            		</div> 
                </div>
            </div>
            </c:if>
    	</div>
	</div> 
	</c:if>
    <div id="ajaxtg">
    </div>
    <font size="2">
        <div class="div-group-5 pt-10 pb-10 bg-hui-tx position-r">
            <div class="line-left-green"><i class="pl-10">推荐商品</i></div>
            <div class="position-a overflow-hidden"style="left:80px;top:0px;height:37px;line-height:37px;">
                <c:if test="${not empty roll}">
                    <%@ include file="/webcom/roll.jsp" %>
                </c:if>
            </div>
        </div>
    </font>
    <div class="div-group-5">
        <div class="col-6" style="padding-right: 5px;" id="ajaxdivleft">
        </div>
        <div class="col-6" style="padding-left: 5px;" id="ajaxdivright">
        </div>
    </div>
    <%@include file="/webcom/foot.jsp" %>
</main>
<%@include file="/webcom/return-top.jsp" %>
<div class="hang50 clear"></div>
<%@ include file="/webcom/shop-foot.jsp"%>
<script>
    function  check_task(){
       var submitData = { 
                type:"allshare",
            };
            $.post('${ctx}/suc/bbs!ajaxCheckTask.action?custid=${custid}&agid=${agid}&&lscode=${lscode}', submitData,

                    function (json) { 
                        if (json.state == 0) {
                            var text='分享成功!'; 
                            if(json.expreward>0){
                                text+="经验+"+json.expreward+" "
                            }
                            if(json.jfreward>0){
                                text+="积分+"+json.jfreward
                            } 
                          swal({
                                text: text,
                                timer: 2000,
                                type: 'success',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        }  
                    }, "json");
     
     }
</script> 
<script>
    ajaxjz();
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) {
            ajaxjz();
        }
    });
    wx.config({
        debug: false,
        appId: '${token.appid}',
        timestamp: '${token.timestamp}',
        nonceStr: '${token.noncestr}',
        signature: '${token.signature}',
        jsApiList: [ 'checkJsApi',
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo',
            'hideMenuItems',
            'showMenuItems'
        ]
    });
    wx.ready(function(){
        var share={
            title: '${share.fxtitle}', // 分享标题
            desc: '${share.fxsummary}', // 分享描述
            link: '${share.fxurl}', // 分享链接
            imgUrl: '${filehttp}${share.fximg}', // 分享图标
            success: function () {
             check_task();
            },
            cancel: function () {
            }
        };
        wx.onMenuShareAppMessage(share);
        wx.onMenuShareTimeline(share);
        wx.onMenuShareAppMessage(share);
        wx.onMenuShareQQ(share);
        wx.onMenuShareWeibo(share);
    });
</script>
<c:if test="${not empty com.ewmurl}">
 <c:if test="${com.ewmxs==0}">
  <%@ include file="/webcom/focus-page.jsp" %>
 </c:if>
</c:if>
</body>
</html> 