$(function(){
	/*Ajax提交表单
	  <form action="*" data-ajax="false">时不使用ajax提交表单，使用默认格式提交表单
	*/
	$('form').submit(function(event){
        var id = $(this).attr('id');
        var my_form = new form_validator(id);
        var validator = my_form.validator();
        if(!validator){
            if($('#error_box').length > 0){
                //错误盒子
                error_box(my_form.msg);
                return false;
            }else{
                alert(my_form.msg);
                return false;
            }
        }else{
            var ajax_form = $(this).attr('data-ajax') ? false : true;
            if(ajax_form){
                event.preventDefault();
                $(this).ajaxSubmit({
                    success: function(data){
                        if(data.success){
                            alert("操作成功");
                            window.location.reload();
                        }else{
                            alert(data.msg);
                        }
                    },
                    error: function(){
                        alert('数据请求错误!');
                    }
                });
            }else{
                $(this).submit();
            }
        }
	});
})

//错误盒子
function error_box(msg){
	if(msg && msg != ''){
        $('#error_box #inner_text').text(msg);
    	$('#error_box').show();
    	setTimeout('$(\'#error_box\').fadeOut(800);', 1000)
    }else{
    	$('#error_box').hide();
    }

    //关闭错误盒子
	$('.right_close').on('click', function(){
		$('#error_box').fadeOut(800);
	});
}