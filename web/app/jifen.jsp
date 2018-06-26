<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>激活</title>
    <link href="${ctx }/cmp/css/cmpjh.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${ctx}/js/jquery-1.8.3.js" ></script>
	<script src="${ctx }/js/WeixinApi.js" type="text/javascript"></script>

<script type="text/javascript">

function jifenpay(){
	

	var submitData = {
			
		};
		$.post('${ctx }/cmp/pingche!wxpay.action?toUser=${toUser}', submitData,
		function(data) {
			if (data.success == true) {
				WeixinJSBridge.invoke('getBrandWCPayRequest',{
			  		 "appId" : data.appId,"timeStamp" : data.timeStamp, "nonceStr" : data.nonceStr, "package" : data.package,"signType" : "SHA1", "paySign" : data.paySign 
			   			},function(res){
								alert(res.err_msg);
								alert(res.err_code + res.err_desc + res.err_msg);
						});
				return;
			} else {
				$("#no").val('');
				alert(data.msg);
			}
		},
		"json")
}
function shuaxin(){
	if('${method}'==''){
		window.location.href='${ctx}/shop/shop!member.action?toUser=${toUser}';
	}else{
		window.location.href='${method}';
	}
	  
}
</script>
</head>

<body>

<div class="jh">
    <div class="button xg">
        <div class="wz2" onclick="jifenpay()" >购买积分</div>
    </div>
</div>


</body>

</html>

