<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<script type="text/javascript" src="${ctx }/app/js/jquery.qrcode.js"></script>
<script type="text/javascript">
function qrcode(str){
	$("#code").qrcode({
		render: "table", //table方式
		width: 200, //宽度
		height:200, //高度
		text: str //任意内容
	});
}

</script>
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

<div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
   
    <div class="pageheader">
      
      <h2><i class="fa fa-eye"></i> 微官网 <span>微官网配置</span></h2>
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
       
            
                  <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
                  </button>
                  <ul class="dropdown-menu pull-right" role="menu">
                      <li><a href="http://dwz.cn/" target="_blank">百度短网址</a></li>
                      <li><a href="http://cli.im/" target="_blank">二维码生成</a></li>
                     
                  </ul>

       
       	</div>
      </div>
    </div>
	<div class="contentpanel">

	<div class="row">
    	<div class="col-md-5">
        	<div class="big-divice">
            	<div class="gongzonghao">${entity.title }</div>
            	<div class="shouji"></div>
            	<div class="shouji_di"></div>
            	<div class="kuang"><iframe name="leftmenu" marginwidth=10 marginheight=10 frameborder=no  width="100%"  height=100% id="myiframe"
                	src='${method}' scrolling="auto" ></iframe>
               	</div>
        	</div>
    	</div><!-- col-md-5 -->
		<div class="col-md-7">
			<!-- <p>关键字回复，微信回复链接地址复制带有&fromUser=fromUserData的地址</p>
			<div class="form-group">
                        		<label class="col-sm-2 control-label">回复地址 <span class="asterisk">*</span></label>
                        		<div class="col-sm-10">
                            		<textarea  class="form-control" rows="2"  >${method}</textarea>
                        		</div>
            </div> -->
            <p>微官网内部跳转，请复制以下地址</p>
			<div class="form-group">
                        		<label class="col-sm-2 control-label">原生地址 <span class="asterisk">*</span></label>
                        		<div class="col-sm-10">
                            		<textarea  class="form-control" rows="2"  >${dlurl}</textarea>
                        		</div>
            </div>
           <!--  <p>图文跳转链接或者发送给第三方用一下URL，通过这个进入直接可以获取到用户信息
			</p>
			<div class="form-group">
                        		<label class="col-sm-2 control-label">短网址 <span class="asterisk">*</span></label>
                        		<div class="col-sm-10">
                            		<textarea id="summary" name="summary" class="form-control" rows="1"  >${surl}</textarea>
                        		</div>
            </div> -->
			<p>图文跳转链接或者发送给第三方用一下URL，通过这个进入直接可以获取到用户信息
			</p>
			<div class="form-group">
                        		<label class="col-sm-2 control-label">带单点登陆 <span class="asterisk">*</span></label>
                        		<div class="col-sm-10">
                            		<textarea id="summary" name="summary" class="form-control" rows="4"  >${ddurl}</textarea>
                        		</div>
            </div>
           
            <div class="form-group">
                        		
                        		<div class="col-sm-10">
                            		<div id="code"></div>
                        		</div>
            </div>
           
            
        
   		</div>
  
	
	</div>
	</div>
</div>
</section>

<script type="text/javascript">
//qrcode('${surl}');	
</script>

</body>
</html>
