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
    <title>提现明细</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/> 
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/> 
    <script src="${contextPath}/mvccol/js/fomatdate2.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
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
	    		    xszf+='<div class="line-bottom zi-6 overflow-hidden txt-c">'
	    		      +''; 
	    		      xszf+='<div class="col-7 pt-15 pb-10"><font size="2">'+Date.prototype.format(v[i].createdate)+'</font></div>';
	    		     
	    		      xszf+='<div class="col-2 pt-15 pb-10"><font size="2">-'+v[i].price+'</font></div></div>'; 
	    		   
	    		   
				 }
	    		fypage++;
				 
	    		
	    	}else{
	    		
	    	}
	    	
	    	issend=true;
			$('#ajaxdiv').html(xszf);
			 
	},"json")
	
}
 
    </script>
</head>
<body>
 

<main class="lock cmp640" id="section1"> 
     

    <div class="txt-c zi-cheng  div-group-5">

        <div class="line-left1 line-top line-bottom line-right border-radius5"> 

            <div class="line-bottom  zi-6 overflow-hidden txt-c weight500" style="border-radius:5px 5px 0px 0px ;"> 
                <div class="col-7 pt-15 pb-10"><font size="2">时间</font></div>
                <div class="col-2 pt-15 pb-10"><font size="2">佣金</font></div>
            </div>
             
            <!--循环列表开始-->
            
            <div id="ajaxdiv"></div>
         
            <!--下面代码不要删除或者循环--> 
                <div class="zi-hui zi-green overflow-hidden txt-c"
                     style="border-radius:5px 5px 0px 0px ;">
                    <div class="col-15 pt-15 pb-10"><font size="2">以上是您的佣金提现明细</font></div>
                </div> 
        </div>
    </div> 

</main>
     <!--提现弹出层-->
        <div class="fullscreen cmp640 bg-hei-8 overflow-auto display-none div-group-5" id="tx_tcc">
            <div class="width-6 maring-a bg-bai border-radius5" style="margin-top: 30%">
                <div class="hang50 div-group-10 line-bottom">
                    <font size="2">
                        <input class="width-10 zi-hui-tq weight500 txt-c" style="line-height:31px;height:28px;" type="text"
                               id="price"
                               value="请输入提现金额(1-200)"
                               onfocus="if(this.value=='请输入提现金额(1-200)'){this.value=''};this.style.color='black';"
                               onblur="if(this.value==''||this.value=='请输入提现金额(1-200)'){this.value='请输入提现金额(1-200)';this.style.color='#aaa';}"/>
                    </font>
                </div>
                <div class="overflow-hidden">
                    <font size="2"> 
                            <div class="txt-c zi-hui-tq col-6 pt-5 pb-5 line-right" onclick="hide_tcc()">
                                取消
                            </div>  
                            <div class="txt-c zi-hui-tq col-6 pt-5 pb-5" onclick="wxtx()">
                                确认
                            </div> 
                    </font>
                </div>
            </div>
   </div>
<script type="text/javascript">
ajaxjz();
$(window).scroll(function () {

    var offsetY = $(window).scrollTop();

    var section1 = $("#section1").height();
	if(section1-offsetY<600){
		ajaxjz(); 
	}
   
});
function hide_tcc(){
 $('#tx_tcc').hide();
}
function show_tcc(){
 $('#tx_tcc').show();
}
</script> 
</body>
</html>