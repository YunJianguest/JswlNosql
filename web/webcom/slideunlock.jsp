<%@ page contentType="text/html;charset=UTF-8" %>
 <div id="slider">
    <div id="slider_bg"></div>
    <span id="label">>></span> <span id="labelTip">拖动滑块验证</span> </div>
  <link href="${ctx}/slideunlock/slide-unlock.css" rel="stylesheet">
  <script src="${ctx}/slideunlock/jquery.slideunlock.js"></script> 
  <script>
    $(function () {
        var slider = new SliderUnlock("#slider",{
				successLabelTip : "验证成功！"	
			},function(){
				 
            	checkOK();
        	});
        slider.init();
    })
</script>  