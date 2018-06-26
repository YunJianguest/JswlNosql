<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>客服</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/> 
    
     <!--标准mui.css-->
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css"/>
    <!--App自定义的css--> 
    <link href="${ctx}/mvccol/mui-css/mui.picker.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/mui-css/mui.poppicker.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate2.js"></script>
    <script src="${ctx}/mvccol/js/fomatdate_js.js"></script>
    <style>
        .bg-fa82a5 {
            background-color: #fd6c8e;
        }

        .bottom-fa82a5 {
            background-color: #fd6c8e;
        }

        .bottom-fa82a5:hover, .bottom-fa82a5:focus {
            background-color: #e36280;
        }

        .lt-left {
            left: -10px;
            top: 10px;
            width: 0;
            height: 0;
            border-top: 15px solid #ffffff;
            border-left: 15px solid transparent;
        }

        .p-top-left-10 {
            top: 10px;
            left: 10px;
        }

        .lt-right {
            right: -10px;
            top: 10px;
            width: 0;
            height: 0;
            border-top: 15px solid #fa82a5;
            border-right: 15px solid transparent;
        }

        .pl-60 {
            padding-left: 60px;
        }

        .hang600 {
            height: 600px;;
        }

        .btn-bai-hui {
            background-color: #eef1f6;
        }

        .btn-bai-hui:hover, .btn-bai-hui:focus {
            background-color: #dddddd;
        }
        ::-webkit-scrollbar {
            width: 1px;
        } /* 这是针对缺省样式 (必须的) */
    </style>
    <script>
        var winheight = window.innerHeight;
        var rid='';
        var no='';
        var tid='';
        var headimgurl='';
        var nickname='';
        var issend = true;
        var fypage =0; 
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            } 
            var submitData = {  
            };
            issend = false;   
            $.post('${ctx}/suc/dating!datingServiceTrumpetWeb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) { 
                        var xszf =$('#ajaxService').html(); 
                        if (json.state == '0') {
                            var v = json.list; 
                            for (var i = 0; i < v.length; i++) {
                            if(v[i].obj!=null&&v[i].obj.no!=null){
                              xszf+='<div class=" overflow-hidden div-group-10 border-bottom-d9d9d9" onclick="getReplay(this,\''+v[i].obj.no+'\',\''+v[i].obj.headimgurl+'\',\''+v[i].obj.nickname+'\')">'
                                  +'<div class="img-wh40 position-r">'
                                  +'<img src="${filehttp}/'+v[i].obj.headimgurl+'" class="width-10">';
                                  if(v[i].uncount>0){
                                  xszf+='<div class="position-a bg-hong" style="top: -4px;right: -4px;border-radius: 10px;width:6px; height:6px;"></div>';
                                  } 
                                  xszf+='</div></div>'; 
                             }
                            
                            }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxService').html(xszf);
                        
                    }, "json")
        }
        function getReplay(v,id,picurl,name){
         $('#ajaxService').find('.div-group-10').removeClass('bg-bai');
         $(v).addClass('bg-bai');
         repfypage=0;
         $('#ajaxReplay').html('');
         ajaxReplay(id);
         no=id;
         headimgurl=picurl;
         nickname=name;
         
        }
        var  repissend=true;
        var  repfypage=0;
         function ajaxReplay(id) {//加载 
            if (!repissend) {
                return;
            } 
            var submitData = { 
              id:id 
            };
            repissend = false;   
            $.post('${ctx}/suc/dating!ajaxServiceMsg.action?custid=${custid}&lscode=${lscode}&fypage=' + repfypage, submitData,
                    function (json) {  
                        var xszf =$('#ajaxReplay').html(); 
                        if (json.state == '0') {
                       
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                              xszf+='<div class="hang60 overflow-hidden btn-bai-hui width-10 position-r border-bottom-d9d9d9" onclick="getMsg('+v[i]._id+',\''+v[i].ids+'\')">'
                                  +'<div class="pull-left img-wh40 position-a p-top-left-10 position-r">'
                                  +'<img src="${filehttp}/'+v[i].headimgurl+'" class="width-10">';
                                  if(v[i].uncount>0){
                                  xszf+='<div class="position-a bg-hong" style="top: -4px;right: -4px;border-radius: 10px;width:6px; height:6px;"></div>';
                                  } 
                                  xszf+='</div>'
                                  +'<div class="pt-10 pr-10 width-10 pl-60">'
                                  +'<font size="2">'
                                  +'<div class="hang20 line-height20 zi-hei-tq">'
                                  +'<div class="col-6 sl weight500">'+v[i].nickname+'</div>'
                                  +'<font size="2">'
                                  +'<div class="col-6 txt-r sl zi-hui-wx">'+v[i].endupdate+'</div>'
                                  +'</font></div></font>'
                                  +'<font size="2">'
                                  +'<div class="hang20 sl line-height20 zi-hui-wx">'+v[i].endmsg+'</div>'
                                  +'</font></div></div>';
                            
                            }
                            repfypage++;
                        } else {
                        }
                        repissend = true; 
                        $('#ajaxReplay').html(xszf);
                        
                    }, "json")
        }
        
          var  msgissend=true;
          var  msgfypage=0;
         function ajaxMsg(id) {//加载 
            if (!msgissend) {
                return;
            } 
            var submitData = { 
              id:id,
              fid:no
            };
            msgissend = false;   
            $.post('${ctx}/android/reply!ajaxdetailkf.action?custid=${custid}&lscode=${lscode}&fypage=' + msgfypage, submitData,
                    function (json) { 
                        var xszf =$('#ajaxMsg').html(); 
                        if (json.state == '0') {
                            var v = json.list;
                               for (var i = v.length - 1; i >= 0; i--) {
                                if (v[i].location == "right") {
                                    xszf+='<div class="width-10 pl-5 clear">'
                                        +'<div class="hang50 line-height50 txt-c zi-hui-wx">'
                                        +'<font size="1">'+Date.prototype.format(v[i].createdate)+'</font>'
                                        +'</div>'
                                        +'<div class="width-1 pull-left">'
                                        +'<div class="pr-10">'
                                        +'<div class=" maring-a clear img-wh35 img-bj zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/' + v[i].picurl + ');">'
                                        +'</div></div></div>'
                                        +'<div class="width-8 pull-left position-r">'
                                        +'<div class="position-a lt-left"></div>'
                                        +'<div class="div-group-10 bg-bai zi-6 border-radius5 position-r pull-left txt-l">'
                                        +'<div>'+v[i].content+'</div>'
                                        +'</div></div></div>';
                               
                                } else {
                                    xszf += '<div class="width-10 pr-5 pull-right clear">'
                                         +'<div class="hang50 line-height50 txt-c zi-hui-wx"><font size="1">'+Date.prototype.format(v[i].createdate)+'</font></div>'
                                         +'<div class="width-1 pull-right">'
                                         +'<div class="pl-10">'
                                         +'<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3"  style="background-image:url(${filehttp}/' + v[i].picurl + ');">'
                                         +'</div></div></div>'
                                         +'<div class="width-8 pull-right position-r">'
                                         +'<div class="position-a lt-right"></div>'
                                         +' <div class="div-group-10 bg-fa82a5 border-radius5 position-r pull-right zi-bai txt-l">'
                                         +'<div>'+v[i].content+'</div>'
                                         +'</div></div></div>';
                                     
                                }
                            }
                            msgfypage++;
                        } else {
                        }
                        msgissend = true; 
                        $('#ajaxMsg').html(xszf);
                        scrollmsg();
                        
                    }, "json")
        }
            function sendmsg() {  
            var time = new Date().Format("yyyy-MM-dd hh:mm:ss"); 
            var content = $('#msg').val(); 
            var msg = {
                "content": $('#msg').val(),
                "fromUserid":no,
                "fromNickname":nickname,
                "picurl":headimgurl,
                "toUserid": tid + ",",
                "rid": rid,
                "custid":'${custid}', 
            };
            if (content.length > 0) {
               // MsgService.sendMessage(msg);
               socket.send(JSON.stringify(msg));
                var html = $('#ajaxMsg').html();
                html += '<div class="width-10 pr-5 pull-right clear">'
                + '<div class="hang50 line-height50 txt-c zi-hui-wx">'
                + '<font size="1">'+time+'</font></div>'
                +'<div class="width-1 pull-right">'
                +'<div class="pl-10">'
                +'<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/'+headimgurl+');">'
                +'</div></div></div>'
                +'<div class="width-8 pull-right position-r">'
                +'<div class="position-a lt-right"></div>'
                +'<div class="div-group-10 bg-fa82a5 border-radius5 position-r pull-right zi-bai txt-l">'
                +' <div>' + content + '</div>'
                +'</div></div></div>';
                
                $('#ajaxMsg').html(html);
                $('#msg').val('');
                scrollmsg();
                     

            } else {
                alert("发送的内容不能为空！");
            }
        }
        function showMessage(data) {  
           remidMp3();
            var message = decodeURI(decodeURI(data.title));
            // var text = dwr.util.getValue("info");
            var xszf = $('#ajaxMsg').html();
            xszf += '<div class="width-10 pl-5 clear">'
            +'<div class="hang50 line-height50 txt-c zi-hui-wx">'
            +'<font  size="1">' + data.time+ '</font></div>'
            +'<div class="width-1 pull-left">'
            +'<div class="pr-10">'
            +' <div class=" maring-a clear img-wh35 img-bj zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/' + data.picurl + ');">'
            +'</div></div></div>'
            +'<div class="width-8 pull-left position-r">'
            +'<div class="position-a lt-left"></div>'
            +'<div class="div-group-10 bg-bai zi-6 border-radius5 position-r pull-left txt-l">'
            +'<div>' + data.content + '</div>'
            +'</div></div></div>'; 
            $('#ajaxMsg').html(xszf);
            scrollmsg();             
        }
         function txMessage(data) {   
         remidMp3();
         repfypage=0;
         $('#ajaxReplay').html('');
         ajaxReplay(no);
        }
        function kfMessage(data) {  
         remidMp3();
         fypage=0;
         $('#ajaxService').html('');
         ajaxjz();
        }
        function Init() {  
                var submitData = {
                   id:no, 
                 };
                 $.post('${ctx}/suc/dating!getCode.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {  
                     if(json.state==0){  
                        $('#btsend').attr('onClick', 'sendmsg()');
                       // dwr.engine.setActiveReverseAjax(true);
                        //dwr.engine.setNotifyServerOnPageUnload(true);
                        //MsgService.onPageLoads('${custid}', json.value, rid,'${lscode}'); 
                       } 
                    }, "json");
               
        }
         function scrollmsg() {
            document.getElementById("ajaxMsg").scrollTop = document.getElementById("ajaxMsg").scrollHeight;
        }
        
        function  hide_zl(){
          $('#tc_zl').hide();
        }
        function  show_zl(){
          $('#tc_zl').show();
        } 
        var u_name='';
        var u_sex='';
        var u_age='';
        var u_height='';
        var u_picurl='';
        var u_province='';
        var u_city='';
        function  ajaxSave(){
          u_name=$('#name').val().replace('请填写你的昵称','');
          u_picurl=$('#logo').val();
          if(u_name.length==0){
           alert('请填写昵称');
           return;
          }
          if(u_picurl.length==0){
           alert('请上传头像');
           return;
          }
             var submitData = {
    	         name:u_name,
    	         picurl:u_picurl,
    	         age:u_age,
    	         province:u_province,
    	         city:u_city, 
    	         height:u_height, 
    	         sex:u_sex 
	            }; 
		$.post('${ctx}/suc/dating!saveService.action?custid=${custid}&lscode=${lscode}', submitData,
        	 
        	 function(json){ 
        	  if(json.state==0){  
        	       hide_zl();
        	       fypage=0;
        	       $('#ajaxService').html('');
        	       ajaxjz();
        	  }else{ 
        	  
        	  }
        	 },"json");
        
        }
        function   getMsg(id,ids){
          Init();
          msgfypage=0;
          $('#ajaxMsg').html(''); 
          rid=id;
          ajaxMsg(id);
          tid=ids.replace(no,'').replace(',','');  
          delunfind(rid,no);
          
        }
         function delunfind(rid,id){
            var submitData = {
                rid:rid,
                id:id 
            };
            $.post('${ctx}/suc/dating!delunfind.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {  
                     if(json.state==0){ 
                         
                       } 
               }, "json");
        }
        
         //dwr.engine.setActiveReverseAjax(true);
         //dwr.engine.setNotifyServerOnPageUnload(true);
         //MsgService.onPageLoads('${custid}','','0','${lscode}'); 
    </script>
    
</head>
<body class="lock" style="background-color: #f0f0f0">
<div class=" overflow-hidden width-10 position-f"style="bottom:20px;">
    <div class="pt-10 clear">
        <div class="div-group-5 bg-hei-5 overflow-hidden maring-a" style="width:870px;">
            <div class="pull-left bg-hei-8 hang600 line-right position-r overflow-hidden" style="width:60px;">
                <div class="bg-hei-5 overflow-hidden border-bottom-d9d9d9 hang60 pt-10 width-10 position-a"
                     style="bottom: 0px;">
                    <div class="img-wh40 div-group-10 maring-a btn-bai" onclick="show_zl()">
                        <img src="${ctx}/img/dating/addimg.png" class="width-10">
                    </div>
                </div>
                <div class="overflow-auto" style="height: 540px;" id="ajaxService">
                     
                </div>
            </div>
            <div class="pull-left bg-hui-tx hang600 line-right overflow-auto" style="width:230px;" id="ajaxReplay">
            </div>
            <div class="pull-left div-group-5 bg-hui-tx hang600 position-r" style="width:570px;">
                <div  style="height: 460px; overflow:auto;" id="ajaxMsg"> 
                </div> 
                <div class="position-a zi-hui width-10 bg-hui-tx"
                     style="bottom:0px; right:0px;">
                    <div class="hang100 div-group-5 line-top">
                        <form action="">
                <textarea 
                          rows="5" name="message" class="size12 weight500 bg-hui-tx zi-hui-wx"
                          style="height:90px;" onfocus="scrollmsg()" id="msg"></textarea>
                        </form>
                    </div>
                    <div class="overflow-hidden pr-5 pb-5">
                        <font size="2">
                            <div class="pull-right width-1 bottom-fa82a5 txt-c zi-bai border-radius3"
                                 style="line-height:30px" id="btsend">发送
                            </div>
                        </font>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="fullscreen bg-hei-8 display-none" style="height: 100%; z-index: 5" id="tc_zl">
    <input type="hidden" id="logo"/>
    <div style="padding-top:5%">
        <div class=" maring-a bg-bai border-radius3 position-r"
             style="width:280px;height: 402px;">
            <div class="txt-c line-height40 line-bottom-92 weight500 zi-hui-wx hang40">资料填写</div>
            <div class="overflow-auto pl-5 pr-5 pt-5" style="height: 310px;">
                <div class="img-wh80 border-radius50 overflow-hidden"
                     style=" margin:0px auto 0px auto;border: solid 3px #ffffff;">

                    <!--有头像div-->
                    <!--<img src="img/touxiang.jpg" class="width-10">-->

                    <!--初始div-->
                    <div class="pull-left bg-hui-tx txt-c img-wh70 position-a position-r overflow-hidden"style=" border-radius: 100px;" onclick="pz('logo','200','200',false,this)">
                        <i class="fa fa-user-secret fa-3x zi-bai" style="line-height: 70px;"></i>
                        <!--无头像时显示的div-->
                        <div class="position-a width-10" style="bottom: 0px;left: 0px;">
                            <div class="hang25 line-height20 bg-hei-5 zi-bai"><font size="1">点击上传</font></div>
                        </div>
                    </div>

                </div>
                <div class="bg-bai">
                    <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                        <div class="pull-left">
                            昵称
                        </div>
                        <div class="pull-right line-height40 pt-3">

                            <input class="zi-fa82a5 txt-r zi-hui-wx"
                                   style="background-color: transparent;height:35px;line-height:35px;"
                                   type="text"
                                   id="name"
                                   value="请填写你的昵称"
                                   onfocus="if(this.value=='请填写你的昵称'){this.value=''};this.style.color='#fa82a5';"
                                   onblur="if(this.value==''||this.value=='请填写你的昵称'){this.value='请填写你的昵称';this.style.color='#fa82a5';}"/>
                        </div>
                    </div>
                    <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                        <div class="pull-left">
                            年龄
                        </div>
                        <div class="pull-right" id="age">
                            <div class="pull-left line-height40">
                                <i class="zi-fa82a5" id="setage">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                            </div>
                        </div>
                    </div>
                    <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                        <div class="pull-left">
                            性别
                        </div>
                        <div class="pull-right" id="sex">
                            <div class="pull-left line-height40">
                                <i class="zi-fa82a5" id="setsex">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                            </div>
                        </div>
                    </div>
                    <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                        <div class="pull-left">
                            身高
                        </div>
                        <div class="pull-right" id="height">
                            <div class="pull-left line-height40">
                                <i class="zi-fa82a5" id="setheight">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                            </div>
                        </div>
                    </div>
              
                    <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx" id="showCityPicker3">
                        <div class="pull-left">
                            所在地
                        </div>
                        <div class="pull-right">
                            <div class="pull-left line-height40">
                                <i class="" id="province">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                            </div>
                            <div class="pull-left pl-40 line-height40">
                                <i class="" id="city">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                            </div>
                        </div>
                    </div>
                    <div class="hang40"></div>
                </div>
            </div>
            <div class="hang50 line-top-92 pt-5">
                <div class="width-9 maring-a hang40 border-radius5 line-height40 txt-c btn-green zi-bai weight500" onclick="ajaxSave()">
                    确认保存
                </div>
            </div>
            <a href="javascript:hide_zl()">
                <div class="position-a" style="right:-7px;top:-7px;">
                    <div class="img-wh20 border-radius50 bg-hui-tx txt-c">
                        <font size="2">
                            <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                        </font>
                    </div>
                </div>
            </a>

        </div>

    </div>
    
 <%@include file="/webcom/cut-img1.jsp" %>
 
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
		    				"rid":rid
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
	 if(true){
		 remidMp3(); 
		 if(data.toUserid.indexOf(no)>=0&&no!=""){ 
			 if(data.rid==rid){
				 var time = new Date().Format("yyyy-MM-dd hh:mm:ss"); 
		         var xszf = $('#ajaxMsg').html();
		         xszf += '<div class="width-10 pl-5 clear">'
		         +'<div class="hang50 line-height50 txt-c zi-hui-wx">'
		         +'<font  size="1">' +time+ '</font></div>'
		         +'<div class="width-1 pull-left">'
		         +'<div class="pr-10">'
		         +' <div class=" maring-a clear img-wh35 img-bj zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/' + data.picurl + ');">'
		         +'</div></div></div>'
		         +'<div class="width-8 pull-left position-r">'
		         +'<div class="position-a lt-left"></div>'
		         +'<div class="div-group-10 bg-bai zi-6 border-radius5 position-r pull-left txt-l">'
		         +'<div>' + data.content + '</div>'
		         +'</div></div></div>'; 
		         $('#ajaxMsg').html(xszf);
		         scrollmsg();             
			 }else if(rid!=""){
				 $.post('${ctx}/user/remind!AddAllUnread.action?custid=${custid}&lscode=${lscode}&rid='+data.rid, {ids:data.toUserid}, function(json) {
				       if(json.state==0){ 
				    	   $("body").showTxt("show",{text:"您有一条来自"+data.fromNickname+"新消息"});
							 repfypage=0;
					         $('#ajaxReplay').html('');
					         ajaxReplay(no); 
				    	   
				       }else{ 
				       } 
				     }, "json");  
				
			 }
			
		 }else{
			 $.post('${ctx}/user/remind!AddAllUnread.action?custid=${custid}&lscode=${lscode}&rid='+data.rid, {ids:data.toUserid}, function(json) {
			       if(json.state==0){ 
			    	   $("body").showTxt("show",{text:"您有一条来自"+data.fromNickname+"新消息"});
						 fypage=0;
				         $('#ajaxService').html('');
						 ajaxjz(); 
			       }else{ 
			       } 
			     }, "json");  
			
		 }
		
	 }
	
};  
</script>
<!--MUIjs-->
<script src="${ctx}/mvccol/mui-js/mui.min.js"></script>
<script src="${ctx}/mvccol/mui-js/mui.picker.min.js"></script>

<script src="${ctx}/mvccol/mui-js/mui.poppicker.js"></script>

<script src="${ctx}/mvccol/mui-js/city.data.js" type="text/javascript" charset="utf-8"></script>
<script>
    (function ($, doc) { 
        $.init();
        $.ready(function () {

            var cityPicker3 = new $.PopPicker({
                layer: 2
            });
            cityPicker3.setData(cityData);
            var showCityPickerButton = doc.getElementById('showCityPicker3');
            var province = doc.getElementById('province');
            var city = doc.getElementById('city'); 
            showCityPickerButton.addEventListener('tap', function (event) {
                cityPicker3.show(function (items) {
                    province.innerHTML =(items[0] || {}).text;
                    u_province=(items[0] || {}).text;
                    city.innerHTML=(items[1] || {}).text;
                    u_city=(items[1] || {}).text; 
                });
            }, false);
            
            var agePicker = new $.PopPicker();
					agePicker.setData([{
						value: '16',
						text: '16岁'
					}, {
						value: '17',
						text: '17岁'
					}, {
						value: '18',
						text: '18岁'
					}, {
						value: '19',
						text: '19岁'
					}, {
						value: '20',
						text: '20岁'
					}, {
						value: '21',
						text: '21岁'
					}, {
						value: '22',
						text: '22岁'
					}, {
						value: '23',
						text: '23岁'
					}, {
						value: '24',
						text: '24岁'
					}, {
						value: '25',
						text: '25岁'
					}, {
						value: '26',
						text: '26岁'
					}, {
						value: '27',
						text: '27岁'
					}, {
						value: '28',
						text: '28岁'
					}, {
						value: '29',
						text: '29岁'
					}, {
						value: '30',
						text: '30岁'
					}, {
						value: '31',
						text: '31岁'
					}, {
						value: '32',
						text: '32岁'
					}, {
						value: '33',
						text: '33岁'
					}, {
						value: '34',
						text: '34岁'
					}, {
						value: '35',
						text: '35岁'
					}, {
						value: '36',
						text: '36岁'
					}, {
						value: '37',
						text: '37岁'
					}, {
						value: '38',
						text: '38岁'
					}, {
						value: '39',
						text: '39岁'
					}, {
						value: '40',
						text: '40岁'
					}, {
						value: '41',
						text: '41岁'
					}, {
						value: '42',
						text: '42岁'
					}, {
						value: '43',
						text: '43岁'
					}, {
						value: '44',
						text: '44岁'
					}, {
						value: '45',
						text: '45岁'
					}, {
						value: '46',
						text: '46岁'
					}, {
						value: '47',
						text: '47岁'
					}, {
						value: '48',
						text: '48岁'
					}, {
						value: '49',
						text: '49岁'
					}, {
						value: '50',
						text: '50岁'
					}, {
						value: '51',
						text: '51岁'
					},{
						value: '52',
						text: '52岁'
					},{
						value: '53',
						text: '53岁'
					},{
						value: '54',
						text: '54岁'
					}, {
						value: '55',
						text: '55岁'
					}]);
					
					var setting_age_button = doc.getElementById('age');
					var setting_age = doc.getElementById('setage');
					setting_age_button.addEventListener('tap', function(event) {
						agePicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setage.innerText=items[0].text;
							u_age=items[0].value;
						});
					}, false);
				 
					//身高
					var heightPicker = new $.PopPicker();
					heightPicker.setData([{
						value: '140',
						text: '140cm'
					}, {
						value: '141',
						text: '141cm'
					}, {
						value: '142',
						text: '142cm'
					}, {
						value: '143',
						text: '143cm'
					}, {
						value: '144',
						text: '144cm'
					}, {
						value: '145',
						text: '145cm'
					}, {
						value: '146',
						text: '146cm'
					}, {
						value: '147',
						text: '147cm'
					}, {
						value: '148',
						text: '148cm'
					}, {
						value: '149',
						text: '149cm'
					}, {
						value: '150',
						text: '150cm'
					}, {
						value: '151',
						text: '151cm'
					}, {
						value: '152',
						text: '152cm'
					}, {
						value: '153',
						text: '153cm'
					}, {
						value: '154',
						text: '154cm'
					}, {
						value: '155',
						text: '155cm'
					}, {
						value: '156',
						text: '156cm'
					}, {
						value: '157',
						text: '157cm'
					}, {
						value: '158',
						text: '158cm'
					}, {
						value: '159',
						text: '159cm'
					}, {
						value: '160',
						text: '160cm'
					}, {
						value: '161',
						text: '161cm'
					}, {
						value: '162',
						text: '162cm'
					}, {
						value: '163',
						text: '163cm'
					}, {
						value: '164',
						text: '164cm'
					}, {
						value: '165',
						text: '165cm'
					}, {
						value: '166',
						text: '166cm'
					}, {
						value: '167',
						text: '167cm'
					}, {
						value: '168',
						text: '168cm'
					}, {
						value: '169',
						text: '169cm'
					}, {
						value: '170',
						text: '170cm'
					}, {
						value: '171',
						text: '171cm'
					}, {
						value: '172',
						text: '172cm'
					}, {
						value: '173',
						text: '173cm'
					}, {
						value: '174',
						text: '174cm'
					}, {
						value: '175',
						text: '175cm'
					},{
						value: '176',
						text: '176cm'
					},{
						value: '177',
						text: '177cm'
					},{
						value: '178',
						text: '178cm'
					},{
						value: '179',
						text: '179cm'
					},{
						value: '180',
						text: '180cm'
					},{
						value: '181',
						text: '181cm'
					},{
						value: '182',
						text: '182cm'
					},{
						value: '183',
						text: '183cm'
					},{
						value: '184',
						text: '184cm'
					},{
						value: '185',
						text: '185cm'
					},{
						value: '186',
						text: '186cm'
					},{
						value: '187',
						text: '187cm'
					},{
						value: '188',
						text: '188cm'
					}, {
						value: '189',
						text: '189cm'
					}, {
						value: '190',
						text: '190cm'
					}, {
						value: '191',
						text: '191cm'
					}]);
					
					var setting_height_button = doc.getElementById('height');
					var setting_height = doc.getElementById('setheight');
					setting_height_button.addEventListener('tap', function(event) {
						heightPicker.show(function(items) {  
							setting_height.innerText=items[0].text;
							u_height=items[0].value;
						});
					}, false);
			 
					
					var qqPicker = new $.PopPicker();
					qqPicker.setData([{
						value: '0',
						text: '公开'
					}, {
						value: '1',
						text: '保密'
					}]);
					 
					
					var telPicker = new $.PopPicker();
					telPicker.setData([{
						value: '0',
						text: '公开'
					}, {
						value: '1',
						text: '保密'
					}]);
				 
					
					var wxPicker = new $.PopPicker();
					wxPicker.setData([{
						value: '0',
						text: '公开'
					}, {
						value: '1',
						text: '保密'
					}]);
				 
					 
					//交友目的
					var purposePicker = new $.PopPicker();
					purposePicker.setData([{
						value: '0',
						text: '结婚'
					}, {
						value: '1',
						text: '交友'
					}]);
				 
					//性别
					var sexPicker = new $.PopPicker();
					sexPicker.setData([{
						value: '1',
						text: '男'
					}, {
						value: '2',
						text: '女'
					}]);
					
					var setting_sex_button = doc.getElementById('sex');
					var setting_sex = doc.getElementById('setsex');
					setting_sex_button.addEventListener('tap', function(event) {
						sexPicker.show(function(items) {  
							setting_sex.innerText=items[0].text;
							u_sex= items[0].value;
						});
					}, false);
				 
					//婚姻状态
					var marriagePicker = new $.PopPicker();
					marriagePicker.setData([{
						value: '0',
						text: '未婚'
					}, {
						value: '1',
						text: '已婚'
					}, {
						value: '2',
						text: '离异'
					}, {
						value: '3',
						text: '丧偶'
					}]);
					 
					//收入状态
					var incomePicker = new $.PopPicker();
					incomePicker.setData([{
						value: '0',
						text: '2000元以下'
					}, {
						value: '1',
						text: '2000-5000元'
					}, {
						value: '2',
						text: '5000-10000元'
					}, {
						value: '3',
						text: '10000元以上'
					}]);
					 
					//学历状态
					var recordPicker = new $.PopPicker();
					recordPicker.setData([{
						value: '0',
						text: '高中'
					}, {
						value: '1',
						text: '技校'
					}, {
						value: '2',
						text: '中专'
					}, {
						value: '3',
						text: '本科'
					}, {
						value: '4',
						text: '硕士'
					}, {
						value: '5',
						text: '博士'
					}]);
				 
					//职业状态
					var professionalPicker = new $.PopPicker();
					professionalPicker.setData([{
						value: '0',
						text: '各类专业、技术人员'
					}, {
						value: '1',
						text: '办事人员和有关人员'
					}, {
						value: '2',
						text: '商业工作人员'
					}, {
						value: '3',
						text: '服务性工作人员'
					}, {
						value: '4',
						text: '其他'
					}]);
				 
					//星座状态
					var constellationPicker = new $.PopPicker();
					constellationPicker.setData([{
						value: '0',
						text: '白羊座'
					}, {
						value: '1',
						text: '金牛座'
					}, {
						value: '2',
						text: '双子座'
					}, {
						value: '3',
						text: '巨蟹座'
					}, {
						value: '4',
						text: '狮子座'
					}, {
						value: '5',
						text: '处女座'
					}, {
						value: '6',
						text: '天秤座'
					}, {
						value: '7',
						text: '天蝎座'
					}, {
						value: '8',
						text: '射手座'
					}, {
						value: '9',
						text: '摩羯座'
					}, {
						value: '10',
						text: '水瓶座'
					}, {
						value: '11',
						text: '双鱼座'
					}]);
					 
				 
					
					//恋爱观念
					var conceptPicker = new $.PopPicker();
					conceptPicker.setData([{
						value: '0',
						text: '慰藉型'
					}, {
						value: '1',
						text: '友情型'
					}, {
						value: '2',
						text: '理想型'
					}, {
						value: '3',
						text: '志趣型'
					}, {
						value: '4',
						text: '功利型'
					}, {
						value: '5',
						text: '情爱型'
					}]);
				 
					//首次见面
					var firstmeetPicker = new $.PopPicker();
					firstmeetPicker.setData([{
						value: '0',
						text: '学校'
					}, {
						value: '1',
						text: '网吧'
					}, {
						value: '2',
						text: '广场'
					}, {
						value: '3',
						text: '商场'
					}, {
						value: '4',
						text: '公园'
					}, {
						value: '5',
						text: '咖啡厅'
					}, {
						value: '6',
						text: '河边'
					}, {
						value: '7',
						text: '海边'
					}, {
						value: '8',
						text: '宾馆'
					}, {
						value: '9',
						text: '家'
					}]);
				 
					
					//约会地点
					var likeDatingSitePicker = new $.PopPicker();
					likeDatingSitePicker.setData([{
						value: '0',
						text: '学校'
					}, {
						value: '1',
						text: '网吧'
					}, {
						value: '2',
						text: '广场'
					}, {
						value: '3',
						text: '商场'
					}, {
						value: '4',
						text: '公园'
					}, {
						value: '5',
						text: '咖啡厅'
					}, {
						value: '6',
						text: '河边'
					}, {
						value: '7',
						text: '海边'
					}, {
						value: '8',
						text: '宾馆'
					}, {
						value: '9',
						text: '家'
					}]);
			 
					//体重状态
					var weightPicker = new $.PopPicker();
					weightPicker.setData([{
						value: '30',
						text: '30kg'
					}, {
						value: '31',
						text: '30kg'
					}, {
						value: '32',
						text: '32kg'
					}, {
						value: '33',
						text: '33kg'
					}, {
						value: '34',
						text: '34kg'
					}, {
						value: '35',
						text: '35kg'
					}, {
						value: '36',
						text: '36kg'
					}, {
						value: '37',
						text: '37kg'
					}, {
						value: '38',
						text: '38kg'
					}, {
						value: '39',
						text: '39kg'
					}, {
						value: '40',
						text: '40kg'
					}, {
						value: '41',
						text: '41kg'
					}, {
						value: '42',
						text: '42kg'
					}, {
						value: '43',
						text: '43kg'
					}, {
						value: '44',
						text: '44kg'
					}, {
						value: '45',
						text: '45kg'
					}, {
						value: '46',
						text: '46kg'
					}, {
						value: '47',
						text: '47kg'
					}, {
						value: '48',
						text: '48kg'
					}, {
						value: '49',
						text: '49kg'
					}, {
						value: '50',
						text: '50kg'
					}, {
						value: '51',
						text: '51kg'
					}, {
						value: '52',
						text: '52kg'
					}, {
						value: '53',
						text: '53kg'
					}, {
						value: '54',
						text: '54kg'
					}, {
						value: '55',
						text: '55kg'
					}, {
						value: '56',
						text: '56kg'
					}, {
						value: '57',
						text: '57kg'
					}, {
						value: '58',
						text: '58kg'
					}, {
						value: '59',
						text: '59kg'
					}, {
						value: '60',
						text: '60kg'
					}, {
						value: '61',
						text: '61kg'
					}, {
						value: '62',
						text: '62kg'
					}, {
						value: '63',
						text: '63kg'
					}, {
						value: '64',
						text: '64kg'
					}, {
						value: '65',
						text: '65kg'
					}, {
						value: '66',
						text: '66kg'
					}, {
						value: '67',
						text: '67kg'
					}, {
						value: '68',
						text: '68kg'
					}, {
						value: '69',
						text: '69kg'
					}, {
						value: '70',
						text: '70kg'
					}, {
						value: '71',
						text: '71kg'
					}, {
						value: '72',
						text: '72kg'
					}, {
						value: '73',
						text: '73kg'
					}, {
						value: '74',
						text: '74kg'
					}, {
						value: '75',
						text: '75kg'
					}, {
						value: '76',
						text: '76kg'
					}, {
						value: '77',
						text: '77kg'
					}, {
						value: '78',
						text: '78kg'
					}, {
						value: '79',
						text: '79kg'
					}, {
						value: '80',
						text: '80kg'
					}, {
						value: '81',
						text: '81kg'
					}, {
						value: '82',
						text: '82kg'
					}, {
						value: '83',
						text: '83kg'
					}, {
						value: '84',
						text: '84kg'
					}, {
						value: '85',
						text: '85kg'
					}, {
						value: '86',
						text: '86kg'
					}, {
						value: '87',
						text: '87kg'
					}, {
						value: '88',
						text: '88kg'
					}, {
						value: '89',
						text: '89kg'
					}, {
						value: '90',
						text: '90kg'
					}, {
						value: '91',
						text: '91kg'
					}, {
						value: '92',
						text: '92kg'
					}, {
						value: '93',
						text: '93kg'
					}, {
						value: '94',
						text: '94kg'
					}, {
						value: '95',
						text: '95kg'
					}]);
				  		
        }); 
    })(mui, document);
   
</script>
<script> 
  $("#ajaxService").scroll(function () {
        var offsetY = $(ajaxService).scrollTop(); 
        var section1 = $("#ajaxService").height();
        if (section1 - offsetY > 100) {  
            ajaxjz();
        }
    });
  ajaxjz(); 
  function remidMp3(){
    var audio = new Audio("${ctx}/mp3/noti.mp3");
    audio.play();
  } 
</script>
</body>
</html>