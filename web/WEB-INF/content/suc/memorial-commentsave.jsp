<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>祭奠</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .zi-3a{
            color: #aaa;
            background-color: transparent;
        }
    </style>
    <script>
    function  submint(){ 
          var content=$('#content').val().replace('请在此处输入您对亲人的悼念词。','');  
          if(content==''){
            alert('请输入悼念词');
            return;
          } 
           var submitData = {
             id:'${id}',
             cid:'${cid}', 
             content:content, 
            };
            $.post('${ctx}/suc/memorial!ajaxcommentadd.action?custid=${custid}&lscode=${lscode}', submitData, function (json) {
                 
                if (json.state == 0) { 
                    window.location.href='${ctx}/suc/memorial!detail.action?custid=${custid}&lscode=${lscode}&_id=${id}';    
                }  
            }, "json");
          
        }
        
    </script>
</head>
<body>
<main class="cmp640">
    <font size="2">
        <div class="div-group-10"> 
            <div class=" overflow-hidden line-bottom">
                <font size="2">
                    <div class="col-2 zi-hei-tq pl-5 pt-10 weight500">内容</div>
                </font>
                <div class="col-10 pt-2">
                    <form action="">
                <textarea style="height:100px;" onfocus="if(this.value=='请在此处输入您对亲人的悼念词。'){this.value=''};this.style.color='#aaa';"
                          onblur="if(this.value==''||this.value=='请在此处输入您对亲人的悼念词。'){this.value='请在此处输入您对亲人的悼念词。';this.style.color='#aaa';}"
                          rows="5" id="content">请在此处输入您对亲人的悼念词。</textarea>
                    </form>
                </div>
            </div>
            <div class="line-height40 txt-c hang40 zi-bai btn-green mt-25 mb-10 border-radius3" onclick="submint()">
                保存
            </div>
        </div>


    </font>
</main>
</body>
</html>