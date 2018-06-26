<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
<meta name="apple-touch-fullscreen" content="yes">
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="telephone=no" name="format-detection" />
<meta content="email=no" name="format-detection" />
<title>地区选择</title>
<link href="/MyNosql/shop2/css/public.css"  rel="stylesheet" type="text/css">
<link href="/MyNosql/shop2/css/dcstyle.css"  rel="stylesheet" type="text/css">
<script src="/MyNosql/shop2/js/jquery-1.8.3.min.js" ></script>
<script src="/MyNosql/shop2/js/dc.js" ></script>
</head>

<body>
<header class="dqxz_head">
	<div class="dqxz_head_box headerbox ovh"><div class="search fl"><input type="text" value="请输入搜索关键字" onFocus="if (value =='请输入搜索关键字'){value =''}" onBlur="if (value ==''){value='请输入搜索关键字'}"><a href="#"><img src="/MyNosql/shop2/images/dc_icon01.png" ></a></div></div>
</header>
<section>
	
    
    <div class="hotplace jsplace" id="jsTit">
    	<h2>地区</h2>
        <div class="box">
        	<ul>
        	<#list areaList as area> 
            	<li><a href="#${area._id}">${area.name}</a></li>
            </#list>	
            </ul>
        </div>
    </div>
    <div id="jsList">
    
	     <#list areaList as area> 
         <div class="hotplace">
            <h2><a name="${area._id}" href="/MyNosql/shop/shop!com.action?toUser=${toUser }&areaid=${area._id }">${area.name}</h2>
            <div class="box">
                <ul>
                <#list area.area as areatwo> 
                <li><a href="/MyNosql/shop/shop!com.action?toUser=${toUser }&areatwoid=${areatwo._id }">${areatwo.name}</a></li>
                </#list>
               
            </div>
         </div>
         </#list>
	</div>
</section>

</body>
</html>
