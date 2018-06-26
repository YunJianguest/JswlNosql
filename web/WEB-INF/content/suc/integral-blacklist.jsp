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
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 
    <script src="${ctx}/app/js/bootstrap-switch_1.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%@ include file="/webcom/toast.jsp" %>
    <script type="text/javascript">
        //        点击按钮显示隐藏
        function no1() {
            if ($("#no1-tanchu").is(":hidden")) {
                $("#no1-tanchu").show();
            } else {
                $("#no1-tanchu").show();
            }
            $("#no2-tanchu").hide();
            $("#no1dingyue-tanchu").hide();
            $("#no1guanli-tanchu").hide();
        }

        function no2() {
            if ($("#no2-tanchu").is(":hidden")) {
                $("#no2-tanchu").show();
            } else {
                $("#no2-tanchu").show();
            }
            $("#no1-tanchu").hide();
            $("#no1dingyue-tanchu").hide();
            $("#no1guanli-tanchu").hide();
        }

        function no1guanli() {
            if ($("#no1guanli-tanchu").is(":hidden")) {
                $("#no1guanli-tanchu").show();
            } else {
                $("#no1guanli-tanchu").show();
            }
            $("#no1-tanchu").hide();
            $("#no2-tanchu").hide();
            $("#no1dingyue-tanchu").hide();
        }

        function no1dingyue() {
            if ($("#no1dingyue-tanchu").is(":hidden")) {
                $("#no1dingyue-tanchu").show();
            } else {
                $("#no1dingyue-tanchu").show();
            }
            $("#no1-tanchu").hide();
            $("#no2-tanchu").hide();
            $("#no1guanli-tanchu").hide();
        }


        $(function () {
            $(".yListr3 li").click(function () {
                $(this).addClass("zhiding").siblings().removeClass("zhiding");
            })
        })
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("zhiding").siblings().removeClass("zhiding");
            })
        })
    </script>
    <script>
        var money = 1;
        var issend = true;
        function setmoney(m) {
            money = m;
            $('#money').html(m);
        }
        function moneypay() {

            var remark = '积分充值';
            var submitData = {
                lx: 0,
                no: '0',
                name: '',
                total: 0.1,
                num: 1,
                price: money,
                remark: remark,
            };

            if (issend) {
                issend = false;
                $.post('${ctx}/suc/integral!wxpay.action?custid=${custid}&lscode=${lscode}', submitData,
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
                                        alert("充值成功！");
                                        window.location.href = "${ctx}/suc/integral!web.action?custid=${custid}&lscode=${lscode}";
                                    } else {

                                        //alert(res.err_code+res.err_desc+res.err_msg);

                                        issend = true;
                                    }
                                });
                                return;
                            } else if (json.state == 1) {
                                alert("该账号没有开通支付");
                                issend = true;
                            } else if (json.state == 3) {
                                alert("没有登录");
                            }
                        },
                        "json")
            }
        }
    </script>
    <style>
        .yListr3 .zhiding .div3 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }

        .yListr2 .zhiding a .div2 {
            color: #45c01a;
        }

        .hang25 {
            height: 30px;
            line-height: 28px;
        }
    </style>
</head>
<body class="cmp640">
<main>

    <!--选择按钮-->
    <font size="2">
        <div class="clear pt-10 pb-10 overflow-hidden bg-bai line-bottom yListr2">
            <li class=" button_group1 line-right zhiding">
                <a href="#" onclick="no1()">
                    <div class="zi-hui-wx txt-c weight500 div2">
                        积分充值
                    </div>
                </a>
            </li>
            
        </div>
    </font>
    <!--选择按钮结束-->

    <!--第一个-->
    <div class="" id="no1-tanchu">
        <div class="clear div-group-5  maring-a">

            <div class="overflow-hidden weight500 yListr3">

                <li class="pt-15 col-3 zhiding">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(1)">
                        100积分
                    </div>
                </li>
                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(3)">
                        300积分
                    </div>
                </li>

                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(6)">
                        600积分
                    </div>
                </li>

                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(10)">
                        1000积分
                    </div>
                </li>

                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(15)">
                        1500积分
                    </div>
                </li>

                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(20)">
                        2000积分
                    </div>
                </li>

                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(30)">
                        3000积分
                    </div>
                </li>

                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(50)">
                        5000积分
                    </div>
                </li>
                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(100)">
                        10000积分
                    </div>
                </li>
                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(200)">
                        20000积分
                    </div>
                </li>
                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(300)">
                        30000积分
                    </div>
                </li>
                <li class="pt-15 col-3">
                    <div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25"
                         onclick="setmoney(500)">
                        50000积分
                    </div>
                </li>

            </div>
        </div>


        <div class="pt-5 pl-5 pr-5 clear">
            <div class="txt-l weight500 zi-6">
                价格:<i class="zi-green pl-5" id="money">1</i>元
            </div>
        </div>

        <div class="pt-40 pl-5 pr-5 clear" onclick="moneypay()">
            <div class="btn-green txt-c border-radius5 maring-a zi-bai" style="height:40px;line-height:42px;">
                确认支付
            </div>
        </div>
        <!--简介-->
        <div class="clear pt-50">
            <div class=" zi-bai pull-left bg-green hang30"
                 style="border-radius: 0px 100px 100px 0px;padding-left:15px;padding-right: 25px; line-height:32px;">
                <font size="2">积分规则</font>
            </div>
        </div>

        <div class="zi-hui-tq div-group-10 clear weight500" style="line-height:30px;">
            <font size="2">
                <div><i class="pr-5">1:</i>1元=100积分</div>
                <div><i class="pr-5">2:</i>积分充值成功后积分实时到帐。</div>
                <div><i class="pr-5">3:</i>在商城购买某些商品时可用积分抵现。</div>
                <div><i class="pr-5">4:</i>积分可以用来在论坛赞赏，兑换物品等。</div>
            </font>
        </div>
        <!--结束-->


    </div>

    <!--第二个-->
    <div class="display-none" id="no2-tanchu">

        <div class="pl-5 pr-5 maring-a clear pt-40 overflow-hidden">
            <div class="overflow-hidden weight500">
                <div class="txt-c zi-hui-wx pl-5 pr-5 line-lu pt-6 border-radius3 overflow-hidden"
                     style="height:35px;">
                    <input class="width-10 zi-hui-wx weight500" style="height:20px; line-height:24px" type="text"
                           name=""
                           value="请输入提现金币数"
                           onfocus="if(this.value=='请输入提现金币数'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='请输入提现金币数'){this.value='请输入提现金币数';this.style.color='#aaa';}">
                </div>
            </div>
        </div>

        <div class="pt-10 pl-5 pr-5 clear zi-hui-tq">
            <font size="2">
                <div class="txt-l weight500">
                    现有:<i class="zi-green pl-5">500</i>金币
                    <a href="#"><i class="pl-10 zi-cheng ">（全部提现）</i></a>
                </div>
            </font>
        </div>


        <div class="clear pt-25">

            <div class=" width-9_5 maring-a overflow-hidden yListr3">

                <li class="pt-15 zhiding">
                    <div class="div3 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25">
                        微信帐号：js5512
                    </div>
                </li>

                <ul class="pt-15">
                    <div class="div3 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25">
                        支付宝帐号：开发中
                    </div>
                </ul>

                <ul class="pt-15">
                    <div class="div3 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25">
                        银行帐号：开发中
                    </div>
                </ul>

            </div>
        </div>


        <div class="pt-45 clear">
            <a href="#">
                <div class="btn-green txt-c border-radius5 maring-a width-9_5 zi-bai"
                     style="height:40px;line-height:42px;">
                    确认(可兑换人民币4.5元)
                </div>
            </a>
        </div>

        <font size="2">
            <div class="pt-10 clear zi-hui-tq txt-l width-9_5 maring-a weight500">
                <a href="#"><i class="zi-green">绑定提现帐号</i></a>
            </div>
        </font>


        <!--简介-->
        <div class="pt-50">
            <div class=" zi-bai pull-left bg-green hang30 line-height30"
                 style="border-radius: 0px 100px 100px 0px;padding-left:15px;padding-right: 25px; line-height:32px;">
                <font size="2">提现说明</font>
            </div>
        </div>


        <div class="zi-hui-tq div-group-10 clear weight500" style="line-height:30px;">
            <font size="2">
                <div><i class=""></i>提现功能暂时还没有开启请您谅解</div>
            </font>
        </div>
        <!--结束-->
    </div>

</main>
<script type="text/javascript">
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
            'showMenuItems',
            'hideAllNonBaseMenuItem',
            'showAllNonBaseMenuItem',
            'translateVoice',
            'startRecord',
            'stopRecord',
            'onRecordEnd',
            'playVoice',
            'pauseVoice',
            'stopVoice',
            'uploadVoice',
            'downloadVoice',
            'chooseImage',
            'previewImage',
            'uploadImage',
            'downloadImage',
            'getNetworkType',
            'openLocation',
            'getLocation',
            'hideOptionMenu',
            'showOptionMenu',
            'closeWindow',
            'scanQRCode',
            'chooseWXPay',
            'openProductSpecificView',
            'addCard',
            'chooseCard',
            'openCard'
        ]
    });

    wx.ready(function () {
        var share = {
            title: '${title}', // 分享标题
            desc: '${entity.summary}', // 分享描述
            link: '${token.url}', // 分享链接
            imgUrl: '${osshttp}${entity.logo}', // 分享图标
            success: function () {

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