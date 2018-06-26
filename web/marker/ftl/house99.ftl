<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <meta name="author" content="Alvaro Trigo Lopez"/>
    <meta name="description" content="fullPage full-screen sliders navigation widh dots."/>
    <meta name="keywords"
          content="fullpage,jquery,demo,screen,fullscreen,sliders navigation, horizontal navigation,horizontal,navigation,dots"/>
    <meta name="Resource-type" content="Document"/>
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
          name="viewport">
    <link href="css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/jquery.fullPage.css"/>
    <link rel="stylesheet" type="text/css" href="css/examples.css"/>
    <script src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.fullPage.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#fullpage').fullpage({
                slidesNavigation: true,
                scrollingSpeed: 1500,
                afterSlideLoad: function (anchorLink, index, slideIndex, direction) {
                    if (index == 1 && direction == length) {

                    }
                }
            });
            setInterval(function () {
                $.fn.fullpage.moveSlideRight();
            }, 3000);

        });
        function startAnimation(v) {
            if (2 == 2) {
                $('#fullpage').fullpage({
                    slidesNavigation: true,
                    scrollingSpeed: 3000,
                    afterSlideLoad: function (anchorLink, index, slideIndex, direction) {
                        if (index == 1 && direction == length) {
                            alert(direction);
                            alert(length);
                        }
                    }
                });
                setInterval(function () {
                    $.fn.fullpage.moveSlideRight();
                }, 3000);
            } else {
                $('#fullpage').fullpage({

                    slidesNavigation: true,
                    scrollingSpeed: 3000,
                });
            }
        }
    </script>
</head>
<body>
<div id="fullpage" class="cmp640">
    <div class="section">
        <a href="">
            <div class="slide" id="slide1" data-anchor="slide1"
                 style="background-image:url(img/smq-no1.jpg); background-size:100% auto"></div>
        </a>
        <a href="">
            <div class="slide" id="slide2" data-anchor="slide2"
                 style="background-image:url(img/smq-no1.jpg); background-size:100% auto"></div>
        </a>
        <a href="">
            <div class="slide" id="slide3" data-anchor="slide3"
                 style="background-image:url(img/smq-no1.jpg); background-size:100% auto"></div>
        </a>
    </div>
</div>
<div class="position-f cmp640 " style="top:0px;left:0px;">
    <div class="col-6 pt-5 pl-15">
    
        <div class="col-6 pt-8">
            <div class="img-bj border-radius5 img-wh70 bg-hei-5">
                <div class="img-wh40 maring-a pt-10">
                    <img src="img/touxiang.jpg" class="width-10 border-radius5">
                </div>
                <div class="txt-c zi-bai  pt-10"><font size="1">走进韩城</font></div>
            </div>
        </div>
       
    </div>
</div>

</body>
</html>