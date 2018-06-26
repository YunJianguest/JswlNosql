<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div id="gotop" class="gotop cmp640 pr-10"style="left: 0px;">
 <a href="javascript:this.blur();">
  <div class="pull-right clear img-wh30 bg-hei-5 zi-bai txt-c border-radius5">
  <i class="fa fa-arrow-up fa-1dx line-height30"></i>
  </div>
 </a>
</div>
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