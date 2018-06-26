<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<header class="cmp640 bg-lu hang40 txt-c " style="line-height: 40px;">
    <a href="javascript:gb()" class="pull-left pl-10 "  style="position: absolute;left: 5px"><i class="fa fa-chevron-left mr-10"></i>返回</a>
    <span class="size16 zi-bai " >选择省市</span>
    <a href="javascript:gb()" id="cd-menu-trigger" href=" "><i class="fa fa-1dx fa-remove " style="margin-top:8px;margin-right: 2px"></i></a>
    <div class="txt-c">
        <div class="slider-content txt-c">
        <li ><a  class="title txt-l"><i class="fa fa-minus fa-rotate-90 zi-lu "></i>&nbsp;热门城市</a>
            <a href="javascript:selpro('北京市');" class="remen"><p>北京市</p></a>
            <a href="javascript:selpro('天津');" class="remen"><p>天津</p></a>
            <a href="javascript:selpro('西安" class="remen"><p>西安</p></a>
            <a href="javascript:selpro('石家庄');" class="remen"><p>石家庄</p></a>
        </li>
        </div>
    </div>
</header>
<div class="slider-content cmp640 mt-40" >
	<div class="txt-c" id="zimu">
		<li >	<a name="a" class="title txt-l"><i class="fa fa-minus fa-rotate-90 zi-lu "></i>&nbsp;字母选择</a>
                <#list jcdictList as dict> 
                <a href="#pro${dict.zm}" class="zimu"><p>${dict.zm}</p></a>
                
        		</#list>
        </li>
	</div>
		<#list jcdictList as dict> 
            <ul>
            	<li id="pro${dict.zm}"><a name="g" class="title">${dict.zm}</a>
                    <ul>
                    	<#list dict.area as areatwo> 
                        <li><a href="javascript:selpro('${areatwo.value}');"><span>${areatwo.value}</span></a></li>
                        </#list>
                        
                    </ul>
                </li>
               
			</ul>
		</#list>
	
		
</div>

<a href="#zimu" class="zi-hui" style="position: fixed;right:10px;bottom: 10px">
        <span class="fa-stack fa-2x">
               <i class="fa fa-square fa-stack-2x" style="color:rgba(0, 0, 0, 0.4);"></i>
               <i class="fa fa-arrow-up fa-stack-1x fa-inverse" style="left:-4px"></i>
         </span>
      </a>		
	
    


</body>
</html>