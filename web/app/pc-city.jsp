<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"><head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <title>快拼车</title>
 	<link rel="icon" href="${ctx }/cmp/favicon.ico" mce_href="/favicon.ico" type="image/x-icon">
	<link rel="shortcut icon" href="${ctx }/cmp/favicon.ico" mce_href="/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="${ctx }/cmp/css/style.css" media="screen" type="text/css">
    <link rel="stylesheet" href="${ctx }/cmp/css/1.css" media="screen" type="text/css">
    <link rel="stylesheet" href="${ctx }/cmp/css/2.css" media="screen" type="text/css">
    <link rel="stylesheet" href="${ctx }/cmp/css/3.css" media="screen" type="text/css">
 	 <link href="${ctx }/cmp/css/jquery.scroller-1.0.2.css" rel="stylesheet" type="text/css">
    <style>
html {
width: 100%;
height: 100%;
}
body {
background-color: white;
}
ul#searchzone li {
border: none;
border-image: none;
}
ul.city_lst li {
    color: #394B59;
    float: left;
    text-align: center;
    width: 33.3%;
}

ul.city_lst li a {
    border-bottom: 1px dashed #D8D8D8;
    border-right: 1px dashed #D8D8D8;
    color: #394B59;
    display: block;
    height: 50px;
    line-height: 50px;
}

h3 {
    background-color: #008000;
    color: #FFFFFF;
    height: 40px;
    line-height: 40px;
    padding: 0 10px;
}

ul.letters_lst li {
    color: #394B59;
    float: left;
    text-align: center;
    width: 16.6%;
}
ul.letters_lst li a {
    border-bottom: 1px dashed #D8D8D8;
    border-right: 1px dashed #D8D8D8;
    color: #394B59;
    display: block;
    height: 50px;
    line-height: 50px;
}
h4 {
    background-color: #F0F0F0;
    color: #333333;
    height: 30px;
    line-height: 30px;
    padding: 0 10px;
}
</style>
	<link rel="stylesheet" type="text/css" href="http://api.map.baidu.com/res/12/bmap_autocomplete.css">
</head>

<body>

<div style="text-align:center;clear:both">
</div>
<div id="header" class="header" style="position:relative;">
<span id="backbtn" class="backbtn"></span>
<div class="headertitle">热门城市</div>
</div>
<ul id="hotcity" class="city_lst">
<li>
<a onclick="showWait();" href="javascript:;">北京市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">上海市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">成都市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">杭州市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">广州市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">深圳市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">重庆市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">武汉市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">南京市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">石家庄市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">天津市</a>
</li>
<li>
<a onclick="showWait();" href="javascript:;">青岛市</a>
</li>
</ul>
<h3>选择城市拼音首字母</h3>
<ul id="letterlist" class="letters_lst">
<li>
<a href="#citylist">A</a>
</li>
<li>
<a href="#citylist">B</a>
</li>
<li>
<a href="#citylist">C</a>
</li>
<li>
<a href="#citylist">D</a>
</li>
<li>
<a href="#citylist">E</a>
</li>
<li>
<a href="#citylist">F</a>
</li>
<li>
<a href="#citylist">G</a>
</li>
<li>
<a href="#citylist">H</a>
</li>
<li>
<a href="#citylist">J</a>
</li>
<li>
<a href="#citylist">K</a>
</li>
<li>
<a href="#citylist">L</a>
</li>
<li>
<a href="#citylist">M</a>
</li>
<li>
<a href="#citylist">N</a>
</li>
<li>
<a href="#citylist">P</a>
</li>
<li>
<a href="#citylist">Q</a>
</li>
<li>
<a href="#citylist">R</a>
</li>
<li>
<a href="#citylist">S</a>
</li>
<li>
<a href="#citylist">T</a>
</li>
<li>
<a href="#citylist">W</a>
</li>
<li>
<a href="#citylist">X</a>
</li>
<li>
<a href="#citylist">Y</a>
</li>
<li>
<a href="#citylist">Z</a>
</li>
</ul>

<div id="citylist">
<h4 id="h">A</h4>
<ul id="cities" class="city_lst" style="display: block;"><li><a href="javascript:;">澳门特别行政区</a></li><li><a href="javascript:;">安阳市</a></li><li><a href="javascript:;">安顺市</a></li><li><a href="javascript:;">鞍山市</a></li><li><a href="javascript:;">安庆市</a></li><li><a href="javascript:;">阿勒泰地区</a></li><li><a href="javascript:;">阿拉善盟</a></li><li><a href="javascript:;">阿里地区</a></li><li><a href="javascript:;">阿克苏地区</a></li><li><a href="javascript:;">安康市</a></li><li><a href="javascript:;">阿坝藏族羌族自治州</a></li></ul>
</div>
	<div id="shade" style="display: none;">
		<img src="${ctx }/cmp/images/loading.gif">
		正在加载中... 
	</div>

<div class="footer">
<span>©2013-2014</span>
<a href="weixin://contacts/profile/gh_b52e1dd392a2">
<span>快拼车</span>
</a>
<div id="running" style="width:100%;height:100%;visibility:hidden;position:fixed;top:0px;left:0px;z-index:1000;">
<table width="100%" height="100%">
<tbody>
<tr valign="middle" align="center">
<td>
<table width="200px" bgcolor="black" height="200px" style="border-radius:5px;filter: alpha(opacity=70); opacity: 0.7; color: white;">
<tbody>
<tr valign="middle" align="center">
<td>
<div id="clocktimes"> </div>
<br>
正在跳转
<br>
请稍后......
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</div>
 <script type="text/javascript" src="${ctx }/cmp/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx }/cmp/js/loadCity.js"></script>




</div></body></html>