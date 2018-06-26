$(function () {
	//init
	queryCities('A');
	$("#letterlist").children('li').click(function(){
		var name=$(this).children('a').html();
		
		$("#citylist").children('h4').html(name);
		queryCities(name);
	});
	
	
	$("#backbtn").click(function(){
		
		history.back();
	});
	
	$("#hotcity").children('li').click(function(){
		var name=$(this).children('a').html();
		toPage(name);
	});
	
	
});

function queryCities(name) {
	jQuery.ajax( {  
		type : 'GET',  
		contentType : 'application/json',  
		url : '/queryCity.do?name=' +name,  
		dataType : 'json',  
		success : function(data) {  
		//alert(data);
		var f ="";
		if (data && data.success == "true") {  
			$.each(data.data, function(i, item) {  
				
				 f += "<li><a href='javascript:;' >"+item.chineseName
    					+"<\/a><\/li>";
			});  
			$("#cities").html(f);
			$("#cities").children('li').click(function(){
				var name=$(this).children('a').html();
				toPage(name);
			});

		}  
	},  
	beforeSend: function() {
		$("#shade").show();
		
	},
	complete: function() {
		$("#shade").hide();
    },
	
	error : function() {  
		alert("查询城市错误，请稍后刷新."); 
	}  
	});  
}

function showWait() {
	document.getElementById("running").style.visibility = "visible";
	window.setTimeout(hideWait, 10000);
	window.onunload = hideWait;
	} 

function hideWait() {
	document.getElementById("running").style.visibility = "hidden";
	} 

function toPage(name) {
	var params = window.location.search.substring(1);
	var target = params.split('=');
	var strCookie=document.cookie; 
	
	if(target[1]  == 'fromCity') {
		
		var arr,reg=new RegExp("(^| )"+"city_value"+"=([^;]*)(;|$)");
		
		if(arr=document.cookie.match(reg))
		{
			var values = unescape(arr[2]);
			
			var citys = values.split(",");
			
			var targetV1 = citys[1].split(":");
	    	if(targetV1[1] !="") {
	    		document.cookie="city_value=fromcity:" + escape(name) +",tocity:" +   escape(targetV1[1]);
	        } else {
	        	document.cookie="city_value=fromcity:" + escape(name) +",tocity:" + "";
	        }
			
			
		} else {
			document.cookie="city_value=fromcity:" + escape(name) +",tocity:" + "";
		}
		
		window.location.href=window.location.protocol+"//"+window.location.host+"/pages/route/publishRoute.jsp";
	} else if(target[1] =='toCity'){
		
		  var strCookie=document.cookie; 

		    var arr,reg=new RegExp("(^| )"+"city_value"+"=([^;]*)(;|$)");
		    
		    if(arr=document.cookie.match(reg))
		    {
		    	var values = unescape(arr[2]);

		    	var citys = values.split(",");

		    	var targetV2 = citys[0].split(":");

		    	if(targetV2[1] !="") {
		    		document.cookie="city_value=fromcity:" + escape(targetV2[1]) +",tocity:" + escape(name);
		        } else {
		        	document.cookie="city_value=fromcity:"  +",tocity:" + escape(name);
		        }
		    } else {
		    	document.cookie="city_value=fromcity:"  +",tocity:" + escape(name);
		    }
		window.location.href=window.location.protocol+"//"+window.location.host+"/pages/route/publishRoute.jsp";
	}else if(target[1] =='fromCityforS'){ 
		var arr,reg=new RegExp("(^| )"+"city_value"+"=([^;]*)(;|$)");
		
		if(arr=document.cookie.match(reg))
		{
			var values = unescape(arr[2]);
			
			var citys = values.split(",");
			
			var targetV1 = citys[1].split(":");
	    	if(targetV1[1] !="") {
	    		document.cookie="city_value=fromcity:" + escape(name) +",tocity:" +   escape(targetV1[1]);
	        } else {
	        	document.cookie="city_value=fromcity:" + escape(name) +",tocity:" + "";
	        }
			
			
		} else {
			document.cookie="city_value=fromcity:" + escape(name) +",tocity:" + "";
		}
		window.location.href=window.location.protocol+"//"+window.location.host+"/pages/route/searchRoute.jsp";
	}
	else if(target[1] =='toCityforS'){ 
		  var strCookie=document.cookie; 

		    var arr,reg=new RegExp("(^| )"+"city_value"+"=([^;]*)(;|$)");
		    
		    if(arr=document.cookie.match(reg))
		    {
		    	var values = unescape(arr[2]);

		    	var citys = values.split(",");

		    	var targetV2 = citys[0].split(":");

		    	if(targetV2[1] !="") {
		    		document.cookie="city_value=fromcity:" + escape(targetV2[1]) +",tocity:" + escape(name);
		        } else {
		        	document.cookie="city_value=fromcity:"  +",tocity:" + escape(name);
		        }
		    } else {
		    	document.cookie="city_value=fromcity:"  +",tocity:" + escape(name);
		    }
		window.location.href=window.location.protocol+"//"+window.location.host+"/pages/route/searchRoute.jsp";
	}
	else if(target[1] =='listCity'){ 
		window.location.href=window.location.protocol+"//"+window.location.host+"/latestRouteList.do?city=" + encodeURI(name);
	}
	
	else if(target[1] =='fromCityforU'){ 
		var arr,reg=new RegExp("(^| )"+"city_value"+"=([^;]*)(;|$)");
		
		if(arr=document.cookie.match(reg))
		{
			var values = unescape(arr[2]);
			
			var citys = values.split(",");
			
			var targetV1 = citys[1].split(":");
	    	if(targetV1[1] !="") {
	    		document.cookie="city_value=fromcity:" + escape(name) +",tocity:" +   escape(targetV1[1]);
	        } else {
	        	document.cookie="city_value=fromcity:" + escape(name) +",tocity:" + "";
	        }
			
			
		} else {
			document.cookie="city_value=fromcity:" + escape(name) +",tocity:" + "";
		}
		window.location.href=window.location.protocol+"//"+window.location.host+"/pages/route/updateRoute.jsp";
	}
	else if(target[1] =='toCityforU'){ 
		  var strCookie=document.cookie; 

		    var arr,reg=new RegExp("(^| )"+"city_value"+"=([^;]*)(;|$)");
		    
		    if(arr=document.cookie.match(reg))
		    {
		    	var values = unescape(arr[2]);

		    	var citys = values.split(",");

		    	var targetV2 = citys[0].split(":");

		    	if(targetV2[1] !="") {
		    		document.cookie="city_value=fromcity:" + escape(targetV2[1]) +",tocity:" + escape(name);
		        } else {
		        	document.cookie="city_value=fromcity:"  +",tocity:" + escape(name);
		        }
		    } else {
		    	document.cookie="city_value=fromcity:"  +",tocity:" + escape(name);
		    }
		window.location.href=window.location.protocol+"//"+window.location.host+"/pages/route/updateRoute.jsp";
	}
	else if(target[1] =='insuredCity'){ 
		
		document.cookie="insuredCity=" + escape(name)+";path=/";
		  
		window.location.href=window.location.protocol+"//"+window.location.host+"/pages/policy/insure.jsp";
	}
}