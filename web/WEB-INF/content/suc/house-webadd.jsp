<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>商户上传资料</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 

    <!--标准mui.css-->
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css">
    <!--App自定义的css-->
    <link rel="stylesheet" type="text/css" href="${ctx}/mvccol/mui-css/app.css"/>
    <link href="${ctx}/mvccol/mui-css/mui.picker.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/mui-css/mui.poppicker.css" rel="stylesheet"/>

    <!--muiover-->

    <style>

        .xzb {
            border: solid 1px #00c44e;
            background-color: #00c44e;
            color: #ffffff;
        }

        .xz {
            border: solid 1px #ccc;
            background-color: #ffffff;
            color: #ffffff;
        }

        .bfcss {
            background-color: #eee;
            color: #666;
        }

        .bfcss:hover {
            background-color: #ddd;
            color: #666;
        }

        .bfcss:active {
            background-color: #ddd;
            color: #666;
        }

        .fa-spin1 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }
        .txtinput{
        -webkit-user-select:text;
        } 
        .yqbtn {
            background-color: #ffffff;
            color: #ef8200;
        }


        .yqbtn:hover {
            background-color: #ef8200;
            color: #ffffff;
        }

        .yqbtn1 {
            background-color: #ffffff;
            color: limegreen;
        }

        .yqbtn1:hover {
            background-color: limegreen;
            color: #ffffff;
        }
        .bg-bai-8 {
            background-color: rgba(225, 225, 225, 0.9);
        }
        .line-bottom-c3c3c6 {
            border-bottom: 1px solid #c3c3c6;
        } 
    </style>

    <script>
        $(function () {
            if ('${user._id}' == 'notlogin') {
                alert("请先登录！");
                window.location.href = "${ctx}/user/fromuser!UserDetail.action?custid=${custid}";
            }
            ;
        });
        function shopping_xiaoshi() {
            $('#shopping_tanchu').hide();
        }
        function shopping_xianshi() {
            $('#shopping_tanchu').show();
        }

        function shengfen_xiaoshi() {
            $('#shengfen_tanchu').hide();
        }
        function shengfen_xianshi() {
            $('#shengfen_tanchu').show();
        }

        function chengshi_xiaoshi() {
            $('#chengshi_tanchu').hide();
        }
        function chengshi_xianshi() {
            $('#chengshi_tanchu').show();
        }

        function quxian_xiaoshi() {
            $('#quxian_tanchu').hide();
        }
        function quxian_xianshi() {
            $('#quxian_tanchu').show();
        }

        function xieyi_xiaoshi() {
            $('#xieyi_tanchu').hide();
        }
        function xieyi_xianshi() {
            $('#xieyi_tanchu').show();
        }

        var type='';
        var isplay = false;
        var keyword='';
        function bf() {
            if (!isplay) {
                $("#bfid").addClass("bfcss");
                $("#xzid").addClass("xz");
                isplay = true;
            } else {
                $("#bfid").removeClass("bfcss");
                $("#xzid").removeClass("xz");
                isplay = false;
            }

        }

        function submit() {
            var name = $('#name').val();
            var logo = $('#logo').val();
            var context = $('#context').val();
            var tel = $('#tel').val();
            if (name.replace('商户名称', '') == "") {
                alert("请输入商户名称");
                return;
            }
            if (logo.length == "") {
                alert("请上传图片");
                return;
            }
            if (context.replace('请输入10-300个字', '') == "") {
                alert("请输入商户简介");
                return;
            }
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(tel))) {
                alert("手机号码有误，请重填");
                return;
            }
            var address = $('#province').val() + " " + $('#city').val() + " " + $('#county').val() + " " + $('#address').val();
            if ($('#province').val().replace('省份', '') == "") {
                alert("请选择省市");
                return;
            }
            if ($('#address').val().replace('详细地址', '') == "") {
                alert("请输入详细地址");
                return;
            }
            if (type=="") {
                alert("请输入选择类型");
                return;
            }
            $('#keyword').find('input').each(function(){
             if($(this).val().replace('关键字', '') != ""){
             keyword+=$(this).val()+",";
             }
            });
            keyword+=name+",";
            var submitData = {
                name: name,
                logo: logo,
                content: context,
                tel: tel,
                address: address,
                type:type,
                keyword:keyword
            };
            $.post('${ctx}/suc/house!ajaxwebadd.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            alert("上传成功");
                            window.location.href = '${ctx}/suc/house!personalhome.action?custid=${custid}&lscode=${lscode}';
                        }
                    }, "json")


        }
        function showtype(){
        $('#tanchushezhi2').show();
        } 
        function settype(v,t){
        type=v;
        $('#type').html(t);
        $('#tanchushezhi2').hide();
        }
    </script>

</head>
<body>
<main class="cmp640">
    <div class="div-group-5 pl-10 pr-10">
        <input name="logo" id="logo" type="hidden"/>

        <div class="size14 line-bottom-92 weight500 pt-10 pb-10" style="padding-left: 2px;">照片资料<i
                class="size12 zi-hui">（商家/政府机关门头照）</i></div>
        <div class="line-bottom-92 line-right-92 line-left-92 div-group-5 pt-10 pb-10 overflow-hidden">
            <div class="col-3">
                <a href="javascript:pz('logo','200','200',false,'logoimg')">
                    <div class="img-wh60 maring-a border-radius3 line-lu">
                        <div class="position-r">
                            <div id="logoimg" class="div-group-15">
                                <img src="${contextPath}/mvccol/img/addimg.png" class="width-10">
                            </div>

                        </div>
                    </div>
                </a>
            </div>

        </div>

        <div class="size14 line-bottom-92 weight500 pt-10 pb-10" style="padding-left: 2px;">商家类别</div>

        <div class="line-bottom-92 line-right-92 line-left-92 hang50" onclick="showtype()">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-heigh40 pt-10 weight500"
                   id="type" >例：家居，服装，餐饮...</div>
        </div>

        <div class="size14 line-bottom-92 weight500 pt-10 pb-10" style="padding-left: 2px;">商家资料</div>

        <div class="line-bottom-92 line-right-92 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 pt-20 weight500" type="text"
                   id="name" name=""
                   value="商户名称" onfocus="if(this.value=='商户名称'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='商户名称'){this.value='商户名称';this.style.color='#aaa';}"
                   style="-webkit-user-select:text">
        </div>
        <div class="line-bottom-92 line-right-92 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 pt-20 weight500" type="text" id="tel"
                   name="tel"
                   value="您的手机号码方便我们和您联系"
                   onfocus="if(this.value=='您的手机号码方便我们和您联系'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='您的手机号码方便我们和您联系'){this.value='您的手机号码方便我们和您联系';this.style.color='#aaa';}"
                   style="-webkit-user-select:text">
        </div>
        <div class="line-bottom-92 line-right-92 line-left-92 overflow-hidden zi-hui">
            <form action="">
                <textarea id="context"
                          onfocus="if(this.value=='（商家简介）请输入10-300个字'){this.value=''};this.style.color='#666666';"
                          onblur="if(this.value==''||this.value=='（商家简介）请输入10-300个字'){this.value='（商家简介）请输入10-300个字';this.style.color='#aaa';}"
                          rows="5" name="message" class="size14 weight500"
                          style="height:90px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);"
                          style="-webkit-user-select:text">（商家简介）请输入10-300个字</textarea>
                <input name="remLen" type="text" value="300字" size="5" readonly="readonly"
                       class="zi-hui size12 pl-2 pb-10 pull-right">
            </form>
        </div>

        <div class="size14 line-bottom-92 weight500 pt-10 pb-10" style="padding-left: 2px;">关键字<i
                class="size12 zi-hui">（输入关键字用户会更容易搜索到您的信息）</i></div>

        <div class="line-bottom-92 line-right-92 line-left-92 hang50" id="keyword">
            <a href="#">
                <div class="col-3 pr-5 pl-5 pt-10">
                    <input class="width-10 bg-hui border-radius3 txt-c size12 zi-hui  hang30 line-height30 weight500"
                           type="text"
                           name=""
                           value="关键字" onfocus="if(this.value=='关键字'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='关键字'){this.value='关键字';this.style.color='#aaa';}"
                           style="-webkit-user-select:text">
                </div>
            </a>

            <a href="#">
                <div class="col-3 pr-5 pl-5 pt-10">
                    <input class="width-10 bg-hui border-radius3 txt-c size12 zi-hui  hang30 line-height30 weight500"
                           type="text"
                           name=""
                           value="关键字" onfocus="if(this.value=='关键字'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='关键字'){this.value='关键字';this.style.color='#aaa';}"
                           style="-webkit-user-select:text">
                </div>
            </a>

            <a href="#">
                <div class="col-3 pr-5 pl-5 pt-10">
                    <input class="width-10 bg-hui border-radius3 txt-c size12 zi-hui  hang30 line-height30 weight500"
                           type="text"
                           name=""
                           value="关键字" onfocus="if(this.value=='关键字'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='关键字'){this.value='关键字';this.style.color='#aaa';}"
                           style="-webkit-user-select:text">
                </div>
            </a>

            
              <div class="col-3 pr-5 pl-5 pt-10">
                    <input class="width-10 bg-hui border-radius3 txt-c size12 zi-hui  hang30 line-height30 weight500"
                           type="text"
                           name=""
                           value="关键字" onfocus="if(this.value=='关键字'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='关键字'){this.value='关键字';this.style.color='#aaa';}"
                           style="-webkit-user-select:text">
              </div>
           
        </div>


        <div class="size14 line-bottom-92 weight500 pt-10 pb-10" style="padding-left: 2px;">地址信息</div>

        <div class="line-bottom-92 line-right-92 line-left-92 hang50" id='showCityPicker3'>
            <a href="#">
                <div class="col-4 pr-5 pl-5 pt-10">
                    <input id="province"
                           class="width-10 bg-hui border-radius3 txt-c size14 zi-hui weight500 hang30 line-height30"
                           type="text"
                           name=""
                           value="省份" onfocus="if(this.value=='省份'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='省份'){this.value='省份';this.style.color='#aaa';}">
                </div>
            </a>

            <a href="#">
                <div class="col-4 pr-5 pl-5 pt-10">
                    <input id="city"
                           class="width-10 bg-hui border-radius3 txt-c size14 zi-hui hang30 line-height30 weight500"
                           type="text"
                           name=""
                           value="城市" onfocus="if(this.value=='城市'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='城市'){this.value='城市';this.style.color='#aaa';}">
                </div>
            </a>

            <a href="#">
                <div class="col-4 pr-5 pl-5 pt-10">
                    <input id="county"
                           class="width-10 bg-hui border-radius3 txt-c size14 zi-hui hang30 line-height30 weight500"
                           type="text"
                           name=""
                           value="区/县" onfocus="if(this.value=='区/县'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='区/县'){this.value='区/县';this.style.color='#aaa';}">
                </div>
            </a>

        </div>

        <!--城市信息放置处-->
        <div id='cityResult3' class=" bg-cheng zi-bai weight500 display-none">城市位置信息放置处</div>


        <div class="line-bottom-92 line-right-92 line-left-92 hang50">

            <div class="width-10 pr-5 pl-5 pt-10">
                <input id="address"
                       class="width-10 bg-hui border-radius3 txt-c size14 zi-hui  hang30 line-height30 weight500"
                       type="text"
                       value="详细地址" onfocus="if(this.value=='详细地址'){this.value=''};this.style.color='#666666';"
                       onblur="if(this.value==''||this.value=='详细地址'){this.value='详细地址';this.style.color='#aaa';}"
                       style="-webkit-user-select:text">
            </div>

        </div>


    </div>

    <div class="div-group-15 pt-15">

        <div class="pb-25  pl-5 overflow-hidden">
            <a href="javascript:bf();">
                <div id="xzid" class="txt-c pull-left size12 weight900 xzb border-radius3"
                     style="width: 20px; height: 20px;line-height:20px;">
                    √
                </div>
            </a>

            <div class="pull-left size12 pl-5 zi-hei pt-5">我已阅读并同意<a href="javascript:xieyi_xianshi()"><i
                    class="zi-hei" style="border-bottom: 1px solid #000000">《商户中心协议》</i></a></div>
        </div>

        <a href="javascript:submit()">
            <div id="bfid"
                 class=" btn-green zi-bai div-group-10 maring-a size14 txt-c weight500 border-radius5 lock">提交申请
            </div>
        </a>
    </div>

    <!--弹出层商户协议-->
    <div class="fullscreen cmp640 bg-hei-5 display-none lock" id="xieyi_tanchu">
        <div class="position-r overflow-hidden width-10">
            <%--<a href="javascript:xieyi_xiaoshi()">--%>
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
            <%--</a>--%>
            <div class="position-a width-9" style="top:5%;left:5%;">
                <div class=" width-10 maring-a overflow-hidden size14 border-radius5 div-group-10 bg-bai pb-15 "
                     style="overflow: auto; height:430px;">
                    <div class="pb-10 weight500 txt-c  size18">商户入驻协议</div>
                    <div style="line-height:20px;" class="pb-5 size14 txt-c display-none">欢迎您使用邑联手机管家号码公众平台服务！</div>
                    <div class="size14 pb-15 zi-hui-wx" style="line-height:20px;">
                        【首部及导言】</br>

                        欢迎您使用邑联手机管家号码公众平台服务！</br>

                        为使用邑联手机管家号码公众平台（以下简称“号码公众平台”）服务，您应当阅读并
                        遵守《邑联手机管家号码公众平台服务协议》（以下简称“本协议”）、《邑联服务协
                        议》。请您务必审慎阅读、充分理解各条款内容，特别是免除或
                        限制责任的相应条款，以及开通或使用某项服务的单独协议，并选择接受或不接受
                        。限制或免除责任条款可能以加粗形式提示您注意。</br>

                        除非您已阅读并接受本协议所有条款，否则您无权使用邑联手机管家号码公众平台
                        服务（以下简称“本服务”）。您对本服务的登陆、查看等使用行为即视为您已阅读并
                        同意本协议的约束。</br>

                        如果您未满18周岁，请在法定监护人的陪同下阅读本协议，并特别注意未成年人使
                        用条款。</br>


                        一、【协议的范围】</br>

                        1.1【协议适用主体范围】</br>

                        本协议是您与邑联之间关于您使用邑联手机管家号码公众平台（以下简称“号码公众
                        平台”）服务所订立的协议。</br>

                        1.2【协议关系及冲突条款】</br>

                        本协议内容同时包括邑联可能不断发布的关于本服务的相关协议、业务规则等内容
                        。内容一经正式发布，即为本协议不可分割的组成部分，您同样应当遵守。</br>

                        二、【关于本服务】</br>

                        2.1【本服务的内容】</br>

                        本服务内容是指邑联手机管家提供的号码登记申请商铺企业资料公示等服务。（以
                        下简称“本服务”）。</br>

                        2.2 【本服务的形式】</br>

                        作为企业/个人用户，您在号码公众平台可以申请对本企业电话号码进行黄页号码登
                        记、黄页号码名称变更、取消黄页显示等。您的申请经审核通过后，您的申请需求
                        会在邑联手机管家客户端中予以同步或显示，但邑联有权决定是否通过您的申请。</br>

                        三、【用户信息保护】</br>

                        3.1保护用户信息是邑联的一项基本原则，邑联将会采取合理的措施保护用户信息。
                        邑联对相关信息采用专业加密存储与传输方式，保障用户信息的安全。</br>

                        3.2 您在使用本服务的过程中，可能需要提供一些必要的信息，例如：进行相关申请
                        时，需要提供您的主体信息（包括但不限于公司名称、营业执照、组织机构代码证
                        、税务登记证、企业logo、个人身份信息等）、联系信息、号码信息以及相关的权利
                        证明材料等，以明确用户身份并核实相关的权利归属。若国家法律法规或政策有特
                        殊规定的，您需要提供真实的身份信息。若您提供的信息不完整，则无法使用本服
                        务或在使用过程中受到限制。</br>

                        3.3邑联将运用各种安全技术和程序建立完善的管理制度来保护您的个人信息，以免
                        遭受未经授权的访问、使用或披露。</br>

                        3.4邑联非常重视对未成年人个人信息的保护。若您是18周岁以下的未成年人，在使
                        用邑联的服务前，应事先取得您家长或法定监护人的书面同意。</br>

                        四、【主权利义务条款】</br>

                        4.1【信息提供】</br>
                        4.1.1您保证：您会依法及按照要求提交使用本服务所必须的真实、准确的经过您确
                        认的身份信息（包括但不限于公司名称、营业执照、组织机构代码证、税务登记证
                        、企业logo、个人身份信息）、联系信息、号码信息以及相关的权利证明材料等。</br>

                        4.1.2您保证：您具备使用本服务，上报、分享、管理相关电话号码信息的权利；您
                        提供的所有材料及信息真实、准确、完整，并在信息发生变更后，及时进行更新；
                        您具备履行本协议项下之义务、各种行为的能力；您通过号码公众平台从事的一切
                        行为均不违反任何对您的有约束力的法律文件也不会侵犯任何人的合法权益。否则
                        ，您应不使用号码公众平台提供的相关服务，且应独自承担由此带来的一切责任及
                        给邑联手机管家用户、邑联造成的全部损失。</br>

                        4.1.3 您保证您不曾今后也不会通过您提供的电话号码进行任何非法活动，包括但不
                        限于电话骚扰、电话诈骗等不法行为。</br>

                        4.1.4您保证：您的所有承诺均真实、有效，若由于虚假承诺或违反以上承诺而引起
                        的一切责任，皆由申请人自行承担。若因此给邑联公司造成任何损失的，您应当负
                        责赔偿。</br>

                        4.2【号码信息的使用范围】</br>
                        您同意并授权邑联可将您提供的号码及黄页信息等同步到邑联手机管家客户端（包
                        括邑联手机管家的所有版本，包括但不限于定制版、合作版）以供邑联手机管家用
                        户查看，且邑联及邑联手机管家用户为此无需支付任何费用；该授权为全世界范围
                        内永久性的、不可撤销的、免费的授权。</br>

                        4.3【申请的处理】您不得利用号码公众平台发起恶意的申请，也不得滥用号码公众
                        平台所提供的服务。</br>
                        4.4【平台性质】</br>
                        您理解并同意：号码公众平台是一个中立的平台服务提供者，仅向用户提供号码登记申请及修改号码等服务；</br>

                        4.5【用户注意事项】</br>
                        4.5.1 您理解并同意：为了向您提供有效的服务，本服务会可能利用您通讯终端的处
                        理器和带宽等资源。本服务使用过程中可能产生网络数据流量的费用，用户需自行
                        向运营商了解相关资费信息，并自行承担相关费用。</br>
                        4.5.2您理解并同意：本服务的某些功能可能会让第三方知晓用户的信息，例如：邑
                        联手机管家用户可能会知晓您的黄页信息等。</br>
                        4.5.3您在使用本服务某一特定服务时，该服务可能会另有单独的协议、相关业务规
                        则等（以下统称为“单独协议”），您在使用该项服务前请阅读并同意相关的单独协议。</br>

                        4.5.4 您理解并同意邑联将会尽其商业上的合理努力保障您在本服务及服务中的数据
                        存储安全，但是，邑联并不能就此提供完全保证，包括但不限于以下情形：</br>
                        （1）邑联不对您在本服务及服务中相关数据的删除或储存失败负责；</br>
                        （2）邑联有权根据实际情况自行决定单个用户在本服务及服务中数据的最长储存期
                        限，并在服务器上为其分配数据最大存储空间等。您可根据自己的需要自行备份本
                        服务及服务中的相关数据；</br>
                        （3）如果您停止使用本服务或服务被终止或取消，邑联可以从服务器上永久地删除
                        您的数据。服务停止、终止或取消后，邑联没有义务向您返还任何数据。</br>
                        4.5.5 用户在使用本服务及服务时，须自行承担如下来自邑联不可掌控的风险内容，
                        包括但不限于：</br>
                        （1）由于不可抗拒因素可能引起的个人信息丢失、泄漏等风险；</br>
                        （2）用户在使用本服务访问第三方网站时，因第三方网站及相关内容所可能导致的
                        风险，由用户自行承担；</br>
                        （3）用户上报的信息被他人查看、知晓、转发、分享、使用、传播等可能带来的风
                        险和责任；</br>
                        4.6【第三方产品和服务】</br>
                        4.6.1 您在使用本服务中由第三方提供的产品或服务时，除遵守本协议约定外，还应
                        遵守第三方的用户协议。邑联和第三方对可能出现的纠纷在法律规定和约定的范围
                        内各自承担责任。</br>
                        4.6.2 因用户使用本服务或要求邑联提供特定服务时，本服务可能会调用第三方系统
                        或者通过第三方支持用户的使用或访问，使用或访问的结果由该第三方提供，邑联
                        不保证通过第三方提供服务及内容的安全性、准确性、有效性及其他不确定的风险
                        ，由此若引发的任何争议及损害，与邑联无关，邑联不承担任何责任。</br>

                        五、用户行为规范</br>
                        5.1【信息内容规范】</br>
                        5.1.1本条所述信息内容是指用户使用本服务过程中所制作、发布、传播的任何内容
                        ，包括但不限于号码名称、企业logo等。</br>
                        5.1.2您在使用本服务时不得利用本服务从事以下行为，包括但不限于：</br>
                        （1）发布、传送、传播、储存违反国家法律、危害国家安全统一、社会稳定、公序
                        良俗、社会公德以及侮辱、诽谤、淫秽、暴力的内容；</br>
                        （2）发布、传送、传播、储存侵害他人名誉权、肖像权、知识产权、商业秘密等合
                        法权利的内容；</br>
                        （3） 涉及他人隐私、个人信息或资料的；</br>
                        （4） 发表、传送、传播骚扰信息及垃圾信息；</br>
                        （5） 其他违反法律法规、政策及公序良俗、社会公德或干扰本服务正常运营和侵犯
                        其他用户或第三方合法权益内容的信息。</br>
                        5.2【用户禁止行为】</br>
                        除非经邑联书面许可，您不得进行以下行为：</br>
                        （1）通过任何方式搜集本服务中其他用户的用户名、电子邮件等相关信息，并以发
                        送垃圾邮件、连锁邮件、垃圾短信、即时消息等方式干扰、骚扰其他用户；</br>
                        （3）将本服务再次许可他人使用；</br>
                        （4）其他未经邑联书面许可的行为。</br>
                        5.3 【服务使用规范】</br>
                        除非法律允许或邑联书面许可，您不得从事下列行为：</br>
                        （1）删除本服务及其副本上关于著作权的信息；</br>
                        （2）对本服务进行反向工程、反向汇编、反向编译，或者以其他方式尝试发现软件
                        的源代码；</br>
                        （3）对邑联拥有知识产权的内容进行使用、出租、出借、复制、修改、链接、转载
                        、汇编、发表、出版、建立镜像站点等；</br>
                        （4）对本服务软件或者软件运行过程中释放到任何终端内存中的数据、软件运行过
                        程中客户端与服务器端的交互数据，以及软件运行所必需的系统数据，进行复制、
                        修改、增加、删除、挂接运行或创作任何衍生作品，形式包括但不限于使用插件、
                        外挂或非经邑联授权的第三方工具/服务接入软件和相关系统；</br>
                        （5）通过修改或伪造软件运行中的指令、数据，增加、删减、变动软件的功能或运
                        行效果，或者将用于上述用途的软件、方法进行运营或向公众传播，无论这些行为
                        是否为商业目的；</br>
                        （6）通过非邑联开发、授权的第三方软件、插件、外挂、系统，登录或使用邑联软
                        件及服务，或制作、发布、传播上述工具；</br>
                        （7）自行或者授权他人、第三方软件对本软件及其组件、模块、数据进行干扰；
                        （8）其他未经邑联明示授权的行为；</br>
                        （9）其他违反法律法规、政策的行为。</br>
                        5.4【服务运营规范】</br>
                        除非法律允许或邑联书面许可，您使用本服务过程中不得从事下列行为：</br>
                        （1）提交、发布虚假信息，或冒充、利用他人名义的；</br>
                        （2）诱导其他用户点击链接页面或分享信息的；</br>
                        （3）虚构事实、隐瞒真相以误导、欺骗他人的；</br>
                        （4）侵害他人名誉权、肖像权、知识产权、商业秘密等合法权利的；</br>
                        （6）利用本服务从事任何违法犯罪活动的；</br>
                        （7）制作、发布与以上行为相关的方法、工具，或对此类方法、工具进行运营或传
                        播，无论这些行为是否为商业目的；</br>
                        　 （8）其他违反法律法规规定、侵犯其他用户合法权益、干扰产品正常运营或邑
                        联未明示授权的行为。</br>
                        　 5.5【对自己行为负责】</br>

                        您充分了解并同意，您必须为自己帐号下的一切行为负责，包括您所发表的任何内
                        容以及由此产生的任何后果。您应对本服务中的内容自行加以判断，并承担因使用
                        内容而引起的所有风险，包括因对内容的正确性、完整性或实用性的依赖而产生的
                        风险。邑联无法且不会对因前述风险而导致的任何损失或损害承担责任。</br>

                        5.6【违约处理】</br>

                        5.6.1 如果邑联发现或收到他人举报或投诉用户违反本协议约定的，邑联有权进行独
                        立判断并采取技术手段予以删除、屏蔽或断开相关的信息链接。同时，邑联有权视
                        您的行为性质，采取包括但不限于暂停或终止本服务、追究法律责任等措施。</br>

                        5.6.2 您理解并同意，邑联有权依合理判断对违反有关法律法规或本协议规定的行为
                        进行处理，对违法违规的任何用户采取适当的法律行动，并依据法律法规保存有关
                        信息向有关部门报告等，用户应独自承担由此而产生的一切法律责任。</br>

                        5.6.3 您理解并同意，因您违反本协议或相关服务条款的规定，导致或产生第三方主
                        张的任何索赔、要求或损失，您应当独立承担责任；邑联因此遭受损失的，您也应
                        当一并赔偿。</br>


                        六、【本服务的软件形式】</br>

                        若邑联通过软件形式提供本服务的，邑联和您还应遵守本条款的以下约定：</br>

                        6.1 邑联可能为不同的终端设备开发不同的软件版本，您应当根据实际情况选择下载
                        合适的版本进行安装。</br>

                        6.2 您可以直接从邑联的网站上获取软件，也可以从得到邑联授权的第三方获取。如
                        果您从未经邑联授权的第三方获取软件或与软件名称相同的安装程序，邑联无法保
                        证该软件能够正常使用，并对因此给您造成的损失不予负责。</br>

                        6.3 为了改善用户体验，并保证服务的安全性和功能的一致性，邑联有权不经向您特
                        别通知而对软件进行更新（这些更新可能会采取软件替换、修改、功能强化、版本
                        升级等形式），或者对软件的部分功能效果进行改变或限制。</br>

                        6.4 软件新版本发布后，旧版软件可能无法使用。邑联不保证旧版软件继续可用及相
                        应的客户服务，请您随时核对并下载最新版本。</br>　


                        七、【终端安全责任】</br>

                        7.1 您理解并同意，本服务同大多数互联网服务一样，可能会受多种因素影响，包括
                        但不限于用户原因、网络服务质量、社会环境等；也可能会受各种安全问题的侵扰
                        ，包括但不限于他人非法利用用户资料，进行现实中的骚扰；用户下载安装的其他
                        软件或访问的其他网站中可能含有病毒、木马程序或其他恶意程序，威胁您的终端
                        设备信息和数据安全，继而影响本服务的正常使用等。因此，您应加强信息安全及
                        个人信息的保护意识，注意密码保护，以免遭受损失。</br>

                        7.2维护软件安全与正常使用是邑联和您的共同责任，邑联将按照行业标准合理审慎
                        地采取必要技术措施保护您的终端设备信息和数据安全，但是您承认和同意邑联并
                        不能就此提供完全保证。</br>

                        八、【其他】</br>

                        8.1 您使用本软件即视为您已阅读并同意受本协议的约束。邑联有权在必要时修改
                        本协议条款。您可以在本软件的最新版本中查阅相关协议条款。本协议条款变更后
                        ，如果您继续使用本服务，即视为您已接受修改后的协议。如果您不接受修改后的
                        协议，应当停止使用本服务。</br>

                        8.2本协议签订地为中华人民共和国陕西省渭南市。</br>

                        8.3 本协议的成立、生效、履行、解释及纠纷解决，适用中华人民共和国大陆地区法
                        律（不包括冲突法）。</br>

                        8.4 若您和邑联之间发生任何纠纷或争议，首先应友好协商解决；协商不成的，您同
                        意将纠纷或争议提交本协议签订地有管辖权的人民法院管辖。</br>

                        8.5 本协议所有条款的标题仅为阅读方便，本身并无实际涵义，不能作为本协议涵义
                        解释的依据。</br>

                        8.6 本协议条款无论因何种原因部分无效或不可执行，其余条款仍有效，对双方具有
                        约束力。（正文完）</br>
                    </div>
                    <a href="javascript:xieyi_xiaoshi()">
                        <div class="btn-green div-group-5 maring-a size14 zi-bai txt-c weight500 border-radius5 lock">
                            同意并退出
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!--结束-->
      <%@include file="/webcom/foot.jsp" %>
</main>
<div class="clear" style="height: 50px;"></div>
<%@ include file="/webcom/house-foot.jsp" %>
<%@include file="/webcom/cut-image.jsp" %>

<!-- Return to the top -->
<div id="gotop" class="gotop">
    <a href="javascript:this.blur();">
        <div class=" maring-a clear img-wh40 bg-hei-8 zi-bai txt-c border-radius50">
            <i class="fa fa-arrow-up pt-3 fa-2x"></i>
        </div>
    </a>
</div>
<!--黄页分类-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="tanchushezhi2">
    <div class="overflow-hidden width-10">
        <a href="javascript:shezhixiaoshi2()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>
        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                <c:forEach items="${type}" var="bean">
                    
                        <a href="javascript:settype('${bean.coding}','${bean.title}')">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                ${bean.title}
                            </div>
                        </a>
                </c:forEach>
            </div>
            <a href="javascript:shezhixiaoshi2()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>


<!--MUIjs-->
<script src="${ctx}/mvccol/mui-js/mui.min.js"></script>
<!--<script src="../js/mui.picker.min.js"></script>-->
<script src="${ctx}/mvccol/mui-js/mui.picker.js"></script>
<script src="${ctx}/mvccol/mui-js/mui.poppicker.js"></script>

<script src="${ctx}/mvccol/mui-js/city.data-3.js" type="text/javascript" charset="utf-8"></script>
<script>
    (function ($, doc) {
        $.init();
        $.ready(function () {

            var cityPicker3 = new $.PopPicker({
                layer: 3
            });
            cityPicker3.setData(cityData3);
            var showCityPickerButton = doc.getElementById('showCityPicker3');
            var province = doc.getElementById('province');
            var city = doc.getElementById('city');
            var county = doc.getElementById('county');
            showCityPickerButton.addEventListener('tap', function (event) {
                cityPicker3.show(function (items) {
                    province.value = (items[0] || {}).text;
                    city.value = (items[1] || {}).text;
                    if (typeof((items[2] || {}).text) == "undefined") {
                        county.value = '';
                    } else {
                        county.value = (items[2] || {}).text;
                    }

                    //返回 false 可以阻止选择框的关闭

                    //return false;
                });
            }, false);
        });
    })(mui, document);

    function shezhixiaoshi2() {
        $('#tanchushezhi2').hide();
    }
    function shezhixianshi2() {
        $('#tanchushezhi2').show();
    }
</script>


</body>
</html>