<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
 
 <%@include file="/webcom/bracket.jsp"%>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="${ctx}/bracket/images/favicon.png" type="image/png">

  <title>用户登陆</title>
 
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>

<body class="signin">
 
<section>
  
    <div class="signinpanel">
        
        <div class="row">
            
            <div class="col-md-7">
                
                <div class="signin-info">
                    <div class="logopanel">
                        <h1><span></span> 资源管理系统 <span></span></h1>
                    </div><!-- logopanel -->
                
                    <div class="mb20"></div>
                
                    <h5><strong></strong></h5>
                    <ul>
                        
                    </ul>
                    <div class="mb20"></div>
                   
                </div><!-- signin0-info -->
            
            </div><!-- col-sm-7 -->
            
            <div class="col-md-5">
                
                <form method="post" id="loginform" name="loginForm"   action="j_spring_security_check">
                    <h4 class="nomargin">后台登陆</h4>
                   
                
                    <input type="text" id="j_username" onblur="checkName(this.value)" name="j_username" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" class="form-control uname" placeholder="账号" />
                    <input type="password" id="j_password" name="j_password" class="form-control pword" placeholder="密码" />
                   
                    <button class="btn btn-success btn-block">登陆</button>
                    
                </form>
            </div><!-- col-sm-5 -->
            
        </div><!-- row -->
        
        <div class="signup-footer">
            <div class="pull-left">
                某某公司
            </div>
            
        </div>
        
    </div><!-- signin -->
  
</section>

 
<script>
    jQuery(document).ready(function(){
        
        // Please do not use the code below
        // This is for demo purposes only
        var c = jQuery.cookie('change-skin');
        if (c && c == 'greyjoy') {
            jQuery('.btn-success').addClass('btn-orange').removeClass('btn-success');
        } else if(c && c == 'dodgerblue') {
            jQuery('.btn-success').addClass('btn-primary').removeClass('btn-success');
        } else if (c && c == 'katniss') {
            jQuery('.btn-success').addClass('btn-primary').removeClass('btn-success');
        }
    });
</script>

</body>
</html>
