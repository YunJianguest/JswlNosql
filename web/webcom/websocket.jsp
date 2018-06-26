<%@ page contentType="text/html;charset=UTF-8" %>
<script src="${ctx}/app/js/alert_show.js"></script>
<script >

var socket = new WebSocket("ws://www.pskjyf.com/websocket");  
socket.onopen = function() { 
		     $.post('${ctx}/user/remind!getUserid.action?custid=${custid}&lscode=${lscode}', null, function(json) {
		       if(json.state==0){ 
		    		var msg = {
		    				"init" : "init",
		    				"uid" : json.value,
		    				"custid" : "${custid}", 
		    			};
		    		socket.send(JSON.stringify(msg)); 
		       }else{ 
		       } 
		     }, "json"); 
	
};

socket.onclose = function(evt) { 
}
socket.onerror = function(evt) { 
} 
document.onkeydown = function(event){
	var e = event || window.event || arguments.callee.caller.arguments[0];
	if(e && e.keyCode == 13){ // enter 键
		emit();
	}
};
function encodeScript(data) {
	if(null == data || "" == data) {
		return "";
	}
	return data.replace("<", "&lt;").replace(">", "&gt;");
}
socket.onmessage = function(evt) {
	
	var data = JSON.parse(evt.data); 
	if(typeof(data.fromNickname)!="undefined"){
		 $.post('${ctx}/user/remind!AddUnread.action?custid=${custid}&lscode=${lscode}&rid='+data.rid, null, function(json) {
		       if(json.state==0){ 
		    	   $("body").showTxt("show",{text:"您有一条来自"+data.fromNickname+"新消息"});
		    	   if($("#uncount").length>0){
		    		   findUnfind();  
		    	   }
		    	   
		       }else{ 
		       } 
		     }, "json");  
	}else{ 
		 $("body").showTxt("show",{text:data.message});
	}
	
};  
</script>
