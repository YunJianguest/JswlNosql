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
    <title>代理店铺</title>
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
     
    }; 
   
    issend=false; 
    loading(); 
    $.post('${ctx}/shop/shop!ajaxagentshop.action?custid=${custid}&agid=${agid}&lscode=${lscode}&fypage='+fypage, submitData,
       	function(json) { 
       	   loading.hide();
    		var xszf=$('#ajaxdiv').html(); 
	    	if(json.state=='0'){
	    		var v = json.list; 
	    		 for(var i=0;i<v.length;i++){  
	    		    xszf += '<div class="col-12 btn-bai pt-7 pb-5 hang60 line-bottom-92 overflow-hidden" style="line-height:20px;" onclick="window.location.href=\'${ctx}/shop/shop!agentweb.action?custid=${custid}&lscode=${lscode}&agid='+v[i]._id+'\'">' ;
                                if (v[i].picurl != null) {
                                    xszf += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh45 img-bj  zi-bai txt-c border-radius50 " style="background-image:url(${filehttp}/' + v[i].picurl + ');"></div></div>';
                                } else {
                                    xszf += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh40  zi-hui txt-c border-radius50"><i class="fa fa-leaf fa-2dx line-height40"></i> </div></div>';
                                }
                                xszf += '<div class="pull-left pt-5 pl-15 col-8"><div class="zi-hei size14 sl width-10">' + v[i].name + '</div>'
                                + '<div class="zi-hui size12 sl"><font size="0.8">'+v[i].summary+'</font></div></div>' 
                                + '</div></div>';
	    		   
            
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
           <!--循环列表开始-->
            
            <div id="ajaxdiv"></div>
          
        </div>
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