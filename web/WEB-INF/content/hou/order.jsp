<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <script src="js/jquery-1.8.3.js"></script>
    <link href="css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="css/font-awesome.min.css" rel="stylesheet"/>
    <style>
        .line-height32 {
            line-height: 32px;
        }
        .line-bottom-red {
            border-bottom: 3px solid #eb2c58;
            color: #eb2c58;
        }
        .bottom-bai-bj {
            background-color: #ffffff;
        }

        .zi-jin {
            color: #e3c06a;
        }

        .bottom-bai-bj:hover, .bottom-bai-bj:focus {
            color: #eb2c58;
        }

    </style>
    <script>
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("line-bottom-red").siblings().removeClass("line-bottom-red");
            })
        })
        var fypage=0;
        var isend=true; 
        function init(){
        	if(!isend){
        		return;
        	}
        	isend=false;
        	var submitData={
        			
        	}
        	$.post('${ctx}/hou/order!getData.action', submitData,
        			function(json) {
        		         var html='';
        				 if(json.state==0){
        					 var list=json.list;
        					 for(var i=0;i<list.length;i++){
        						 
        						 html+='<div class="div-group-10 overflow-hidden line-bottom-92 clear">'
        						     +'<div class="hang20 line-height20 weight500">'
        						     +'<div class="pull-left">日常保洁</div>'
        						     +'<div class="pull-right zi-lan-tq">进行中</div>'
        						     +'</div></div>'
        						     +'<div class="width-9 maring-a pt-10 pb-10 overflow-hidden zi-6 weight500">'
        						     +'<div class="hang30 line-height30">服务时间：2017-03-03（周六） 15：00-19：00</div>'
        						     +'<div class="hang30 line-height30">服务地点：西安恒大公寓B座1025室 </div>'
        						     +'<div class="hang30 line-height30"> 联系电话：15098646636</div></div>'
        						     +'<div class="size10 zi-6 weight500">'
        						     +'<div class="line-top-92 pl-10 pr-10 hang30 line-height30">'
        						     +'<div class="pull-left">服务价格：2小时</div>'
        						     +'<div class="pull-right zi-jin">70元</div>'
        						     +'</div>'
        						     +'<div class="clear pl-10 pr-10 hang30 line-height30">'
        						     +'<div class="pull-left">清洁剂：</div>'
        						     +'<div class="pull-right zi-jin">0元</div>'
        						     +'</div>'
        						     +'<div class="line-bottom-92 pl-10 pr-10 hang30 line-height30">'
        						     +'<div class="pull-left">订单总价：</div>'
        						     +'<div class="pull-right zi-jin">70元</div>'
        						     +'</div></div>'
        						     +'<div class="hang10 clear bg-hui-92"></div>'; 
        				        
        					 }
        					 $('#list').html(html);
        					 
        				 }
        					
        		},"json");
        	
        }
    </script>
</head>
<body class="lock">
<main class="cmp640">
    <font size="2">

        <div class="clear position-r position-f cmp640 bg-bai" style="top: 0px; left: 0px; z-index:3;">
            <div class="hang40 pt-5 line-bottom-92 weight100 yListr2 zi-hei">
                <li class="button_group1 hang30 line-height32 txt-c line-bottom-red">
                    进行中
                </li>
                <li class="button_group1 hang30 line-height32 txt-c">
                    已完成
                </li>
                <li class="button_group1 hang30 line-height32 txt-c">
                    待评价
                </li>
                <li class="button_group1 hang30 line-height32 txt-c">
                   全部订单
                </li>
            </div>
        </div>
        <div class="hang40 clear"></div>

        <div class="div-group-10 overflow-hidden line-bottom-92 clear">
            <div class="hang20 line-height20 weight500">
                <div class="pull-left">日常保洁</div>
                <div class="pull-right zi-lan-tq">进行中</div>
            </div>
        </div>
        <div class="width-9 maring-a pt-10 pb-10 overflow-hidden zi-6 weight500">
            <div class="hang30 line-height30">
                服务时间：2017-03-03（周六） 15：00-19：00
            </div>
            <div class="hang30 line-height30">
                服务地点：西安恒大公寓B座1025室
            </div>
            <div class="hang30 line-height30">
                联系电话：15098646636
            </div>
        </div>
       <div class="size10 zi-6 weight500">
           <div class="line-top-92 pl-10 pr-10 hang30 line-height30">
               <div class="pull-left">服务价格：2小时</div>
               <div class="pull-right zi-jin">70元</div>
           </div>
           <div class="clear pl-10 pr-10 hang30 line-height30">
               <div class="pull-left">清洁剂：</div>
               <div class="pull-right zi-jin">0元</div>
           </div>
           <div class="line-bottom-92 pl-10 pr-10 hang30 line-height30">
               <div class="pull-left">订单总价：</div>
               <div class="pull-right zi-jin">70元</div>
           </div>
       </div>

        <!--分隔线-->
        <div class="hang10 clear bg-hui-92"></div>

        <div class="div-group-10 overflow-hidden line-bottom-92 clear">
            <div class="hang20 line-height20 weight500">
                <div class="pull-left">油烟机清洗</div>
                <div class="pull-right zi-6">已完成</div>
            </div>
        </div>
        <div class="width-9 maring-a pt-10 pb-10 overflow-hidden zi-6 weight500">
            <div class="hang30 line-height30">
                服务时间：2017-03-03（周六） 15：00-19：00
            </div>
            <div class="hang30 line-height30">
                服务地点：西安恒大公寓B座1025室
            </div>
            <div class="hang30 line-height30">
                联系电话：15098646636
            </div>
        </div>
        <div class="size10 zi-6 weight500 line-top-92">
            <div class="pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">服务价格：中式油烟机<i class="zi-lan1 pl-5">x2</i><i class="zi-hui-wx pl-5">[单价120元]</i></div>
                <div class="pull-right zi-jin">240元</div>
            </div>
            <div class="pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">服务价格：欧式油烟机<i class="zi-lan1 pl-5">x2</i><i class="zi-hui-wx pl-5">[单价120元]</i></div>
                <div class="pull-right zi-jin">240元</div>
            </div>
            <div class="pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">服务价格：侧吸式油烟机<i class="zi-lan1 pl-5">x1</i><i class="zi-hui-wx pl-5">[单价120元]</i></div>
                <div class="pull-right zi-jin">120元</div>
            </div>
            <div class="clear pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">清洁剂：</div>
                <div class="pull-right zi-jin">0元</div>
            </div>
            <div class="pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">订单总价：</div>
                <div class="pull-right zi-jin">600元</div>
            </div>
        </div>


        <!--分隔线-->
        <div class="hang10 clear bg-hui-92"></div>

        <div class="div-group-10 overflow-hidden line-bottom-92 clear">
            <div class="hang20 line-height20 weight500">
                <div class="pull-left">开荒保洁</div>
                <div class="pull-right zi-6">待评价:<i class="zi-lan-tq pl-10">点击评论</i></div>
            </div>
        </div>
        <div class="width-9 maring-a pt-10 pb-10 overflow-hidden zi-6 weight500">
            <div class="hang30 line-height30">
                服务时间：2017-03-03（周六） 15：00-19：00
            </div>
            <div class="hang30 line-height30">
                服务地点：西安恒大公寓B座1025室
            </div>
            <div class="hang30 line-height30">
                联系电话：15098646636
            </div>
        </div>
        <div class="size10 zi-6 weight500">
            <div class="line-top-92 pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">服务价格：一居室</div>
                <div class="pull-right zi-jin">550元</div>
            </div>
            <div class="clear pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">清洁剂：</div>
                <div class="pull-right zi-jin">0元</div>
            </div>
            <div class="line-bottom-92 pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">订单总价：</div>
                <div class="pull-right zi-jin">550元</div>
            </div>
        </div>


        <!--分隔线-->
        <div class="hang10 clear bg-hui-92"></div>

        <div class="div-group-10 overflow-hidden line-bottom-92 clear">
            <div class="hang20 line-height20 weight500">
                <div class="pull-left">日常保洁</div>
                <div class="pull-right zi-hui-wx">已取消</div>
            </div>
        </div>
        <div class="width-9 maring-a pt-10 pb-10 overflow-hidden zi-6 weight500">
            <div class="hang30 line-height30">
                服务时间：2017-03-03（周六） 15：00-19：00
            </div>
            <div class="hang30 line-height30">
                服务地点：西安恒大公寓B座1025室
            </div>
            <div class="hang30 line-height30">
                联系电话：15098646636
            </div>
        </div>
        <div class="size10 zi-6 weight500">
            <div class="line-top-92 pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">服务价格：2小时</div>
                <div class="pull-right zi-jin">70元</div>
            </div>
            <div class="clear pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">清洁剂：</div>
                <div class="pull-right zi-jin">0元</div>
            </div>
            <div class="line-bottom-92 pl-10 pr-10 hang30 line-height30">
                <div class="pull-left">订单总价：</div>
                <div class="pull-right zi-jin">70元</div>
            </div>
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
            <div class="bottom-bai-bj zi-hui-wx txt-c weight500 line-right_bai hang50">
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
            <div class="bottom-bai-bj zi-hui-wx txt-c weight500 line-right_bai hang50">
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
            <div class="bottom-bai-bj zi-hui-wx txt-c weight500 line-right_bai hang50">
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
            <div class="bottom-bai-bj zi-hui-wx txt-c weight500 line-right_bai hang50">
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