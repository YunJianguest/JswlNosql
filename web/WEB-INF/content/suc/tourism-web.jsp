<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
    <title>${title }</title>
    <!-- Resource style -->
    <script type="text/javascript" src="/CcjhNosql/cmp/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/cmp/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx }/cmp/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx }/cmp/css/style_0.css" rel="stylesheet"> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx }/cmp/js/main.js"></script>
    <script type="text/javascript" src="/CcjhNosql/cmp/js/iscroll.js"></script>   
    <link rel="stylesheet" href="${ctx}/wwz/css/bbsmain.css" />
    <link rel="stylesheet" href="${ctx}/wwz/css/bbsdialog.css" /> 
    <!-- Resource style -->
    <script type="text/javascript" src="${ctx}/wwz/js/bbspics.js"></script>
    <script type="text/javascript" src="${ctx}/wwz/js/bbsinput.js"></script>
    <script type="text/javascript" src="${ctx}/wwz/js/bbsmain.js"></script>
    <script type="text/javascript" src="${ctx}/wwz/js/bbsdialog.js"></script>
    <script type="text/javascript" src="${ctx}/wwz/js/bbshelper.js"></script>
    <script type="text/javascript" src="${ctx }/cmp/js/swipe.js"></script>
   
    <script>
        $(function () {
            new Swipe(document.getElementById('banner_box'), {
                speed: 500,
                auto: 3000,
                callback: function () {
                
                }
            });
        });
      
    </script>
    
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
    	"sel":$('#sel').val()
    };

    issend=false;
    $.post('${ctx}/suc/tourism!ajaxweb.action?toUser=${toUser}&fypage=' + fypage, submitData,
       	function(json) {
    		var xszf=$('#ajaxdiv').html();
	    	if(json.state==0){
	    		var v = json.list;
	    		for(var i=0;i<v.length;i++){
					xszf+='<a href="${ctx}/suc/tourism!detail.action?toUser=${toUser}&fromUser=${fromUser}&_id='+v[i]._id+'">'
					      +'<div class="col-12 size14 pb-5 line-bottom overflow-hidden">'
					      +'<div class="div-group-5">'
					      +'<div class="size14 sl width-10">'+v[i].title+'</div>'
					      +'<div class="zi-hei pt-5 clear">'+v[i].summary+'</div>'
					      +'<div class="pt-10 pb-10"><img src="${osshttp}/'+v[i].picurl+'" width="100%"></div>'
					      +'<div class="size12 zi-hui pull-left">'+v[i].insdate+'</div>'
					      +'<div class="size12 pull-right">'
					      +'<span class="pr-10 zi-hui click-red"><i class="fa fa-thumbs-up pr-5" onclick="aa()"></i><i id="a">'+v[i].ydl+'</i></span>'
					      +'<a href="javascript:xianshi1()">'
					      +'<span class="zi-hui click-red">'
					      +'<i class="fa fa-comments pr-5"></i><i>'+v[i].comcount+'</i>'
					      +'</span></a></div></div></div></a>';
					   
				}
	    		fypage++;
	    		
	    	}else{
	    		
	    	}
	    	issend=true;
			$('#ajaxdiv').html(xszf);
			
	},"json")
	
}
function xz_title(){
	$('#seldiv').show();
}
function gb(){
	$('#seldiv').hide();
}  

function praiseTrends(thi,flag,trendsid) {
		 
		$.post('${ctx}/suc/tourism!trendspraise.action?toUser=${toUser}&fromUser=${fromUser}&type=${type}&trendsid='+trendsid+"&flag="+flag, function(res) {
			 
			if (res.length>0) {
				$(thi).find('label').html(res);
				if(flag){
				    $(thi).find('span').removeClass('zi-lu');
					$(thi).find('span').addClass('zi-hui'); 
					
					$(thi).attr('onclick','praiseTrends(this,false,'+ trendsid +');');
				}else{
				    $(thi).find('span').removeClass('zi-hui');
					$(thi).find('span').addClass('zi-lu');
				   
					$(thi).attr('onclick','praiseTrends(this,true,'+ trendsid +');');
				}
			}else {
				alert("请求失败...","1000");
			}
		});
	} 
</script>
<script>
        $(document).ready(function () {

            var _objscroll = {
                win: $(window),
                doc: $(document),
                gotopdiv: $('#gotop')
            };

            _objscroll.win.scroll(function () {
                if (_objscroll.win.scrollTop() > _objscroll.win.height()) {
                    _objscroll.gotopdiv.show();
                } else {
                    _objscroll.gotopdiv.hide();
                }

            });

            _objscroll.gotopdiv.click(function () {
                _objscroll.win.scrollTop(0);
                return false;

            });

        });
        function xiaoshi() {
            $('#tanchu').hide();
        }
        function xianshi() {
            $('#tanchu').show();
        }
        
  function gettype(ths){
    if(ths.checked==true){
     type+=ths.value+",";
    }
  }  
  
  function submit(){
		var title = $("#form_title").val(); 
		 
		if (!title) {
			alert("请输入标题", 2000);
			return;
		}  
		if(type=""){
		    alert("请选择栏目", 2000);
			return;
		}
		var submitData={
		 title:title,
		}
	  $.post('${ctx}/suc/bbs!ajaxiscf.action?toUser=${toUser}&fromUser=${fromUser}', submitData,
	   
	  function(json){
	     if(json.state=='0'){
	     
	     var ajaxurl="${ctx}/wwz/bbs!savetrends.action?toUser=${toUser}&fromUser=${fromUser}&type="+type+"&_id=${trends._id}"
		 
		 $('#form_1').attr("action",ajaxurl);
		 $('#form_1').submit(); 
		  
	     }else{
	       alert("请稍后再试！",2000);
	       return;
	     }
	  
	  });
		
		
		
		 
	}
	
	
function xlchange(key,value){
   $("#xl").html(value);
   $("#xlsel").hide();
   window.location.href='${ctx}/wwz/wwz!bmtbbs.action?type=${type}&toUser='+key;

}
function xlshow(){
   $("#xlsel").show();
}
function sel(){
$('#ajaxdiv').html('');
ajaxjz();

}
      
</script>

</head>
<body class="cmp640">
<main style="position: relative" id="section1">
<div class="hang40"></div>


    <!-- sel -->
   <div class="maring-a div-group-5 pb-5">
        <a href="#">
         <span class="col-10 zi-hong size16 weight500 ">
          <input class="width-10 pl-10 line-left1 line-bottom line-top zi-hui"
                 style="height: 38px; border-radius: 3px 0px 0px 3px;" type="text" name=""
                 value="" onfocus="javascript:if(this.value=='请输入关键字搜索')this.value='';">
       </span>
        </a>
        <a href="#">
        <span class="col-2 zi-hei">
           <div class="line-right line-bottom line-top fa fa-search width-10 txt-c fa-2x pt-5 "
                style="height: 38px; border-radius: 0px 3px 3px 0px;"></div>
        </span>
        </a>
    </div>

    
    <!-- sel -->
    
     
    <c:if test="${not empty advertisement}">
    <div id="banner_box" class="box_swipe overflow-hidden " style="width:100%">
        <ul>
        <c:forEach items="${advertisement}" var="bean">
       
            <li>
                <a href="${bean.url}">
                    <img src="${osshttp }${bean.picurl}" alt="${bean.title}" style="width:100%;"/>
                </a>
            </li>
        </c:forEach>
          
        </ul>
    </div>
   </c:if>
   
   
  <!-- tab -->
 
<!-- tab end-->


<c:if test="${not empty roll}">
 		<div class="pmd hang30">
			<marquee width=100%  direction=left align=middle border=0>
				<c:forEach items="${roll}" var="bean" >
					<a href="${bean.url }" >${bean.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</c:forEach>
			</marquee>
		</div>
 	
</c:if>

<div  id="ajaxdiv"></div>
 
  
</main>
 
<script type="text/javascript">
ajaxjz();
$(window).scroll(function () {

    var offsetY = $(window).scrollTop();

    var section1 = $("#section1").height();
	if(section1-offsetY<600){
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
</body>
</html>