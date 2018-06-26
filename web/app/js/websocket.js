
var socket = new WebSocket("ws://localhost:8080/CcjhNosql/websocket"); 

function send(msg) { 
	msg = JSON.stringify(msg); 
	socket.send(msg); 
}
socket.onopen = function() {
		var msg = {
				"init" : "init",
				"uid" : "123456789",
				"custid" : "123456789123456789",
				"type" : "test",
			};
		socket.send(JSON.stringify(msg)); 
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
        
