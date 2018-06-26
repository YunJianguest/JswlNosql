$(function () {
	//init
	if($("#errorMessage").val() !="") {
		alert($("#errorMessage").val());
	}
	var time = 30;
	$("#btnCode").click(function () {
		
		if($('#btnCode').hasClass('verify_disable') != '') {
			return;
		}
		var phoneNum =$("#txt_mobile").val().replace(/\s/,"");
		if(phoneNum == "") {
			alert("亲，手机号不能为空！");
			return;
		} else {
			var n=new RegExp(/^[1][34578][0-9]{9}$/);
			if(!n.test(phoneNum)){
				alert("亲，您的手机号填错了吧！");
				return;
			} 
		}
		
		countTimeOUT();
		jQuery.ajax( {  
			type : 'GET',  
			contentType : 'application/json',  
			url : '/verifyphonenumber.do?phoneNum=' +phoneNum,  
			dataType : 'json',  
			success : function(data) {  
			alert("验证码已发送到您手机.");
		 
		},  
		beforeSend: function() {
		},
		complete: function() {
	    },
		
		error : function() {  
		}  
		});  
	});
	
	
	$("#btn_submit").click(function () {
		
	var nn =$("#txt_nickname").val().replace(/\s/,"");
		
		if(nn == "") {
			alert("亲，昵称忘填了吧！");
			return;
		}
		
		var t =$("#txt_mobile").val().replace(/\s/,"");
		
		if(t == "") {
			alert("亲，手机号不能为空！");
			return;
		}
		var n=new RegExp(/^[1][3578][0-9]{9}$/);
		
		if(!n.test(t)){
			alert("亲，您的手机号填错了吧！");
			return;
		} 
		
		if($("#txt_password").length>0) {
			var p =$("#txt_password").val().replace(/\s/,"");
			
			if(p == "") {
				alert("亲，密码不能为空！");
				return;
			} else {
				if(p.length<6) {
					alert("亲，密码长度不能少于6位！");
					return;
				}
			}
		}
		
		
		if($("#txt_password2").length>0) {
			
			var p2 =$("#txt_password2").val().replace(/\s/,"");
			
			if(p2 == "") {
				alert("亲，密码不能为空！");
				return;
			} else {
				if(p != p2) {
					alert("亲，密码不一致！");
					return;
				}
			}
		}
		
		var tv =$("#txt_verifycode").val().replace(/\s/,"");
		
		if(tv == "") {
			alert("亲，短信验证码不能为空！");
			return;
		}
		
		if($("#txt_qqid").length >0){
			
			var qv =$("#txt_qqid").val().replace(/\s/,"");
			var qq=new RegExp(/^[0-9]{5,10}$/);
			
			if(qv != "") {
				if(!qq.test(qv)){
					alert("亲，您的QQ号填错了吧！");
					return;
				} 
			}
		}
		showWait();
		$("#loginform").submit();
	});
});
var time= 30;
function countTimeOUT() {
	time--;
	if(time >0){
		$("#btnCode").attr('class','verify_disable');
		$("#btnCode").text(time+"秒后可重发");
		
		setTimeout(countTimeOUT,1000);
	} else {
		$("#btnCode").text("重新获取");
		$("#btnCode").attr('class','verify_able');
		time =30;
	}
}