<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>

    <div class="main " id="wrapper">
    	
		
        <div class="zimu size22" >选择省</div>
        <div >
            <ul id="cities" class="pinpai_lst" style="display: block;">
            	<#list jcdictList as dict> 
                <li><a href="javascript:seldict1('${dict.value}','${dict.value}');">${dict.value}</a></li>
                </#list>
               
            </ul>
        </div>
      

    </div>
</body>
</html>