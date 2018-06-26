<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="fullscreen cmp640 bg-hei-5 lock" id="jfts">
    <div class="overflow-hidden width-10">
        <a href="javascript:jfts_hide()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class=" cmp640 position-f position-r" style="top:15%;left:0px;z-index: 99;">

            <div class="position-a hang60 width-10" style="top:-35px;z-index: 100;">
                <div class="img-wh70 border-radius50 maring-a">
                    <img src="${filehttp}/${user.headimgurl}" width="100%" class=" border-radius50">
                </div>
            </div>

            <div class="maring-a position-r border-radius5 div-group-15 pt-45 bg-bai" style="width:280px;">

                <a href="javascript:jfts_hide()">
                    <div class="position-a" style="right:-7px;top:-7px;z-index: 101;">
                        <div class="img-wh20 border-radius50 bg-hui-tx txt-c">
                            <font size="2">
                                <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                            </font>
                        </div>
                    </div>
                </a>

                <div class=" width-10 border-radius5 zi-hui-tq overflow-hidden">
                    <font size="2">
                        <div class="weight500">您好:</div>
                        <div class="weight500 line-height25">&nbsp&nbsp&nbsp尊敬的：<i>${user.nickname}</i>，您已成功登录我平台，为了回馈您对我们平台的信任我们特意为您送上<i class="zi-green">${com.zsjf}积分</i>，积分可在积分商城兑换您喜欢的物品，详情请看<i class="zi-green">积分攻略</i>${com.tsjf}</div>
                    </font>
                </div>

                <div class="width-10 pt-15">
                    <div class="button_group1" onclick="loadjfsc()">
                        <div class="width-8 maring-a border-radius3 btn-green zi-bai txt-c hang30 line-height30">
                            积分商城
                        </div>
                    </div>
                    <div class="button_group1" onclick="window.location.href='${ctx}/set/help!web.action?custid=${custid}&agid=${agid}&agid=${agid}&lscode={lscode}'">
                        <div class="width-8 maring-a border-radius3 btn-green zi-bai txt-c hang30 line-height30">
                            积分攻略
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script>
function  jfts_hide(){
 $("#jfts").hide();
}
function  jfts_show(){
 $("#jfts").show();
}

function   loadjfsc(){ 
         var submitData = { 
	            };  
       $.post('${ctx}/shop/shop!checkJfsc.action?custid=${custid}&agid=${agid}&agid=${agid}&lscode=${lscode}', submitData,
        	 function(json){ 
        	  if(json.state==0){  
        	     window.location.href='${ctx}/shop/shop!index.action?custid=${custid}&agid=${agid}&agid=${agid}&lscode={lscode}&comid='+json.value;
        	  }else{
        	       noty({text: "尊敬的用户！暂时没有找到已经开通的积分商城！！",type:'information', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() { 
                                              } // 关闭之后
                                            },});
        	  }
        	 },"json");
    }
</script>
