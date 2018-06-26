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
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <!-- Resource style -->
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <script>


        function xiaoshi() {
            $('#tanchu').hide();
        }
        function xianshi() {
            $('#tanchu').show();
        }
    </script>

    <style>
        .zi-hui-da {
            color: #dadada;
        }

        .bg-zong {
            background: #630601
        }

        .shadow-wai1 {
            box-shadow: 0px 0px 0px rgba(255, 255, 255, .5), /*左边阴影*/ 1px 0px 10px rgba(140, 140, 140, .5), /*右边阴影*/ 0 -1px 5px rgba(140, 140, 140, .5), /*顶部阴影*/ 0 1px 5px rgba(140, 140, 140, .5); /*底边阴影*/
        }

        .border-radius5s {
            border-radius: 5px 5px 0 0;
        }
         .yListr2 .biankuang .div2 {
            background-color: #32d9c0;
            color: #ffffff;
            width: 100%;
        }

        .yListr2 li .div2 {
            height: 35px;
            line-height: 36px;
        }

        .line-32d9c0 {
            border: 1px solid #32d9c0;
            color: #32d9c0;
            border-radius: 200px;
            height: 37px;
        }

        .line-right-32d9c0 {
            border-right: 1px solid #32d9c0;
        }

    </style>
</head>
<script>
 $(function () {
      $(".yListr2 li").click(function () {
          $(this).addClass("biankuang").siblings().removeClass("biankuang");
          var value=$.trim($(this).find('div').html());
          if(value=='摇奖活动'){
            change(1);
          }
          if(value=='投票活动'){
            change(2);
          }
          if(value=='刮刮乐活动'){
            change(3);
          }
          if(value=='0元抢活动'){
            change(4);
          }
          if(value=='砍价活动'){
            change(5);
          }
      })
  })

    var isajax = true;
    var fypage = 0;
    var xszf = "";
    var type = "";
    var lx = 0;
    var vt = 1;
    function ajaxjzyj() {//加载
        if (!isajax) {
            return;
        }

        var submitData = {
            "sel": $('#sel').val(),
            "lx": lx
        };
        isajax = false;
        $.post('${ctx}/suc/totalactivity!ajaxlucky.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                function (json) {
                    var xszfleft = $('#ajaxleft').html();
                    var xszfright = $('#ajaxright').html();
                    if (json.state == 0) {
                        var v = json.list;
                        for (var i = 0; i < v.length; i++) {
                            if (i & 1 != 0) {
                                xszfright+= '<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                + '<div class="position-r"><a href="${ctx}/suc/luckydraw!web.action?custid=${custid}&lscode=${lscode}&lucid=' + v[i]._id + '"><img src="${filehttp}/' + v[i].picurl + '" class="width-10 border-radius5s"></a>'
                                + '<div class="position-a width-3" style="top: 0px; right:10px;">'
                                + '<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">' + v[i].state + '</font></div>'
                                + '<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
                                + '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                + '<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                + '<font size="1"><i class="pr-5">参与人数:</i>' + v[i].pcount + '<i class="pl-5">人</i></font></div></div></div>'
                                + '<a href="#"> <div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
                                + '<div class="clear sl zi-hei-tq">' + v[i].title + '</div>'
                                + '</a></div></div>';


                            } else {


                                xszfleft+= '<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                + '<div class="position-r"><a href="${ctx}/suc/luckydraw!web.action?custid=${custid}&lscode=${lscode}&lucid=' + v[i]._id + '"><img src="${filehttp}/' + v[i].picurl + '" class="width-10 border-radius5s"></a>'
                                + '<div class="position-a width-3" style="top: 0px; right:10px;">'
                                + '<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">' + v[i].state + '</font></div>'
                                + '<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
                                + '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                + '<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                + '<font size="1"><i class="pr-5">参与人数:</i>' + v[i].pcount + '<i class="pl-5">人</i></font></div></div></div>'
                                + '<a href="#"> <div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
                                + '<div class="clear sl zi-hei-tq">' + v[i].title + '</div>'
                                + '</a></div></div>';
                            }

                        }
                        fypage++;
                        $('#ajaxleft').html(xszfleft);
                        $('#ajaxright').html(xszfright);
                    } else {

                    }
                    isajax = true;


                }, "json")

    }
    function ajaxjztp() {//加载
        if (!isajax) {
            return;
        }

        var submitData = {
            "sel": $('#sel').val(),

        };
        isajax = false;
        $.post('${ctx}/suc/totalactivity!ajaxvotolm.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                function (json) {
                    var xszfleft = $('#ajaxleft').html();
                    var xszfright = $('#ajaxright').html();
                    if (json.state == 0) {
                        var v = json.list;
                        for (var i = 0; i < v.length; i++) {
                            if (i & 1 != 0) {
                                xszfright += '<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                + '<div class="position-r"><a href="${ctx }/suc/votelm!index.action?_id=' + v[i]._id + '&custid=${custid}&lscode=${lscode}"><img src="${filehttp}/' + v[i].picurl + '" class="width-10 border-radius5s"></a>'
                                + '<div class="position-a width-3" style="top: 0px; right:10px;">'
                                + '<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">' + v[i].state + '</font></div>'
                                + '<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
                                + '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                + '<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                + '<font size="1"><i class="pr-5">参与人数:</i>' + v[i].pcount + '<i class="pl-5">人</i></font></div></div></div>'
                                + '<a href="#"> <div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
                                + '<div class="clear sl zi-hei-tq">' + v[i].title + '</div>'
                                + '</a></div>';


                            } else {


                                xszfleft += '<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                + '<div class="position-r"><a href="${ctx }/suc/votelm!index.action?_id=' + v[i]._id + '&custid=${custid}&lscode=${lscode}"><img src="${filehttp}/' + v[i].picurl + '" class="width-10 border-radius5s"></a>'
                                + '<div class="position-a width-3" style="top: 0px; right:10px;">'
                                + '<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">' + v[i].state + '</font></div>'
                                + '<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
                                + '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                + '<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                + '<font size="1"><i class="pr-5">参与人数:</i>' + v[i].pcount + '<i class="pl-5">人</i></font></div></div></div>'
                                + '<a href="#"> <div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
                                + '<div class="clear sl zi-hei-tq">' + v[i].title + '</div>'
                                + '</a></div>';
                            }

                        }
                        fypage++;
                        $('#ajaxleft').html(xszfleft);
                        $('#ajaxright').html(xszfright);
                    } else {

                    }
                    isajax = true;


                }, "json")

    }

    function  ajaxact(){
        if (!isajax) {
            return;
        }
        var submitData = {
            "sel": $('#sel').val(),
        };
        isajax = false;
        $.post('${ctx}/suc/activity!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                function (json) {
                    var xszfleft = $('#ajaxleft').html();
                    var xszfright = $('#ajaxright').html();
                    if (json.state == 0) {
                        var v = json.list;
                        for (var i = 0; i < v.length; i++) {
                            if (i & 1 != 0) {
                                xszfright += '<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                + '<div class="position-r"><a href="${ctx }/suc/activity!webdetail.action?id=' + v[i]._id + '&custid=${custid}&lscode=${lscode}"><img src="${filehttp}/' + v[i].picurl + '" class="width-10 border-radius5s"></a>'
                                + '<div class="position-a width-3" style="top: 0px; right:10px;">';
                                if(v[i].type==0){
                                xszfright+='<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">砍价</font></div>';
                                }
                                xszfright+='<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
                                + '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">';
                                if(v[i].jfdh>0){
                                xszfright+='<div class="pull-left zi-bai div-group-5 txt-c zi-bai weight500"><font size="1"><i class="pr-5">发起需:</i>'+v[i].jfdh+' 积分</font></div>';
                                }else{
                                xszfright+='<div class="pull-left zi-bai div-group-5 txt-c zi-bai weight500"><font size="1"><i class="pr-5">发起免费</i></font></div>';
                                }
                                xszfright+='<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                + '<font size="1"><i class="pr-5">剩余:</i>' + v[i].num + '<i class="pl-5"></i></font></div></div>'
                                + '<div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
                                + '<div class="clear sl zi-hei-tq">' + v[i].title + '</div>'
                                +'<div class="pt-5"><font size="2">现价:' + v[i].price.toFixed(2)+'</font><i class="zi-hui pl-10">可砍至:' + v[i].lowprice.toFixed(2) + '</i></div>'
                                + '</div></div></div>';


                            } else {


                                xszfleft += '<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
                                + '<div class="position-r"><a href="${ctx }/suc/activity!webdetail.action?id=' + v[i]._id + '&custid=${custid}&lscode=${lscode}"><img src="${filehttp}/' + v[i].picurl + '" class="width-10 border-radius5s"></a>'
                                + '<div class="position-a width-3" style="top: 0px; right:10px;">';
                                if(v[i].type==0){
                                   xszfleft+='<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">砍价</font></div>';
                                }
                                xszfleft+= '<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
                                + '<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">';
                                if(v[i].jfdh>0){
                                xszfleft+='<div class="pull-left zi-bai div-group-5 txt-c zi-bai weight500"><font size="1"><i class="pr-5">发起需:</i>'+v[i].jfdh+' 积分</font></div>';
                                }else{
                                xszfleft+='<div class="pull-left zi-bai div-group-5 txt-c zi-bai weight500"><font size="1"><i class="pr-5">发起免费</i></font></div>';
                                }
                                xszfleft+='<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                + '<font size="1"><i class="pr-5">剩余:</i>' + v[i].num + '<i class="pl-5"></i></font></div></div>'
                                + '<div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
                                + '<div class="clear sl zi-hei-tq">' + v[i].title + '</div>'
                                +'<div class="pt-5"><font size="2">现价:' + v[i].price.toFixed(2)+'</font><i class="zi-hui pl-10">可砍至:' + v[i].lowprice.toFixed(2) + '</i></div>'
                                + '</div></div></div>';
                            }

                        }
                        fypage++;
                        $('#ajaxleft').html(xszfleft);
                        $('#ajaxright').html(xszfright);
                    } else {

                    }
                    isajax = true;


                }, "json");
    }

    function change(v) {
        vt = v;
        $('#ajaxleft').html('');
        $('#ajaxright').html('');
        if (v == 1) {
            lx = 0;
            fypage = 0;
            ajaxjzyj();
        } else if (v == 3) {
            lx = 1;
            fypage = 0;
            ajaxjzyj();
        } else if (v == 2) {
            fypage = 0;
            ajaxjztp();
        }else if(v==4){
            lx = 2;
            fypage = 0;
            ajaxjzyj();
        }else if(v==5){
            fypage = 0;
            ajaxact();
        }
    }

</script>
<body class="cmp640 bg-hui-98 lock">
<main>
    <c:if test="${not empty slide}">
        <div id="banner_box" class="box_swipe overflow-hidden position-r" style="width:100%">
            <ul>
                <c:forEach items="${slide}" var="bean">
                    <li>
                        <a href="${bean.url}">
                            <img src="${filehttp}/${bean.picurl}" alt="1" style="width:100%;"/>
                        </a>
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
            });
        </script>
    </c:if>


    <c:if test="${not empty user.isadmin}">
        <div class="pl-5 pr-5 pt-10 clear">
            <a href="${ctx}/suc/luckydraw!webadd.action?custid=${custid}&lscode=${lscode}">
                <div class="btn-lu txt-c div-group-10 weight500 zi-bai border-radius5">
                    <font size="2">
                        活动发起
                    </font>
                </div>
            </a>
        </div>
    </c:if>


    <!--早期导航不能动-->
    <div class="div-group-5 pt-20">
        <!--<div class="size14 weight500 pt-15 pb-10" style="padding-left: 2px;">活动选择</div>-->
        <font size="1">
            <div class=" width-10 bg-bai weight500 overflow-hidden yListr2 line-32d9c0">
                <li class="button_group1" id="yj">
                    <div class="div2 txt-c width-10 line-right-32d9c0">
                        摇奖活动
                    </div>
                </li>
                <li class="button_group1" id="tp">
                    <div class="div2 txt-c width-10 line-right-32d9c0">
                        投票活动
                    </div>
                </li>
                <li class="button_group1" id="ggl">
                    <div class="div2 txt-c width-10 line-right-32d9c0">
                        刮刮乐活动
                    </div>
                </li>
                <li class="button_group1" id="0yq">
                    <div class="div2 txt-c width-10 line-right-32d9c0">
        0元抢活动
                    </div>
                </li>
                <li class="button_group1" id="kj">
                    <div class="div2 txt-c width-10">
                       砍价活动
                    </div>
                </li>

            </div>
        </font>

    </div>
    <!--早期导航不能动结束-->

    <div class="pl-5 pr-5">
        <div class="col-6" style="padding-right: 5px;" id="ajaxleft">

        </div>
        <div class="col-6" style="padding-left: 5px;" id="ajaxright">

        </div>
    </div>

    <div class="clear hang50"></div>
    <%@ include file="/webcom/lucky-foot.jsp" %>
</main>
<script type="text/javascript">
  if('${type}'>1){
    vt='${type}';
  }
   if (vt == 1) {
        lx = 0;
        $('#yj').addClass("biankuang");
        ajaxjzyj(); 
     } else if (vt == 2) { 
        $('#tp').addClass("biankuang");
        ajaxjztp();
     } else if (vt == 3) {
        lx =1;
        $('#ggl').addClass("biankuang");
        ajaxjzyj();
     }else if(vt == 4){
        lx =2;
        $('#0yq').addClass("biankuang");
        ajaxjzyj();
     }else if(vt == 5){
        $('#kj').addClass("biankuang");
        ajaxact();
 }
    $(window).scroll(function () {

        var offsetY = $(window).scrollTop();

        var section1 = $("#section1").height();

        if (section1 - offsetY < 600) {
            if (vt == 1) {
                lx = 0;
                ajaxjzyj();
            } else if (vt == 3) {
                lx =1;

                ajaxjzyj();
            } else if (vt == 2) {

                ajaxjztp();
            }else if(vt == 4){
                lx =2;
                ajaxjzyj();
            }else if(vt == 5){
                ajaxact();
            }
        }

    });

</script>

<script>
    function  check_task(){
       var submitData = { 
                type:"allshare",
            };
            $.post('${ctx}/suc/bbs!ajaxCheckTask.action?custid=${custid}&&lscode=${lscode}', submitData,

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
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if>
</c:if>
</body>
</html>