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
    <title>祭奠-创建纪念馆</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .line-height32 {
            line-height: 32px;
        }
        .line-bottom-red {
            border-bottom: 3px solid red;
        }
        .zi-3a{
            color: #aaa;
            background-color: transparent;
        }
    </style>
    <script>
        var state=1;
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("line-bottom-red").siblings().removeClass("line-bottom-red");
                state=$(this).attr('id');
                if(state==1){
                 $('#name2s').hide();
                }else if(state==2){
                 $('#name2s').show();
                }
            })
        });
        function submit() {
            var name='';
            var title=$('#title').val();
            if(title.replace('纪念馆名称', '')==''){
              alert('请输入名称');
              return;
            }
            var name1=$('#name1').val().replace('逝者姓名','');
            var name2=$('#name2').val().replace('逝者姓名','');
            if(name1==''){
              alert('请输入逝者姓名');
              return;
            }
            if(!$('#name2').is(':hidden')&&name2==''){
              alert('请输入逝者姓名');
              return;
            }
            name=name1+","+name2;
            var submitData = {
                title:title,
                name:name
            };
            $.post('${ctx}/suc/memorial!ajaxwebadd.action?custid=${custid}&lscode=${lscode}', submitData,

                    function (json) {
                        if (json.state == 0) {
                          alert("添加成功！");
                          window.location.href='${ctx}/suc/memorial!myindex.action?custid=${custid}&lscode=${lscode}';
                        } else {

                        }

                    }, "json");


        }
    </script>
</head>
<body>
<main class="cmp640">

    <font size="2">
        <div class="clear position-r" style=" z-index:3;">
            <div class="hang40 pt-5 bg-hui-92 weight100 yListr2 zi-hei">
                <li class="button_group1 hang30 line-height32 txt-c line-bottom-red" id='1'>
                    单人馆
                </li>
                <li class="button_group1 hang30 line-height32 txt-c" id='2'>
                    双人馆
                </li>
            </div>
        </div>
    </font>

    <font size="2">
        <div class="div-group-10">
         <!--创建双人馆页面-->
            <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom">
                <font size="2">
                    <div class="col-3 zi-hei-tq weight500">纪念馆名称</div>
                    <input class="zi-3a zi-hui pt-20 hang20 line-height20"type="text" name=""
                           value="纪念馆名称" id="title" onfocus="if(this.value=='纪念馆名称'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='纪念馆名称'){this.value='纪念馆名称';this.style.color='#aaa';}"/>
                </font>
            </div>
            <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom">
                <font size="2">
                    <div class="col-3 zi-hei-tq weight500">逝者姓名</div>
                    <input class="zi-3a zi-hui pt-20 hang20 line-height20"type="text" name=""
                           value="逝者姓名" id="name1" onfocus="if(this.value=='逝者姓名'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='逝者姓名'){this.value='逝者姓名';this.style.color='#aaa';}"/>
                </font>
            </div>
            <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom display-none" id="name2s">
                <font size="2">
                    <div class="col-3 zi-hei-tq weight500">逝者姓名</div>
                    <input class="zi-3a zi-hui pt-20 hang20 line-height20"type="text" name=""
                           value="逝者姓名" id="name2" onfocus="if(this.value=='逝者姓名'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='逝者姓名'){this.value='逝者姓名';this.style.color='#aaa';}"/>
                </font>
            </div>


            <!--保存按钮是个公用的-->
            <div class="pt-20" onclick="submit()">
                <div class="line-height30 txt-c width-3 maring-a hang30 zi-bai btn-green border-radius3">
                    保存纪念馆
                </div>
            </div>
        </div>

    </font>
</main>
</body>
</html>