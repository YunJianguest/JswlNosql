<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>
    <script src="${contextPath}/bracket/js/jquery.tagsinput.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/bracket/css/jquery.tagsinput.css"/>
    <script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js" type="text/javascript"></script> 
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript">
        $(document).ready(function () {
            var validator = $("#custinfoForm").validate({
                rules: { 
                },
                messages: {},
                highlight: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                },
                success: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-error');
                }
            });
        });
       function changepay(){
       if($("#qx").val()==1){
       $("#partner").show();
       $("#partner_key").show(); 
       }else{
       $("#partner").hide(); 
       $("#partner_key").hide(); 
       }
       }
       function changesq(){
        if($("#sqlx").val()==1){
         $("#app_appid").hide();
         $("#app_secret").hide(); 
        }else{
         $("#app_appid").show();
         $("#app_secret").show();
        }
       }
    </script>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %> 
        <div class="pageheader">
            <h2><i class="fa fa-user"></i>系统管理 <span>关注配置</span></h2>
        </div>
       <div class="div-group-10 overflow-hidden">
            <form id=custinfoForm action="${ctx}/weixin/wxtoken!savetoken.action" class="form-horizontal"  method="post" >
            <div class="overflow-hidden">
                <div class=" div-group-10 pb-25 bg-bai border-radius5 overflow-hidden">
                    <div class="clear pt-25">
                        <div class="col-2">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">原始ID:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100" type="text"
                                       value="${toUser}" name="toUser" id="toUser" readonly="readonly">
                            </div>
                        </div>
                        <div class="col-2 pl-10" id="app_appid">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">AppID:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100" type="text"
                                       value="${entity.appid}"
                                       name="appid" id="appid">
                            </div>
                        </div>
                        <div class="col-2 pl-10" id="app_secret">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">AppSecret:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100" type="text"
                                       value="${entity.secret}"
                                       name="secret" id="secret">
                            </div>
                        </div>
                        <div class="col-2 pl-10">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">账号类型:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                        <select id="zhlx" name="zhlx" class="hang30 width-10" data-placeholder="请选择" >
                                           <option value="0">未认证</option>
										   <option value="1">订阅号已认证</option>
										   <option value="2">服务号已认证</option>
                                        </select>
                            </div>
                        </div>
                        <div class="col-2 pl-10">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">结算方式:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                        <select id="qx" name="qx" class="hang30 width-10" data-placeholder="请选择" onchange="changepay()" >
                                          <option value="0">不结算</option>
										  <option value="1">本公众号结算</option>
										  <option value="2">父类结算</option>
                                        </select>
                            </div>
                        </div>
                         <div class="col-2 pl-10">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">是否验证关注:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                <select id="isgz" name="isgz" class="hang30 width-10" data-placeholder="请选择">
                                    <option value="0">不验证</option>
                                    <option value="1">验证</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="clear pt-25">
                        <div class="col-2">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">开通客服:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                        <select id="kf" name="kf" class="hang30 width-10" data-placeholder="请选择" >
                                          <option value="0">不开通</option>
										  <option value="1">开通</option>
                                        </select>
                            </div>
                        </div>
                        <div class="col-2 pl-10">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">账号类型:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                        <select id="isjh" name="isjh" class="hang30 width-10" data-placeholder="请选择">
                                         <option value="0">默认账户</option>
										 <option value="1">普通账号</option>
                                        </select>
                            </div>
                        </div>
                        <div class="col-2 pl-10" id="partner">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">财付通商户号:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100" type="text"
                                       value="${pay.partner}"
                                       name="partner" id="pay_partner" >
                            </div>
                        </div>
                        <div class="col-2 pl-10" id="partner_key">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">财付通密钥:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100" type="text"
                                       value="${pay.partner_key}"
                                       name="partner_key" id="pay_partner_key">
                            </div>
                        </div>
                         <div class="col-2 pl-10" id="partner_key">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">商户名称:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                <input class="width-10 size14 zi-hui hang30 pt-10 pl-10 pr-10 weight100" type="text"
                                       value="${pay.name}"
                                       name="pay_name" id="pay_name">
                            </div>
                        </div>
                        <div class="col-2 pl-10">
                            <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">授权方式:</div>
                            <div class="line-bottom line-right line-left1 hang40">
                                <select id="sqlx" name="sqlx" class="hang30 width-10" data-placeholder="请选择" onchange="changesq()">
                                    <option value="0">本公众号授权</option>
                                    <option value="1">父类授权</option>
                                </select>
                            </div>
                        </div>
                       
                    </div>
                    <div class="pt-10 clear">
                        <a href="javascript:checksubmit()">
                            <div class="pt-20 pb-20 clear">
                                <div class="border-radius5 div-group-5 btn-lan zi-bai">
                                    <div class="hang40 txt-c weight500 line-height40">
                                        <font size="3">
                                            提交
                                        </font>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            </form>
      </div>
  </div> 
</section> 
<script type="text/javascript"> 
  if('${entity.toUser}'!=''){
   $('#zhlx').val('${entity.zhlx}');
   $('#qx').val('${entity.qx}');
   $('#sqlx').val('${entity.sqlx}');
   $('#kf').val('${entity.kf}');
   $('#isjh').val('${entity.isjh}');
   $('#isgz').val('${entity.isgz}'); 
  }
  if($('#qx').val()==1){
   $('#pay_partner').val('${pay.partner}');
   $('#partner_key').val('${pay.partner_key}');
   $('#pay_name').val('${pay.name}');
  } 
  changepay();
  changesq();
 function checksubmit() {  
  $('#custinfoForm').submit();
 }  
</script>
</body>
</html>
