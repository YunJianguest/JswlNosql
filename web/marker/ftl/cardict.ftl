<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<header class="cmp640 bg-lu hang40 txt-c ">
            <a href="javascript:gb();" class="pull-left pl-10 "  style="position: absolute;left: 5px"><i class="fa fa-chevron-left mr-10"></i>返回</a>
            <span class="size16 zi-bai " >选择车型</span>
            <a href="javascript:gb();" id="cd-menu-trigger" ><i class="fa fa-1dx fa-remove " style="margin-top:8px;margin-right: 2px"></i></a>
</header>
<div class="slider-content cmp640 mt-40" >
	<div class="txt-c" id="zimu">
		<li >
				<a name="a" class=" title txt-l "><i class="fa fa-minus fa-rotate-90 zi-lu "></i>&nbsp;热门品牌</a>
                <a href="javascript:selpp('大众','大众');" class="remen"><img src="/MyNosql/cmp/car/大众.png" ><p>大众</p></a>
                <a href="javascript:selpp('福特','福特');" class="remen"><img src="/MyNosql/cmp/car/福特.png" ><p>福特</p></a>
                <a href="javascript:selpp('别克','别克');" class="remen"><img src="/MyNosql/cmp/car/别克.png" ><p>别克</p></a>
                <a href="javascript:selpp('比亚迪','比亚迪');" class="remen"><img src="/MyNosql/cmp/car/比亚迪.png" ><p>比亚迪</p></a>
                <a href="javascript:selpp('雪佛兰','雪佛兰');" class="remen"><img src="/MyNosql/cmp/car/雪佛兰.png" ></a>
                <a href="javascript:selpp('本田','本田');" class="remen"><img src="/MyNosql/cmp/car/本田.png" ></a>
                <a href="javascript:selpp('丰田','丰田');" class="remen"><img src="/MyNosql/cmp/car/丰田.png" ></a>
                <a href="javascript:selpp('马自达','马自达');" class="remen"><img src="/MyNosql/cmp/car/马自达.png" ></a>
              </li>
              <li >	
              	<a name="a" class="title txt-l"><i class="fa fa-minus fa-rotate-90 zi-lu "></i>&nbsp;字母选择</a>
                <a href="#dictA" class="zimu"><p>A</p></a>
                <a href="#dictB" class="zimu"><p>B</p></a>
                <a href="#dictC" class="zimu"><p>C</p></a>
                <a href="#dictD" class="zimu"><p>D</p></a>
                <a href="#dictE" class="zimu"><p>E</p></a>
                <a href="#dictF" class="zimu"><p>F</p></a>
                <a href="#dictG" class="zimu"><p>G</p></a>
                <a href="#dictH" class="zimu"><p>H</p></a>
                <!--<a href="#dictE" class="zimu"><p>I</p></a>-->
                <a href="#dictJ" class="zimu"><p>J</p></a>
                <a href="#dictK" class="zimu"><p>K</p></a>
                <a href="#dictL" class="zimu"><p>L</p></a>
                <a href="#dictM" class="zimu"><p>M</p></a>
                <a href="#dictN" class="zimu"><p>N</p></a>
                <a href="#dictO" class="zimu"><p>O</p></a>
                <a href="#dictP" class="zimu"><p>P</p></a>
                <a href="#dictQ" class="zimu"><p>Q</p></a>
                <a href="#dictR" class="zimu"><p>R</p></a>
                <a href="#dictS" class="zimu"><p>S</p></a>
                <a href="#dictT" class="zimu"><p>T</p></a>
                <!--<a href="#dictE" class="zimu"><p>U</p></a>-->
                <!--<a href="#dictE" class="zimu"><p>V</p></a>-->
                <a href="#dictW" class="zimu"><p>W</p></a>
                <a href="#dictX" class="zimu"><p>X</p></a>
                <a href="#dictY" class="zimu"><p>Y</p></a>
                <a href="#dictZ" class="zimu"><p>Z</p></a>
        </li>
	</div>
		<#list jcdictList as dict> 
            <ul>
            	<li id="dict${dict.zm}"><a name="g" class="title">${dict.zm}</a>
                    <ul>
                    	<#list dict.area as areatwo> 
                        
                        <li><a href="javascript:selpp('${areatwo.value}','${areatwo.value}');"><img src="/MyNosql/cmp/car/${areatwo.value}.png"><span >${areatwo.value}</span></a></li>
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

	
</html>