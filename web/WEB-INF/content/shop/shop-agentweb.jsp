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
    <title>佣金记录</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/> 
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/> 
    <script src="${contextPath}/mvccol/js/fomatdate2.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <style> 

        .web-site {
            margin-left: 125px;
        }

        .button-kong {
            width: 30px;
            height: 30px;
            line-height: 26px;
            border-top: solid 2px #eee;
            border-bottom: solid 2px #eee;
        }

        .line-height33 {
            line-height: 33px;
        }
          .bk {
            height: 70px;
            width: 70px;
        }
        .border-bottom-d9d9d9{
            border-bottom: solid 1px #d9d9d9;
            
        }
        .zi-353535{
            color: #353535;
        }
        .zi-bbbbbb{
            color: #bbbbbb;
        }
        .zi-9a9a9a{
            color: #9a9a9a;
        }
        .zi-d8d8d8{
            color: #d8d8d8;
        }
        .hang-sl-2{
            overflow: hidden;text-overflow:ellipsis;display: -webkit-box;-webkit-line-clamp:4;-webkit-box-orient:vertical;
        }
    </style>
    <script>
        var loading;
        function  loading(){
        var opts = {
		lines: 13, // The number of lines to draw
		length: 8, // The length of each line
		width: 4, // The line thickness
		radius: 13, // The radius of the inner circle
		corners: 1, // Corner roundness (0..1)
		rotate: 0, // The rotation offset
		color: '#FFF', // #rgb or #rrggbb
		speed: 1, // Rounds per second
		trail: 60, // Afterglow percentage
		shadow: false, // Whether to render a shadow
		hwaccel: false, // Whether to use hardware acceleration
		className: 'spinner', // The CSS class to assign to the spinner
		zIndex: 2e9, // The z-index (defaults to 2000000000)
		top: 'auto', // Top position relative to parent in px
		left: 'auto' // Left position relative to parent in px
	}; 
	   var target = document.createElement("div");
	   document.body.appendChild(target);
	   var spinner = new Spinner(opts).spin(target);
	  loading=iosOverlay({
		text: "Loading", 
		spinner: spinner
	   });
     }
    var issend=true;
    var fypage=0;
    var xszf=""; 
	 
  function ajaxjz(){//加载 
    if(!issend){
    	return;
    }
   
   	var submitData = { 
       state:'${state}'
    }; 
   
    issend=false;  
    $.post('${ctx}/shop/shop!ajaxagent.action?custid=${custid}&agid=${agid}&lscode=${lscode}&fypage='+fypage, submitData,
       	function(json) { 
    		var xszf=$('#ajaxdiv').html(); 
	    	if(json.state=='0'){
	    		var v = json.list; 
	    		 for(var i=0;i<v.length;i++){  
	    		    xszf+='<div class="pl-10 pr-10 pt-10 overflow-hidden">'
	    		      +'<div class="bg-bai border-radius5">'
	    		      +'<div class="hang30 line-bottom-98 zi-hui-tq weight500 overflow-hidden line-height30 pl-5 pr-5 zi-353535">'
	    		      +'<font size="1"><div class="col-9 sl">订单编号:<i class="pl-5">'+v[i].obj._id+'</i></div>' 
	    		      +'</font></div>';
	    		      
	    		            xszf+='<div class="clear div-group-10 position-r hang90 border-radius5">'
	    		         +'<div class=" position-a"><div class="img-bj bk border-radius3" style="background-image:url(${filehttp}/'+v[i].obj.headimgurl+');"></div>'
	    		         +'</div>'
	    		         +'<div style="padding-left:80px;">'
	    		         +'<font size="2">'
	    		         +'<div class="zi-6 weight500 sl">下单人：'+v[i].obj.nickname+'</div>'
	    		         +'</font>'
	    		         +'<div class=" pull-left weight500 width-10">'
	    		         +'<font size="1">';
	    		         if(v[i].kdcom!=null){
	    		           xszf+='<div class="clear sl hang30 weight100" style="line-height:35px;" onclick="getkd('+v[i].obj.kdno+')">'
	    		               +'<span class="zi-hui">'+v[i].kdcom+'<i class="zi-lan pl-5">'+v[i].obj.kdno+'</i><span class="zi-lan-tq pl-10">点击查看</span></span>'
	    		               +'</div>';
	    		               
	    		         }else{
	    		           xszf+='<div class="clear sl hang30 weight100" style="line-height:35px;">'
	    		               +'<span class="zi-hui"><span class="zi-lan-tq">暂无物流信息</span></span>'
	    		               +'</div>';
	    		         }
	    		         xszf+='<div class=" hang30 width-10 line-height30 zi-6">'  
	    		         +'<div class="col-9">共'+v[i].obj.count+'件商品<i class="pl-10 zi-hong">￥'+v[i].price.toFixed(2)+'元</i></div>';
	    		         if(v[i].obj.state==1){
	    		          xszf+='<div class="col-3 txt-r zi-bbbbbb">已下单</div>';
	    		         }else if(v[i].obj.state==2){
	    		          xszf+='<div class="col-3 txt-r zi-bbbbbb">待发货</div>';
	    		         }else if(v[i].obj.state==3){
	    		          xszf+='<div class="col-3 txt-r zi-bbbbbb">已发货</div>'; 
	    		         }else if(v[i].obj.state==5){
	    		          xszf+='<div class="col-3 txt-r zi-bbbbbb">已退款</div>';
	    		         } 
	    		         xszf+='</div></font></div></div></div>';
	    		      
	    		     xszf+='</div></div>';
	    		    
	    		  
	    		   
				 }
	    		fypage++;
				 
	    		
	    	}else{
	    		
	    	}
	    	
	    	issend=true;
			$('#ajaxdiv').html(xszf);
			 
	},"json")
	
}
  function  getkd(id){
   window.location.href='http://m.kuaidi100.cn/result.html#com=auto&no='+id;
  }
    </script>
</head>
<body class="bg-hui-92">
 

<main class="lock cmp640  lock " id="section1"> 
    <!--循环列表开始-->
            <div id="ajaxdiv"></div>
           
         
            <!--下面代码不要删除或者循环--> 
                <div class="zi-hui zi-green overflow-hidden txt-c"
                     style="border-radius:5px 5px 0px 0px ;">
                    <div class="col-15 pt-15 pb-10"><font size="2">以上是您的佣金获得明细</font></div>
                </div> 
    

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
 
</script> 
</body>
</html>