<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %> 
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
    <title>律师个体首页</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .bottom-bai-ls {
            background-color: #ffffff;
        }

        .bottom-bai-ls:hover, .bottom-bai-ls:focus {
            color: #e3c06a;
        }

        .zi-6b6b6b {
            color: #6b6b6b
        }

        .zi-jin {
            color: #e3c06a
        }

        .line-jin2 {
            border: 2px solid #e3c06a;
        }

        .line-jin1 {
            border: 1px solid #e3c06a;
        }

        .border-radius30 {
            border-radius: 30px;
        }

        .zt-song {
            font-family: 宋体;
        }
    </style>
    <script>
        var issend = true; 
        function ajaxfwyj() {//加载
            if (!issend) {
                return;
            }

            var submitData = {
                "lucid": "${entity._id}"
            };
            issend = false;
            $.post('${ctx}/suc/lawyer!ajaxcomments.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        var xszf = '';
                        if (json.state == 0) {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                              xszf+='<font size="2">'
                                  +'<div class="pt-10 pb-10 overflow-hidden line-bottom-92 width-9 maring-a zi-hui-tq">'
                                  +'<div class="pt-5 pb-5">150****1182</div>'
                                  +'<div class="line-height20 pt-10 pb-10 weight500 zi-hei-tq">此处放置</div>'
                                  +'<div class="pt-5 pb-5">评价时间：2017-09-09 12：00：00</div>'
                                  +'</div></font>';  
                            }

                        } else {

                        }
                        issend = true; 
                        fypage++;
                        $('#ajaxdiv').html(xszf);
                    }, "json")

        }
        var issendbus = true;
        function ajaxbus() {//加载
            if (!issendbus) {
                return;
            }

            var submitData = { 
            	id:'${entity._id}'
            };
            issendbus = false;
            $.post('${ctx}/suc/lawyer!ajaxbus.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        var xszf = '';
                        if (json.state == 0) {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                              xszf+='<div class="col-4 line-bottom-92 pt-25 pb-30 line-right-92">'
                                  +'<div class="txt-c maring-a border-radius5 zi-jin">'
                                  +'<i class="fa '+v[i].icon+' fa-2x"></i>'
                                  +'</div>'
                                  +'<font size="2" class="txt-c">'
                                  +'<div class="pt-15 pb-15 zi-6b6b6b weight500 zt-song">'+v[i].title+'</div>'
                                  +'<div class="pt-5 pb-5 zi-6b6b6b line-jin1 width-6 maring-a border-radius30 zi-jin">'
                                  +'<font size="1">￥'+v[i].price+'/次</font></div>'
                                  +'</font></div>';
                           
                            }

                        } else {

                        }
                        issendbus = true;  
                        $('#bus').html(xszf);
                    }, "json")

        }
    </script>
</head>
<body class="cmp640">
<main>

    <div class="position-r overflow-hidden clear" style="height:160px;">
        <img src="${ctx}/img/lawyer/bj.jpg" width="100%">

        <div class="position-a width-10 cmp640"
             style="height:160px;top: 0px;">
            <div class="img-wh70 line-jin2 maring-a border-radius50 position-r" style="top:30px;">
              <c:if test="${not empty entity.picurl }">
               <img src="${filehttp}/${entity.picurl}" class="width-10 border-radius50"/> 
              </c:if>
               <c:if test="${empty entity.picurl }">
               <img src="${ctx}/img/unfind.jpg" class="width-10 border-radius50"/> 
               </c:if>
               
                <div class="width-10 hang50 line-height50 txt-c zi-bai weight500">
                    ${entity.name}
                </div>
                <div class="img-wh20 txt-c border-radius50 bg-bai position-a" style="bottom:-2px;right:-2px;">
                    <font size="1">
                        <i class="zi-jin size10 fa fa-star line-height20"></i>
                    </font>
                </div>
            </div>
        </div>
    </div>
    <div class="hang40 line-height40 pl-10 pr-10 line-bottom-92 zi-hui-tq">
        <i class="fa fa-bullhorn zi-jin pr-5"></i>《平台名称》已经为全国<i class="zi-jin">3588</i>位律师提供了优质的服务...
    </div>
    <!--律师所擅长的业务和收费标准-->
    <div id="bus"></div>
    

    <div class="clear hang10 bg-hui-92"></div>
    <div class="div-group-10 overflow-hidden line-bottom-92 clear">
        <div class="hang20 line-height20" style="border-left: 4px solid #e3c06a"><i class="pl-10 weight500">律师简介</i>
            <!--点击下面查看更多跳转律师简介页面-->
            <div class="pull-right size10 zi-hui-tq">查看更多<i class="fa fa-chevron-right pl-5"></i></div>
        </div>
    </div>

    <div class="pt-10 pb-15 zt-song overflow-hidden width-9 maring-a zi-hui-tq size12 weight500 line-height25">
        <div class=" hang-sl-4 sj2">
           ${entity.content}
        </div>
    </div>

    <div class="clear hang10 bg-hui-92"></div>
    <div class="div-group-10 overflow-hidden line-bottom-92 clear">
        <div class="hang20 line-height20 weight500" style="border-left: 4px solid #e3c06a"><i class="pl-10">律师信息</i>
        </div>
    </div>
    <div class="pt-10 pb-10 overflow-hidden width-9 maring-a zi-6 weight500">
        <div class="hang40 line-height40">
            擅长领域：婚姻 交通 合同 婚姻 交通 合同
        </div>
        <div class="hang40 line-height40">
            所在机构：${entity.institution}
            <!--如果没有律师事务所那就是不显示-->
        </div>
        <div class="hang40 line-height40">
            执业证号：${entity.cerno}
        </div>
    </div>

    <div class="clear hang10 bg-hui-92"></div>
    <div class="div-group-10 overflow-hidden line-bottom-92 clear">
        <div class="hang20 line-height20" style="border-left: 4px solid #e3c06a">
            <div class="pull-left weight500"><i class="pl-10">客户评价</i></div>

            <!--点击下面评价弹出输入框-->
            <div class="pull-right size10 zi-hui-tq" onclick="window.location.href='${ctx}/suc/lawyer!commentadd.action?custid=${custid}&lscode=${lscode}&id=${id}'">评价<i class="fa fa-chevron-right pl-5"></i></div>
        </div>
    </div>

    <font size="2">
        <div class="pt-10 pb-10 overflow-hidden line-bottom-92 width-9 maring-a zi-hui-tq">
            <div class="pt-5 pb-5">
                150****1182
            </div>
            <div class="line-height20 pt-10 pb-10 weight500 zi-hei-tq">
                此处放置用户评价后的内容某某律师解答的非常清楚让我茅塞顿开
            </div>
            <div class="pt-5 pb-5">
                评价时间：2017-09-09 12：00：00
            </div>
        </div>
    </font>
    <font size="2">
        <div class="pt-10 pb-10 overflow-hidden line-bottom-92 width-9 maring-a zi-hui-tq">
            <div class="pt-5 pb-5">
                150****1182
            </div>
            <div class="line-height20 pt-10 pb-10 weight500 zi-hei-tq">
                此处放置用户评价后的内容某某律师解答的非常清楚让我茅塞顿开
            </div>
            <div class="pt-5 pb-5">
                评价时间：2017-09-09 12：00：00
            </div>
        </div>
    </font>
  <%@ include file="/webcom/foot.jsp" %>
 </main>
<div class="clear hang50"></div>
<!--底部按钮-->
<%@ include file="/webcom/lawyer-foot.jsp" %>
<script>
ajaxbus();
</script>
</body>
</html>