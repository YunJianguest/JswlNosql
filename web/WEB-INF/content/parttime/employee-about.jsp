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
    <title>小象兼职</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
  <script>
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("zi-hong").siblings().removeClass("zi-hong");
            })
        })
    </script>
    <style>
        .zi-26bd93 {
            color: #26bd93;
        }

        .line-left-26bd93 {
            border-left: 3px solid #26bd93;
        }

        .line-height37 {
            line-height: 37px;
        }

        .btn-26bd93 {
            background-color: #26bd93;
        }

        .btn-26bd93:hover {
            background-color: #21a883;
        }

        .bottom-26bd93 {
            background-color: white;
        }

        .zi-jin {
            color: #e3c06a
        }

        .bottom-26bd93:hover {
            color: #21a883;
        }
    </style>
    <script>
    function  apply(){
    	   var submitData = { 
    			 mid:'${entity._id}'
    	  };
    	  $.post('${ctx}/parttime/order!createMiss.action?custid=${custid}&lscode=${lscode}', submitData, function(json) {
    		  if(json.state==0){
    			  alert("报名成功！");
    			  window.location.href="${ctx}/parttime/mission!order.action?custid=${custid}&lscode=${lscode}";
    		  }else if(json.state==1){
    			  alert("报名失败！"); 
    		  }else if(json.state==2){
    			  alert("重复报名！"); 
    		  }
    	    
    	  }, "json") 
    	}
    </script>
</head>
<body>
<main class="cmp640">

    <!--标题放置处-->
    <div class="hang40 line-height40 pl-10 pr-10 zi-bai bg-bai cmp640 position-f line-bottom"
         style="left:0px;top: 0px;z-index: 10;">
        <div class="pull-left zi-bai">
            <div class="pull-left pt-4 pr-5">
                <div class="bg-bai overflow-hidden" style="height:32px;width:118px;">
                    <img src="${ctx}/img/parttime/logo.png" class="width-10">
                </div>
            </div>
            <div class="pull-left zi-hei-tq pl-10">
                <!--<i class="fa fa-caret-down pl-5"></i>-->
            </div>
        </div>
        <div class="pull-right zi-hei">
            <i class="weight500">分享得佣金</i>
        </div>
    </div>
    <div class="hang40"></div>

    <div class="div-group-10">
        <div class="line-height25 weight500 size20 zi-hei pt-5">
            <i class="zi-26bd93 pr-5">[自营]</i>${entity.title}
        </div>

        <div class="pt-15 pb-5 zi-6 overflow-hidden weight500">
            <font size="2">
                <div class="txt-l col-6">
                    发布时间：<i><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${entity.createdate}" /></i>
                </div>
                <div class="txt-r col-6">
                    <i>关注度：20</i>
                </div>
            </font>
        </div>
    </div>
    <div class="hang7 overflow-hidden bg-hui clear"></div>

    <div class="div-group-10 weight500">
        <font size="5">
            <div class="line-height25 zi-jin pt-5">
                薪资待遇：${entity.wages}
            </div>
        </font>

        <div class="pt-15 pb-5 line-height30 zi-6 size16 overflow-hidden">
            <div><i class="zi-hei">公司名称：</i>${entity.company}</div>
            <div><i class="zi-hei">工作地点：</i>${entity.workaddress}</div>
            <div><i class="zi-hei">集合时间：</i><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${entity.gatherdate}" /></div>
            <div><i class="zi-hei">工作时间：</i><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${entity.startdate}" />至<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${entity.enddate}" /></div>
            <div><i class="zi-hei">招聘条件：</i>学历一本<i class="pl-5 pr-5">|</i>${entity.experience}</div>
            <div><i class="zi-hei">年龄要求：</i>${entity.education}</div>
            <div><i class="zi-hei">招聘人数：</i>招聘${entity.num}人</div>
        </div>
    </div>
    <div class="hang7 overflow-hidden bg-hui clear"></div>
    <div class="size16 div-group-10 zi-hei overflow-hidden weight500">
        <div class="hang40 line-height40">联系人：${entity.linkname}</div>
        <div class="hang40">
            <div class="pull-left line-height40">联系电话：${entity.linktel}</div>
            <div class="pull-right">
                <div class="clear img-wh35 line-height37 btn-26bd93 txt-c border-radius50">
                    <font size="4">
                        <i class="fa fa-phone zi-bai line-height37"></i>
                    </font>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="hang7 overflow-hidden bg-hui clear"></div>

    <font size="3">
        <div class="div-group-5 pt-10 pb-10 line-bottom">
            <div class="line-left-26bd93 weight500"><i class="pl-10">职位描述</i></div>
        </div>
    </font>

    <div class="width-10 clear div-group-10">
        ${entity.summary}
    </div>
</main>

<!--点击事件提示框  弹出后经过很短时间就消失-->
<div class="position-f width-10" style="bottom:100px;left:0px;">
    <div class="zi-bai txt-c line-height25">
        <!--此处字数尽量不要超过十字-->
        <i class="bg-hei-8 div-group-10 border-radius5 line-height25">提示信息条字数尽量不要超过十五字</i>
    </div>
</div>

<div class="clear hang50"></div>

<div class=" button_foot bg-bai zi-hui shadow-wai cmp640">
    <div class="zi-hui-wx txt-c weight500 button_group1">
        <div class="col-4 hang50 line-height50 bottom-26bd93"><i class="fa fa-star pr-5"></i>收藏</div>
        <div class="col-8 hang50 line-height50 zi-bai btn-26bd93 txt-c" onclick="apply()">
            立刻报名
        </div>
    </div>
</div>

</body>
</html>