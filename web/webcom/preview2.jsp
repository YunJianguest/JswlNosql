<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
<link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet"> 
<script>
    function erweima_xiaoshi() {
        $('#erweima_tanchu').hide();
    }
    function erweima_xianshi() {
        $('#erweima_tanchu').show();
    }
</script>
<div class="fullscreen bg-hei-8 display-none" id="erweima_tanchu">
    <div style="padding-top:5%">
        <div class="div-group-15 maring-a bg-bai border-radius3 position-r"
             style="width:280px;height: 300px;">
            <div class="div-group-10">
                <div class="bg-hei-5 maring-a"id="code" style="width: 200px;height: 200px;"></div>
            </div>
            <div class="txt-c weight500 zi-hui-wx size12">微信扫描二维码进行支付</div> 
            <a href="javascript:erweima_xiaoshi()">
                <div class="position-a" style="right:-7px;top:-7px;">
                    <div class="img-wh20 border-radius50 bg-hui-tx txt-c"style="line-height:20px">
                        <font size="2">
                            <i class="fa fa-remove zi-green"></i>
                        </font>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/app/js/jquery.qrcode.js"></script>
<script type="text/javascript" src="${ctx}/app/js/qrcode.js"></script> 
<script type="text/javascript">
    function qrcode(str) {
         $('#code').html('');
         $('#code').qrcode({ 
		  width : "200",
          height : "200",
          text	: str, 
	     });	 
        erweima_xianshi();
    }
</script>