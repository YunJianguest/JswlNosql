// Run the code when the DOM is ready
$( pieChart );

function pieChart() {

    // Config settings
    var chartSizePercent =90;                        // 圆大小
    var sliceBorderWidth = 1;                         // 边宽度
    var sliceBorderStyle = "#fff";                    // 边颜色
    var pullOutBorderStyle ="#fff" ;                  // 点击后颜色
    var pullOutBorderWidth = 3;                       // 点击后边宽
    var maxPullOutDistance = 10;                      // 点击距离
    var pullOutFrameStep = 5;                         // 点击速度
    var pullOutFrameInterval = 40;                    // 多少毫秒
    var pullOutLabelPadding = -42;                     // 注释距离
    var pullOutLabelFont = "bold  16px '微软雅黑', Arial, sans-serif ";  // 标识字体
    var pullOutValueFont = "bold  16px '微软雅黑', Arial, sans-serif";  // 小字字体
    var pullOutShadowColour = "rgba( 0, 0, 0, .2 )";  // 阴影
    var pullOutShadowOffsetX = 3;                     // X阴影
    var pullOutShadowOffsetY = 3;                     // Y阴影
    var pullOutShadowBlur = 3;                        // 阴影模糊
    var chartStartAngle = -.1 * Math.PI;              // 饼图开始位置

    // Declare some variables for the chart
    var canvas;                       //在页面的canvas元素
    var currentPullOutSlice = -1;     // 片目前拉出（1 =无片）
    var currentPullOutDistance = 0;   // 有多少像素的拔片目前拿出在动画
    var animationId = 0;              // 轨道由setinterval()动画间隔的ID
    var chartData = [];               // 图表数据（标签，价值观，和角度）
    var chartColours = [];            // 图的颜色（从HTML表格拉）
    var totalValue = 0;               // 图表中的所有值的总
    var canvasWidth;                  // 画布的宽度，以像素为单位
    var canvasHeight;                 // 画布的高度，以像素为单位
    var centreX;                      // 图中心坐标X
    var centreY;                      // 图中心坐标Y
    var chartRadius;                  // 饼图的半径

    // 设置的东西，并绘制图表
    init();


    /**
     * Set up the chart data and colours, as well as the chart and table click handlers,
     * and draw the initial pie chart
     */

    function init() {

        // Get the canvas element in the page
        canvas = document.getElementById('chart');

        // Exit if the browser isn't canvas-capable
        if ( typeof canvas.getContext === 'undefined' ) return;

        // Initialise some properties of the canvas and chart
        canvasWidth = canvas.width;
        canvasHeight = canvas.height;
        centreX = canvasWidth / 2;
        centreY = canvasHeight / 2;
        chartRadius = Math.min( canvasWidth, canvasHeight ) / 2 * ( chartSizePercent / 100 );

        // Grab the data from the table,
        // and assign click handlers to the table data cells

        var currentRow = -1;
        var currentCell = 0;

        $('#chartData td').each( function() {
            currentCell++;
            if ( currentCell % 2 != 0 ) {
                currentRow++;
                chartData[currentRow] = [];
                chartData[currentRow]['label'] = $(this).text();
            } else {
                var value = parseFloat($(this).text());
                totalValue += value;
                value = value.toFixed(2);
                chartData[currentRow]['value'] = value;
            }

            // 存储层指标在该细胞，并附加一个点击处理它
            $(this).data( 'slice', currentRow );
            $(this).click( handleTableClick );

            // 提取和存储单元的颜色
            if ( rgb = $(this).css('color').match( /rgb\((\d+), (\d+), (\d+)/) ) {
                chartColours[currentRow] = [ rgb[1], rgb[2], rgb[3] ];
            } else if ( hex = $(this).css('color').match(/#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/) ) {
                chartColours[currentRow] = [ parseInt(hex[1],16) ,parseInt(hex[2],16), parseInt(hex[3], 16) ];
            } else {
                alert( "Error: Colour could not be determined! Please specify table colours using the format '#xxxxxx'" );
                return;
            }

        } );

        // 现在，计算和存储的开始和结束每一片角度图表中的数据

        var currentPos = 0; // 在馅饼切片的当前位置（从0到1）

        for ( var slice in chartData ) {
            chartData[slice]['startAngle'] = 2 * Math.PI * currentPos;
            chartData[slice]['endAngle'] = 2 * Math.PI * ( currentPos + ( chartData[slice]['value'] / totalValue ) );
            currentPos += chartData[slice]['value'] / totalValue;
        }

        // 都准备好了！现在画的饼图，并添加点击事件吧
        drawChart();
        $('#chart').click ( handleChartClick );
    }


    /**
     * 在图表区点击鼠标的过程。
     *
     * 如果被点击了一片，或把它切换。
     * 如果用户点击了外面的馅饼，把任何片回来。
     *
     * @param Event The click event
     */

    function handleChartClick ( clickEvent ) {

        // 获取鼠标点击时鼠标光标的位置，相对于帆布
        var mouseX = clickEvent.pageX - this.offsetLeft;
        var mouseY = clickEvent.pageY - this.offsetTop;

        // Was the click inside the pie chart?
        var xFromCentre = mouseX - centreX;
        var yFromCentre = mouseY - centreY;
        var distanceFromCentre = Math.sqrt( Math.pow( Math.abs( xFromCentre ), 2 ) + Math.pow( Math.abs( yFromCentre ), 2 ) );

        if ( distanceFromCentre <= chartRadius ) {

            //是的，点击里面的图。
            // 找到片，通过比较的角度相对于图中心点。

            var clickAngle = Math.atan2( yFromCentre, xFromCentre ) - chartStartAngle;
            if ( clickAngle < 0 ) clickAngle = 2 * Math.PI + clickAngle;

            for ( var slice in chartData ) {
                if ( clickAngle >= chartData[slice]['startAngle'] && clickAngle <= chartData[slice]['endAngle'] ) {

                    // 切片发现。拉出或推进中，要求。
                    toggleSlice ( slice );
                    return;
                }
            }
        }

        // 用户必须点击以外的馅饼。把任何掏出片回来。
        pushIn();
    }


    /**
     * Process mouse clicks in the table area.
     *
     * Retrieve the slice number from the jQuery data stored in the
     * clicked table cell, then toggle the slice
     *
     * @param Event The click event
     */

    function handleTableClick ( clickEvent ) {
        var slice = $(this).data('slice');
        toggleSlice ( slice );
    }


    /**
     * Push a slice in or out.
     *
     * If it's already pulled out, push it in. Otherwise, pull it out.
     *
     * @param Number The slice index (between 0 and the number of slices - 1)
     */

    function toggleSlice ( slice ) {
        if ( slice == currentPullOutSlice ) {
            pushIn();
        } else {
            startPullOut ( slice );
        }
    }


    /**
     * 从开始拉一片馅饼。
     *
     * @param Number The slice index (between 0 and the number of slices - 1)
     */

    function startPullOut ( slice ) {

        // 如果我们已经拔出这片
        if ( currentPullOutSlice == slice ) return;

        // 纪录片我们拔出，清除任何以前的动画，然后开始动画
        currentPullOutSlice = slice;
        currentPullOutDistance = 0;
        clearInterval( animationId );
        animationId = setInterval( function() { animatePullOut( slice ); }, pullOutFrameInterval );

        // 突出关键字表中相应的行
        $('#chartData td').removeClass('highlight');
        var labelCell = $('#chartData td:eq(' + (slice*2) + ')');
        var valueCell = $('#chartData td:eq(' + (slice*2+1) + ')');
        labelCell.addClass('highlight');
        valueCell.addClass('highlight');
    }


    /**
     * Draw a frame of the pull-out animation.
     *
     * @param Number The index of the slice being pulled out
     */

    function animatePullOut ( slice ) {

        // Pull the slice out some more
        currentPullOutDistance += pullOutFrameStep;

        // If we've pulled it right out, stop animating
        if ( currentPullOutDistance >= maxPullOutDistance ) {
            clearInterval( animationId );
            return;
        }

        // Draw the frame
        drawChart();
    }


    /**
     * Push any pulled-out slice back in.
     *
     * Resets the animation variables and redraws the chart.
     * Also un-highlights all rows in the table.
     */

    function pushIn() {
        currentPullOutSlice = -1;
        currentPullOutDistance = 0;
        clearInterval( animationId );
        drawChart();
        $('#chartData td').removeClass('highlight');
    }


    /**
     * Draw the chart.
     *
     * Loop through each slice of the pie, and draw it.
     */

    function drawChart() {

        // 得到一个绘图上下文
        var context = canvas.getContext('2d');

        // 清空画布，准备新框架
        context.clearRect ( 0, 0, canvasWidth, canvasHeight );

        //画出每一层的图表，跳过拔出片（如果有的话）
        for ( var slice in chartData ) {
            if ( slice != currentPullOutSlice ) drawSlice( context, slice );
        }

        // 如果有一个拔出片的影响，得出了。
        // （我们得出拉拔片上的阴影，没有画过的。）
        if ( currentPullOutSlice != -1 ) drawSlice( context, currentPullOutSlice );
    }



    function drawSlice ( context, slice ) {

        //计算该片调整的开始和结束角度
        var startAngle = chartData[slice]['startAngle']  + chartStartAngle;
        var endAngle = chartData[slice]['endAngle']  + chartStartAngle;

        if ( slice == currentPullOutSlice ) {

            // 我们拉（或拉）这片。
            // 偏移从饼中心，绘制文本标签，
            // 添加一个阴影。

            var midAngle = (startAngle + endAngle) / 2;
            var actualPullOutDistance = currentPullOutDistance * easeOut( currentPullOutDistance/maxPullOutDistance, .8 );
            startX = centreX + Math.cos(midAngle) * actualPullOutDistance;
            startY = centreY + Math.sin(midAngle) * actualPullOutDistance;
            
            context.shadowOffsetX = pullOutShadowOffsetX;
            context.shadowOffsetY = pullOutShadowOffsetY;
            context.shadowBlur = pullOutShadowBlur;

        } else {

            // 本片不退出，所以把它从饼中心
            startX = centreX;
            startY = centreY;
        }

        // 设置层渐变填充
        var sliceGradient = context.createLinearGradient( 0, 0, canvasWidth*.75, canvasHeight*.75 );
        sliceGradient.addColorStop( 1, 'rgb(' + chartColours[slice].join(',') + ')' );

        //绘制切片
        context.beginPath();
        context.moveTo( startX, startY );
        context.arc( startX, startY, chartRadius, startAngle, endAngle, false );
        context.lineTo( startX, startY );
        context.closePath();
        context.fillStyle = sliceGradient;
        context.shadowColor = ( slice == currentPullOutSlice ) ? pullOutShadowColour : "rgba( 0, 0, 0, 0 )";
        context.fill();
        context.shadowColor = "rgba( 0, 0, 0, 0 )";


        // 风格的切片边界适当
        if ( slice == currentPullOutSlice ) {
            context.lineWidth = pullOutBorderWidth;
            context.strokeStyle = pullOutBorderStyle;
        } else {
            context.lineWidth = sliceBorderWidth;
            context.strokeStyle = sliceBorderStyle;
        }

        // 绘制切片边界
        context.stroke();

        // 绘制切片文字
        context.fillStyle = "#fff";
        context.shadowColor ="#000";
        context.shadowBlur ="3"
        context.shadowOffsetX="0"
        context.shadowOffsetY="0"
        context.textAlign = "center" ;
        context.font = pullOutLabelFont;
        context.fillText( chartData[slice]['label'], centreX + Math.cos(midAngle) * ( chartRadius + maxPullOutDistance + pullOutLabelPadding ), centreY + Math.sin(midAngle) * ( chartRadius + maxPullOutDistance + pullOutLabelPadding ) );
        context.font = pullOutValueFont;
        context.fillText( ( parseInt( chartData[slice]['value'] / totalValue * 100 + .5 ) ) +  "%", centreX + Math.cos(midAngle) * ( chartRadius + maxPullOutDistance + pullOutLabelPadding ), centreY + Math.sin(midAngle) * ( chartRadius + maxPullOutDistance + pullOutLabelPadding ) + 20 );
    }


    function easeOut( ratio, power ) {
        return ( Math.pow ( 1 - ratio, power ) + 1 );
    }

};
