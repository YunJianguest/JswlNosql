<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta property="qc:admins" content="5641314377603321663757" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>登 陆</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/> 
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <style>

        .hang66 {
            height: 66px;;
        }

        .width1180 {
            width: 1180px;;
        }

        .width100px {
            width: 100px;
            height: 35px;
            line-height: 35px;
        }

        .shadow-wai1 {
            -webkit-box-shadow: 0 0 5px rgba(140, 140, 140, .5);
            -moz-box-shadow: 0 0 5px rgba(140, 140, 140, .5);
            box-shadow: 0 0 5px rgba(140, 140, 140, .5);
        }

        .color {
            width: 120px;
            height: 40px;
            line-height: 45px;
            color: #717171;
        }

        .btn-d {
            background-color: #26a9e1;
        }

        .btn-d:hover {
            border: solid 2px #26a9e1;
            background-color: #ffffff;
            color: #26a9e1;
            line-height: 31px;
        }

        .btn-t {
            border: solid 2px #26a9e1;
            color: #26a9e1;
        }

        .btn-t:hover {
            background-color: #26a9e1;
            color: #ffffff;
        }

        .btn-tb {
            border: solid 1px #ccc;
            color: #666666;
        }

        .btn-tb:hover {
            border: solid 1px #26a9e1;
            background-color: #26a9e1;
            color: #ffffff;
        }
         .yqbtn {
            background-color: #ffffff;
            color: #ef8200;
        }

        .yqbtn:hover {
            background-color: #ef8200;
            color: #ffffff;
        }

        .yqbtn1 {
            background-color: #ffffff;
            color: limegreen;
        }

        .yqbtn1:hover {
            background-color: limegreen;
            color: #ffffff;
        }

        .bg-bai-8 {
            background-color: rgba(225, 225, 225, 0.9);
        }

        .line-bottom-c3c3c6 {
            border-bottom: 1px solid #c3c3c6;
        }
    </style>
   <script>
        var issend = true;
        var fypage =0;
        var cid='';
        var sid='';
       function ajaxshop() {
           if (!issend) {
                return;
            } 
            issend = false;
            var submitData = {
                 
            };
            $.post('${ctx}/shop/shopcustservice!getAllshop.action?', submitData,
                    function (json) {  
                     if(json.state==0){
                         var v = json.list;
                         var html='';
                         for(var i=0;i<v.length;i++){
                           html+='<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="setshop(\''+v[i].custid+'\',\''+v[i].name+'\','+v[i]._id+')">'+v[i].name+'</div>';
                           
                         }
                         $('#ajaxdiv').html(html);
                         issend = true;     
                       } 
                    }, "json");
        }
        function setshop(id,name,wid){
         cid=id;
         sid=wid;
         $('#shopn').html(name);
         hide_shop();
        }
   </script>
</head>
<body class="cmp640">
 
<div class="maring-a overflow-hidden clear" style="width: 300px;margin-top:120px;">

    <div class="line-lu overflow-hidden border-radius3">
        <font size="2"> 
                <div class="width-10 pl-15 pr-15 zi-hui-tq" style="line-height:42px;height:42px;"
                       id="shopn"  
                       onclick="show_shop()">选择店铺</div> 
        </font>
    </div>
    <div class="line-lu overflow-hidden border-radius3 mt-35">
        <font size="2"> 
                <input class="width-10 pl-15 pr-15 zi-hui-tq" style="line-height:42px;height:42px;" type="text"
                      placeholder="平台账号" id="uid" name="uid" 
                       > 
        </font>
    </div>

    <div class="line-lu overflow-hidden border-radius3 mt-35">
        <font size="2"> 
                <label>
                  <input class="width-10 pl-15 pr-15 zi-hui-tq" style="line-height:42px;height:42px;" type="password"
                           id="password" name="password" class="txt_input"
                           placeholder="登录密码" >
                </label> 
        </font>
    </div> 
    <div class="txt-c mt-40 border-radius3 weight500 zi-bai btn-d" style="line-height:42px;height:42px;" onclick="login()">
            <font class="size3">
                确认登录
            </font>
    </div> 
 

</div>


<!--黄页分类-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="shop_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_shop()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5" style="height:300px;overflow: auto;"  id="ajaxdiv">
                  
                 
                     
            </div>
            <a href="javascript:hide_shop()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 
<script>
 $(function(){
   $('#uid').val(localStorage.getItem('uid'));
   $('#password').val(localStorage.getItem('password'));
   if(localStorage.getItem('shopn')!=null){
    $('#shopn').html(localStorage.getItem('shopn'));
   } 
   cid=localStorage.getItem('cid');
   sid=localStorage.getItem('sid');
   if($('#uid').val()!=''&&$('password').val()!=''){
       //login(); 
    }    
 });

</script>
<script> 
 function  login(){  
        if($('#uid').val()==''){
         alert('请输入账号');
          return;
        } 
        if($('password').val()==''){
         alert('请输入密码');
          return;
        }  
        if(cid==null||sid==null){
         alert('请选择店铺');
          return;
        }
         
         var submitData = {
    	        id:$('#uid').val(),
    	        password:$('#password').val(),
    	        wid:sid,
    	        custid:cid
	            };  
       $.post('${ctx}/shop/shopcustservice!ajaxlogin.action?', submitData,
        	 
        	 function(json){ 
        	  if(json.state==0){
        	     if(localStorage.getItem('uid')==''||localStorage.getItem('uid')==null||localStorage.getItem('password')==''||localStorage.getItem('password')==null){
        
           swal({ 
                   text: "是否保存密码？",
                   type: 'warning',
                   showCancelButton: true,
                   confirmButtonColor: '#3085d6',
                   cancelButtonColor: '#d33',
                   confirmButtonText: '保存!',
                   cancelButtonText: '取消!',
                   confirmButtonClass: 'btn btn-success mr-15',
                   cancelButtonClass: 'btn btn-danger ml-15',
                   buttonsStyling: false
                  }).then(function () {
                      localStorage.setItem('uid',$('#uid').val());
                      localStorage.setItem('password',$('#password').val());
                      localStorage.setItem('shopn',$('#shopn').html());
                      localStorage.setItem('cid',cid);
                      localStorage.setItem('sid',sid);
                      
                      
                        window.location.href='${ctx}/android/reply!web.action?custid='+cid+'&lscode='+json.value;               
                 }, function (dismiss) {
                        window.location.href='${ctx}/android/reply!web.action?custid='+cid+'&lscode='+json.value; 
                           // dismiss can be 'cancel', 'overlay',
                           // 'close', and 'timer'
              if (dismiss === 'cancel') {
                                    
                }
             });
        
         
            }else{
               window.location.href='${ctx}/android/reply!web.action?custid='+cid+'&lscode='+json.value;  
            }  
        	 
        }else{
        	    alert("账号或密码错误！");
        }
        	  
      },"json");
     
     
    }
function hide_shop(){
 $('#shop_tc').hide();
}
function show_shop(){
 $('#shop_tc').show();
 ajaxshop();
}  
</script>
 
</body>

</html>