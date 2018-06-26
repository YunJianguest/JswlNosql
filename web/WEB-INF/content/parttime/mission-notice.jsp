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
    <script src="${contextPath}/mvccol/js/fomatdate2.js"></script>
 <style>

        .line-height32 {
            line-height: 32px;
        }

        .line-bottom-red {
            border-bottom: 3px solid #26bd93;
            color: #26bd93;
        }

        .zi-26bd93 {
            color: #26bd93;
        }

        .bg-26bd93 {
            background-color: #26bd93;
        }

        .bottom-26bd93 {
            background-color: white;
        }

        .bottom-26bd93:hover {
            color: #21a883;
        }
    </style>
    <script>
    

    
    var fypage=0;
    var issend=true;
    var vt=1;
    function ajaxjz() {  
       var submitData = { 
       };
       if(!issend){
       	return;
       }
       issend = false; 
       $.post('${ctx}/parttime/mission!ajaxNotice.action?custid=${custid}&lscode=${lscode}&fypage=' +fypage, submitData, function (json) {
           var xszf; 
               xszf = $('#ajaxdiv').html();
           
           if (json.state == 0) {
        	  
               var v = json.list; 
               for (var i = 0; i < v.length; i++) {  
               	  if(v[i].type==0){
               		  xszf+='<div class="pt-30"><div class="maring-a width-9 border-radius5 bg-bai weight500">';
               		      if(v[i].title==null){
               		    	 xszf+='<div class="hang50 line-height50 pl-10 pr-10 overflow-hidden line-bottom-92 clear sl size16">平台提醒</div>'; 
               		      }else{
               		    	xszf+='<div class="hang50 line-height50 pl-10 pr-10 overflow-hidden line-bottom-92 clear sl size16">'+v[i].title+'</div>'; 
               		      }
               		     
               		      xszf+='<div class="div-group-10 pl-20 pr-20 line-height25 overflow-hidden zi-hui line-bottom-92">'+v[i].content+'</div>'
               		      +'<div class="pl-10 pr-10 size14 hang40 txt-c zi-26bd93 line-height40">'+Date.prototype.format(v[i].createdate)+'</div></div></div>';
                 
               	  }else if(v[i].type==1){
               		  xszf+='<div class="pt-30">'
               		      +'<div class="maring-a width-9 border-radius5 bg-bai weight500">'
               		      +'<div class="hang50 line-height50 pl-10 pr-10 overflow-hidden line-bottom-92 clear sl size16">'+v[i].title+'</div>'
               		      +'<div class="div-group-10 pl-20 pr-20 overflow-hidden line-bottom-92 zi-6">'
               		      +'<div class="hang30 line-height30 sl">'
               		      +'<i class="zi-hei">岗位名称</i>'+v[i].obj.title+'</div>'
               		      +'<div class="hang30 line-height30 sl">'
               		      +' <i class="zi-hei">工作地点：</i>'+v[i].obj.workaddress+'</div>'
               		      +'<div class="hang30 line-height30">'
               		      +'<i class="zi-hei">集合日期：</i>'+Date.prototype.format(v[i].obj.gatherdate)+'</div>'
               		      +'<div class="hang30 line-height30">'
               		      +'<i class="zi-hei">上班时间：</i>'+Date.prototype.format(v[i].obj.startdate)+' 至 '+Date.prototype.format(v[i].obj.enddate)+'</div>'
               		      +'<div class="hang30 line-height30"><i class="zi-hei">招聘人数：</i>'+v[i].obj.num+'人</div>'
               		      if(v[i].obj.jstype==0){
               		    	xszf+='<div class="hang30 line-height30"><i class="zi-hei">薪资：</i>'+v[i].obj.price+'</div></div>';  
            		      }
               		      if(v[i].obj.jstype==1){
               		    	xszf+='<div class="hang30 line-height30"><i class="zi-hei">薪资：</i>'+v[i].obj.price+'/时</div></div>';   
               		      }
               		      if(v[i].obj.jstype==2){
               		    	xszf+='<div class="hang30 line-height30"><i class="zi-hei">薪资：</i>'+v[i].obj.price+'/天</div></div>';   
          		          }
               		      if(v[i].obj.jstype==3){
               		    	xszf+='<div class="hang30 line-height30"><i class="zi-hei">薪资：</i>'+v[i].obj.price+'/月</div></div>';   
          		          }
               		      
               		     xszf+='<div class="pl-10 pr-10 size14 hang40 txt-c zi-26bd93 line-height40"> '+Date.prototype.format(v[i].createdate)+'</div>'
               		      +'</div></div>';
                     	    
               		  
               	  }else if(v[i].type==2){
               		  xszf+='<div class="pt-30">'
               		      +'<div class="maring-a width-9 border-radius5 bg-bai weight500">'
               		      +'<div class="hang50 line-height50 pl-10 pr-10 overflow-hidden line-bottom-92 clear sl size16">'+v[i].title+'</div>'
               		      +'<div class="div-group-10 pl-20 pr-20 overflow-hidden line-bottom-92 zi-6">'
               		      +'<div class="hang30 line-height30"><i class="zi-hei">订单编号：</i>'+v[i].obj._id+'</div>'
               		      +'<div class="hang30 line-height30"><i class="zi-hei">接单日期：</i>'+Date.prototype.format(v[i].obj.createdate)+'</div>'
               		      +'<div class="hang30 line-height30">'
               		      +'<i class="zi-hei">集合日期：</i>2017-03-03 15:40:00 </div>'
               		      +'<div class="hang30 line-height30"><i class="zi-hei">上班时间：</i>'+Date.prototype.format(v[i].obj.startdate)+'至'+Date.prototype.format(v[i].obj.enddate)+'</div>'
               		      +'<div class="hang30 line-height30"><i class="zi-hei">带队电话：</i>'+v[i].obj.linktel+'</div></div>'
               		      +'<div class="zi-hei line-bottom-92"><div class="clear pl-10 pr-10 hang30 line-height30">'
               		      +'<div class="pull-left">到账日期：</div><div class="pull-right zi-jin">'+Date.prototype.format(v[i].obj.updatedate)+'</div></div>'
               		      +'<div class="pl-10 pr-10 hang30 line-height30"><div class="pull-left">工作时间：'+v[i].obj.time+'小时</div>'
               		      +'<div class="pull-right zi-jin">'+v[i].obj.total+'元</div> </div>'
               		      +'<div class="clear pl-10 pr-10 hang30 line-height30"><div class="pull-left">加班费：</div>'
               		      +'<div class="pull-right zi-jin">0元</div></div>'
               		      +'<div class="clear pl-10 pr-10 hang30 line-height30"><div class="pull-left">总计：</div>'
               		      +'<div class="pull-right zi-jin">'+v[i].obj.total+'元</div></div></div>'
               		      +'<div class="pl-10 pr-10 size14 hang40 txt-c zi-26bd93 line-height40">'+Date.prototype.format(v[i].createdate)+'</div></div></div>';
        

               	  }
                  
               }
               fypage++;
           } else {
           }
           issend = true;
           $('#ajaxdiv').html(xszf); 
       }, "json");
   }
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("line-bottom-red").siblings().removeClass("line-bottom-red");
            })
        })
    </script>
</head>
<body class=" bg-hui-92">
<main class="cmp640">
    <!--标题放置处-->
    <div class="hang40 line-height40 pl-10 pr-10 zi-bai cmp640 position-f bg-bai line-bottom"
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
        <div class="pull-right zi-hei" onclick="share_xianshi()">
            <i class="weight500">分享得佣金</i>
        </div>
    </div>
    <div class="hang40"></div>
    <div id="ajaxdiv"></div>

</main>

<!--点击事件提示框  弹出后经过很短时间就消失-->
<!--<div class="position-f width-10" style="bottom:100px;left:0px;">-->
<!--<div class="zi-bai txt-c line-height25">-->
<!--&lt;!&ndash;此处字数尽量不要超过十字&ndash;&gt;-->
<!--<i class="bg-hei-8 div-group-10 border-radius5 line-height25">提示信息条字数尽量不要超过十五字</i>-->
<!--</div>-->
<!--</div>-->

<div class="clear hang60"></div>
<!--底部按钮-->
 <%@include file="/webcom/mission-foot.jsp"%>
 <%@include file="/webcom/mission-share.jsp"%>
 <script type="text/javascript">
ajaxjz();
$(window).scroll(function () {

    var offsetY = $(window).scrollTop();

    var section1 = $("#section1").height();
	if(section1-offsetY<600){
		ajaxjz(); 
	}
   
});
 
</script> 
</body>
</html>