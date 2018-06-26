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
    <title>祭奠-亲友圈</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
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
       var isappend=true;
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
                 fypage=0;
                 state=3;
                 ajaxweb(false); 
                }
            })
        })
          function ajaxweb(t) {
            if(!isappend){
              return;
            }
            var submitData = {
                id:'${id}'
            };
            isappend=false;
            var url='';
            if(state==1){
               url='${ctx}/suc/memorial!ajaxcircleweb.action?custid=${custid}&lscode=${lscode}&fypage='+fypage;
            }
            if(state==2){
               url='${ctx}/suc/memorial!ajaxfocusweb.action?custid=${custid}&lscode=${lscode}&fypage='+fypage;
            }
            if(state==3){
               url='${ctx}/suc/memorial!ajaxcirclefalseweb.action?custid=${custid}&lscode=${lscode}&fypage='+fypage;
            }
            $.post(url, submitData, function (json) {
                var xszf = ''; 
                var txt='<div class="pt-20" onclick="join()"><div class="line-height30 txt-c width-3 maring-a hang30 zi-bai btn-green border-radius3">申请加入亲友圈</div></div>';
                if(t){
                  xszf=$('#ajaxdiv').html();
                  xszf.replace(txt,'');
                }
                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) { 
                       xszf += '<div class="col-12 btn-bai pt-7 pb-5 hang60 line-bottom-92 overflow-hidden" style="line-height:20px;">'; 
                                xszf += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh45 img-bj  zi-bai txt-c border-radius50 " style="background-image:url(${filehttp}/' + v[i].headimgurl + ');"></div></div>'; 
                                xszf += '<div class="pull-left pt-15 pl-15 col-8"><div class="zi-hei size14 sl width-10">' 

                                + v[i].nickname + '</div></div>';
                                if(state==3&&'${isadmin}'=='ok'){
                                xszf +='<div class="pull-right col-2 pt-15" onclick="set(\''+v[i]._id+'\')"><div class="zi-hei size14  width-10">同意</div></div>';
                                } 
                                xszf +='</div>'; 
                    }
                    fypage++;
                } else {
                } 
                if('${isadmin}'!='ok'&&state==1){
                  xszf+=txt;
                } 
                isappend=true;
                $('#ajaxdiv').html(xszf);
            }, "json");
        }
        
         
        function join(){
          var submitData = {
               id:'${id}'
            };
            $.post('${ctx}/suc/memorial!ajaxcircleadd.action?custid=${custid}&lscode=${lscode}', submitData, function   (json) {
                
                if (json.state == 0) {
                  swal({ 
                     text: '申请成功！',
                     timer: 2000,
                     type:'success',
                     showConfirmButton: false
                     }).then(function () {}, 
                      function (dismiss) {
                    if (dismiss === 'timer') {
                         window.location.href='${ctx}/suc/memorial!circleweb.action?custid=${custid}&lscode=${lscode}&id=${id}';
                    }
                   }
                  );
                
                } else if(json.state==1){
                      swal({ 
                       text: '正在审核，请耐心等待！',
                       timer: 2000,
                       type:'warning',
                       showConfirmButton: false
                     }); 
                }else{
                     swal({ 
                       text: '申请失败！',
                       timer: 2000,
                       type:'error',
                       showConfirmButton: false
                     });
                }
                 
            }, "json");
        }
        function set(id){
          var submitData = {
               id:id,
               state:2
            };
            $.post('${ctx}/suc/memorial!ajaxcircleset.action?custid=${custid}&lscode=${lscode}', submitData, function (json) { 
                if (json.state == 0) {
                 alert('审核成功！');
                 window.location.href='${ctx}/suc/memorial!circleweb.action?custid=${custid}&lscode=${lscode}&id=${id}';
                }  
            }, "json");
        }
    </script>
</head>
<body>
<main class="cmp640">
    <div class=" line-bottom-92 position-f overflow-hidden cmp640 width-10" style="top: 0px;left: 0px;">
        <font size="2">
            <div class="clear position-r" style=" z-index:3;">
                <div class="hang40 pt-5 bg-hui-92 weight100 yListr2 zi-hei">
                    <li class="button_group1 hang30 line-height32 txt-c line-bottom-red" id="1">
                        亲友
                    </li>
                    <li class="button_group1 hang30 line-height32 txt-c" id="2">
                        关注
                    </li>
                    <c:if test="${isadmin=='ok'}">
                     <li class="button_group1 hang30 line-height32 txt-c" id="3">
                        待审核
                     </li>
                    </c:if>
                    
                    
                </div>
            </div>
        </font>
    </div>

    <div class="hang40 clear"></div>

    <div id="ajaxdiv"></div>
    <!--保存按钮是个公用的-->
    
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