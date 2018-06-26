<%@ page contentType="text/html;charset=UTF-8"%> 
 <script src="${ctx }/video/js/video.js"></script>
  <!-- Unless using the CDN hosted version, update the URL to the Flash SWF -->
 <link href="${ctx }/video/css/video-js.css" rel="stylesheet" type="text/css">
  <script>
    videojs.options.flash.swf = "${ctx }/video/video-js.swf";

  </script>
 
 
  <video id="example_video_1"  class="video-js vjs-default-skin" controls preload="none" width="100%" height="100%"
    
     poster="${ctx }/video/bjs.jpg" data-setup="{}">
   
   <c:if test="${not empty adverList}">
   <c:forEach items="${adverList}" var="list" begin="0" end="0">
   <source src="${list.url}" type='video/mp4' />
   </c:forEach>
   </c:if>
   <c:if test="${empty adverList}">
   <c:forEach items="${videolist}" var="list" begin="0" end="0">
   <source src="${list.url}" type='video/mp4' />
   </c:forEach>
   </c:if> 
     
  
  </video>
<script>
  var gt;
  
  videojs("example_video_1").ready(function(){
        var myPlayer = this;
        gt=myPlayer;
        myPlayer.play();
   
    });
   setInterval(change,1000);
  
</script>
 
 