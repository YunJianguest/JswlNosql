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
    <title>${title}</title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <!-- Resource style -->
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/swipe.js"></script>
    <script>
        function phb_xiaoshi() {
            $('#phb_tanchu').hide();
        }
        function phb_xianshi() {
            $('#phb_tanchu').show();
        }
        function yd() {
            var submitData = {
                id: '${entity.obj._id}',
            };
            $.post('${ctx}/suc/activity!ajaxyd.action?lscode=${lscode}&custid=${custid}', submitData,
                    function (json) { 
                        if (json.state == 0) {
                           swal({
                                text: '恭喜您预订成功！共花费 ${entity.obj.jfdh}积分',
                                timer: 2000,
                                type: 'success',
                                showConfirmButton: false
                             }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {
                                            window.location.href = '${ctx}/suc/activity!webyd.action?id=' + json.value + '&custid=${custid}&lscode=${lscode}';
                                        }
                                    }
                            ); 

                        } else if (json.state == 2) {
                            swal({
                                text: '您已经预定了该商品！',
                                timer: 2000,
                                type: 'warning',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {
                                            window.location.href = '${ctx}/suc/activity!webyd.action?id=' + json.value + '&custid=${custid}&lscode=${lscode}';
                                        }
                                    }
                            );
                        } else if(json.state==1){
                            swal({
                                text: '亲，来迟了一步，库存已完，请查看其它商品！',
                                timer: 2000,
                                type: 'warning',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        }else if(json.state==3){
                             swal({ 
                               text: "亲，您积分不足，您可以查看其它产品或者赚取积分！",
                               type: 'warning',
                               showCancelButton: true,
                               confirmButtonColor: '#3085d6',
                               cancelButtonColor: '#d33',
                               confirmButtonText: '去赚积分',
                               cancelButtonText: '稍后再说',
                               confirmButtonClass: 'btn btn-success mr-15',
                               cancelButtonClass: 'btn btn-danger ml-15',
                                   buttonsStyling: false
                             }).then(function () {
                                   window.location.href='${ctx}/suc/task!web.action?custid=${custid}&lscode=${lscode}';
                                   
                            }, function (dismiss) {
                           // dismiss can be 'cancel', 'overlay',
                           // 'close', and 'timer'
                             if (dismiss === 'cancel') {
                                  
                                 }
                            });
                        }
                    }, "json");
        }
        function kj() {
            var submitData = {
                id: '${entity._id}',
            };
            $.post('${ctx}/suc/activity!ajaxplay.action?lscode=${lscode}&custid=${custid}', submitData,
                    function (json) { 
                        if (json.state == 0) {
                            var html='<div class="txt-c weight500 width-10">花费${entity.obj.jfcy}积分 成功帮${entity.nickname}砍掉：<i>'+json.value.toFixed(2)+'</i>元</div>';
                            show_kj();
                            animo_bg('anim_kj','bargain-bg',700);
                            setTimeout(function () {
                                $("#kjprice").html(html);  
                            }, 2000); 
                            setTimeout(function () {
                                hide_kj();
                                window.location.href = '${ctx}/suc/activity!webyd.action?id=${entity._id}&custid=${custid}&lscode=${lscode}';
                            }, 5000);

                        } else if (json.state == 2) {
                            swal({
                                text: '已经到底了，不能再砍了！',
                                timer: 2000,
                                type: 'warning',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        } else if (json.state == 1) {
                            swal({
                                text: '该商品已经被领空了，请查看其它商品！',
                                timer: 2000,
                                type: 'warning',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        } else if (json.state == 3) {
                            swal({
                                text: '您已经砍过该商品了！',
                                timer: 2000,
                                type: 'warning',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        } else if (json.state == 4){
                            swal({ 
                               text: "亲，您积分不足，您可以查看其它产品或者赚取积分！",
                               type: 'warning',
                               showCancelButton: true,
                               confirmButtonColor: '#3085d6',
                               cancelButtonColor: '#d33',
                               confirmButtonText: '去赚积分',
                               cancelButtonText: '稍后再说',
                               confirmButtonClass: 'btn btn-success mr-15',
                               cancelButtonClass: 'btn btn-danger ml-15',
                                   buttonsStyling: false
                             }).then(function () {
                                   window.location.href='${ctx}/suc/task!web.action?custid=${custid}&lscode=${lscode}';
                                   
                            }, function (dismiss) {
                           // dismiss can be 'cancel', 'overlay',
                           // 'close', and 'timer'
                             if (dismiss === 'cancel') {
                                  
                                 }
                            });
                        }else{ 
                          swal({
                                text: '砍价异常！',
                                timer: 2000,
                                type: 'warning',
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
         
        var fypage = 0;
        function gmlb() {
            var submitData = {
                id: '${entity.obj._id}',
            };
             $.post('${ctx}/suc/activity!ajaxydweblist.action?lscode=${lscode}&custid=${custid}&fypage='+fypage, submitData,
                    function (json) {
                        var html = $('#ajaxgmdiv').html();
                        if (json.state == 0) {
                            var list = json.list;
                            for (var i = 0; i < list.length; i++) {
                                html += '<div class="overflow-hidden txt-l weight500 pt-3 pb-5">'
                                + '<div class="zi-hei" style="line-height:17px;">'
                                + '<i class="zi-bai">' + list[i].nickname + '</i> 在' + list[i].createdate + '参与了该活动！</div></div>';
                            }
                            fypage++;
                        }
                        $('#ajaxgmdiv').html(html);


                    }, "json");
        } 
        var tpage=0;
        function kjlb() {
            var submitData = {
                id: '${entity._id}',
            };
             $.post('${ctx}/suc/activity!ajaxdetailweb.action?lscode=${lscode}&custid=${custid}&fypage='+tpage, submitData,
                    function (json) { 
                        var html = $('#ajaxdiv').html();
                        if (json.state == 0) {
                            var list = json.list;
                            for (var i = 0; i < list.length; i++) {
                                html += '<div class="overflow-hidden txt-c weight500 hang40 line-bottom-bai">'
                                + '<div class="col-2 pt-5 pb-5">'
                                + '<div class="maring-a img-wh30 img-bj border-radius50" style="background-image: url(${filehttp}/' + list[i].headimgurl + ');"></div> </div>'
                                + '<div class="col-10 sl zi-bai txt-l" style="line-height: 40px;"><font size="1"><i>' + list[i].nickname + '</i>以迅雷不及掩耳之势成功砍掉' + list[i].kjprice.toFixed(2) + '元</font></div></div>';
                            }
                            tpage++;
                        }
                         $('#ajaxdiv').html(html);
                        if (html != '') {
                            $('#defaultdiv').hide();
                            $('#ajaxdiv').show();
                        }


                    }, "json");
        } 
        function hide_kj() {
            $("#kj_tc").hide();
        }
        function show_kj() {
            $("#kj_tc").show();
        }
        function  animo_bg(id,img,time){
            setTimeout(function () {
                $("#"+id).attr("src","${ctx}/img/"+img+"2.png");
            }, 2*time);
            setTimeout(function () {
            $("#"+id).attr("src","${ctx}/img/"+img+"3.png");
            }, 3*time);
          setTimeout(function () {
            $("#"+id).attr("src","${ctx}/img/"+img+"4.png");
            }, 4*time);
         
           setTimeout(function () {
            $("#"+id).attr("src","${ctx}/img/"+img+"5.png");
            }, 5*time);
            setTimeout(function () {
             var html='<audio src="${ctx}/mp3/bargain.mp3" autoplay="autoplay"></audio>'
             $("#"+id).append(html);
           }, 1.5*time);
        }
    </script>
    <style>
        .hang25 {
            height: 25px;
            line-height: 25px;
        }

        .img-100 img {
            width: 100%
        }

        /*排行版三角形*/
        .arrow {
            width: 0px;
            height: 0px;
            border-width: 15px;
            border-style: solid;
            border-color: #ec5254 transparent transparent #ec5254;
        }

        .button_group1 {
            width: 2000px;
            display: table-cell;
        }

        .sc-hong {
            background-color: #ec5254;
        }

        .zi-sc-hong {
            color: #ec5254;
        }

        .btn-sc-hong {
            background-color: #ec5254;
        }

        .btn-sc-hong:hover {
            background-color: #d94c4e;
        }

        .bg-hei-6 {
            background-color: rgba(30, 30, 30, 0.6);
        }

        .line-bottom-bai {
            border-bottom: solid 1px white;
        }

        /*行数限制文本超出隐藏*/
        .hang-sl-2 {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
    </style>
</head>
<body class="cmp640 lock">
<main>

    <!--动画-->
    <div class="fullscreen cmp640 lock pb-10 bg-hei-5 display-none" id="kj_tc">
        <div class="position-r overflow-hidden animated slideInDown">
            <div class="img-wh30 bg-bai txt-c position-a border-radius50" style="top:10%;right:5%;"
                 onclick="hide_kj()"><i class="fa fa-close line-height30 zi-hui"></i></div>
            <div class="width-9 maring-a overflow-hidden position-r" style="margin-top:25%;" >
                <img src="${ctx}/img/bargain-bg1.png" class="width-10" id="anim_kj">

                <div class=" position-a width-10 position-r overflow-hidden" style="bottom:-8px;">
                    <div class="width-8 maring-a">
                        <img src="${ctx}/img/bargain-title.png" class="width-10">
                    </div>
                    <font size="2">
                        <div class="zi-bai position-a width-10 maring-a overflow-hidden" style="top:5%;" id="kjprice">
                           
                        </div>
                    </font>
                </div>
            </div>

        </div>
    </div>
    <!--结束-->
    <c:if test="${not empty com.ewmurl}">
        <c:if test="${com.ewmxs==0}"> 
            <%@ include file="/webcom/focus-page.jsp" %>
        </c:if>
    </c:if>
    <!--弹出层排行榜-->
    <div class="fullscreen cmp640 bg-hei-5 display-none lock pb-10" id="phb_tanchu">
        <div class="position-r overflow-hidden width-10">
            <a href="javascript:phb_xiaoshi()">
                <div class="width-10 overflow-hidden" style="height:1000px;"></div>
            </a>

            <div class="position-a width-7 position-r overflow-hidden sc-hong div-group-10 border-radius5"
                 style="top:7%;left:15%;height: 400px;overflow: auto;">
                <div class="position-a hang50 overflow-hidden sc-hong width-10"
                     style="top: 0px; left: 0px;border-radius: 5px 5px 0px 0px;">
                    <div class="pt-10">
                        <div class="hang40 width-5 maring-a bj-hong1 txt-c zi-bai weight500 line-height40"
                             style="border-radius: 50px;"><font size="3">砍价排行榜</font></div>
                    </div>
                </div>
                <a href="javascript:phb_xiaoshi()">
                    <div class="position-a img-wh50 zi-bai txt-r div-group-10" style="top: 0px; right: 0px;">
                        <i class="fa fa-close fa-1dx"></i>
                    </div>
                </a>

                <div class="pt-50 weight500 zi-bai overflow-hidden" style="height:375px;overflow: auto;">
                    <font size="2" id="ajaxgmdiv">

                    </font>
                </div>
            </div>
        </div>
    </div>
    <!--结束-->
    <div class="width-10 position-r">
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

        <div class="position-a" style="bottom: 0px; left: 0px;">
            <img src="${ctx}/mvccol/img/fgyd.png" class="width-10">
        </div>
    </div>

    <div class="width-10 div-group-10 pt-30 hang60">
        <font size="2">
            <div class="pull-left col-12 bg-hei-6 position-r" style="border-radius: 50px;">
                <div class="position-r hang25 sc-hong zi-bai" style="border-radius: 50px;width:${entity.bl}%">
                    <div class="pull-left pl-5 hang25 overflow-hidden" style="line-height:28px"><font
                            size="2"><fmt:formatNumber value='${entity.obj.lowprice}' pattern="0.0#"/>元</font>
                    </div>
                    <div class="position-a position-r" style="top:-28px;right:-5px;">
                        <div class="sc-hong zi-bai overflow-hidden hang25"
                             style="line-height: 21px;padding-left:5px;padding-right:5px;border-radius: 5px 5px 0px 5px;">
                            <font size="1"><fmt:formatNumber value='${entity.obj.price}' pattern="0.0#"/>元</font>
                        </div>
                        <div class="position-a" style="bottom:-11px;right:0px;">
                            <div class="zi-sc-hong">
                                <font size="4"><i class="fa fa-caret-down"></i></font>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="position-a pr-5 zi-bai" style="top: 0px; right: 0px;">
                    <div class="pull-right hang25 overflow-hidden" style="line-height: 28px;">
                        <font size="2"><fmt:formatNumber value='${entity.oldprice}' pattern="0.0#"/>元</font>
                    </div>
                </div>
            </div>
        </font>
    </div>

    <div class="div-group-10">
        <div class="zi-6 overflow-hidden txt-c weight500 hang50">
            <div class="col-2 pt-5 pb-5">
                <div class="maring-a img-wh40 img-bj border-radius50"
                     style="background-image: url(${filehttp}/${entity.headimgurl});"></div>
            </div>
            <div class="col-10 zi-hei txt-l pt-8 hang-sl-2" style="line-height:20px;"><font
                    size="2"><i>${entity.nickname}</i>还差<fmt:formatNumber value='${entity.obj.price}' pattern="0.0#"/>元即可获得${entity.pro.ptitle}，快来帮他砍价吧！
            </font>
            </div>
        </div>

    </div>

    <div class="pt-20 pb-25 div-group-10 overflow-hidden">
        <div class="col-6" onclick="yd()">
            <div class="width-9 hang40 maring-a  btn-cheng zi-bai txt-c"
                 style="border-radius: 50px;line-height: 40px;">
                <font size="3">
                    我也要参与
                </font>
            </div>
        </div>

        <div class="col-6" onclick="kj()">
            <div class="width-9 hang40 maring-a btn-sc-hong zi-bai txt-c"
                 style="border-radius: 50px; line-height: 40px;">
                <font size="3">
                    为好友砍价
                </font>
            </div>
        </div>
    </div>


    <div class="overflow-hidden pt-5 clear">
        <div class="sc-hong" style="height:3px;"></div>
        <div class="pt-2">
            <font size="2">
                <div class="pull-left sc-hong hang30 pl-10 pr-10 zi-bai weight500" style="line-height:32px;">
                    砍友砍价信息
                </div>
                <div class="arrow pull-left"></div>
            </font>
        </div>
    </div>
    <div class="border-radius5 div-group-10 clear" id="section1">
        <div class=" border-radius5 sc-hong mt-20 mb-20" id="ajaxdiv"
             style="height: 190px;overflow: auto;display: none;"></div>
        <div class="clear txt-c zi-hui size14" id="defaultdiv">
            <div class="pt-10">
                <i class="fa fa-tags fa-6x"></i>
            </div>
            <div class="pt-20 pb-20">
                暂无砍友帮忙砍价
            </div>
        </div>
    </div>

    <div class="overflow-hidden clear">
        <div class="sc-hong" style="height:3px;"></div>
        <div class="pt-2">
            <font size="2">
                <div class="pull-left sc-hong hang30 pl-10 pr-10 zi-bai weight500" style="line-height:32px;">
                    活动详情
                </div>
                <div class="arrow pull-left"></div>
            </font>
        </div>
    </div>

    <div class="border-radius5 div-group-10 pt-20 clear img-100">
        ${entity.obj.content}
    </div>

    <div class="hang60 clear"></div>
    <!--底部button-->
    <div class=" button_foot cmp640 shadow-wai weight500" style="bottom:0px;">
        <div class="button_group1">
            <a href="${ctx}/suc/totalactivity!web.action?custid=${custid}&lscode=${lscode}">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-home"></div>
                    </font>

                    <div class=" pt-3">
                        <font size="1">
                            活动首页
                        </font>
                    </div>
                </div>
            </a>
        </div>
        <div class="button_group1">
            <a href="javascript:phb_xianshi()">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-signal"></div>
                    </font>

                    <div class=" pt-3">
                        <font size="1">
                            砍价排行榜
                        </font>
                    </div>
                </div>
            </a>
        </div> 
        <div class=" button_group1">
            <a href="${ctx}/suc/activity!webydlb.action?custid=${custid}&lscode=${lscode}">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-gift"></div>
                    </font>

                    <div class=" pt-3">
                        <font size="1">
                            参与的活动
                        </font>
                    </div>
                </div>
            </a>
        </div>
        <div class=" button_group1">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5"
            onclick="window.location.href='${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}'">
                <font size="4">
                    <div class="fa fa-money"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                        我的卡卷
                    </font>
                </div>
            </div>
        </div>
        <div class=" button_group1">
            <a href="${ctx}/user/fromuser!UserDetail.action?custid=${custid}&lscode=${lscode}">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-user"></div>
                    </font>

                    <div class=" pt-3">
                        <font size="1">
                            个人中心
                        </font>
                    </div>
                </div>
            </a>
        </div>
    </div>
</main>
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
    gmlb();
    kjlb();
    $("#section1").scroll(function () {
        var offsetY = $("#section1").scrollTop();
        if (offsetY > 300) {
            kjlb();
        }
    });
    wx.config({
        debug: false,
        appId: '${token.appid}',
        timestamp: '${token.timestamp}',
        nonceStr: '${token.noncestr}',
        signature: '${token.signature}',
        jsApiList: ['checkJsApi',
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo',
            'hideMenuItems',
            'showMenuItems'
        ]
    });
    wx.ready(function () {
        var share = {
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

</body>
</html>