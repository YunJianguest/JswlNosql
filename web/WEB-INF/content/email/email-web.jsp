<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>${title}</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"> 
    <style>
       .bg-bai-8 {
            background-color: rgba(225, 225, 225, 0.9);
        }

        .line-bottom-c3c3c6 {
            border-bottom: 1px solid #c3c3c6;
        }
    </style>
    <script>
    var issend=true;
    var fypage=0;
    var js="";
    var id="";
    var toUserid='';
    var state=0; 
	 
  function ajaxjz(tg){//加载 
     var url="";
      if(state==0){
        url='${ctx}/email/email!ajaxinbox.action?custid=${custid}&lscode=${lscode}&fypage='+fypage;
      }else{
        url='${ctx}/email/email!ajaxoutbox.action?custid=${custid}&lscode=${lscode}&fypage='+fypage;
      }  
    if(!issend){
    	return;
    } 
   	var submitData = { 
        state:0
    }; 
   
    issend=false; 
    $.post(url, submitData,
       	function(json) {
       	    var  js=''; 
       	    if(tg){
       	        js=$('#ajaxdiv').html(); 
       	      }  
	    	if(json.state=='0'){ 
	    	 	var v = json.list; 
	    		
	    		 for(var i=0;i<v.length;i++){   
	    		     js+='<div class="col-12 btn-bai pt-7 pb-5 hang60 line-bottom-92 overflow-hidden" style="line-height:20px;">';
                           if(state==1){
                           js += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh45 img-bj  zi-bai txt-c border-radius50 " style="background-image:url(${filehttp}/' + v[i].fromheadimgurl + ');"></div></div>';
                          }
                          if(state==0){
                           js += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh45 img-bj  zi-bai txt-c border-radius50 " style="background-image:url(${filehttp}/' + v[i].fromheadimgurl + ');"></div></div>';
                          } 
                          if(state==1){
                             js+= '<div class="pull-left pt-15 pl-15 col-8" onclick="detail('+v[i]._id+',1)"><div class="zi-hei size14 sl width-10">发给' + v[i].tonickname+ '的邮件  '+v[i].createdate+'</div>'
                          + '</div>';
                          }
                          if(state==0){
                            if(v[i].state==0){
                               js+= '<div class="pull-left pt-15 pl-15 col-8" onclick="detail('+v[i]._id+',0)"><div class="zi-hei size14 sl width-10">(已读)来自' + v[i].fromnickname+ '的邮件 '+v[i].createdate+'</div>'
                          + '</div>';
                            }else if(v[i].state==1){  
                               js+= '<div class="pull-left pt-15 pl-15 col-8" onclick="detail('+v[i]._id+',0)"><div class="zi-hei size14 sl width-10">(未读)来自' + v[i].fromnickname+ '的邮件 '+v[i].createdate+'</div>'
                          + '</div>';
                            }
                          
                          }
                    
                       if(state==1){
                       js+='<div class="pull-right pt-8" onclick="show_email_out(\''+v[i]._id+'\')"><div class=" maring-a clear img-wh40 txt-c border-radius50"><i class="fa fa-asterisk pt-7 fa-1x" style="color: limegreen"></i>'
                         +'</div></div></div>'; 
                       }
                       if(state==0){
                       js+='<div class="pull-right pt-8" onclick="show_email_in(\''+v[i]._id+'\',\''+v[i].fromno+'\')"><div class=" maring-a clear img-wh40 txt-c border-radius50"><i class="fa fa-asterisk pt-7 fa-1x" style="color: limegreen"></i>'
                         +'</div></div></div>'; 
                       }
                      
                          
				 }
	    		fypage++;
				 
	    		
	    	}else{
	    	
	    	  if(js.indexOf('暂无信息，请查看其它内容！')>0){
                      
                        }else{
                          js+='<div class="clear txt-c zi-hui size14"><div class="pt-10">'
                          +'<i class="fa fa-tags fa-6x"></i></div><div class="pt-20 pb-20">'
                          +'暂无信息，请查看其它内容！ </div></div>'; 
                        }
	    		
	    	}
	    	issend=true;
			$('#ajaxdiv').html(js);
	},"json")
}

    $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("zi-hong").siblings().removeClass("zi-hong");
                $(".yListr2 i").removeClass("fa-caret-up");
                if ($(this).hasClass('zi-hong')) {
                    $(this).find('i').addClass("fa-caret-up");
                    if($(this).attr("id")==0){
                    state=0;
                    }
                    if($(this).attr("id")==1){
                    state=1;
                    }
                    fypage=0;
                    ajaxjz(false);
                }
            })
        })
        
     function  ajaxset(v){
        hide_email_in();
        hide_email_out(); 
      	var submitData = { 
        state:v,
        id:id,
        type:state
       }; 
       
      $.post('${ctx}/email/email!ajaxset.action?custid=${custid}&lscode=${lscode}&fypage='+fypage, submitData,
       	function(json) {
       	   if(json.state==0){ 
       	     if(v==3){
       	       alert("删除成功");
       	       ajaxjz(false); 
       	     } 
       	   }
	   },"json");
     }
     function  detail(id,state){
       window.location.href='${ctx}/email/email!detail.action?custid=${custid}&lscode=${lscode}&id='+id+'&state='+state;
     }
    </script>
</head>
<body>
<main class="lock cmp640" > 
   <div class="hang40 pt-5 line-bottom weight100 yListr2 zi-hui-tq">
                <li class="button_group1 hang30 line-height30 txt-c line-right weight500" id="0">
                  收件箱<i class="pl-5 fa fa-1dx fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height30 txt-c line-right weight500" id="1">
                   发件箱<i class="pl-5 fa fa-1dx fa-caret-down"></i>
                </li>
              
            </div>
    <div class="" id="ajaxdiv">
    </div>
</main>

 
<!--发件箱管理 -->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="email_out">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_email_out()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">  
                          
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="ajaxset(3)">
                                删除
                            </div>
                       
            </div>
            <a href="javascript:hide_email_out()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<!--收件箱管理 -->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="email_in">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_email_in()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="email_hf()">
                               回复
                            </div>
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="ajaxset(3)">
                                删除
                            </div>
                       
            </div>
            <a href="javascript:hide_email_in()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 
<script type="text/javascript">
 function hide_email_out(){
   $("#email_out").hide();
 }
 function show_email_out(v){
    id=v;
  $("#email_out").show();
 }
 function hide_email_in(){
  $("#email_in").hide();
 }
 function show_email_in(v,t){
   id=v;
   toUserid=t;
  $("#email_in").show();
 }
 function  email_hf(){
   window.location.href="${ctx}/email/email!movesave.action?custid=${custid}&lscode=${lscode}&toUserid="+toUserid;
 }
  
</script>
<script type="text/javascript">

 if('${state}'>0){
    state='${state}';
    $(".yListr2 li").each(function(){
     if($(this).attr("id")=='${state}'){
      $(this).addClass("zi-hong");
      $(this).find('i').addClass("fa-caret-up");
     }
    });
   }else{  
    $(".yListr2 li").each(function(){
     if($(this).attr("id")==0){
      $(this).addClass("zi-hong");
      $(this).find('i').addClass("fa-caret-up");
     }
     });
   }
    ajaxjz(false); 
    $(window).scroll(function () {
        var scrollTop = $(this).scrollTop();
        var scrollHeight = $(document).height();
        var windowHeight = $(this).height();
        if (scrollTop + windowHeight == scrollHeight) {
         ajaxjz(true); 
        }
    });
   
</script>
</body>
</html>