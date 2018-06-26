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
    <title>祭奠-我的馆</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .line-height32 {
            line-height: 32px;
        }

        .line-bottom-red {
            border-bottom: 3px solid red;
        }

        .zi-3a {
            color: #aaa;
            background-color: transparent;
        }

        .bk {
            width: 50px;
            height: 50px;
        }
    </style>
    <script>
       var fypage=0; 
       var state=1;
       var sel='';
       var isappend = true;
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("line-bottom-red").siblings().removeClass("line-bottom-red");
                if($(this).attr('id')==1){
                 fypage=0;
                 state=1;
                 ajaxweb(false); 
                }else if($(this).attr('id')==2){
                 fypage=0; 
                 state=2;
                 ajaxweb(false);
                }else if($(this).attr('id')==3){
                 state=3;
                 fypage=0;
                 ajaxweb(false); 
                }
            })
        })
          function ajaxweb(t) {
            if (!isappend) {
                return;
            }
            var url='';
            if(state==1||state==2){
               url='${ctx}/suc/memorial!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage='+fypage;
            } 
            if(state==3){
               url='${ctx}/suc/memorial!ajaxrelated.action?custid=${custid}&lscode=${lscode}&fypage='+fypage;
            } 
            var type=0;
            if(state==1){
              type=1;
            }else if(state==2){
              type=2;
            }
            var submitData = {
              type:type,
              sel:sel
            };
            isappend = false;
            $.post(url, submitData, function (json) {
                var xszf = '';
                if(t){
                  xszf=$('#ajaxdiv').html();
                }
                if (json.state == 0) { 
                    var v = json.list;  
                    for (var i = 0; i < v.length; i++) {
                          if(state==3){
                            if(v[i].me!=null){
                             xszf+='<div onclick="detail('+v[i].me._id+')"><div class="hang20 line-height20 mt-10 mb-5 pl-10 pr-10 zi-6">'
                              +'<div class="pull-left">'+v[i].me.title+'</div>'
                              +'<font size="2">'
                              +'<div class="pull-right">'
                              +'<div class="pull-left pr-15 hang20 line-height20"><i class="fa fa-users line-height20 pr-5"></i>'+v[i].me.relativescount+'</div>'
                              +' <div class="pull-left hang20 line-height20"><i class="fa fa-plus line-height20 pr-5"></i>'+v[i].me.focuscount+'</div>'
                              +'</div></font></div>'; 
                           }else{
                             continue;
                           }
                           
                          }else{
                           xszf+='<div onclick="detail('+v[i]._id+')"><div class="hang20 line-height20 mt-10 mb-5 pl-10 pr-10 zi-6">'
                              +'<div class="pull-left">'+v[i].title+'</div>'
                              +'<font size="2">'
                              +'<div class="pull-right">'
                              +'<div class="pull-left pr-15 hang20 line-height20"><i class="fa fa-users line-height20 pr-5"></i>'+v[i].relativescount+'</div>'
                              +' <div class="pull-left hang20 line-height20"><i class="fa fa-plus line-height20 pr-5"></i>'+v[i].focuscount+'</div>'
                              +'</div></font></div>'; 
                           }
                             var js=v[i].lsdead;
                              if(state==3){
                               js=v[i].me.lsdead;
                              }
                              if(js!=null){
                              for ( var j = 0; j< js.length; j++) {
								xszf+='<div class=" clear pb-10 pl-10 pr-10 overflow-hidden position-r">'
								    +'<div class="position-r">'
								    +'<div class=" position-a" style="top: 6px;">';
								    if(js[j].picurl!=null&&js[j].picurl!=""){
								    xszf+='<div class="img-bj bk border-radius3" style="background-image: url(${filehttp}'+js[j].picurl+');"></div></div>';
								    }else{
								    xszf+='<div class="img-bj bk border-radius3" style="background-image: url(${ctx}/img/memor-lbmr.jpg);"></div></div>'; 
								    } 
								    xszf+='<div style="padding-left:60px;">'
								    +'<div class="zi-6 hang20 line-height20 sl zi-hei">'
								    +'<font size="2">'
								    +'<div class="sl">姓名：'+js[j].name+'</div>'
								    +'</font></div>'
								    +'<font size="2"><div class="clear sl weight100 hang20 line-height20">';
								    if(js[j].birthdate!=null){
								    xszf+='<span class="zi-hui">生辰：'+js[j].birthdate+'</span></div>';
								    }else{
								    xszf+='<span class="zi-hui">生辰：暂无</span></div>';
								    } 
								    xszf+='<div class="weight100 hang20 line-height20">';
								    if(js[j].burialdate!=null){
								    xszf+='<span class="zi-hui">忌日：'+js[j].burialdate+'</span>';
								    }else{
								    xszf+='<span class="zi-hui">忌日：暂无</span>';
								    } 
								    xszf+='</div></font></div></div></div>';
							 }
                              } 
                              
                         xszf+='<div class="pl-5 pr-5">'
                             +'<div class="line-bottom"></div></div></div>';
             
                    } 
                   fypage++; 
                } else { 
                }
                isappend = true; 
                $('#ajaxdiv').html(xszf);
            }, "json");
        }
         
        function detail(id){
         window.location.href='${ctx}/suc/memorial!detail.action?custid=${custid}&lscode=${lscode}&_id='+id;
        }
        function ajaxsel(){
          sel = $('#sel').val().replace('搜索', '');
          fypage = 0;
          state=1;
          $('ajaxdiv').html('');
          ajaxweb(false);
          
        }
    </script>
</head>
<body>
<main class="cmp640">
     <div class=" line-bottom-92 position-f overflow-hidden cmp640 width-10"style="top: 0px;left: 0px;z-index:9;">
        <div class="div-group-10 bg-hei overflow-hidden">
            <div class="pull-left col-10 bg-bai" style="border-radius: 3px 0px 0px  3px ;">
                <div class="clear width-10 maring-a txt-c hang30 mt-5 position-r">
                    <input class=" width-10 txt-c line-height30 zi-hui " style="background-color: transparent" type="text"
                           id="sel"
                           value="搜索" onfocus="if(value=='搜索'){value=''}"
                           onblur="if (value ==''){value='搜索'}">
                </div>
            </div>
            <div class="col-2 txt-c bg-bai hang30" style="border-radius: 0px 3px 3px 0px ; padding-top: 2px;" onclick="ajaxsel()">
              <div class=" line-left1" style="height: 26px;line-height: 26px;">
                  <i class="fa fa-search zi-hui"style="line-height: 26px;"></i>
              </div>
            </div>
        </div>
        <font size="2">
            <div class="clear position-r" style=" z-index:3;">
                <div class="hang40 pt-5 bg-hui-92 weight100 yListr2 zi-hei">
                    <li class="button_group1 hang30 line-height32 txt-c line-bottom-red" id="1">
                        香火最旺
                    </li>
                    <li class="button_group1 hang30 line-height32 txt-c" id="2">
                        亲友最活跃
                    </li>
                    <li class="button_group1 hang30 line-height32 txt-c" id="3">
                        与我相关馆
                    </li>
                </div>
            </div>
        </font>
    </div>

    <div class="hang90 clear"></div>

    <div id="ajaxdiv"></div>
    <div class="hang50 clear"></div>
</main> 
<!--底部按钮-->
<%@ include file="/webcom/memorial-foot.jsp" %>
<script> 
ajaxweb(false);
$(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) {  
             ajaxweb(true);
            
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