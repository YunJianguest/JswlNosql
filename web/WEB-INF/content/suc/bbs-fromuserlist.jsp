<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ include file="/webcom/limit.jsp" %>
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
    <!-- Resource style -->
    <script src="${contextPath}/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/style_0.css" rel="stylesheet">  
    <link rel="stylesheet" href="${contextPath}/mvccol/qqFace/css/reset.css">
    <script src="${contextPath}/mvccol/js/swiper.min.js"></script>
    <link href="${contextPath}/mvccol/css/swiper.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${contextPath}/mvccol/css/photoswipe.css" /> 
    <link rel="stylesheet" href="${contextPath}/mvccol/css/default-skin.css" />
   
 
   
    <style type="text/css">

        .my-gallery img {
            width: 100%;
            height: auto;
            display: block;
            float: left
        }

        .my-gallery figure {
            display: block;
            float: left;
            width:50%;
            padding:4px 2px 0px 2px;
        }

        .hang150{
            height:180px;
        }

        .my-gallery figcaption {
            display: none;
        }

        @-webkit-keyframes heartBlast {
            0% {
                font-size-adjust: 0.5;
            }
            100% {
                font-size-adjust: 0.55;
            }
        }

        @keyframes heartBlast {
            0% {
                font-size-adjust: 0.5;
            }
            100% {
                font-size-adjust: 0.55;
            }
        }

        .tudiv img {
            width: 100%;
            padding: 2px 1px;
            overflow: hidden;
        }
    </style>
   
    <style>
    .comment{width:680px; margin:20px auto; position:relative; background:#fff; padding:20px 50px 50px; border:1px solid #DDD; border-radius:5px;}
    .comment h3{height:28px; line-height:28px}
    .com_form{width:100%; position:relative}
    .input{width:99%; height:60px; border:1px solid #ccc}
    .com_form p{height:28px; line-height:28px; position:relative; margin-top:10px;}
    span.emotion{width:42px; height:20px; background:url(http://www.16code.com/cache/demos/user-say/img/icon.gif) no-repeat 2px 2px; padding-left:20px; cursor:pointer}
    span.emotion:hover{background-position:2px -28px}
    .qqFace{margin-top:4px;background:#fff;padding:2px;border:1px #dfe6f6 solid;}
    .qqFace table td{padding:0px;}
    .qqFace table td img{cursor:pointer;border:1px #fff solid;}
    .qqFace table td img:hover{border:1px #0066cc solid;}
    #show{width:770px; margin:20px auto; background:#fff; padding:5px; border:1px solid #DDD; vertical-align:top;}
    .dhid {
            width: 65px ! important;
            margin-right: 7px ! important;
        }

        .dhid2 {
            width: 62px ! important;
            margin-right: 7px ! important;
        }

        .pb-7 {
            padding-bottom: 7px;
        }

        .yListr1 ul em.title {
            border-bottom: 3px solid #d63333;
            position: relative;
            color: #d63333;
        }
        .file{
            position: absolute;
            z-index: 100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
        }
    </style>
     
    <script>
    
     var hfid;
     var pid;
     var bmtid;
        function xiaoshi() {
            $('#tanchu').hide();
        }
        function xianshi() {
            $('#tanchu').show();
        }


        var isplay = false;
        function bfb() {
            if (!isplay) {
                $("#tanchu-b").show();
                isplay = true;
            } else {
                $("#tanchu-b").hide();
                isplay = false;
            }
        }

        $(function () {
            $(".yListr ul em").click(function () {
                $(this).addClass("yListrclickem ").siblings().removeClass("yListrclickem");
            })
        })
        $(function () {
            $(".yListr1 ul em").click(function () {
                $(this).addClass("title ").siblings().removeClass("title");
            })
        })
        function replace_em(str){
	  
	    str = str.replace(/\[em_([0-9]*)\]/g,'<img src="${contextPath}/mvccol/qqFace/arclist/$1.gif" border="0" />');
	    return str;
}

    </script>
    <script>
    var issend=true;
    var fypage=0; 
    function ajaxjz(tag,fag,fy){
     if(!issend){
    	return;
     } 
    var submitData = {
   	    sgl:tag
    };
     issend=false;
    $.post('${ctx}/suc/bbs!ajaxIndex.action?custid=${custid}&fypage='+ fy, submitData,function(json){
       var xszf;
       if(fag){
        xszf=$('#ajaxdiv').html();
       }else{
        xszf='';
       }
       
       if(json.state==0){
        var v = json.list;
        for(var i=0;i<v.length;i++){
           xszf+='<div class="position-r"><div class=" overflow-hidden" style="padding-left: 50px;">'
           +'<div class="weight500 pl-5 pt-5 sl pull-left"><font size="2">'+v[i].nikename+'</font></div>'
           +'<div class="fa fa-angle-right zi-hui pt-5 pl-5 pull-left"></div><div class="zi-6 pl-5 clear">'
           +'<div class="pt-5 pull-left weight500"><font size="1"><i>'+v[i].createdate+'</i>'
           +'<i class="pl-10 zi-lan-tq">'+v[i].humor+'</i></font></div></div></div>'
           +'<div class="position-a img-wh50" style="top:0px; left:0px;">';
           if(v[i].headimgurl.indexOf("http")>0 ){
            xszf+='<div class="img-wh40 img-bj border-radius50 maring-a" style="background-image: url('+v[i].headimgurl+')"></div>';
           }else{
           xszf+='<div class="img-wh40 img-bj border-radius50 maring-a" style="background-image: url(${contextPath}/'+v[i].headimgurl+')"></div>';
        
           }
          
           xszf+='</div></div><div class="clear pl-5 pr-5 pt-15"><a href="${ctx}/suc/bbs!bbsDetails.action?bmtid='+v[i]._id+'" onclick="reading('+v[i]._id+',this)"><div class="size12 weight500 zi-hei-tq" style="line-height: 20px;word-wrap:break-word;">';
           
           var content=replace_em(v[i].content);
           xszf+='<font size="2">'+content+'</font></div></a></div>'
                  +'<div class="pb-5 pt-5"><div id="thumbs" class="overflow-hidden">';
           var picurl=v[i].picurls; 
           if(picurl!=null){
             for(var j=0;j<picurl.length;j++){
             if(picurl[j]!=''){
              xszf+='<i class="col-6 pt-2"><a href="${filehttp}'+picurl[j]+'" class="pull-left" style="background-image:url(${filehttp}'+picurl[j]+')"></a></i>';
            
             }
            }
           } 
           xszf+='</div></div><div class="pl-5 pr-5 clear clear weight500"><div class="pt-10 pb-10 overflow-hidden">'
                +'<font size="3"><a href="#"><div class="pull-left pt-3 zi-6 weight500">';
           if(v[i].reading==null){
           xszf+='<font size="2">浏览0次</font>';
           }else{
           xszf+='<font size="2">浏览'+v[i].reading+'次</font>';
           } 
           xszf+='</div></a><a href="javascrpit:void(0)" onclick="lt_hf('+v[i]._id+')"><div class="pull-right bg-bai ml-25 zi-hui-tq ml-15">'
           +'<div class="img-wh18"><img src="${ctx}/mvccol/img/huifu.png" width="100%"></div>'
           +'</div></a><a href="javascrpit:void(0)" onclick="praise('+v[i]._id+',this)"><div class="pull-right bg-bai zi-hui-tq ml-15">'
           +'<div class="img-wh18"><img src="${ctx}/mvccol/img/zan.png" width="100%"></div></div>'
           +'</a></font></div>'
           +'<div class="pt-15 line-top-92">'
           +'<a href="#"><div class=" zi-lan-tq weight100">'
           +'<font size="2">';
           if(v[i].praise==null){
           xszf+='<i class="fa fa-thumbs-up pr-5"></i>0人觉得很赞</font></div></a></div></div><div class="pt-5">';
            
           }else{
            xszf+='<i class="fa fa-thumbs-up pr-5"></i>'+v[i].praise+'人觉得很赞</font></div></a></div></div><div class="pt-5">';
          
           } 
           var comments=v[i].commentlist;
           for(var k=0;k<comments.length;k++){
           if(comments[k].content!=null){
           xszf+='<a href="javascript:lt_hfchild('+comments[k]._id+','+v[i]._id+')"><div class="zi-hei-tq weight500 pt-5"><font size="2"><i class="zi-lan-tq pr-5">'+comments[k].name+':</i>'+comments[k].content+'</font></div></a>';
           } 
             var commentchilds=comments[k].commentchildlist;
             for(var l=0;l<commentchilds.length;l++){
               if(commentchilds[l].content!=null){
                 xszf+='<a href="javascript:lt_hfchilds('+commentchilds[l]._id+','+comments[k]._id+','+v[i]._id+')"><div class="zi-hei-tq weight500 pt-5"><font size="2"><i class="zi-lan-tq pr-5">'+commentchilds[l].name+'</i>'
           +'回复<i class="zi-lan-tq pr-5">'+commentchilds[l].hfname+':</i>'+commentchilds[l].content+'</font></div></a>';
               } 
              }
           }  
           xszf+='</div><div class="clear mt-20 mb-15 overflow-hidden  border-radius3 overflow-hidden"><font size="2">'
           +'<a href="javascript:lt_hf('+v[i]._id+')"><div class="clear mt-20 mb-15 overflow-hidden line-lu border-radius3 overflow-hidden"><font size="2">'
           +'<input class="col-10 pl-5 pr-5 zi-hui-tq weight500" style="line-height:35px;height:35px;" type="text" placeholder="评论">'
           +'<span class="col-2 txt-c weight500 zi-6"><i style="line-height:35px;" class="">回复</i>'
           +'</span></font></div></a></div></div><div class="hang10 bg-hui-qj mb-10"></div>';
     
        }
        fypage++;
       }else{ 
       } 
      	issend=true;
		$('#ajaxdiv').html(xszf); 
       
     },"json");
    
    }
    
    function ajaxlist(tag,fag,fy){ 
      if(!issend){
    	return;
      } 
    var submitData = {
   	    sgl:tag
    };
     issend=false;
    $.post('${ctx}/suc/bbs!indexList.action?custid=${custid}&fypage='+ fy, submitData,function(json){
       var xszf;
       if(fag){ 
         $('#ajaxdiv').append(json);
       }else{
         $('#ajaxdiv').children().remove();
         $('#ajaxdiv').append(json);
       }
       fypage++; 
       //$('#thumbs a').touchTouch()
       /**$('#thumbs a').each(function(v){
       alert($(this).attr('class')); 
        $(this).touchTouch(); 
       }); */
        // execute above function
     //initPhotoSwipeFromDOM('.my-gallery');
    
     issend=true;
     });
    
    }
    
    
    
    
    function submitcomment(){
     var submitData = {
    	        bmtid:bmtid,
    	        parentid:pid,
    	        hfid:hfid,
    	        content:$("#hfcontent").val(),
	            };  
    $.post('${ctx}/suc/bbs!ajaxAddcomment.action', submitData,
        	 
        	 function(json){
        	  if(json.state==0){ 
        	  window.location.href='${ctx}/suc/bbs!index.action?custid=${custid}&lscode=${lscode}';
        	  }else{
        	   alert("发表失败！");
        	  }
        	 },"json");
    
    }
   function submitcommentchild(id,pid,thi){
     var submitData = {
    	        bmtid:id,
    	        parentid:pid,
    	        content:$(thi).parent().find('input').val(),
	            }; 
    $.post('${ctx}/suc/bbs!ajaxAddcomment.action', submitData,
        	 
        	 function(json){
        	  if(json.state==0){ 
        	  window.location.reload();
        	  }else{
        	   alert("发表失败！");
        	  }
        	 },"json");
    
    }
    function formsubmit(){  
		var content = $("#qqfaceshow").val();
		var picurl=''; 
		$(".pic-list .col-3").each(function(index,el){ 
		 picurl+=','+$(el).attr("name");     
		}); 
		var submitData = {
    	        content:content,
    	        picurl:picurl,
	            }; 
		$.post('${ctx}/suc/bbs!ajaxAdd.action?custid=${custid}', submitData,
        	 
        	 function(json){
        	  if(json.state==0){
        	  alert("发表成功！");
        	  window.location.reload();
        	  }else{
        	   alert("发表失败！");
        	  }
        	 },"json");
	 
    }
     function  reading(id,thi){
     
         var submitData = {
    	        bmtid:id,  
	            };  
       $.post('${ctx}/suc/bbs!bbsReading.action?toUser=${toUser}', submitData,
        	 
        	 function(json){
        	  if(json.state==0){   
        	   }else{
        	    
        	  }
        	  
        	 },"json");
     
     
    }
     function  praise(id,thi){
      
         var submitData = {
    	        bmtid:id,  
	            };  
       $.post('${ctx}/suc/bbs!bbspraiseAdd.action?toUser=${toUser}', submitData,
        	 
        	 function(json){
        	  if(json.state==0){ 
        	    var html='<font size="2"><i class="fa fa-thumbs-up pr-5"></i>'+json.value+'人觉得很赞</font>'; 
        	    $(thi).parent().parent().parent().find('.zi-lan-tq').html(html);
        	     
        	  }else{
        	   alert("点赞失败！");
        	  }
        	  
        	 },"json");
      
     
    }
    </script>
     <script>
     

        //        评论框弹出层

        function lt_xiaoshi() {
            $('#lt_tanchu').hide();
        }
        function lt_hf(id) {
          bmtid=id;
          pid='';
          hfid='';
            $('#lt_tanchu').show();
        }
        function lt_hfchild(parentid,id){ 
          bmtid=id;
          pid=parentid;
          hfid='';
          $('#lt_tanchu').show();
        }
        function lt_hfchilds(hffid,parentid,id){ 
          bmtid=id;
          pid=parentid;
          hfid=hffid;
          $('#lt_tanchu').show();
        }

        var isplay = false;
        function bfb2() {
            if (!isplay) {
                $("#tanchu-b2").show();

                isplay = true;
            } else {
                $("#tanchu-b2").hide();

                isplay = false;
            }

        }

    </script>
    
   

</head>
<body class="bg-bai lock"> 
<main class="cmp640" id="section1">
     
    <div class="position-r overflow-hidden clear" style="height:180px;">
        <img src="${entity.bj}" width="100%">

        <div class="position-a width-10 cmp640 bg-hei-5"
             style="height:200px;top: 0px;">
            
        </div>
        <div class="position-a width-10 cmp640" style="top:30px;left: 0px;">
            <div class="position-r">
                <div class=" pl-20 position-a">
                  <a href="${ctx}/user/fromuser!UserDetail.action?custid=${custid}&fromUserid=${fromUserid}">
                    <div class="border-radius50 pt-3 img-wh80"
                         style="background-color:  rgba(255, 255, 255, 0.5)">
                        <div class="img-wh70 maring-a img-bj border-radius50"
                             style="background-image: url(${ctx}/${user.headimgurl});width: 74px;height: 74px;"></div>
                    </div>
                   </a>
                </div>
                <div class="position-a bg-cheng txt-c zi-bai" style="bottom:-13px;left: 20px; border-radius: 20px;">
                    <div class="position-r pt-3" style="width:80px; height:18px;line-height:15px;">
                        <font size="1">LV${user.level}</font>

                        <div class="position-a " style="bottom:-6px; left:-5px;">
                            <div class="img-wh30">
                                <img src="${ctx}/${user.levelimgurl}" width="100%">
                            </div>
                        </div>
                    </div>

                </div>

                <div class="zi-bai pt-10" style="padding-left: 120px;height:80px;">

                    <div class="weight500">
                        <font size="3">
                            <div class="width-5 maring-a clear sl pull-left">${user.name}</div>
                            <font size="1">
                                <div class="pl-5 pt-7 pull-left">
                                    (<i>${user.no}</i>)
                                </div>
                            </font>
                            
                            <div class="pl-5 pull-left"></div>
                        </font>
                    </div>

                    <div class=" pt-7 weight100 clear">
                        <font size="2"><i class="pr-10">${user.province}</i><i>${user.city}</i></font>
                    </div>

                    <div class=" pt-8">
                        <div class="pull-left img-wh25">
                            <img src="${ctx}/${user.levelimgurl}" width="25px">
                        </div>
                        <div class="pull-left pt-6 pl-5">
                            <font size="2"><i class="pr-5 pl-2">积分:</i><i>${user.jf}</i></font>
                        </div>
                    </div>

                </div>

            </div>
        </div>

        <!--栏目开始-->
        <div class=" hang30 pt-3 width-10 weight500 bg-hei-8 position-a cmp640"
             style="bottom:0px; left:0px;">

            <div class="col-4 txt-c line-right hang25 overflow-hidden" onclick="ajaxlist('',false,0)" style="line-height:25px;">
                <font size="2">
                    <div class="width-9_5 maring-a zi-hui clear sl" style="line-height:25px;">
                        最新帖子
                    </div>
                </font>
            </div>
            <div class="col-4 txt-c line-right hang25 overflow-hidden" onclick="ajaxlist('1',false,0)" style="line-height:25px;">
                <font size="2">
                    <div class="width-9_5 maring-a zi-hui clear sl" style="line-height:25px;">
                       最热帖子
                    </div>
                </font>
            </div>
            <div class="col-4 txt-c hang25 overflow-hidden" onclick="ajaxlist('2',false,0)" style="line-height:25px;">
                <font size="2">
                    <div class="width-9_5 maring-a zi-hui clear sl" style="line-height:25px;">
                       与我相关
                    </div>
                </font>
            </div>
        </div>
        
    </div>


    <div class="clear overflow-hidden line-bottom-92">
        <font size="2">
            <a href="javascript:xianshi()">
                <input class="col-10 pl-5 pt-3 pr-5 zi-hui-tq" style="line-height:35px;height:35px;" type="text"
                       name=""
                       value="说点什么" onfocus="if(this.value=='说点什么'){this.value=''};this.style.color='black';"
                       onblur="if(this.value==''||this.value=='说点什么'){this.value='说点什么';this.style.color='#aaa';}">
                         <span class="col-2 line-left-92 pt-3 txt-c weight500"
                               style="background-color: #f5f5f6;color:#606060">
                            <i style="line-height:35px;" class="fa fa-smile-o fa-1dx"></i>
                         </span>
            </a>
        </font>
    </div>

 
    <div id="ajaxdiv"></div>
    
  <%@include file="/webcom/foot.jsp" %>
</main>

<!--发帖-->
<div class="fullscreen cmp640 bg-bai overflow-auto display-none" id="tanchu">

    <div class=" width-10 bg-lu">
        <div class="hang40 pl-15 pull-left zi-bai line-height40">
            <a href="javascript:xiaoshi()">
                <i class="fa fa-chevron-left weight500 pr-5"></i>
                <font size="2">
                   取消
                </font>
            </a>
        </div>
        <div class="hang40 pr-15 zi-bai pull-right line-height40">
            <a href="#">
                <i class="fa  size10 pr-10 clear"></i>
                <font size="2">
                 
                </font>
            </a>
        </div>
        <div class="width-7 maring-a txt-c hang40 zi-bai weight500 line-height40" style="top:0px; z-index: 1;">
            <font size="2">
            发表你的想法       
            </font>
        </div>
    </div>

    <div class="pt-10">
        <div class="bg-bai">
            <form action="">
                 <textarea id="qqfaceshow" value="评论" onfocus="if(this.value=='请输入10-300个字'){this.value=''};this.style.color='black';"
                          onblur="if(this.value==''||this.value=='请输入10-300个字'){this.value='请输入10-300个字';this.style.color='#aaa';}"
                          rows="5" name="message" class="size14 weight500"
                          style="height:180px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);">请输入10-300个字</textarea>
                   <div id="qqb"></div>
                <input name="remLen" type="text" value="300" size="5" readonly="readonly"
                       class="zi-hui size12 pl-2 pb-10 pull-right">

            </form>
        </div>
        
        
      <div class=" overflow-hidden  clear">
            <!--<div class="hang5 bg-hui-tx clear"></div>-->
            <div class="div-group-10 overflow-hidden  display-none pic-list" style="padding-top: 0px;">
                <div class="col-3 pt-10">
                      <div class="img-wh70  border-radius5 line-lu maring-a position-r">
                            <input type="file" accept="image/*" class="file cameraInput" name="cameraInput">
                            <div class="img-wh70 div-group-20">
                                <img src="${contextPath}/mvccol/img/addimg.png" class="width-10">
                            </div>
                        </div>
                </div>
               
              
            </div>
        </div>
 
        

        <div class="hang5 bg-hui-tx clear"></div>
        <div class="clear div-group-10 pb-5 overflow-hidden">
            <div class=" pull-left">
                <a href="javascript:bfb()">
                    <i class="fa fa-photo fa-1dx zi-6 pt-5" id="imgup"></i>
                </a>
            </div>
            <div class="pull-left pl-25">
                <a href="#">
                    <i class="fa fa-smile-o fa-1dx zi-6 pt-5" id="qqface"></i>
                </a>
            </div>
            <a href="javascript:formsubmit();">
                <div class="btn-green mr-5 zi-bai txt-c size12 weight500 pull-right col-2 border-radius3"
                     style="height:28px; line-height:29px;">
                    发表
                </div>
            </a>
        </div>

        <div class=" overflow-hidden  display-none clear" id="qqbq">
             
           
        </div>

      

    </div>
</div>


<!--评论输入框弹出层-->
<div class="fullscreen cmp640 bg-hei-8 lock display-none" id="lt_tanchu">
    <div class="position-r overflow-hidden width-10">
        <a href="javascript:lt_xiaoshi()">
            <div class="width-10 overflow-hidden" style="height:1000px;">

            </div>
        </a>

        <div class="position-a width-10" style="top:0;left:0;">
            <div class=" div-group-5">
                <div class=" div-group-10  overflow-hidden bg-bai border-radius3">
                    <div class="col-12 ">
                        <form>
                    <textarea id="hfcontent" placeholder="评论" onfocus="if(this.value=='评论'){this.value=''};this.style.color='black';"
                              onblur="if(this.value==''||this.value=='评论'){this.value='评论';this.style.color='#aaa';}"
                              rows="5" class="form-control"></textarea>
                        </form>
                    </div>
                    <div class=" pt-5 pb-10 clear">

                        <a href="javascript:bfb2()">
                            <i class="fa fa-smile-o fa-1dx pt-7 zi-hui"></i>
                        </a>
                        <a href="javascript:submitcomment()">
                            <div class="btn-green hang30 zi-bai txt-c size14 weight500 pull-right col-2 border-radius3">
                                评论
                            </div>
                        </a>
                        <a href="javascript:lt_xiaoshi()">
                            <div class="btn-lan hang30 mr-10 zi-bai txt-c size14 weight500 pull-right col-2 border-radius3">
                                退出
                            </div>
                        </a>
                    </div>

                    <div class="display-none clear"id="tanchu-b2">
                        <div class="hang60 bg-cheng"></div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<!--结束-->



<!-- Return to the top -->
<div id="gotop" class="gotop">
    <a href="javascript:this.blur();">
        <div class=" maring-a clear img-wh30 bg-hei-8 zi-bai txt-c border-radius50">
            <i class="fa fa-arrow-up pt-3 fa-1dx"></i>
        </div>
    </a>
</div>
<script src="${contextPath}/mvccol/js/touchTouch.jquery.js"></script>
<script src="${contextPath}/mvccol/lrz/exif.js"></script>
<script src="${contextPath}/mvccol/lrz/lrz.js"></script>
<script src="${contextPath}/mvccol/lrz/mobileFix.mini.js"></script> 
<script src="${contextPath}/mvccol/lrz/index.js"></script>
<script src="${contextPath}/mvccol/qqFace/js/jquery.qqFace.js"></script>
 
    <script src="${contextPath}/mvccol/js/photoswipe.min.js"></script>
    <script src="${contextPath}/mvccol/js/photoswipe-ui-default.min.js" ></script>
<script type="text/javascript">
$(window).scroll(function () {

    var offsetY = $(window).scrollTop();

    var section1 = $("#section1").height();
	if(section1-offsetY<600){
		ajaxlist('',true,fypage); 
	}
   
});

$(function(){
	$('#qqface').qqFace({
		id : 'facebox', 
		assign:'qqfaceshow', 
		path:'${contextPath}/mvccol/qqFace/arclist/'	//表情存放的路径
	});
	$(".sub_btn").click(function(){
		var str = $("#saytext").val();
		$("#show").html(replace_em(str));
	});
});
//查看结果

</script>

<script>
    $(function () { 
      ajaxlist('2',false,0); 
     
    });
</script>

<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        slidesPerView: 5,
        paginationClickable: true,
        spaceBetween: 30,
        freeMode: true
    });
</script>

<script language="JavaScript">
   function textCounter(field, countfield, maxlimit) {
         // 函数，3个参数，表单名字，表单域元素名，限制字符； 
        if (field.value.length > maxlimit)
         //如果元素区字符数大于最大字符数，按照最大字符数截断； 
            field.value = field.value.substring(0, maxlimit);
        else
        //在记数区文本框内显示剩余的字符数； 
            countfield.value = maxlimit - field.value.length;
    }

</script>
<script type="text/javascript">
    var initPhotoSwipeFromDOM = function (gallerySelector) {

        // parse slide data (url, title, size ...) from DOM elements
        // (children of gallerySelector)
        var parseThumbnailElements = function (el) {
            var thumbElements = el.childNodes,
                    numNodes = thumbElements.length,
                    items = [],
                    figureEl,
                    linkEl,
                    size,
                    item;

            for (var i = 0; i < numNodes; i++) {

                figureEl = thumbElements[i];

                // include only element nodes
                if (figureEl.nodeType !== 1) {
                    continue;
                }

                linkEl = figureEl.children[0];

                size = linkEl.getAttribute('data-size').split('x');

                // create slide object
                item = {
                    src: linkEl.getAttribute('href'),
                    w: parseInt(size[0], 10),
                    h: parseInt(size[1], 10)
                };


                if (figureEl.children.length > 1) {
                    item.title = figureEl.children[1].innerHTML;
                }

                if (linkEl.children.length > 0) {
                    item.msrc = linkEl.children[0].getAttribute('src');
                }

                item.el = figureEl;
                items.push(item);
            }

            return items;
        };

        // find nearest parent element
        var closest = function closest(el, fn) {
            return el && (fn(el) ? el : closest(el.parentNode, fn));
        };

        // triggers when user clicks on thumbnail
        var onThumbnailsClick = function (e) {
            e = e || window.event;
            e.preventDefault ? e.preventDefault() : e.returnValue = false;

            var eTarget = e.target || e.srcElement;

            // find root element of slide
            var clickedListItem = closest(eTarget, function (el) {
                return (el.tagName && el.tagName.toUpperCase() === 'FIGURE');
            });

            if (!clickedListItem) {
                return;
            }

            // find index of clicked item by looping through all child nodes
            // alternatively, you may define index via data- attribute
            var clickedGallery = clickedListItem.parentNode,
                    childNodes = clickedListItem.parentNode.childNodes,
                    numChildNodes = childNodes.length,
                    nodeIndex = 0,
                    index;

            for (var i = 0; i < numChildNodes; i++) {
                if (childNodes[i].nodeType !== 1) {
                    continue;
                }

                if (childNodes[i] === clickedListItem) {
                    index = nodeIndex;
                    break;
                }
                nodeIndex++;
            }


            if (index >= 0) {
                // open PhotoSwipe if valid index found
                openPhotoSwipe(index, clickedGallery);
            }
            return false;
        };

        var photoswipeParseHash = function () {
            var hash = window.location.hash.substring(1),
                    params = {};

            if (hash.length < 5) {
                return params;
            }

            var vars = hash.split('&');
            for (var i = 0; i < vars.length; i++) {
                if (!vars[i]) {
                    continue;
                }
                var pair = vars[i].split('=');
                if (pair.length < 2) {
                    continue;
                }
                params[pair[0]] = pair[1];
            }

            if (params.gid) {
                params.gid = parseInt(params.gid, 10);
            }

            return params;
        };

        var openPhotoSwipe = function (index, galleryElement, disableAnimation, fromURL) {
            var pswpElement = document.querySelectorAll('.pswp')[0],
                    gallery,
                    options,
                    items;

            items = parseThumbnailElements(galleryElement);

            // define options (if needed)
            options = {
                // define gallery index (for URL)
                galleryUID: galleryElement.getAttribute('data-pswp-uid'),
                getThumbBoundsFn: function (index) {
                    // See Options -> getThumbBoundsFn section of documentation for more info
                    var thumbnail = items[index].el.getElementsByTagName('img')[0], // find thumbnail
                            pageYScroll = window.pageYOffset || document.documentElement.scrollTop,
                            rect = thumbnail.getBoundingClientRect();

                    return {x: rect.left, y: rect.top + pageYScroll, w: rect.width};
                }

            };

            // PhotoSwipe opened from URL
            if (fromURL) {
                if (options.galleryPIDs) {
                    // parse real index when custom PIDs are used
                    // http://photoswipe.com/documentation/faq.html#custom-pid-in-url
                    for (var j = 0; j < items.length; j++) {
                        if (items[j].pid == index) {
                            options.index = j;
                            break;
                        }
                    }
                } else {
                    // in URL indexes start from 1
                    options.index = parseInt(index, 10) - 1;
                }
            } else {
                options.index = parseInt(index, 10);
            }

            // exit if index not found
            if (isNaN(options.index)) {
                return;
            }

            if (disableAnimation) {
                options.showAnimationDuration = 0;
            }

            // Pass data to PhotoSwipe and initialize it
            gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options);
            gallery.init();
        };

        // loop through all gallery elements and bind events
        var galleryElements = document.querySelectorAll(gallerySelector);
           
        for (var i = 0, l = galleryElements.length; i < l; i++) {
            
            galleryElements[i].setAttribute('data-pswp-uid', i + 1);
            galleryElements[i].onclick = onThumbnailsClick;
            
        }

        var hashData = photoswipeParseHash();
        if (hashData.pid && hashData.gid) {
            openPhotoSwipe(hashData.pid, galleryElements[hashData.gid - 1], true, true);
        }
    };

   
</script>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>

</body>
</html>