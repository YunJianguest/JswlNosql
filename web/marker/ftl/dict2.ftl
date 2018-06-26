<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<header class="cmp640 bg-lu hang40 txt-c " style="line-height: 40px;">
    <a href="javascript:gb()" class="pull-left pl-10 "  style="position: absolute;left: 5px"><i class="fa fa-chevron-left mr-10"></i>返回</a>
    <span class="size16 zi-bai " >选择色板</span>
    <a href="javascript:gb()" id="cd-menu-trigger" href=" "><i class="fa fa-1dx fa-remove " style="margin-top:8px;margin-right: 2px"></i></a>
    
</header>
<div class="slider-content cmp640 mt-40 lock" id="slider"  >
            <div class="txt-c">
              <li >
              	<a name="a" class=" title txt-l "><i class="fa fa-minus fa-rotate-90 zi-lu "></i>&nbsp;选择色板</a>
                <#list jcdictList as dict> 
                <a href="javascript:selsb('${dict.key}','${dict.value}');" class="remen"><img src="${osshttp}${dict.picurl}" ><p>${dict.value}</p></a>
                </#list>    
                
              </li>
            </div>
</div>


	
</html>

