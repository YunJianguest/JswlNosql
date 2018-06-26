 <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
 <%@ include file="/webcom/taglibs.jsp"%> 
      
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
    <title>聊天页面首页</title>
    <!-- Resource style -->
    <script src="js/jquery-1.8.3.js"></script>
     <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/style_0.css" rel="stylesheet"> 
    <link href="${ctx }/app/css/css3_dh.css" rel="stylesheet" type="text/css">
    <!-- Resource style -->
    <link href="${ctx }/app/css/time.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx }/app/js/date.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/iscroll.js"></script>
    <script src="${ctx }/cmp/js/main.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/swipe.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/detail.js"></script>

    <!--Return to the top-->
    <script>
        $(document).ready(function () {

            var _objscroll = {
                win: $(window),
                doc: $(document),
                gotopdiv: $('#gotop')
            };

            _objscroll.win.scroll(function () {
                if (_objscroll.win.scrollTop() > _objscroll.win.height()) {
                    _objscroll.gotopdiv.show();
                } else {
                    _objscroll.gotopdiv.hide();
                }

            });

            _objscroll.gotopdiv.click(function () {
                _objscroll.win.scrollTop(0);
                return false;

            });

        });
    </script>
    <style>
        .top-btn:hover {
            border-bottom: 2px solid limegreen;
        }
    </style>
</head>
<body>
<main class="cmp640 overflow-hidden">

    <div class="hang60" style="height: 53px;"></div>
    <div class="position-f bg-hui zi-hui cmp640" style="border-radius: 10px 10px 0px 0px;top:0px; left: 0px;">

        <div class="zi-hui overflow-hidden"style="height:53px;">

            <div class=" button_group1 zi-hui top-btn pt-15 pb-15">
                <a href="#">
                    <div class="zi-hui txt-c weight100">
                        <i class=" fa fa-comments-o fa-1dx"></i>
                    </div>
                </a>
            </div>

            <div class=" button_group1 top-btn zi-hui">
                <a href="#">
                    <div class="zi-hui txt-c weight100 pt-15 pb-15">
                        <i class=" fa  fa-user fa-1dx"></i>
                    </div>
                </a>
            </div>

            <div class=" button_group1 top-btn zi-hui">
                <a href="#">
                    <div class="zi-hui txt-c weight100 pt-15 pb-15">
                        <i class=" fa fa-comment-o fa-1dx"></i>
                    </div>
                </a>
            </div>

        </div>
    </div>


    
     
  <div class="cmp640">
      <c:forEach items="${roomList}" var="bean">
      <a href="${ctx}/dwr/chat!detail.action?roomid=${bean._id}&toUser=${toUser}">
      <div class="col-12  pt-10 pb-10 hang60 line-bottom-98 overflow-hidden" style="line-height:20px;">
        <div class="pull-left pl-15">
            <div class=" maring-a clear img-wh40 img-bj  zi-bai txt-c border-radius50 "
                 style="background-image:url(${bean.picurl});">
            </div>
        </div>
        <div class="pull-left pt-3 pl-25">
            <div class="zi-hei size14 ">${bean.title}</div>
            <div class=" size12 sl">
                <font size="0.8">
                   ${bean.summary}
                </font>
            </div>
        </div>
        <div class="pull-right pr-15 ">
            <div class=" maring-a clear txt-c pt-15">
                <div class="bj-lu2 border-radius50" style="width: 10px;height:10px;"></div>
            </div>
        </div>
     </div>
     </a>
      </c:forEach>
      
      
      
  </div>
    
 

</main>

<!-- Return to the top -->
<div id="gotop" class="gotop">
    <a href="javascript:this.blur();">
        <div class=" maring-a clear img-wh40 bg-hei-8 zi-bai txt-c border-radius50">
            <i class="fa fa-arrow-up pt-3 fa-2x"></i>
        </div>
    </a>
</div>
</body>
</html>