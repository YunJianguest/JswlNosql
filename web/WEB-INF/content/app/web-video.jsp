<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/music/css/music90.css">

<script src="${contextPath}/music/js/player.js" ></script>

<link rel="stylesheet" type="text/css" href="${contextPath }/touchScroll/css/163css.css">
<script type="text/javascript" src="${contextPath }/touchScroll/js/touchScroll.js"></script>
<script type="text/javascript">
var videourl=[];
var adr=[];
<c:forEach items="${adverList}" var="list">
adr.push("${list.url}");
</c:forEach>
var i=0;
var  n=0;
<c:forEach items="${videolist}" var="list">
videourl.push("${list.url}");
if(i==adr.length){
i=0;
}
videourl.push(adr[i]);
i++;
</c:forEach>


var url="${entity.url}"; 

function change(){
       if(n==videourl.length){
       n=0;
       }
      if(gt.ended()){
         if(url=="video"){
          $("#example_video_1 source").attr("src",videourl[n]);
          $("#example_video_1_html5_api").attr("src",videourl[n]);
         }else{
         $("#example_video_1 source").attr("src",url);
          $("#example_video_1_html5_api").attr("src",url);
         }
        
         n++;
         gt.play();
        }
    }

 
function  chageurl(url){
for(var k=0;k<videourl.length;k++){
  if(videourl[k]==url){
    n=(k-1);
  }
}

$("#example_video_1 source").attr("src",videourl[n]);
$("#example_video_1_html5_api").attr("src",videourl[n]);
gt.play();
n++;

}
 </script>
 
 
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

<div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
   
    
	<div class="contentpanel">

	<div class="row">
    	<div class="col-md-5">
        	<div class="big-divice">
             
            	<div class="shouji"></div>
            	<div class="shouji_di"></div>
            	<div class="kuang"> 
             
             
            	<div style="width: 100%; height: 200px">
            	<%@include file="/webcom/video.jsp"%>
            	</div>
              	<div class="box-163css">
										<div id="wrapper">
											<div id="scroller">
												<ul id="thelist">
													<c:forEach items="${videolist}" var="bean" >
													<a href="javascript:chageurl('${bean.url}');">
													<li><img src="${ctx }/bracket/images/video.png" /> 
													<span>${bean.title}</span>
													</li></a></c:forEach> 
												</ul>
											</div>
										</div>
			    </div>
            	 
               	</div>
        	</div>
    	</div><!-- col-md-5 -->
	 
           
             
           
            
        
   		</div>
  
	
	</div>
	</div>
 
</section>
 
<script>
var t1=new TouchScroll({id:'wrapper','width':5,'opacity':0.7,color:'#555',minLength:20});
</script>
</body>
</html>
