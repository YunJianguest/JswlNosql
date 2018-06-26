var Chat = new function(){

 /**发送聊天信息*/
 this.sendMsg = function(){  
  //消息内容
  var msg = $("#msg").val();
  //房间ID
  var roomid=$("#roomid").val();
  //聊天类型
  var type=$("#type").val();
  //聊天对象
  var touserid=$("#touserid").val();
  var touserimg=$("#touserimg").val();
  //发布时间
  var time = new Date();
  //toUser
  var toUser=$("#toUser").val(); 
  //发送人
  $("#fromuserid").val($("#userName").val());
  var fromuserid=$("#fromuserid").val();
  var fromuserimg=$("#fromuserimg").val();
   
  if (msg == null || jQuery.trim(msg) == ""){alert("请输入内容");return;}
     var obj={
		"msg" : msg,  
        "insdate" : time,
        "type":type,
        "touserid":touserid,
        "touserimg":touserimg,
        "roomid":roomid,
        "fromuserid":fromuserid,
        "fromuserimg":fromuserimg,
        "toUser":toUser
	  };
	  dwr.util.setValue("msg", ""); 
	  ChatService.sendMessage(obj); 
  
 };
 
 /**接受聊天信息*/
 this.receive = function(data){
  if (data == null || data == ""){
   return;
  } 
  var message = decodeURI(decodeURI(data.msg));  
  // var text = dwr.util.getValue("info"); 
  var html='';
  if(showtime==true){
	 html='<div class="hang30 clear"></div><div class="pt-15 txt-c zi-hui weight500" id="ShowTime">'+data.insdate+'</div>'; 
	 showtime=false;
  }
  if($("#userName").val()==data.fromuserid){
	  
	  html+='<div class="col-10 pt-20 pull-right clear"><div class="col-10 position-r" style="right: 1px;">'
	    	+'<div class="position-a" style="right:-10px; top:20px;  width: 0;height: 0;border-top: 15px solid  #b1e866;border-right: 15px solid transparent;"></div>'
	        +'<div class="div-group-10 pt-15 pb-15 bj-lu4 border-radius5 position-r pull-right font-widthauto">'
	        +'<div>'+message+'</div>' 
	        +'</div> </div> <div class="col-2"><div class="pl-10">';
	   
	  if(data.fromuserimg==""){
		  html+='<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius50 " style="background-image:url(http://stc.weimob.com/img/sns/2.png);">'
		        +'</div> </div> </div></div>';
		 
	  }else{
		  html+='<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius50 " style="background-image:url('+data.fromuserimg+');">'
	        +'</div> </div> </div></div>';
	  }
	       
  }else{
	 
	  html+='<div class="col-10 pt-20 clear"><div class="col-2"><div class="pr-10">';
	    if(data.touserimg==""){
	      
	       html+='<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius50 " style="background-image:url(http://stc.weimob.com/img/sns/2.png);">'
			   +'</div> </div> </div>';
     	}else{
     		 html+='<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius50 " style="background-image:url('+data.touserimg+');">'
			   +'</div> </div> </div>';
     	}	   
	     
	   html+='<div class="col-10 position-r">'
	       +'<div class="position-a" style=" left:-10px; top:20px;  width: 0;height: 0;border-top: 15px solid  #fff;border-left: 15px solid transparent;"></div>'         
	       +'<div class="div-group-10 pt-15 pb-15 bg-bai border-radius5 position-r pull-left font-widthauto">'
	       +'<div>'+message+'</div>' 
	       +'</div></div></div>' ; 
  }
        
  
    $('#chat_text').append(html);  
    $("html, body").scrollTop($("body").outerHeight(true)-$(window).outerHeight(true));
 };
  
 /**用回车键进行发送消息*/
 this.keySendMsg = function(e){
  e = e || event;
  if(e.keyCode == 13){
   this.sendMsg();
  }
 }
}