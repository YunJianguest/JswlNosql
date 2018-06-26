$(function () {
	//init
	if($("#errorMessage").val() !="") {
		alert($("#errorMessage").val());
	}
	
	$("#btn_submit").click(function () {
		
		var t =$("#txt_mobile").val().replace(/\s/,"");
		
		if(t == "") {
			alert("亲，手机号不能为空1！");
			return;
		}
		var n=new RegExp(/^[1][3578][0-9]{9}$/);
		
		if(!n.test(t)){
			alert("亲，您的手机号填错了吧！");
			return;
		} 
		
		var p =$("#txt_password").val().replace(/\s/,"");
		
		if(p == "") {
			alert("亲，密码不能为空！");
			return;
		}
		
		var params = window.location.search.substring(1);
		
		var target = params.split('=');
		if(params.split('returnUrl').length == 2) {
			$("#returnUrl").val(target[1] + "=" + target[2]);
		}
		$("#loginform").submit();
	});
});