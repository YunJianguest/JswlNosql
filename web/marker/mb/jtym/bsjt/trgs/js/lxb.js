window.lxb=window.lxb||{};lxb.instance=lxb.instance||0;lxb.instance++;(function(){var a={};lxb.add=lxb.add||function(b,d){var c=a[b];if(!c){c=a[b]={};d.call(null,c)}};lxb.use=lxb.use||function(b){if(typeof b=="string"){if(!a[b]){throw"no module: "+b}else{return a[b]}}else{b.call(null,a)}}})();lxb.add("util",function(a){var b=null;a.init=function(c){b=c};a.css=function(d,c,f){if(!d){return}if(f!==undefined){d.style[c]=f}else{try{if(window.getComputedStyle){return window.getComputedStyle(d)[c]}else{if(d.currentStyle){return d.currentStyle[c]}}}catch(g){}}};a.isStandard=function(){return b.styleType==1};a.isCustom=function(){return b.styleType==2};a.isHorizon=function(){if(b.styleType==1){return b.style<1000}return b.windowLayout==1};a.isVertical=function(){if(b.styleType==1){return b.style>1000}return b.windowLayout==2};a.isLeft=function(){return b.position>0};a.isRight=function(){return b.position<0};a.displayGroup=function(){return b.ifGroup&&(b.windowLayout==2)};a.display400=function(){return b.float_window==1||b.float_window==3};a.displayCallback=function(){return b.float_window==2||b.float_window==3};a.displayLink=function(){return b.inviteInfo.linkStatus==1};a.isVisible=function(c){return c.style.visibility=="visible"}});lxb.add("base",function(d){var c=/msie (\d+\.\d+)/i.test(navigator.userAgent)?(document.documentMode||+RegExp["\x241"]):undefined;d.ie=c;d.g=function(e){return document.getElementById(e)};var m={};if(c<8){m["class"]="className";m.maxlength="maxLength"}else{m.className="class";m.maxLength="maxlength"}d.create=function(r,q){var t=document.createElement(r);var e;if(q){for(var s in q){if(q.hasOwnProperty(s)){e=m[s]||s;t.setAttribute(e,q[s])}}}return t};d.jsonToQuery=function(e){var r=[];for(var q in e){if(e.hasOwnProperty(q)){r.push(q+"="+encodeURIComponent(e[q]))}}return r.join("&")};d.extend=function(r,q){for(var e in q){if(q.hasOwnProperty(e)){r[e]=q[e]}}return r};d.encodeHTML=function(e){return e.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;").replace(/'/g,"&#39;")};var g=new RegExp("(^[\\s\\t\\xa0\\u3000]+)|([\\u3000\\xa0\\s\\t]+\x24)","g");d.trim=function(e){return e.replace(g,"")};d.queryToJSON=function(s){var q={};s=s.split("&");for(var e=0,r;r=s[e];e++){r=r.split("=");if(r[0]){q[r[0]]=r[1]}}return q};d.setCookie=function(r,s,t,e){var u=r+"="+s;if(t){u+="; path="+t}if(e){var q=new Date();q.setTime(q.getTime()+e*24*3600*1000);u+="; expires="+q.toGMTString()}document.cookie=u};d.getCookie=function(q){var r=new RegExp("(^| )"+q+"=([^;]*)(;|\x24)");var e=r.exec(document.cookie);if(e){return e[2]||null}else{return null}};var p=[];var l;var k=false;function n(){if(!k){k=true;for(var q=0,e=p.length;q<e;q++){p[q]()}}}function f(){try{document.documentElement.doScroll("left")}catch(q){setTimeout(f,1);return}n()}if(document.addEventListener){l=function(){document.removeEventListener("DOMContentLoaded",l,false);n()}}else{if(document.attachEvent){l=function(){if(document.readyState==="complete"){document.detachEvent("onreadystatechange",l);n()}}}}if(document.readyState==="complete"){k=true}else{if(document.addEventListener){document.addEventListener("DOMContentLoaded",l,false);window.addEventListener("load",n,false)}else{if(document.attachEvent){document.attachEvent("onreadystatechange",l);window.attachEvent("onload",n);var o=false;try{o=window.frameElement==null}catch(h){}if(document.documentElement.doScroll&&o){f()}}}}d.ready=function(e){k?e():p.push(e)};var b=["","4-3-3","3-4-3","3-3-4"];d.formatTel=function(e,t){var u=b[parseInt(t,10)];var r=[];if(!u){return e}e=e.split("");u=u.split("-");for(var q=0,s;s=u[q];q++){r.push(e.splice(0,parseInt(s,10)).join(""))}return r.join("-")};var a=[];function j(){for(var e=0,q;q=a[e];e++){i(q)}}function i(q){var e=document.compatMode=="CSS1Compat"?document.documentElement:document.body;var r=q.ele;var t;var s;if(q.top===t){s=r.style.top||r.currentStyle.top;if(!s||s=="auto"){s=r.style.bottom||r.currentStyle.bottom;if(s&&s.indexOf("%")>=0){s=e.clientHeight*(100-parseInt(s,10))/100-r.offsetHeight}else{if(s=="auto"){s=t}else{if(s){s=e.clientHeight-r.offsetHeight-parseInt(s,10)}}}}if(s){if(typeof s=="string"&&s.indexOf("%")>=0){s=e.clientHeight*parseInt(s,10)/100}else{s=parseInt(s,10)}q.top=s}else{q.top=t}}if(q.top!==t){r.style.top=e.scrollTop+q.top+"px"}}d.setFixed=function(e){if(a.length<=0){window.attachEvent("onscroll",j);window.attachEvent("onresize",j)}e.style.position="absolute";a.push({ele:e});i(a[a.length-1])};d.addClass=function(q,e){var s=q.className;if(!q){return}var r=new RegExp(e);if(!r.test(q.className)){s=q.className+" "+e}q.className=s.replace(/\s+/," ").replace(/^\s|\s$/,"")};d.removeClass=function(q,e){var s=q.className;if(!q){return}var r=new RegExp(e);if(r.test(q.className)){s=q.className.replace(r,"")}q.className=s.replace(/\s+/," ").replace(/^\s|\s$/,"")};d.q=function(t,s){var q=[],e,r,v,u;if(!(t=t.replace(/\s+/,""))){return q}if("undefined"==typeof s){s=document}if(s.getElementsByClassName){v=s.getElementsByClassName(t);e=v.length;for(r=0;r<e;r++){u=v[r];q[q.length]=u}}else{t=new RegExp("(^|\\s)"+t+"(\\s|\x24)");v=s.all||s.getElementsByTagName("*");e=v.length;for(r=0;r<e;r++){u=v[r];t.test(u.className)&&(q[q.length]=u)}}return q};d.viewportSize=function(){if(document.compatMode=="BackCompat"){return{width:document.body.clientWidth,height:document.body.clientHeight}}else{return{width:document.documentElement.clientWidth,height:document.documentElement.clientHeight}}}});lxb.add("config",function(a){var b=location.href.indexOf("https://")==0?"https://":"http://";a.SiteId="3049852";a.Root=b+"lxbjs.baidu.com/"+"float";a.Lang={TRAN:"\u8f6c",WE:"\u6211\u4eec",CB_INPUT_TIP_1:"\u624b\u673a\u8bf7\u76f4\u63a5\u8f93\u5165\uff1a\u59821860086xxxx",CB_INPUT_TIP_2:"\u5ea7\u673a\u524d\u52a0\u533a\u53f7\uff1a\u59820105992xxxx",CB_INPUT_TIP_3:"\u8f93\u5165\u60a8\u7684\u7535\u8bdd\u53f7\u7801\uff0c\u70b9\u51fb\u901a\u8bdd\uff0c\u7a0d\u540e\u60a8\u5c06\u63a5\u5230\u6211\u4eec\u7684\u7535\u8bdd\uff0c\u8be5\u901a\u8bdd\u5bf9\u60a8<em>\u5b8c\u5168\u514d\u8d39</em>\uff0c\u8bf7\u653e\u5fc3\u63a5\u542c\uff01",CB_INPUT_TIP_HOLDER:"\u8bf7\u8f93\u5165\u60a8\u7684\u7535\u8bdd\u53f7\u7801",INVITE_INPUT_TIP_HOLDER:"\u8F93\u5165\u53F7\u7801\u540E\u70B9\u51FB\u4E0B\u5217\u6309\u94AE\uFF0C\u514D\u8D39\u56DE\u7535",CB_SUCCESS_TIP_1:"\u7a0d\u540e\u60a8\u5c06\u63a5\u5230",CB_SUCCESS_TIP_2:"\u7684\u7535\u8bdd\uff0c<br />\u8be5\u901a\u8bdd\u5bf9\u60a8<em>\u5b8c\u5168\u514d\u8d39</em>\uff0c<br />\u8bf7\u653e\u5fc3\u63a5\u542c\uff01",ERROR_CB_PHONE:"\u8bf7\u60a8\u8f93\u5165\u6b63\u786e\u7684\u53f7\u7801\uff0c\u624b\u673a\u53f7\u7801\u8bf7\u76f4\u63a5\u8f93\u5165\uff0c\u5ea7\u673a\u8bf7\u52a0\u533a\u53f7",ERROR_CB_FAIL:"\u7cfb\u7edf\u7e41\u5fd9\uff0c\u8bf7\u7a0d\u540e\u91cd\u8bd5",LOADING_CB_TIP:"\u62e8\u53f7\u4e2d\uff0c\u8bf7\u7a0d\u5019",CB_SUCCESS_TIP_TXT_0:"\u7a0d\u540e\u60a8\u5c06\u63a5\u5230\u6211\u4eec\u7684\u6765\u7535",CB_SUCCESS_TIP_TXT_1:"\u6b63\u5728\u547c\u53eb\u60a8\u7684\u7535\u8bdd",CB_SUCCESS_TIP_TXT_2:"\u8bf7\u51c6\u5907\u63a5\u542c",CB_INFO_TIP_CLOSE:"\u2573"};a.ClassName={MAIN:"lxb-container",TL_PHONE:"lxb-tl-phone",TL_PHONE_EM:"lxb-tl-phone-em",CB_ICON:"lxb-cb-icon",CB_INPUT:"lxb-cb-input",CB_INPUT_BTN:"lxb-cb-input-btn",CB_INPUT_TIP:"lxb-cb-input-tip",CB_INPUT_TIP_CURSOR:"lxb-cb-input-tip-cursor",CB_SUCCESS_TIP:"lxb-cb-success-tip",CB_LOADING_TIP:"lxb-cb-loading-tip",CB_INFO_TIP:"lxb-cb-info-tip",INVITE_LINK_CON:"lxb-invite-link-con",INVITE_LINK_TEXT:"lxb-invite-link-txt",INVITE_LINK_BTN:"lxb-invite-link-btn",Position:{HOR:["lxb-pos-left","lxb-pos-right"],VER:["lxb-pos-top","lxb-pos-middle","lxb-pos-bottom"]},PositionFix:{HOR:["-left","-right"],VER:["-top","-middle","-bottom"]}};a.ID={MAIN:"LXB_CONTAINER",SHOW:"LXB_CONTAINER_SHOW",IMG_PREV:"LXB_IMG_PREV_",COOKIE_DBCLKID:"LXB_DBCLICKID",COOKIE_REFER:"LXB_REFER"};a.TPL={CB_INPUT_TIP_1:'<ins class="lxb-cb-input-tip-mobile">'+a.Lang.CB_INPUT_TIP_1+'</ins><ins class="lxb-cb-input-tip-tel">'+a.Lang.CB_INPUT_TIP_2+'</ins><ins class="lxb-cb-input-tip-em">'+a.Lang.CB_INPUT_TIP_3+'</ins><ins class="lxb-cb-input-tip-cursor"></ins>',CB_SUCCESS_TIP_1:'<ins class="lxb-cb-success-tip-inner">',CB_SUCCESS_TIP_2:"</ins>",CB_LOADING_TIP:'<ins class="lxb-cb-loading-tip-img"></ins><ins class="lxb-cb-loading-tip-txt">'+a.Lang.LOADING_CB_TIP+"</ins>",CB_INFO_TIP_MAIN:'<ins class="lxb-cb-info-tip-con"></ins><ins class="lxb-cb-info-tip-arrow"></ins><ins class="lxb-cb-info-tip-close">'+a.Lang.CB_INFO_TIP_CLOSE+"</ins>",CB_SUCCESS_TIP_IMG:'<ins class="lxb-cb-success-tip-img"></ins>',CB_SUCCESS_TIP_PHONE:'<ins class="lxb-cb-success-tip-phone">',CB_SUCCESS_TIP_PHONE_END:"</ins>",CB_SUCCESS_TIP_TXT:'<ins class="lxb-cb-success-tip-txt">'+a.Lang.CB_SUCCESS_TIP_TXT_1+'</ins><ins class="lxb-cb-success-tip-txt">'+a.Lang.CB_SUCCESS_TIP_TXT_2+"</ins>",CB_SUCCESS_TIP_TXT_1:'<ins class="lxb-cb-success-tip-txt">'+a.Lang.CB_SUCCESS_TIP_TXT_0+'</ins><ins class="lxb-cb-success-tip-txt">'+a.Lang.CB_SUCCESS_TIP_TXT_2+"</ins>",CB_ERROR_TIP_S:'<ins class="lxb-cb-error-tip">',CB_ERROR_TIP_E:"</ins>"}});lxb.add("net",function(a){var d=lxb.use("base");function e(f,g){return function(h){g.call(null,h);setTimeout(function(){var i=lxb.use("base").g(f);i.parentNode.removeChild(i)},0)}}function b(g,i){var h=document.getElementsByTagName("head")[0];var f=d.create("script",{type:"text/javascript",src:g,id:i||"",charset:"utf-8"});h.appendChild(f)}function c(f){var h=document.getElementsByTagName("head")[0];var g=d.create("link",{rel:"stylesheet",href:f,type:"text/css",charset:"utf-8"});h.appendChild(g)}a.send=function(f,h,j){var g="_lxb_jsonp_"+new Date().getTime().toString(36)+"_";var i=["t="+(new Date().getTime())];i.push("callback="+g);window[g]=e(g,j);h=h||"";if(typeof h!=="string"){h=d.jsonToQuery(h)}h+=(h?"&":"")+i.join("&");f+=(f.indexOf("?")>=0?"&":"?")+h;b(f,g)};a.loadCSS=c;a.log=function(f,g){if(window.console&&console.log){console.log("["+f+"]"+g)}}});lxb.add("tip",function(d){var f={};var i=preHeight=preTop=preLeft=preTipHeight=0;var j={};var a=function(m,l){for(var k in m){if((m.hasOwnProperty&&m.hasOwnProperty(k))||(!m.hasOwnProperty)){if(!(k in ["event"])){l[k]=m[k]}}}};var h=function(){j={arrow:null,close:null,con:null,tipEle:null,value:10}};var b=function(){if(document.compatMode=="BackCompat"){return{width:document.body.clientWidth,height:document.body.clientHeight}}else{return{width:document.documentElement.clientWidth,height:document.documentElement.clientHeight}}};var g=function(k){return{width:k.offsetWidth,height:k.offsetHeight,top:k.offsetTop,left:k.offsetLeft}};var e=function(k){return{width:k.offsetWidth,height:k.offsetHeight,top:k.offsetTop,left:k.offsetLeft}};var c=function(){f.body=b();f.con=g(j.con);f.tip=e(j.tipEle)};d.init=function(k){h();a(k,j)};d.show=function(){j.tipEle.style.display="";c();if(preTipHeight!=f.tip.height||i!=f.con.width||preHeight!=f.con.height||preTop!=f.con.top||preLeft!=f.con.left){d.resetLoc();i=f.con.width;preHeight=f.con.height;preTop=f.con.top;preLeft=f.con.left;preTipHeight=f.tip.height}};d.resetLoc=function(){var k=(f.con.height<=f.tip.height)?true:false;if(f.tip.width>f.con.left){if(f.tip.height>f.con.top){j.arrow.className="arrow-left-t";j.arrow.style.top="6px";j.tipEle.style.top=k?"22px":"10px"}else{j.arrow.className="arrow-left-b";j.tipEle.style.top=k?(f.con.height-f.tip.height-10)+"px":"0px"}j.tipEle.style.left=(f.con.left+f.con.width+7+j.value)+"px"}else{if(f.tip.height>f.con.top){j.arrow.className="arrow-right-t";j.arrow.style.top="6px";j.tipEle.style.top=k?"22px":"10px"}else{j.arrow.className="arrow-right-b";j.tipEle.style.top=k?(f.con.height-f.tip.height-10)+"px":"0px"}j.tipEle.style.left=(-f.tip.width-7-10)+"px"}};d.hide=function(){j.tipEle.style.display="none"}});lxb.add("business.replacer",function(b){function e(j,h,l){var g;for(var f=0,k;k=h[f];f++){g=j.nodeValue.replace(k,l);if(g!=j.nodeValue){j.nodeValue=g}}}function a(h){var g=[];if(typeof h=="string"){h=[h]}for(var f=0,j;j=h[f];f++){if(j.indexOf("@REG:")==0){g.push(new RegExp(j.substring(5),"g"))}else{g.push(j)}}return g}function d(h){var f=[];if(h.nodeType==3){f.push(h)}else{if(h.nodeType==1&&(h.className||h.className==="")&&h.className.indexOf&&h.className.indexOf("lxb-")<0){for(var g=h.firstChild;g!=null;g=g.nextSibling){f=f.concat(d(g))}}}return f}function c(j,k){var f=d(document.body||document.getElementsByTagName("body")[0]);var j=a(j);for(var g=0,h;h=f[g];g++){e(h,j,k)}}b.run=function(j,f,g,k){var i=lxb.use("base");var h=lxb.use("config").Lang;var l=i.formatTel(f,k)+(g?h.TRAN+g:"");if(!j||j.length<=0||!l){return}i.ready(function(){c(j,l)})}});lxb.add("business.container",function(e){var c=lxb.use("base");var h=lxb.use("config").ClassName;var i=lxb.use("config").ID;var g=lxb.use("util");var a=function(){};var f={};var k={};var j=0;function l(){var n=k.main;var o=k.mask;var m=n.style.height||(n.currentStyle?n.currentStyle.height:"");if(!m||m=="auto"){setTimeout(l,300)}else{o.style.height=m;o.style.width=n.style.width||(n.currentStyle?n.currentStyle.width:"100%");n.style.zoom=1}}function b(){var t=h.MAIN;var o=k.main=c.create("ins",{id:i.MAIN});o.style.visibility="hidden";if(f.floatColor){o.style.backgroundColor=f.floatColor}if(f.imagePath){o.style.backgroundImage='url("'+f.imagePath+'")'}var u=h.MAIN+"-"+f.style+"-"+f.type;var m=0;var q=0;if(f.position>0){m=1}var r="";if(g.isHorizon()){r="lxb-vertical"}else{if(g.isVertical()){r="lxb-horizen"}}q=Math.abs(f.position);var s=h.Position.HOR[m];u+=" "+u+h.PositionFix.HOR[m];o.className=t+" "+u+" "+s+" "+r;if(q<=45){o.className+=" "+h.Position.VER[0]}else{o.className+=" "+h.Position.VER[1]}var n=k.btnHide=c.create("ins",{className:h.MAIN+"-btn-hide"});o.appendChild(n);n=k.btnShow=c.create("ins");t=h.MAIN+"-btn-show";t+=" "+h.MAIN+"-btn-show-"+f.style;t+=" "+s;t+=" "+h.MAIN+"-btn-show-"+f.style+h.PositionFix.HOR[m];n.id=i.SHOW;n.className=t;n.style.display="none";if(!(g.isStandard()&&g.isHorizon())){btnBg=k.btnShowBg=c.create("ins",{className:h.MAIN+"-btn-show-bg"});if(f.floatColor){n.style.backgroundColor=f.floatColor}if(f.imagePath){n.style.backgroundImage='url("'+f.imagePath+'")'}n.appendChild(btnBg)}var p=function(w){var v=g.css(o,"zIndex");if(v>0){w.call(null)}else{setTimeout(function(){p(w)},30)}};p(function(){j=parseInt(g.css(o,"height"));if(g.isVertical()){if(g.displayGroup()){j=190+25*f.groupDetail.length}else{if(g.isCustom()){j=220}}}if(g.isCustom()&&g.isHorizon()){j=90}o.style.height=j+"px";o.style.visibility="visible";var v=c.viewportSize();q=(q==1?0:q);k.btnShow.style.top=o.style.top=(q/100*(v.height-j))+"px";a()});if(c.ie&&c.ie<=6){k.mask=c.create("iframe",{frameBorder:0,className:h.MAIN+"-mask"});o.appendChild(k.mask);n.appendChild(k.btnShowMask=c.create("iframe",{frameBorder:0,className:h.MAIN+"-mask"}))}document.body.appendChild(n);document.body.appendChild(o);if(!c.ie){return}if(c.ie<=6||(c.ie==7&&document.compatMode!="CSS1Compat")){n.style.display="";c.setFixed(n);n.style.display="none";c.setFixed(o)}if(c.ie<=6){l();k.btnShowMask.contentWindow.document.open();k.btnShowMask.contentWindow.document.write('<html><head></head><body style="padding:0px;margin:0px;height:100%;width:100%"></body></html>');k.btnShowMask.contentWindow.document.close()}}function d(){k.main.onkeypress=k.main.onkeydown=k.main.onkeyup=k.main.onmousedown=k.main.onmouseup=k.main.onclick=function(n){n=n||window.event;if(n.stopPropagation){n.stopPropagation()}else{n.cancelBubble=true}};k.btnHide.onclick=function(){k.main.style.display="none";k.btnShow.style.display=""};function m(){k.btnShow.style.display="none";k.main.style.display=""}if(k.btnShowMask){k.btnShowMask.contentWindow.document.onclick=m}k.btnShow.onclick=m}e.init=function(m,n){a=n;c.extend(f,m);b();d();return{main:k.main,btnShow:k.btnShow}}});lxb.add("business.custom",function(a){var b=lxb.use("config").ClassName;a.init=function(e){var c=e.main;var g=e.btnShow;var f=b.MAIN+"-custom";f+=" "+b.MAIN+"-custom-"+e.type+"-"+(e.windowLayout==1?"h":"v");f+=" "+b.MAIN+"-custom-"+(e.windowLayout==1?"h":"v")+(Math.abs(e.position)==50?b.PositionFix.VER[1]:"");c.className+=" "+f;var d=e.url;if(d.indexOf("?")>=0){d+="&"}else{d+="?"}d+="t="+new Date().getTime();c.style.backgroundImage="url("+d+")"}});lxb.add("http://weixin.aduer.com/show/css/style1/business.tel",function(a){var e=lxb.use("base");var f=lxb.use("config").ClassName;var d=lxb.use("config").Lang;var b={};function c(){var h=e.create("ins",{className:f.TL_PHONE});var i=e.formatTel(e.encodeHTML(b.phone),b.format);if(b.mode==1&&b.ext){i+=' <em class="'+f.TL_PHONE_EM+'">'+d.TRAN+"</em>"+e.encodeHTML(b.ext)}h.innerHTML=i;var g=h.getElementsByTagName("em")[0];if(b.telFontcolor){h.style.color=b.telFontcolor}if(b.telFontfamily!==undefined&&b.styleType!=1){switch(b.telFontfamily-0){case 0:h.style.fontFamily="\u5b8b\u4f53";if(g){g.style.fontFamily="\u5b8b\u4f53"}break;case 1:h.style.fontFamily="\u9ed1\u4f53";if(g){g.style.fontFamily="\u9ed1\u4f53"}break;case 2:h.style.fontFamily="\u5fae\u8f6f\u96c5\u9ed1";if(g){g.style.fontFamily="\u5fae\u8f6f\u96c5\u9ed1"}break;default:h.style.fontFamily="\u5b8b\u4f53";if(g){g.style.fontFamily="\u5b8b\u4f53"}}}if(b.telFontsize){h.style.fontSize=b.telFontsize+"px";if(g){g.style.fontSize=b.telFontsize+"px"}}if(b.telFontcolor){h.style.color=b.telFontcolor;if(g){g.style.color=b.telFontcolor}}b.main.appendChild(h)}a.init=function(g){e.extend(b,g);c()}});lxb.add("business.callback",function(p){var i=lxb.use("base");var h=lxb.use("config").Lang;var d=lxb.use("config").TPL;var f=lxb.use("config").ClassName;var b=lxb.use("util");var g={};var k={};var l="";function q(){l=h.CB_INPUT_TIP_HOLDER;if(b.displayGroup()){l=h.INVITE_INPUT_TIP_HOLDER}var t=k.input=i.create("input",{type:"text",name:"phone",className:f.CB_INPUT,maxlength:12,value:l});var y=k.cbCon=i.create("ins",{className:"lxb-callback-container"});k.cbCon.appendChild(t);var v=k.btn=i.create("ins",{className:f.CB_INPUT_BTN});v.innerHTML=i.encodeHTML(g.btnFontContent||"");if(!(b.isStandard()&&b.isHorizon())){v.style.color=g.btnfontColor;v.style.backgroundColor=g.btnColor}k.cbCon.appendChild(v);if(b.displayGroup()){v.style.display="none";var x=k.groupContainer=i.create("ins",{className:"lxb-group-container"});k.cbCon.appendChild(x);for(var u=0;u<g.groupDetail.length;u++){var z=i.create("ins",{groupid:g.groupDetail[u].groupid,title:"\u514D\u8D39\u56DE\u7535",className:"lxb-group-btn"});z.innerHTML=i.encodeHTML(g.groupDetail[u].groupname);z.style.color=g.btnfontColor;z.style.backgroundColor=g.btnColor;x.appendChild(z)}}var w=k.tip=i.create("ins",{className:f.CB_INPUT_TIP});var s=lxb.use("config").TPL;w.style.display="none";w.innerHTML=s.CB_INPUT_TIP_1;if(i.ie&&i.ie<=6){w.appendChild(i.create("iframe",{className:f.MAIN+"-mask",frameBorder:0}))}g.main.appendChild(y);g.main.appendChild(w)}var e=lxb.use("tip");function o(){var t=k.infoLayer;t=k.infoLayer=i.create("ins",{className:f.CB_INFO_TIP});t.innerHTML=d.CB_INFO_TIP_MAIN;var s=t.getElementsByTagName("ins");k.tipCon=s[0];k.tipOpt={arrow:s[1],close:s[2],con:g.main,tipEle:t};s[2].onclick=function(){e.hide();clearTimeout(g.successTimer)};g.main.appendChild(t)}function n(s){if(!k.infoLayer){o()}k.tipCon.innerHTML=d.CB_ERROR_TIP_S+i.encodeHTML(s)+d.CB_ERROR_TIP_E;e.init(k.tipOpt);e.show()}function r(s){if(!k.infoLayer){o()}if(s.order=="0"){k.tipCon.innerHTML=d.CB_SUCCESS_TIP_IMG+d.CB_SUCCESS_TIP_PHONE+i.encodeHTML(s.cbPhone)+d.CB_SUCCESS_TIP_PHONE_END+d.CB_SUCCESS_TIP_TXT}else{k.tipCon.innerHTML=d.CB_SUCCESS_TIP_IMG+d.CB_SUCCESS_TIP_TXT_1}e.init(k.tipOpt);e.show();if(s.order=="0"){g.successTimer=setTimeout(function(){e.hide()},5000)}else{g.successTimer=setTimeout(function(){e.hide()},30000)}}function c(){var s=function(t){k.input.blur();if(g.successTimer){e.hide();clearTimeout(g.successTimer)}var u=k.input.value=i.trim(k.input.value);if(!m(u)){return}j(u,t)};if(b.displayGroup()){k.groupContainer.onclick=function(v){v=v||window.event;var u=v.srcElement||v.target;if(/lxb\-group\-btn/.test(u.className.toLowerCase())){var t=u.getAttribute("groupid");s(t)}}}else{k.btn.onclick=function(){s()}}k.input.onfocus=function(){k.tip.style.display="";if(this.value==l){this.value=""}k.loadingLayer&&(k.loadingLayer.style.display="none");if(g.successTimer){e.hide();clearTimeout(g.successTimer)}};k.input.onblur=function(){k.tip.style.display="none";if(i.trim(this.value)==""){this.value=l}};if(!b.displayGroup()){k.input.onkeyup=function(t){t=t||window.event;if(t.keyCode==13){k.btn.onclick()}}}}function a(){var s=k.loadingLayer;if(!s){s=k.loadingLayer=i.create("ins",{className:f.CB_LOADING_TIP});s.style.display="none";g.main.appendChild(s)}s.innerHTML=d.CB_LOADING_TIP;s.style.display=""}function m(t){var s=true;if(!/^\d{11,12}$/.test(t)){s=false;n(h.ERROR_CB_PHONE)}return s}function j(u,t){var v=lxb.use("net");var s=lxb.use("config").Root+"/_c.js";if(g.submitTimer){return}a();g.submitTimer=setTimeout(function(){g.submitTimer=null},5000);var w={vtel:u,siteid:g.siteid,code:g.code};if(t){w.g=t}v.send(s,w,function(x){k.loadingLayer.style.display="none";if(!!x.status){var z=x.msg||h.ERROR_CB_FAIL;n(z+" ( code: "+x.status+" )")}else{var y={};y.order=x.order;y.cbPhone=x.cbPhone;r(y);k.input.value=l}if(g.submitTimer){clearTimeout(g.submitTimer);g.submitTimer=null}})}p.init=function(s){i.extend(g,s);q();c()}});(function(){var j=lxb.use("util");function i(r){var e={};var q=r.float_window;var s=0;if(r.inviteInfo){s=r.inviteInfo.status}if(!q||q=="0"){return{}}e.base={position:r.position,groupDetail:r.groupDetail,windowLayout:r.windowLayout,style:r.style,type:q};if(j.isStandard()){if(j.isVertical()){e.base.floatColor=r.floatColor}}if(j.isCustom()){e.custom={url:r.imagePath,windowLayout:r.windowLayout,position:r.position,type:q};e.base.style="custom";e.base.imagePath=r.imagePath}if(j.display400()){e.tel={phone:r.phone,mode:r.mode,format:r.format,ext:r.ext};if(j.isCustom()){e.tel.telFontcolor=r.telFontcolor;e.tel.telFontfamily=r.telFontfamily;e.tel.telFontsize=r.telFontsize;e.tel.telFontcolor=r.telFontcolor}}if(j.displayCallback()){e.callback={callPhone:r.cbPhone||"",style:r.style,btnFontContent:r.btnFontContent,siteid:r.siteid,btnfontColor:r.btnfontColor,btnColor:r.btnColor,styleType:r.styleType,windowLayout:r.windowLayout,ifGroup:r.ifGroup,groupDetail:r.groupDetail,code:r.code}}if(s!==0){r.inviteInfo=r.inviteInfo||{};r.inviteWay=r.inviteWay||{};e.invite={ifGroup:r.ifGroup,windowLayout:r.windowLayout,status:r.inviteInfo.status||0,content:r.inviteInfo.content||"",font:r.inviteInfo.font||0,fontSize:r.inviteInfo.fontSize||16,fontColor:r.inviteInfo.fontColor||"#000000",background:r.inviteInfo.background||1,backgroundColor:r.inviteInfo.backgroundColor||"rgb(197, 232, 251)",backgroundImg:r.inviteInfo.backgroundImg||"",btnColor:r.inviteInfo.btnColor||"rgb(132, 133, 134)",btnFontColor:r.inviteInfo.btnFontColor||"#ffffff",telFont:r.inviteInfo.telFont||0,telSize:r.inviteInfo.telSize||18,telColor:r.inviteInfo.telColor||"#000000",height:r.inviteInfo.height||140,width:r.inviteInfo.width||230,imgHeight:r.inviteInfo.imgHeight||140,imgWidth:r.inviteInfo.imgWidth||230,position:r.inviteInfo.position||0,linkStatus:r.inviteInfo.linkStatus||0,linkURL:r.inviteInfo.linkURL,linkTextContent:r.inviteInfo.linkTextContent||"",linkTextColor:r.inviteInfo.linkTextColor||"#000000",linkTextFont:r.inviteInfo.linkTextFont||0,linkBtnContent:r.inviteInfo.linkBtnContent||"������������",linkBtnBgColor:r.inviteInfo.linkBtnBgColor||"#000000",linkBtnFontColor:r.inviteInfo.linkBtnFontColor||"#ffffff",ifStartPage:r.inviteWay.ifStartPage||0,stayTime:r.inviteWay.stayTime||0,inviteTimes:r.inviteWay.inviteTimes||1,inviteInterval:r.inviteWay.inviteInterval||0,closeTime:r.inviteWay.closeTime||0,siteId:r.inviteWay.siteId}}return e}function d(w){var v=lxb.use("net");var q=lxb.use("util");if(!!w.status){v.log("error","init");return}var t=w.data;q.init(t);if(t.replace&&t.phone){try{var s=t.mode==1?t.ext:"";lxb.use("business.replacer").run(t.replace,t.phone,s||"",t.format||"1")}catch(u){v.log("error","replace")}}if(t.style<=5&&t.float_window!=1){return}t=i(t);var x;if(t.base){var r=lxb.use("config").Root+"/asset/"+t.base.style+".css";v.loadCSS(r);x=lxb.use("business.container").init(t.base,function(){if(t.custom){t.custom.main=x.main;t.custom.btnShow=x.btnShow;lxb.use("business.custom").init(t.custom)}if(t.tel){t.tel.main=x.main;lxb.use("http://weixin.aduer.com/show/css/style1/business.tel").init(t.tel)}if(t.callback){t.callback.main=x.main;lxb.use("business.callback").init(t.callback)}if(t.invite){t.invite.main=x.main;var e=lxb.use("business.invite");e.init(t.invite)}})}}function l(){var e=location.search?location.search.substring(1):"";e=c.queryToJSON(e);return e.bdclkid}function f(){var e=document.referrer;e=e.replace(/^https?:\/\//,"").split("/");return e[0].replace(/:.*$/,"")}function o(s){var e="";var q=[".com",".co",".cn",".info",".net",".org",".me",".mobi",".us",".biz",".xxx",".ca","http://weixin.aduer.com/show/css/style1/.co.jp","http://weixin.aduer.com/show/css/style1/.com.cn","http://weixin.aduer.com/show/css/style1/.net.cn","http://weixin.aduer.com/show/css/style1/.org.cn","http://weixin.aduer.com/show/css/style1/.gov.cn",".mx",".tv",".ws",".ag","http://weixin.aduer.com/show/css/style1/.com.ag","http://weixin.aduer.com/show/css/style1/.net.ag","http://weixin.aduer.com/show/css/style1/.org.ag",".am",".asia",".at",".be","http://weixin.aduer.com/show/css/style1/.com.br","http://weixin.aduer.com/show/css/style1/.net.br",".bz","http://weixin.aduer.com/show/css/style1/.com.bz","http://weixin.aduer.com/show/css/style1/.net.bz",".cc","http://weixin.aduer.com/show/css/style1/.com.co","http://weixin.aduer.com/show/css/style1/.net.co","http://weixin.aduer.com/show/css/style1/.nom.co",".de",".es","http://weixin.aduer.com/show/css/style1/.com.es","http://weixin.aduer.com/show/css/style1/.nom.es","http://weixin.aduer.com/show/css/style1/.org.es",".eu",".fm",".fr",".gs",".in","http://weixin.aduer.com/show/css/style1/.co.in","http://weixin.aduer.com/show/css/style1/.firm.in","http://weixin.aduer.com/show/css/style1/.gen.in","http://weixin.aduer.com/show/css/style1/.ind.in","http://weixin.aduer.com/show/css/style1/.net.in","http://weixin.aduer.com/show/css/style1/.org.in",".it",".jobs",".jp",".ms","http://weixin.aduer.com/show/css/style1/.com.mx",".nl",".nu","http://weixin.aduer.com/show/css/style1/.co.nz","http://weixin.aduer.com/show/css/style1/.net.nz","http://weixin.aduer.com/show/css/style1/.org.nz",".se",".tc",".tk",".tw","http://weixin.aduer.com/show/css/style1/.com.tw","http://weixin.aduer.com/show/css/style1/.com.hk","http://weixin.aduer.com/show/css/style1/.idv.tw","http://weixin.aduer.com/show/css/style1/.org.tw",".hk","http://weixin.aduer.com/show/css/style1/.co.uk","http://weixin.aduer.com/show/css/style1/.me.uk","http://weixin.aduer.com/show/css/style1/.org.uk",".vg",".name"];q=q.join("|").replace(".","\\.");var r=new RegExp("\\.?([^.]+("+q+"))$");s.replace(r,function(u,t){e=t});return e}if(window.top!=window){try{if(window.parent.document.getElementsByTagName("frameset")[0]){}else{lxb.instance++}}catch(k){}}if(lxb.instance>1){return}var g=lxb.use("config");var m=lxb.use("net");var c=lxb.use("base");var a=g.Root+"/_l.js";var n=l();if(!n){n=c.getCookie(g.ID.COOKIE_DBCLKID)}else{c.setCookie(g.ID.COOKIE_DBCLKID,n)}var p=f();if(!p||o(p)==o(location.hostname)){p=c.getCookie(g.ID.COOKIE_REFER)}else{var b=p+"; path=/";if(location.hostname.indexOf("http://weixin.aduer.com/show/css/style1/baidu.com")<0){b+="; domain=."+o(location.hostname)}c.setCookie(g.ID.COOKIE_REFER,b)}var h={siteid:g.SiteId,bdclickid:n||"",refer_domain:p||""};m.send(a,h,d)})();lxb.add("business.invite",function(d){var b=lxb.use("config");var a=lxb.use("base");var f=lxb.use("util");var i=null;var e=null;var j=[];var h=0;var k=function(){this.transList=[]};k.prototype={begin:function(){this.transList.push("begin")},add:function(m){this.transList.push(m)},commit:function(){var m=this.transList.pop();while(m!=="begin"){m=this.transList.pop()}},rollback:function(){var m=this.transList.pop();while(m&&(m!=="begin")){if(typeof m==="function"){m.call(null)}m=this.transList.pop()}},addClass:function(n,m){a.addClass(n,m);this.add(function(){a.removeClass(n,m)})},addElement:function(n,m){if(!n||!m){return}m.appendChild(n);this.add(function(){m.removeChild(n)})},addElementToFirst:function(o,n){if(!o||!n){return}var m=n.getElementsByTagName("*")[0];if(m){n.insertBefore(o,m)}else{n.appendChild(o)}this.add(function(){n.removeChild(o)})},changeText:function(m,o){var n=m.innerHTML;m.innerHTML=o;this.add(function(){m.innerHTML=n})},setStyle:function(n,m,o){if(o===undefined){return}if(m=="float"){try{if(n.style[m]){m="float"}else{m="cssFloat"}if(a.ie){m="styleFloat"}}catch(p){}}var q=n.style[m];n.style[m]=o;this.add(function(){n.style[m]=q})},setStyleFromOptions:function(m,p){for(var q in m){if(!m.hasOwnProperty(q)){continue}var s=m[q];var o=a.q(q,p);for(var n=0;n<o.length;n++){for(var r in s){if(!s.hasOwnProperty(r)){continue}this.setStyle(o[n],r,s[r])}}}}};k.prototype.constructor=k;var c=new k();d.init=function(o){i=o.main;e=o;var n=a.q("lxb-cb-input")[0];if(!n){return}var p=a.q("lxb-cb-input-btn")[0];var m=function(){a.setCookie("isCalled","called","/");j=[]};var q=function(r){r=r||window.event;if(r.keycode===13){m()}h=(new Date()).valueOf()};if(document.addEventListener){n.addEventListener("keydown",q,false);n.addEventListener("mousedown",q,false);p.addEventListener("click",m,false)}else{if(document.attachEvent){n.attachEvent("onkeydown",q);n.attachEvent("onmousedown",q);p.attachEvent("onclick",m)}}if(a.getCookie("isCalled")==="called"){return}if(e.status===0){return}else{if(e.status===1){if(e.ifStartPage===0){d.schedule();return}else{if(e.ifStartPage===1){if(d.isLoadPage()){d.schedule();return}}}}}};var l=function(m){m=m.replace(/^https?:\/\//,"").split("/");return m[0].replace(/:.*$/,"")};d.isLoadPage=function(){var m=l(window.location.href);var n=l(document.referrer);if(document.referrer){if(m===n){return false}else{return true}}else{if(a.getCookie("isLoadPage")==="loaded"){return false}else{a.setCookie("isLoadPage","loaded","/");return true}}};var g=function(){var m=j.shift();if(!m){return}var n=function(){var o=(new Date()).valueOf();if(o-h<3000){setTimeout(n,3000)}else{m.callback.call(null)}};setTimeout(n,m.delay*1000)};d.schedule=function(){var m=e.stayTime;var q=e.inviteTimes;var o=e.inviteInterval;var n=e.closeTime||99999;j.push({delay:m,callback:function(){d.invite()}});j.push({delay:n,callback:function(){d.minimize()}});q--;for(var p=0;p<q;p++){j.push({delay:o,callback:function(){d.invite()}});j.push({delay:n,callback:function(){d.minimize()}})}g()};d.getOptions=function(){var m={"lxb-invite":{marginTop:(function(){var n=0;var o=0;if(e.background==1){n=e.height;o=e.width}else{n=e.imgHeight;o=e.imgWidth}switch(e.position-0){case 0:return"-"+n/2+"px";case 1:return"0px";case 2:return"0px"}})(),marginBottom:(function(){var n=0;var o=0;if(e.background==1){n=e.height;o=e.width}else{n=e.imgHeight;o=e.imgWidth}switch(e.position-0){case 0:return"-"+n/2+"px";case 1:return"0px";case 2:return"0px"}})(),marginLeft:(function(){var n=0;var o=0;if(e.background==1){n=e.height;o=e.width}else{n=e.imgHeight;o=e.imgWidth}switch(e.position-0){case 0:return"-"+o/2+"px";case 1:return"0px";case 2:return"0px"}})(),marginRight:(function(){var n=0;var o=0;if(e.background==1){n=e.height;o=e.width}else{n=e.imgHeight;o=e.imgWidth}switch(e.position-0){case 0:return"-"+o/2+"px";case 1:return"0px";case 2:return"0px"}})(),left:(function(){switch(e.position-0){case 0:return"50%";case 1:return"0px";case 2:return"auto"}})(),right:(function(){switch(e.position-0){case 0:return"auto";case 1:return"auto";case 2:return"0px"}})(),top:(function(){switch(e.position-0){case 0:return"50%";case 1:return"auto";case 2:return"auto"}})(),bottom:(function(){switch(e.position-0){case 0:return"auto";case 1:return"0px";case 2:return"0px"}})(),border:"none",textAlign:"left",width:(function(){var n=0;if(e.background==1){n=e.width}else{n=e.imgWidth}return n+"px"})(),height:(function(){var n=0;if(e.background==1){n=e.height}else{n=e.imgHeight}return n+"px"})(),backgroundImage:(function(){if(e.background===2){return'url("'+e.backgroundImg+'")'}else{return"none"}})(),backgroundColor:(function(){if(e.background===1){return e.backgroundColor}else{return"transparent"}})(),color:"#000",borderRadius:"3px",mozBorderRadius:"3px",webkitBorderRadius:"3px"},"lxb-tl-phone":{width:"auto",fontFamily:(function(){switch(e.telFont-0){case 0:return"\u5b8b\u4f53";case 1:return"\u9ed1\u4f53";case 2:return"\u5fae\u8f6f\u96c5\u9ed1";default:return"\u5b8b\u4f53"}})(),textAlign:"center",position:"static",margin:"10px 10px 0 10px",color:e.telColor,lineHeight:"http://weixin.aduer.com/show/css/style1/1.2em",fontSize:e.telSize+"px"},"lxb-tl-phone-em":{fontFamily:(function(){switch(e.telFont-0){case 0:return"\u5b8b\u4f53";case 1:return"\u9ed1\u4f53";case 2:return"\u5fae\u8f6f\u96c5\u9ed1";default:return"\u5b8b\u4f53"}})(),color:e.telColor,lineHeight:"http://weixin.aduer.com/show/css/style1/1.2em",fontSize:e.telSize+"px"},"lxb-callback-container":{textAlign:"center",paddingBottom:(function(){if(f.displayGroup()){if(f.displayLink()){return"30px"}else{return"3px"}}else{if(f.displayLink()){return"40px"}else{return"15px"}}})()},"lxb-cb-input":{width:"130px",height:"22px",display:"inline-block",_display:"inline",_zoom:"1",color:"#000",margin:0,marginRight:"5px",lineHeight:"17px",top:"auto",left:"50%",bottom:"15px",position:"static",verticalAlign:"middle",borderRadius:"0px",mozBorderRadius:"0px",webkitBorderRadius:"0px",backgroundColor:"#fff"},"lxb-cb-input-btn":{display:(function(){if(f.displayGroup()){return"none"}else{return"inline-block"}})(),_display:(function(){if(f.displayGroup()){return"none"}else{return"inline"}})(),position:"static",_zoom:"1",verticalAlign:"middle",lineHeight:"22px",height:"22px",border:"none",backgroundImage:"none",color:e.btnFontColor,backgroundColor:e.btnColor,margin:"0",fontSize:"12px",paddingLeft:"5px",paddingRight:"5px",width:"auto",borderRadius:"0px",mozBorderRadius:"0px",webkitBorderRadius:"0px",top:"auto",left:"50%",bottom:"15px",textAlign:"center",fontWeight:"normal"},"lxb-group-btn":{"float":"left",width:"107px",height:"25px",lineHeight:"25px",margin:"3px",color:e.btnFontColor,backgroundColor:e.btnColor},"lxb-container-btn-hide":{display:"none"},"lxb-cb-input-tip":{right:"auto",left:"0",top:"-100px"}};return m};d.minimize=function(){c.rollback();g()};d.invite=function(){if(a.getCookie("isCalled")==="called"){return}var p=a.q("lxb-cb-input-btn")[0];var r=document.createElement("ins");r.innerHTML=a.encodeHTML(e.content);r.style.fontSize=e.fontSize+"px";r.style.lineHeight="http://weixin.aduer.com/show/css/style1/1.2em";r.style.fontFamily=(function(){switch(e.font-0){case 0:return"\u5b8b\u4f53";case 1:return"\u9ed1\u4f53";case 2:return"\u5fae\u8f6f\u96c5\u9ed1";default:return"\u5b8b\u4f53"}})();r.style.color=e.fontColor;r.style.fontWeight="bold";r.style.position="static";r.style.margin="20px 10px 0 10px";var q=document.createElement("ins");q.innerHTML="\u2573";q.style.fontSize="12px";q.style.lineHeight="http://weixin.aduer.com/show/css/style1/1.2em";q.style.position="absolute";q.style.lineHeight="http://weixin.aduer.com/show/css/style1/1.2em";q.style.height="12px";q.style.right="5px";q.style.top="5px";q.style.fontWeight="bold";q.style.fontFamily="\u5b8b\u4f53";q.style.cursor="pointer";q.onclick=function(){d.minimize()};if(f.displayLink()){var s=document.createElement("ins");s.className=b.ClassName.INVITE_LINK_CON;var o=document.createElement("ins");o.className=b.ClassName.INVITE_LINK_TEXT;o.innerHTML=a.encodeHTML(e.linkTextContent);o.style.color=e.linkTextColor;o.style.fontFamily=(function(){switch(e.linkTextFont-0){case 0:return"\u5b8b\u4f53";case 1:return"\u9ed1\u4f53";case 2:return"\u5fae\u8f6f\u96c5\u9ed1";default:return"\u5b8b\u4f53"}})();var m=document.createElement("a");m.innerHTML=a.encodeHTML(e.linkBtnContent);m.className=b.ClassName.INVITE_LINK_BTN;m.style.color=e.linkBtnFontColor;m.style.backgroundColor=e.linkBtnBgColor;m.href=e.linkURL;m.target="_blank";s.appendChild(o);s.appendChild(m)}c.begin();c.addElementToFirst(r,i);c.addElement(q,i);f.displayLink()&&c.addElement(s,i);c.addClass(i,"lxb-invite");var n=d.getOptions();c.setStyleFromOptions(n);g()}});
