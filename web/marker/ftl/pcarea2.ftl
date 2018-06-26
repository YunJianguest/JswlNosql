<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"><head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <title>城市选择</title>
 	
    <link rel="stylesheet" href="/MyNosql/cmp/css/style.css" media="screen" type="text/css">
    <link rel="stylesheet" href="/MyNosql/cmp/css/1.css" media="screen" type="text/css">
    <link rel="stylesheet" href="/MyNosql/cmp/css/2.css" media="screen" type="text/css">
    <link rel="stylesheet" href="/MyNosql/cmp/css/3.css" media="screen" type="text/css">
 	 <link href="/MyNosql/cmp/css/jquery.scroller-1.0.2.css" rel="stylesheet" type="text/css">
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

</head>

<body>

<div style="text-align:center;clear:both">
</div>
<div id="header" class="header" style="position:relative;">
<span id="backbtn" class="backbtn"></span>
<div class="headertitle">热门城市</div>
</div>
<ul id="hotcity" class="city_lst">
<#list rmdictList as dict> 
<li>
<a href="${ip}/cmp/pingche!city.action?toUser=${toUser}&city=${dict.key }&bz=2">${dict.value }</a>
</li>
</#list>

</ul>
<h3>选择城市拼音首字母</h3>
<ul id="letterlist" class="letters_lst">
<li>
<a href="#cityA">A</a>
</li>
<li>
<a href="#cityB">B</a>
</li>
<li>
<a href="#cityC">C</a>
</li>
<li>
<a href="#cityD">D</a>
</li>
<li>
<a href="#cityE">E</a>
</li>
<li>
<a href="#cityF">F</a>
</li>
<li>
<a href="#cityG">G</a>
</li>
<li>
<a href="#cityH">H</a>
</li>
<li>
<a href="#cityJ">J</a>
</li>
<li>
<a href="#cityK">K</a>
</li>
<li>
<a href="#cityL">L</a>
</li>
<li>
<a href="#cityM">M</a>
</li>
<li>
<a href="#cityN">N</a>
</li>
<li>
<a href="#cityP">P</a>
</li>
<li>
<a href="#cityQ">Q</a>
</li>
<li>
<a href="#cityR">R</a>
</li>
<li>
<a href="#cityS">S</a>
</li>
<li>
<a href="#cityT">T</a>
</li>
<li>
<a href="#cityW">W</a>
</li>
<li>
<a href="#cityX">X</a>
</li>
<li>
<a href="#cityY">Y</a>
</li>
<li>
<a href="#cityZ">Z</a>
</li>
</ul>
<#list jcdictList as dict> 
<#if dict.area??>
<div id="city${dict.zm}">
	<h4 id="h">${dict.zm}</h4>
	<ul id="cities" class="city_lst" style="display: block;">
		
		<#list dict.area as areatwo> 
		<li><a href="${ip}/cmp/pingche!city.action?toUser=${toUser}&city=${areatwo.key }&bz=2">${areatwo.value}</a></li>
		</#list>
		
</ul>
</div>
</#if>
</#list>	

<div class="footer">
<span>?2013-2014</span>
</div>
 <script type="text/javascript" src="/MyNosql/cmp/js/jquery-1.4.2.min.js"></script>

</div></body></html>