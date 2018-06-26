<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>${company.name }</title>
<meta name="keywords" content="${company.keyword}" />
<meta name="description" content="${company.keyword}" />
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">

<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes"> 
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">

<link href="/MyNosql/lanrenmb/mod/reset.css"  rel="stylesheet" type="text/css">
<link href="/MyNosql/lanrenmb/mod/mod32.css"  rel="stylesheet" type="text/css">
 <link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/public.css"  />
<link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/home.css" />
<script type="text/javascript" src="/MyNosql/lanrenmb/mod/jquery-1.10.2.min.js" ></script>
<script src="/MyNosql/lanrenmb/mod/swipe2.js" ></script>
</head>

<body>
<div id="wrap" class="clr">
  <div class="banner">  		
  					<div style="width:100%;align:center;margin:0 auto;" id="imageswzi" >
<style>
.pmd{background:url("/MyNosql/lanrenmb/zhengwu/pmd-bj.gif")/*tpa=http://www.lanrenmb.com/wap/334/static/css/pmd-bj.gif*/ repeat-x; height:38px;  line-height:38px; margin-bottom:2px;}
.box_swipe{
    overflow:hidden;
    position:relative;
}
.box_swipe ul{
    -webkit-padding-start: 0px;
}

.box_swipe>ol{
    height:20px;
    position: relative;
    z-index:10;
    margin-top:-25px;
    text-align:right;
    padding-right:15px;
}/* background-color:rgba(0,0,0,0.3); */
.box_swipe>ol>li{
    display:inline-block;
    margin:5px 0;
    width:8px;
    height:8px;
    background-color:#757575;
    border-radius: 8px;
}
.box_swipe>ol>li.on{
    background-color:#ffffff;
}



</style>

<div id="displayswipe" style="-webkit-transform:translate3d(0,0,0);" style="display:none;">
	  <div style="visibility: visible;" id="banner_box" class="box_swipe">
		<ul style="list-style: none outside none; width: 4480px; transition-duration: 500ms; transform: translate3d(-1920px, 0px, 0px);">
		  <#list picurl as pic> 
		  	<li style="width: 640px; display: table-cell; vertical-align: top;">
				<img src="/MyNosql${pic}"  style="width:100%;">
		  	</li>
      		
      		</#list> 		  
		</ul>
		<ol>
			 <#list picurl as pic> 
				 <li class=""></li>&nbsp;
		 </#list> 	
		 		
		 
		 		</ol>
	  </div>
	</div>
<#if (rollList?size>0)>
	<div class="pmd">
		<marquee width=100%  direction=left align=middle border=0>
			<#list rollList as roll> 
			<a href="${roll.url}" >${roll.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</#list> 
		</marquee>
	</div>
</#if>	

<script>
$(function(){
	$("#displayswipe").show();
	$("#displayone").hide();
	//var banner=Array;//banner列表记录


	/*
	var winwidth2= $("#windowwidth").val();
	var bili=$("#bili").val();
	bili=parseFloat(bili);
   	var height2=bili*winwidth2+"px";
   	var height2nopx=bili*winwidth2;
   	
   	
   	$("#imageswzi").css("height",height2);
   	$("#banner_box").css("height",height2);
   	*/
   	if(3==1){
      	$("#displayswipe").hide();
   		$("#displayone").show();
   		//$("#onebannerimg").css("height",height2);
   		//var banner0=Array;//一条banner记录
   		//$("#onebannerimg").attr("src",banner0.images);
    }

   	
	
   	
	new Swipe(document.getElementById('banner_box'), {
		speed: 500,
		auto: 3000,
		callback: function(){
			var lis = $(this.element).next("ol").children();
			lis.removeClass("on").eq(this.index).addClass("on");
		}
	});
});
</script>
</div>
</div>
	<#if (funcList?size>0)>
  	<div class="cont-box clr">
  		<#if funcList[0]??>
  		<#if funcList[0].method=="link">
		<a href="${funcList[0].url}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[0].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[0].name}</p></div>
		</a>
		<#else>
		<a href="/MyNosql/wwz/wwz!${funcList[0].method}.action?_id=1&type=${funcList[0].type}&toUser=${toUser}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[0].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[0].name}</p></div>
		</a>
		</#if>	
		</#if>	
	    
	    <#if funcList[1]??>
  		<#if funcList[1].method=="link">
		<a href="${funcList[1].url}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[1].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[1].name}</p></div>
		</a>
		<#else>
		<a href="/MyNosql/wwz/wwz!${funcList[1].method}.action?_id=1&type=${funcList[1].type}&toUser=${toUser}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[1].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[1].name}</p></div>
		</a>
		</#if>	
		</#if>
	    
		<#if funcList[2]??>
  		<#if funcList[2].method=="link">
		<a href="${funcList[2].url}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[2].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[2].name}</p></div>
		</a>
		<#else>
		<a href="/MyNosql/wwz/wwz!${funcList[2].method}.action?_id=1&type=${funcList[2].type}&toUser=${toUser}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[2].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[2].name}</p></div>
		</a>
		</#if>	
		</#if>
	    	  	  		  	  		  	  		   
   	</div>
    </#if>
    
    <#if (funcList?size>3)>
  	<div class="cont-box clr">
  		<#if funcList[3]??>
  		<#if funcList[3].method=="link">
		<a href="${funcList[3].url}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[3].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[3].name}</p></div>
		</a>
		<#else>
		<a href="/MyNosql/wwz/wwz!${funcList[3].method}.action?_id=1&type=${funcList[3].type}&toUser=${toUser}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[3].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[3].name}</p></div>
		</a>
		</#if>	
		</#if>	
	    
	    <#if funcList[4]??>
  		<#if funcList[4].method=="link">
		<a href="${funcList[4].url}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[4].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[4].name}</p></div>
		</a>
		<#else>
		<a href="/MyNosql/wwz/wwz!${funcList[4].method}.action?_id=1&type=${funcList[4].type}&toUser=${toUser}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[4].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[4].name}</p></div>
		</a>
		</#if>	
		</#if>
	    
		<#if funcList[5]??>
  		<#if funcList[5].method=="link">
		<a href="${funcList[5].url}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[5].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[5].name}</p></div>
		</a>
		<#else>
		<a href="/MyNosql/wwz/wwz!${funcList[5].method}.action?_id=1&type=${funcList[5].type}&toUser=${toUser}" >
			<div class="telbtn01" ><img src="/MyNosql${funcList[5].picurl}"  class='contentimgcl' width='100%'/><p>${funcList[5].name}</p></div>
		</a>
		</#if>	
		</#if>
	    	  	  		  	  		  	  		   
   	</div>
    </#if>
   

</div>

<#if (footList?size>0)>
<br>
<div class="posfixbot f14" style="text-align: center;">
	<dl>
		<#list footList as foot> 
		<dd>
			
			<a href="${foot.url}" ><img
				src="/MyNosql${foot.picurl}" ><font><p>${foot.name}</p>
			</font>
			</a>
			
		</dd>
		</#list>
		
	</dl>

</div>

</#if></body>
</html>


