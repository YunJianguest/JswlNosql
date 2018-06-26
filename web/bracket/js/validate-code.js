$(function(){
	$('.validate-code').click(function(){
		$object = $(this);
		$.post('/source/code/code.php',{validate:1},function(data){
			$object.prop('src', '/source/code/code.php?code='+data);
			$object.siblings('input[name=getcode]').val(data);
		});
	});
})