<!DOCTYPE html>
<html>
<head>
<base  />
<link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=2.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<title>${company.name}</title>

<link href="/MyNosql/marker/mb/14/css/css.css" rel="stylesheet" type="text/css">

<link rel="/MyNosql/marker/mb/14/stylesheet" href="css/refresh.css" />
<script src="/MyNosql/marker/mb/14/js/jQuery.js"></script>

</head>
<body>

<div data-role="page" id="page_gbList"> 
<!-- 页头 -->


<div id="tuan" class="sckill">

<div id="wrapper_gb"  class="wrapper" style="top: -4px">
	 <#if (funcList?size>0)>
     <#list funcList as func>

		  <ul id="groupbuyList" data-page="1" data-pagaTotal="3">
          <#if func.name=="lstb1">
		        
				        <li>
				     
				        <table width="100%" border="0">
				          <tr>
				           <td width="110px"><a href="${func.url}">
		                   <img width="100px" height="66px" src="${osshttp}${func.picurl}">
				           </a></td>
				           <td valign="top">
				             <p>&nbsp;</p>
				          
						      <p>${func.summary}</p>
						        
				           </td>
				         </tr>  
				       </table>
				       
				   </li>
                   </#if>
                   <#if func.name="lstb2">
                         <li>
				     
				        <table width="100%" border="0">
				          <tr>
				           <td width="110px"><a href="${func.url}">
		                   <img width="100px" height="100px" src="${osshttp}${func.picurl}">
				           </a></td>
				           <td valign="top">
				             <p>&nbsp;</p>
                             <p>&nbsp;</p>
                             <p>${func.summary}</p>
						        
				           </td>
				         </tr>  
				       </table>
				       
				   </li>
                   </#if>
                   <#if func.name="lstb3">
                         <li>
				     
				        <table width="100%" border="0">
				          <tr>
				           <td width="110px"><a href="${func.url}"><div style="width:100px; height:100px; border-radius:100px; overflow:hidden">
		                   <img width="100px" height="100px" src="${osshttp}${func.picurl}"></div>
				           </a></td>
				           <td valign="top">
				             <p>&nbsp;</p>
                             <p>&nbsp;</p>
				          
						      <p>${func.summary}</p>
						        
				           </td>
				         </tr>  
				       </table>
				       
				   </li>
                   </#if>
                   <#if func.name="lstb4">
                         <li>
				     
				  	     
				        <table width="100%" border="0">
				          <tr>
				           <td width="110px"><a href="${func.url}"><div style="width:100px; height:100px; border-radius:10px; overflow:hidden">
		                   <img width="100px" height="100px" src="${osshttp}${func.picurl}"></div>
				           </a></td>
				           <td valign="top">
				             <p>&nbsp;</p>
                             <p>&nbsp;</p>
				          
						      <p>${func.summary}</p>
						        
				           </td>
				         </tr>  
				       </table>
				       
				   </li>
                   </#if>
		    
		  </ul>
          </#list>
		  
		  </#if>
		 
	</div>
</div>
  
</div>

 
</div>
</body>
 <script type="text/javascript">
    	$(document).ready(function() { 
		zanCount();
		share()
	});
    $(function () {
        new Swipe(document.getElementById('banner_box'), {
            speed: 500,
            auto: 3000,
            callback: function () {
                var lis = $(this.element).next("ol").children();
                lis.removeClass("on").eq(this.index).addClass("on");
            }
        });
    });
	function share() {
		
		$.post('/MyNosql/wwz/wwzajax!share.action?toUser=${toUser}&url='+encodeURIComponent(window.location.href), null,
    		function(data) {
    			wx.config({
    				debug: false,
    				appId: data.appid, 
    				timestamp: data.timestamp, 
    				nonceStr: data.noncestr, 
   	 				signature: data.signature,
    				jsApiList: [ 'checkJsApi',
                 		'onMenuShareTimeline',
                 		'onMenuShareAppMessage',
                 		'onMenuShareQQ',
                 		'onMenuShareWeibo'
                	 ] 
				});

			wx.ready(function(){
				var share={
		    		title: '${company.name}', // 分享标题
		    		desc: '${company.summary}', // 分享描述
		   			 link:  data.url, // 分享链接
		    		imgUrl: '${osshttp}${company.logo}', // 分享图标
		    		success: function () { 
		      
		    		},
		   	 		cancel: function () { 
		    			alert("别这样啦，好东西要和朋友分享的嘛！分享后我告诉你一个秘密哦！");
		    		}
			};
			wx.onMenuShareAppMessage(share);
			wx.onMenuShareTimeline(share);
			wx.onMenuShareAppMessage(share);
			wx.onMenuShareQQ(share);
			wx.onMenuShareWeibo(share);
		});
    	},"json");	
	}
</script>
</html>