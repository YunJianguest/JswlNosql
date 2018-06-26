<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>${title}</title>
<meta name="viewport" charset="utf-8"
	content="width=device-width, initial-scale=1">
	<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
<link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet"> 
<!--全局样式结束-->
<!--全局脚本开始-->
<script src="${ctx }/app/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
<link href="${ctx }/app/css/style_0.css" rel="stylesheet"> 
<script>
 $(function(){
   if('${user._id}'=="notlogin"){
   alert("请先登录！");
   window.location.href="${ctx}/user/fromuser!UserDetail.action?custid=${custid}";
  }
});
function CheckMail(mail) { 
 var filter  =/^(?:\w+\.?)*\w+@(?:\w+\.)*\w+$/;
 if (filter.test(mail)) return true;
 else {
 alert('您的电子邮件格式不正确');
 return false;}
}
   function submit(){ 
          var  tel=$('#tel').val(); 
          if(!(/^1[3|4|5|7|8]\d{9}$/.test(tel))){ 
          alert("手机号码有误，请重填");  
          return; 
          }  
         var submitData = {  
            tel:tel, 
            headimgurl:$('#headimgurl').val(),
            qq:$('#qq').val(),
            wxid:$('#wxid').val(), 
        }; 
        $.post('${ctx}/user/fromuser!savedetatil.action?custid=${custid}&lscode=${lscode}', submitData,
        	function (json) {
            	if(json.state==0){
            		 alert("修改成功");
            		 window.location.href='${ctx}/user/fromuser!UserDetail.action?custid=${custid}&lscode=${lscode}';
            	}
            },"json")
        }
</script>
</head>
<body>  
<main id="section1" class="cmp640">   
	<input name="headimgurl" id="headimgurl" value="${user.headimgurl}" type="hidden"/>

    <div class="line-bottom overflow-hidden pl-15 pr-15">
        <div class="pull-left hang50 weight500 zi-hei-tq" style="line-height:59px;">
            头像
        </div>
        <div class="pull-right ">
            <a href="javascript:pz('headimgurl','200','200',false,'logo')">
                <div class="pt-5">
                    <div class="img-wh40 border-radius3 overflow-hidden" id="logo">
                        <img src="${filehttp}/${user.headimgurl}" width="100%">
                    </div>
                </div>
            </a>
        </div>
    </div>
  
    <div class="overflow-hidden weight500 pl-15 pr-15">
        <div class="pull-left hang50 line-height50 zi-hei-tq">
            QQ号
        </div>
        <div class=" pull-right hang50">
            <input class="width-10 size12 txt-r zi-hui weight500 hang50 line-height50" type="text" id="qq" name="qq"
                   value="${user.qq}" placeholder="请输入QQ号">
        </div>
    </div>

    <div class="hang10 bg-hui"></div>

    <div class="line-bottom overflow-hidden weight500 pl-15 pr-15">
        <div class="pull-left hang50 line-height50 zi-hei-tq">
            微信号
        </div>
        <div class=" pull-right hang50">
            <input class="width-10 size12 txt-r zi-hui weight500 hang50 line-height50" type="text" id="wxid" name="wxid"
                   value="${user.wxid}" placeholder="请输入微信号">
        </div>
    </div>
  
    <div class="overflow-hidden weight500 pl-15 pr-15">
        <div class="pull-left hang50 line-height50 zi-hei-tq">
            手机号码
        </div>
        <div class=" pull-right hang50">
            <input class="width-10 size12 txt-r zi-hui weight500 hang50 line-height50" type="text" id="tel" name="tel"
                   value="${user.tel}" placeholder="请输入手机号"
                   >
        </div>
    </div>

    <div class="hang10 bg-hui"></div>
    
     <div class=" clear mt-30" onclick="submit()">
         <div class="width-9_5 maring-a btn-green zi-bai div-group-10 maring-a size14 txt-c weight500 border-radius5 lock">确认保存
         </div>
     </div>
  
		
</main>	
<%@include file="/webcom/cut-image.jsp"%>
<script type="text/javascript">
 
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
		    title: '${menu.name}', // 分享标题
		    desc: '${menu.summary}', // 分享描述
		    link: '${token.url}', // 分享链接
		    imgUrl: '${osshttp}${menu.picurl}', // 分享图标
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