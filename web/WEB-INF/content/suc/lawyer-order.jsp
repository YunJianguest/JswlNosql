<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %> 
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
    <title>我的订单</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .line-height32 {
            line-height: 32px;
        }
        .line-bottom-red {
            border-bottom: 3px solid #e3c06a;
        }
        .bottom-bai-ls {
            background-color: #ffffff;
        }

        .zi-jin {
            color: #e3c06a;
        }

        .bottom-bai-ls:hover, .bottom-bai-ls:focus {
            color: #e3c06a;
        }

        .bg-jin {
            background-color: #e3c06a;
        }
    </style>
    <script>
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("line-bottom-red").siblings().removeClass("line-bottom-red");
            })
        })
    </script>
</head>
<body class="lock">
<main class="cmp640">
    <font size="2">

        <div class="clear position-r" style=" z-index:3;">
            <div class="hang40 pt-5 line-bottom-92 weight100 yListr2 zi-hei">
                <li class="button_group1 hang30 line-height32 txt-c line-bottom-red">
                    全部
                </li>
                <li class="button_group1 hang30 line-height32 txt-c">
                    待付款
                </li>
                <li class="button_group1 hang30 line-height32 txt-c">
                    待交付
                </li>
                <li class="button_group1 hang30 line-height32 txt-c">
                    待评价
                </li>
            </div>
        </div>

        <div class="div-group-10 overflow-hidden line-bottom-92 clear">
            <div class="hang20 line-height20 weight500">
                <div class="pull-left">服务名称：[文字咨询]<i class="zi-jin pl-10">￥100</i></div>
                <div class="pull-right zi-jin">已完成</div>
            </div>
        </div>
        <div class="width-8 maring-a pt-10 pb-10 overflow-hidden zi-6 weight500">
            <div class="hang30 line-height30">
               下单时间：2018-03-03 12：00：00
            </div>
            <div class="hang30 line-height30">
                完成时间：2018-03-03 12：00：00
            </div>
            <div class="hang30 line-height30">
                快递公司名称：74857658675832<i class="zi-lan-tq pl-10">查看详情</i>
            </div>
            <div class="hang30 line-height30">
                订单编号：8756474869494
            </div>
        </div>
        <div class="line-top-92 line-bottom-92 hang40 line-height40 txt-c zi-6 weight500">
            确认收货
        </div>

        <!--分隔线-->
        <div class="hang10 clear bg-hui-92"></div>

        <div class="div-group-10 overflow-hidden line-bottom-92 clear">
            <div class="hang20 line-height20 weight500">
                <div class="pull-left">服务名称：[文字咨询]<i class="zi-jin pl-10">￥100</i></div>
                <div class="pull-right zi-jin">已完成</div>
            </div>
        </div>
        <div class="width-8 maring-a pt-10 pb-10 overflow-hidden zi-6 weight500">
            <div class="hang30 line-height30">
                下单时间：2018-03-03 12：00：00
            </div>
            <div class="hang30 line-height30">
                完成时间：2018-03-03 12：00：00
            </div>
            <div class="hang30 line-height30">
                快递公司名称：74857658675832<i class="zi-lan-tq pl-10">查看详情</i>
            </div>
            <div class="hang30 line-height30">
                订单编号：8756474869494
            </div>
        </div>
        <div class="line-top-92 line-bottom-92 hang40 line-height40 txt-c zi-6 weight500">
            确认收货
        </div>



        <div class="pt-30">
            <!--此处放置链接是回到我们总平台的连接-->
            <div class="clear hang50 line-height50 size12 txt-c zi-hui-tq weight500">
                技术支持<a onclick="" class="zi-jin">《我们平台名称》</a>
            </div>
        </div>
    </font>
</main>
<div class="clear hang50"></div>
<!--底部按钮-->
<font size="2">
    <div class=" button_foot bg-bai line-top-92 cmp640">
        <div class=" button_group1 zi-6">
            <div class="bottom-bai-ls zi-hui-wx txt-c weight500 line-right_bai hang50">
                <font size="4">
                    <div class="hang25 line-height30 fa fa-home"></div>
                </font>
                <font size="2">
                    <div class="hang25 line-height25">
                        首页
                    </div>
                </font>
            </div>
        </div>

        <!--咨询是整个平台提供律师也可自己提供给我们素材我们进行审核后上传主要是法律类知识与案例-->
        <div class=" button_group1 zi-6">
            <div class="bottom-bai-ls zi-hui-wx txt-c weight500 line-right_bai hang50">
                <font size="4">
                    <div class="hang25 line-height30 fa fa-newspaper-o"></div>
                </font>
                <font size="2">
                    <div class="hang25 line-height25">
                        资讯
                    </div>
                </font>
            </div>
        </div>
        <div class=" button_group1 zi-6">
            <div class="bottom-bai-ls zi-hui-wx txt-c weight500 line-right_bai hang50">
                <font size="3">
                    <div class="hang25 line-height30 fa fa-envelope-open-o position-r">
                        <div class="position-a bg-hong zi-bai border-radius50 img-wh15 sl"
                             style="top:-3px; right: -10px;line-height: 15px;">
                            <font size="2">9</font>
                        </div>
                    </div>
                </font>
                <font size="2">
                    <div class="hang25 line-height25">
                        消息
                    </div>
                </font>
            </div>
        </div>
        <div class=" button_group1 zi-6">
            <div class="bottom-bai-ls zi-hui-wx txt-c weight500 line-right_bai hang50">
                <font size="3">
                    <div class="hang25 line-height30 fa fa-user"></div>
                </font>
                <font size="2">
                    <div class="hang25 line-height25">
                        我的
                    </div>
                </font>
            </div>
        </div>
    </div>
</font>
</body>
</html>