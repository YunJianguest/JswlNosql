<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<div class="top">
        <div class="szm size15">选择品牌首字母</div>
        <ul id="letterlist" class="letters_lst">
            <li><a href="#dictA">A</a></li>
            <li><a href="#dictB">B</a></li>
            <li><a href="#dictC">C</a></li>
            <li><a href="#dictD">D</a></li>
            <li><a href="#dictE">E</a></li>
            <li><a href="#dictF">F</a></li>
            <li><a href="#dictG">G</a></li>
            <li><a href="#dictH">H</a></li>
            <li><a href="#dictJ">J</a></li>
            <li><a href="#dictK">K</a></li>
            <li><a href="#dictL">L</a></li>
            <li><a href="#dictM">M</a></li>
            <li><a href="#dictN">N</a></li>
            <li><a href="#dictO">O</a></li>
            <li><a href="#dictP">P</a></li>
            <li><a href="#dictQ">Q</a></li>
            <li><a href="#dictR">R</a></li>
            <li><a href="#dictS">S</a></li>
            <li><a href="#dictT">T</a></li>
            <li><a href="#dictW">W</a></li>
            <li><a href="#dictX">X</a></li>
            <li><a href="#dictY">Y</a></li>
            <li><a href="#dictZ">Z</a></li>
           
        </ul>
    </div>
    <div class="main " id="wrapper">
    	<#list jcdictList as dict> 
		<#if dict.area??>
        <div class="zimu size22" id="dict${dict.zm}">${dict.zm}</div>
        <div >
            <ul id="cities" class="pinpai_lst" style="display: block;">
            	<#list dict.area as areatwo> 
                <li><a href="javascript:selpp('${areatwo.key}','${areatwo.value}');">${areatwo.value}</a></li>
                </#list>
               
            </ul>
        </div>
        </#if>
		</#list>

    </div>
</body>
</html>