<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ include file="/webcom/limit.jsp" %>
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
    <title></title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .ls-black {
            background-color: #010101;
        }

        .line-bai-1 {
            border: solid 1px white;
            padding-top: 4px;
            padding-bottom: 3px;
        }

        .line-bai-bottm {
            border-bottom: dashed 1px white;
        }
    </style>
    <script>
        function textCounter(field, countfield, maxlimit) {
            // 函数，3个参数，表单名字，表单域积分素名，限制字符；
            if (field.value.length > maxlimit)
            //如果积分素区字符数大于最大字符数，按照最大字符数截断；
                field.value = field.value.substring(0, maxlimit);
            else
            //在记数区文本框内显示剩余的字符数；
                countfield.value = maxlimit - field.value.length;
        }
        
    var issend=true;
    var fypage=0;
    var xszf="";
	var type=0;
   function ajaxjz(){
      if(!issend){
    	 return;
      }
   	  var submitData = {
   	     _id:'${entity._id}'  
      };
      issend=false; 
      $.post('${ctx}/suc/mark!ajaxwebcom.action?custid=${custid}&lscode=${lscode}&fypage='+fypage, submitData,
       	function(json) { 
    		var xszf=$('#ajaxdiv').html();
	    	if(json.state=='0'){
	    	  var  list=json.list;
	    	  for(var i=0;i<list.length;i++){
	    	      xszf+='<div class="position-r div-group-5 pt-10 pb-10 line-bai-bottm">'
	    	          +'<div class="overflow-hidden zi-bai" style="padding-left:45px;">'
	    	          +'<div class="size12 weight500 pr-5">'+v[i].nickname+'</div>'
	    	          +'<div class="pt-3 size12 line-height20 clear">'+v[i];
	    	          if(v[i].type==1){
	    	          xszf+='<img src="${ctx}/img/mark0/flower.png" class="img-wh10 ml-5"/>';
	    	          }else if(v[i].type==2){
	    	          xszf+='<img src="${ctx}/img/mark0/fire.png" class="img-wh10 ml-5"/>';
	    	          } 
	    	          xszf+='</div></div>'
	    	          +'<div class="position-a img-wh35" style="top:10px;">'
	    	          +'<div class="img-wh35 img-bj maring-a border-radius50" style="background-image: url(${filehttp}/'+v[i].headimgurl+')"></div>'
	    	          +'</div></div>';
	    	    
	    	  }
	    	  fypage++;
            }else{
            }
            issend=true;
			$('#ajaxdiv').html(xszf);
			 
 	},"json")
 }

  function comment() {
    var content=$.trim($('#content').val().replace('请输入您对老兵的悼念词',''));
    if(content.length==0){
       swal({
              text: '请输入您对老兵的悼念词！',
              timer: 1000,
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
    var submitData = {
    	 _id:'${entity._id}',
    	 type:type,
    	 content:content
    };
    $.post('${ctx}/suc/mark!ajaxaddcom.action?custid=${custid}&lscode=${lscode}', submitData,
    	function (json) {
        	if(json.state==0){ 
        	 window.location.href='${ctx}/suc/mark!webdetail.action?custid=${custid}&lscode=${lscode}&id=${entity._id}'; 
        	}
        },"json");
  }
   function  change(v){
      type==v;
      $('.ck').hide();
      if(v==1){
       $('#sub-h').find('img').attr('src','${ctx}/img/mark0/fire.png');
      }else if(v==2){
       $('#sub-h').find('img').attr('src','${ctx}/img/mark0/flower.png');
      } 
      $('#sub').show();
   }
   function cancel(){
     $('.ck').show();
     $('#sub').hide();
   }
    </script>
</head>
<body class=" ls-black">
<main class="cmp640 position-r overflow-auto">
    <div class="overflow-hidden width-10">
        <img class="width-10" src="img/banner.jpg"/>
    </div>
    <div class="width-10 position-a" style="top:1%;">
        <img src="${ctx}img/mark0/title.png" class="width-10 pb-15"/>
        <font size="1">
            <div class=" width-9 pt-15 pb-20 maring-a bg-hei-8 overflow-hidden"
                 style="border:solid 2px white;border-radius:8px;">

                <font size="4" class="ck">
                    <div class="txt-c display-none zi-bai pb-25">共有<i class="zi-hong pl-5 pr-5">50000</i>人参与祭奠</div>
                </font>
                <div class="col-6 ck">
                    <div class="width-4 maring-a" >
                        <img src="${ctx}img/mark0/rslz.png" class="width-10 pb-10"/>

                        <div class="zi-bai txt-c border-radius3 line-bai-1"  onclick="change(1)">
                            燃烛
                        </div>
                    </div>
                </div>
                <div class="col-6 ck" >
                    <div class="width-4 maring-a">
                        <img src="${ctx}img/mark0/xianhua.png" class="width-10 pb-10"/>

                        <div class="zi-bai txt-c border-radius3 line-bai-1" onclick="change(2)">
                            献花
                        </div>
                    </div>
                </div>

                <div class="overflow-hidden display-none zi-hui bg-bai width-9_5 maring-a border-radius5"
                     style="border:solid 1px white;" id="sub"> 
                <textarea  id="content" onfocus="if(this.value=='请输入您对老兵的悼念词'){this.value=''};this.style.color='#666666';"
                          onblur="if(this.value==''||this.value=='请输入您对老兵的悼念词'){this.value='请输入您对老兵的悼念词';this.style.color='#aaa';}"
                          rows="5" name="message" class="size14"
                          style="height:90px;" onKeyDown="textCounter(message,remLen,50);"
                          onKeyUp="textCounter(message,remLen,50);">请输入您对老兵的悼念词</textarea>
                        <input name="remLen" type="text" value="50字" size="5" readonly="readonly"
                               class="zi-hui size12 pl-2 pb-10 pull-right"/>
                     
                </div>
                <div class="width-9_5 maring-a pt-20">
                    <div class="hang30 pull-right border-radius3 size12 btn-bai weight500 pl-10 pr-10 txt-c zi-hui line-height30" onclick="comment()">
                        悼念
                    </div>
                    <div class="hang30 pull-right border-radius3 mr-15 size12 btn-bai weight500 pl-10 pr-10 txt-c zi-hui line-height30" onclick="cancel()">
                        取消
                    </div>
                    <div class="img-wh30 pull-left pt-5 mr-10 border-radius3" id="sub-h">
                        <img src="" class="width-10"/>
                    </div>
                </div>
            </div>
        </font>

        <div class="width-9 pt-20 pb-10 maring-a overflow-hidden " id="ajaxdiv"> 
        </div> 
    </div>
</main>
<script> 
ajaxjz();
$(window).scroll(function () {
    var offsetY = $(window).scrollTop();
    var section1 = $("#section1").height();
	if(section1-offsetY<600){
		ajaxjz();
	}
});
<script> 
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