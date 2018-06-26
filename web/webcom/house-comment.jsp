<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/mvccol/js/fomatdate2.js"></script>
  <script>
    var issend=true;
    var fypage=0;
    var xszf="";
	var type="";
function ajaxjz(){//加载 
    if(!issend){
    	return;
    }  
   	var submitData = {  
    };
    issend=false; 
    $.post('${ctx}/suc/housecomment!ajaxweb.action?custid=${custid}&agid=${agid}&lscode=${lscode}&parentid=${entity._id}&fypage='+fypage, submitData,
       	function(json) {  
    		var xszf=$('#ajaxdiv').html(); 
	    	if(json.state=='0'){
	    		var v = json.list;
	    		 for(var i=0;i<v.length;i++){
	    		  xszf+='<div class="position-r pb-10 overflow-hidden line-bottom-92">'
	    		     +'<div class="pl-50 pt-15 overflow-hidden">'
	    		     +'<a href="#"><div class="weight500 pl-5 sl width-3 pull-left zi-hei-tq">'
	    		     +'<font size="2">'+v[i].name+'</font></div>'
	    		     +'<div class="size12 zi-hui pl-5 pull-right pr-5">'+v[i].sort+'楼</div>'
	    		     +'<div class="clear pt-10 pl-5 zi-hei weight500">'+v[i].content+'</div></a>'
	    		     +'<div class="overflow-hidden div-group-5 pt-10 clear clear weight500">'
	    		     +'<font size="1"><a href="#"><div class="pull-left pt-3 zi-6"><font size="1">'+Date.prototype.format(v[i].createdate)+'</font>'
	    		     +'</div></a></font></div></div>'
	    		     +'<div class="position-a img-wh50 pt-5" style="top:0px; left: 0px;">'
	    		     +'<div class="img-wh35 img-bj border-radius50 maring-a"';
	    		     if(v[i].headimg.indexOf("http")>0){
	    		     xszf+='style="background-image:url('+v[i].headimg+')"></div></div></div>';
	    		     }else{
	    		     xszf+='style="background-image:url(${filehttp}/'+v[i].headimg+')"></div></div></div>';
	    		     }
				}
	    		fypage++;
	    	}else{
	    	}
	    	issend=true;
			$('#ajaxdiv').html(xszf);
	},"json")
}
function showpl(){
$('#hy_tanchu').show();
}
function hidepl(){
$('#hy_tanchu').hide();
}
function submitcomment(){
  var submitData = { 
    	        parentid:'${entity._id}', 
    	        content:$("#hfcontent").val().replace('请输入评论',''),
	            };  
    $.post('${ctx}/suc/housecomment!ajaxsave.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
        	 function(json){
        	  if(json.state==0){ 
        	  window.location.reload();
        	  }else{
        	   alert("发表失败！");
        	  }
        	 },"json");
}
</script>
    <div class="overflow-hidden mb-10 cmp640 line-bottom-92 zi-hui-tq clear hang50 txt-c" style="line-height:50px;">
        ------------------------------ 评论内容 ------------------------------
    </div>
    <div class="hang30 line-height30 cmp640">
        <a href="javascript:showpl()">
            <div class="pull-right pl-15 zi-lan1 pr-5">
                <font size="2">
                    <i class="fa fa-pencil-square-o pr-5"></i>写评论
                </font>
            </div>
        </a>
    </div>
    <div class="cmp640"  id="ajaxdiv"></div>
<div class="hang40 clear"></div> 
<%@include file="/webcom/foot.jsp" %>
<div class="hang50 clear"></div>
<%@ include file="/webcom/house-foot.jsp" %>
<div class="fullscreen cmp640 bg-hei-8 lock display-none" id="hy_tanchu">
    <div class="position-r overflow-hidden width-10">
        <a href="javascript:hidepl()">
            <div class="width-10 overflow-hidden" style="height:1000px;">
            </div>
        </a>
        <div class="position-a width-10" style="top:0;left:0;">
            <div class=" div-group-5">
                <div class=" div-group-10  overflow-hidden bg-bai border-radius3">
                    <div class="col-12 ">
                        <form>
                    <textarea id="hfcontent" placeholder="请输入评论" onfocus="if(this.value=='请输入评论'){this.value=''};this.style.color='black';"
                              onblur="if(this.value==''||this.value=='请输入评论'){this.value='请输入评论';this.style.color='#aaa';}"
                              rows="5" class="form-control"></textarea>
                        </form>
                    </div>
                    <div class=" pt-5 pb-10 clear">
                        <a href="javascript:submitcomment()">
                            <div class="btn-green hang30 zi-bai txt-c size14 weight500 pull-right col-2 border-radius3">
                                评论
                            </div>
                        </a>
                        <a href="javascript:hidepl()">
                            <div class="btn-lan hang30 mr-10 zi-bai txt-c size14 weight500 pull-right col-2 border-radius3">
                                退出
                            </div>
                        </a>
                    </div>
                    <div class="display-none clear"id="tanchu-b2">
                        <div class="hang60 bg-cheng"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--结束-->
<script type="text/javascript">
ajaxjz();
$(window).scroll(function () {
    var offsetY = $(window).scrollTop();
    var section1 = $("#section1").height();
	if(section1-offsetY<700){
		ajaxjz();
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