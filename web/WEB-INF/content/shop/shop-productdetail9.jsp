<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
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
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>

        .img-wh160 {
            width: 130px;
            height: 130px;
        }

        .img-100 img {
            width: 100%
        }

        .bg-hei-2 {
            background-color: rgba(30, 30, 30, 0.2);
        }

        .box-shadow {
            -webkit-box-shadow: 5px 0 50px #e78e92;
            -moz-box-shadow: 5px 0 50px #e78e92;
            box-shadow: 5px 0 50px #e78e92;
        }
    </style>
    <script>
        var fypage = 0;
        function luckbm() {
            var submitData = {
                id: '${entity._id}',
            };
            $.post('${ctx}/shop/shop!ajaxbulkyd.action?lscode=${lscode}&custid=${custid}&agid=${agid}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            alert("报名成功!");
                            $("#needcount").html("还差" + json.needcount + "人就要开奖了");
                            $("#bl").html(json.bl + "%");
                            $("#ibl").css("height", json.bl + "%");
                            if (json.bl >= 100) {
                                $("#zjmd").html("中奖名单");
                                ajaxzj();
                            } else {
                                fypage = 0;
                                ajaxlist();
                            }

                        } else if (json.state == 1) {
                            alert("亲，您已经报过名了！");
                        } else if (json.state == 2) {
                            alert("亲，活动已经结束！");
                        } else {
                            alert("报名失败！");
                        }
                    }, "json");
        }

        function ajaxlist() {
            var submitData = {
                id: '${entity._id}',
                fypage: fypage
            };
            $.post('${ctx}/shop/shop!ajaxbulkydlist.action?lscode=${lscode}&custid=${custid}&agid=${agid}', submitData,
                    function (json) {
                        var html = $("#ajaxdiv").html();
                        if (json.state == 0) {
                            var list = json.list;
                            for (var i = 0; i < list.length; i++) {
                                html += '<div class="zi-6 overflow-hidden txt-c weight500 hang40 line-bottom">'
                                + '<div class="col-2 pt-5 pb-5">'
                                + '<div class="maring-a img-wh30 img-bj border-radius50" style="background-image: url(${filehttp}/' + list[i].headimgurl + ');"></div></div>'
                                + '<div class="col-10 sl zi-6 txt-l" style="line-height:40px;">'
                                + '<font  size="1"> <i>' + list[i].nickname + '</i>在' + list[i].createdate + '参加了活动。</font>'
                                + '</div></div>';
                            }
                            fypage++;
                        }
                        $("#ajaxdiv").html(html);
                    }, "json");

        }
        function ajaxzj() {
            var submitData = {
                id: '${entity._id}',
            };
            $.post('${ctx}/shop/shop!ajaxbulkgmlist.action?lscode=${lscode}&custid=${custid}&agid=${agid}', submitData,
                    function (json) {
                        var html = $("#ajaxdiv").html();
                        if (json.state == 0) {
                            var list = json.list;
                            for (var i = 0; i < list.length; i++) {
                                html += '<div class="zi-6 overflow-hidden txt-c weight500 hang40 line-bottom">'
                                + '<div class="col-2 pt-5 pb-5">'
                                + '<div class="maring-a img-wh30 img-bj border-radius50" style="background-image: url(${filehttp}/' + list[i].headimgurl + ');"></div></div>'
                                + '<div class="col-10 sl zi-6 txt-l" style="line-height:40px;">'
                                + '<font  size="1"> <i>' + list[i].nickname + '</i>在' + list[i].insDate + '购买了该商品。</font>'
                                + '</div></div>';
                            }
                            fypage++;
                        }
                        $("#ajaxdiv").html(html);
                    }, "json");

        }
        function moneypay() {
            if ('${address.tel}' == "") {
                alert("请先设置收货地址");
                window.location.href = '${ctx}/shop/shop!useraddresssave.action?lscode=${lscode}&custid=${custid}&agid=${agid}&addressis=err&backurl=/shop/shop!bargaindetail.action?id=${entity._id}';
                return;
            }
            if ('${bl}' < 100) {
                alert("活动未到购买阶段！");
                return;
            }
            var address = '${address.province}' + "-" + '${address.city}' + "-" + '${address.county}' + " " + '${address.address}';
            var submitData = {
                lx: 0,
                no: '0',
                name: '${address.name}',
                tel: '${address.tel}',
                address: address,
                total: '${entity.pprice}',
                remoney: '${entity.pprice}',
                recordid: '${entity._id}',
                price: '${entity.pprice}',
                remark: '${entity.ptitle}',
                comid: '${entity.comid}',
                num: 1,
                logo: '${entity.logo}',
            };
            $.post('${ctx}/shop/shop!wxpay.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            WeixinJSBridge.invoke('getBrandWCPayRequest', {
                                "appId": json.appId,
                                "timeStamp": json.timeStamp,
                                "nonceStr": json.nonceStr,
                                "package": json.packageValue,
                                "signType": json.signType,
                                "paySign": json.paySign
                            }, function (res) {
                                if (res.err_msg == "get_brand_wcpay_request:ok") {
                                    alert("购买成功！");
                                    window.location.href = "${ctx}/shop/shop!orderform.action?custid=${custid}&agid=${agid}&lscode=${lscode}";
                                } else {

                                    //alert(res.err_code+res.err_desc+res.err_msg);

                                }
                            });
                            return;
                        } else if (json.state == 1) {
                            alert("该账号没有开通支付");
                        } else if (json.state == 3) {
                            alert("没有登录");
                        }
                    },
                    "json")

        }
    </script>
</head>
<body>

<main class="cmp640 pb-45" style="background-color: #ee4049;">
    <div class="width-10 pt-10 cmp640">
        <div class="width-9_5 maring-a">
            <img src="${ctx}/mvccol/img/yyg-banner2.png" class="width-10">
        </div>
        <font size="2">
            <div class="width-9 pt-25 maring-a zi-bai txt-c weight500 line-height20" style="letter-spacing:3px;">
                本次活动由${entity.unit}发起<br>
                满${entity.pcount}人即可享受优惠价，叫上朋友一起来
            </div>
        </font>

        <div class="pt-25">
            <div class="img-wh160 maring-a border-radius50 overflow-hidden position-r bg-hei-2 box-shadow"
                 style="border:4px #ffffff solid;">
                <div class="bg-green position-a position-r" style="bottom: 0px; width:122px;height:${bl}%;"
                     id="ibl"></div>
                <div class="width-10 weight500 zi-bai txt-c position-a"
                     style="bottom: 0px;left: 0px; height:130px;line-height: 135px;">
                    <font size="6" id="bl">
                        ${bl}%
                    </font>
                </div>
            </div>
        </div>
        <font size="3">
            <div class="width-9 pt-25 maring-a txt-c zi-bai weight500" style="letter-spacing:3px;" id="needcount">
                <c:if test="${bl<100}">还差${needcount}人就可享受优惠</c:if>
                <c:if test="${bl>=100}">活动已经结束！</c:if>
            </div>
        </font>

        <div class="pt-40">
            <div class="col-12" onclick="luckbm()">
                <div class="width-8 zi-green maring-a txt-c btn-bai div-group-10 border-radius5 weight500 zi-bai">
                    立即报名
                </div>

            </div>
        </div>
        <div class="div-group-10 pt-40 clear">
            <div class=" border-radius5 bg-bai">
                <div class="zi-6 overflow-hidden txt-c weight500 hang40 line-bottom size16" id="zjmd">
                    <c:if test="${bl>=100}">中奖名单</c:if>
                    <c:if test="${bl<100}">参与人名单</c:if>
                </div>
                <div style="height: 200px;overflow: auto;" id="ajaxdiv">
                </div>
            </div>
        </div>
        <!--活动规则奖项设置-->
        <div class="pt-30">
            <div class=" zi-6 pull-left bg-bai pl-15 pr-25 hang30 weight500 line-height30"
                 style="border-radius: 0px 100px 100px 0px;">
                <font size="2">活动详情</font>
            </div>
        </div>
        <div class="zi-bai clear width-9_5 maring-a pt-10 pb-10 img-100">
            ${entity.context}
        </div>
    </div>
</main>
<div class=" button_foot cmp640 shadow-wai weight500" style="bottom:0px;">
    <div class="button_group1">
        <a href="${ctx}/shop/shop!index.action?lx=1&custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-home"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        商城首页
                    </font>
                </div>
            </div>
        </a>
    </div>
    <c:if test="${ispay==true}">
        <div class="button_group1" onclick="moneypay()">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-money"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        直接购买
                    </font>
                </div>
            </div>
        </div>
    </c:if>
    <div class=" button_group1">
        <a href="${ctx}/shop/shopactivity!web.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
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
        <a href="${ctx}/user/fromuser!UserDetail.action?custid=${custid}&agid=${agid}&fromUserid=${fromUserid}">
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
</body>
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
    if ('${bl}' >= 100) {
        ajaxzj();
    } else {
        ajaxlist();
    }
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) {

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
<c:if test="${not empty com.ewmurl}">
 <c:if test="${com.ewmxs==0}">
  <%@ include file="/webcom/focus-page.jsp" %>
 </c:if>
</c:if>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
</html>