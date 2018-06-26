<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp" %>
<style>
        .bk {
            height: 60px;
            width: 80px;
        }
        .yListr3 .zhiding .div3 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        } 
        .button-kong {
            width: 30px;
            height: 30px;
            line-height: 26px;
            border-top: solid 2px #eee;
            border-bottom: solid 2px #eee;
        }
        .line-height33 {
            line-height: 33px;
        }
  </style> 
<script>
       var gmcs=-1;
    
        /*或者不用jquery*/
        /*商品数量框输入*/
        function keyup() {
            var quantity = document.getElementById("quantity").value;
            if (isNaN(quantity)) {
                alert("请输入数字！");
                document.getElementById("quantity").value =1;
                return;
            } 
            if(quantity>gmcs&&gmcs>0){
                alert("商品数量不能大于"+gmcs);
                document.getElementById("quantity").value =gmcs;
                return;
            }
            if (quantity>99) {
                document.getElementById("quantity").value =99;
                alert("商品数量不能大于99");
            }
            
            if (quantity<1) {
                document.getElementById("quantity").value =1;
                alert("商品数量不能小于1");
            }
        } 
        /*商品数量+1*/
        function numAdd() {
            var quantity = document.getElementById("quantity").value;
            var num_add = parseInt(quantity) + 1;
            var pp = document.getElementById("spes-price").value;
            if (quantity == "") {
                num_add = 1;
            }
            if(price>0){
            pp=price;
            } 
            if(num_add>gmcs&&gmcs>0){
                alert("商品数量不能大于"+gmcs);
                document.getElementById("quantity").value =gmcs;
                 
                return;
            }
            if (num_add >99) {
                document.getElementById("quantity").value = num_add - 1;
                alert("商品数量不能大于99");
            } else {
                document.getElementById("quantity").value = num_add; 
                var Num = pp * num_add; 
                $("#totalPrice").html("Y"+Num.toFixed(2)+"元"); 
            }
            
        }
        /*商品数量-1*/
        function numDec() {
            var quantity = document.getElementById("quantity").value;
            var pp = document.getElementById("spes-price").value;
            if(price){
            pp=price;
            }
            var num_dec = parseInt(quantity) - 1;
            if (num_dec>0) {
                document.getElementById("quantity").value = num_dec; 
                var Num = pp * num_dec; 
                $("#totalPrice").html("Y"+Num.toFixed(2)+"元"); 
            }else{
              document.getElementById("quantity").value = num_dec+ 1;
              alert("商品数量不能小于1");
            }
        } 
</script>
</script>
<div class="fullscreen cmp640 bg-hei-5 lock display-none" id="specs">
    <div class="overflow-hidden width-10">
        <a href="javascript:hidespec()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>
        <input type="hidden" value="0" id="spes-price"/><!--单价-->
        <div class=" cmp640 position-f position-r" style="bottom:10px;left:0px;z-index: 100000;">
            <div class="bg-bai overflow-hidden border-radius3 width-9_5 maring-a">
                <div class="line-bottom pr-10 pl-10 overflow-hidden position-r" style="height:80px;">
                    <div id="spes-img" class="img-bj bk border-radius3 position-a"
                         style="top: 10px;"></div>
                    <div style="padding-left:90px;" class="pt-10">
                        <font size="2">
                            <div class="zi-6 weight500 hang30 sl zi-hei line-height30" id="spes-title">
                            </div>
                            <div class=" pull-left weight500">
                                <div class="sl hang30" style="line-height:35px;">
                                    <span class="zi-cheng" id="totalPrice">￥0元</span>
                                </div>
                            </div>
                            <div class="border-radius3 pull-right overflow-hidden">
                                <div class="pull-left txt-c btn-hui zi-hui img-wh30" onclick="numDec()">
                                    <i class="fa fa-minus fa-1x line-height33"></i>
                                </div>
                                <div class="pull-left overflow-hidden img-wh30">
                                    <input class="size12 txt-c zi-hui gray_input weight500 width-10 button-kong"
                                           id="quantity"
                                           name=""
                                           type="text" onchange="keyup()" value="1"/>
                                </div> 
                                <div class="pull-left txt-c btn-hui zi-hui img-wh30" onclick="numAdd()">
                                        <i class="fa fa-plus fa-1x line-height33"></i>
                                </div>
                               
                            </div>
                        </font>
                    </div>
                </div>
                <div class="pl-10 pb-10 overflow-hidden weight500 yListr3" id="spes-list">
                     
                </div>
            </div>
            <div class="mt-10 clear" onclick="setspec()">
                <div class="hang40 line-height40 btn-bai zi-green border-radius3 txt-c weight500 width-9_5 maring-a">
                    确认提交
                </div>
            </div>
            <a href="javascript:hidespec()">
                <div class="position-a pt-10 pr-5" style="right:2px;top:-17px;">
                    <div class="img-wh20 border-radius50 bg-hui-tx txt-c">
                        <font size="2">
                            <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                        </font>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>
