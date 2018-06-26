// JavaScript Document
$(function(){
	$('.location').width(document.body.clientWidth-190);
	
	$('.cp-quickmenu-icon').hover(
	function(){
		$(this).find('.cp-quickmenu-allcolumn').addClass('display');
	},
	function(){
		$(this).find('.cp-quickmenu-allcolumn').removeClass('display');
	}
	);
	$('.newscate em').click(function(){
		cateid = $(this).attr('cateid');
		$('.location').html('快捷菜单 - '+$(this).attr('column'));
		$('#main').attr('src', 'admin_news_list.php?action=list&typeid='+cateid);
		$('.cp-quickmenu-allcolumn').removeClass('display');
	});
	$('.newscate span').click(function(){
		cateid = $(this).attr('cateid');
		catelink = $(this).attr('link');
		$('.location').html('快捷菜单 - '+$(this).attr('column'));
		$('#main').attr('src', 'admin_news_list.php?action='+catelink+'&typeid='+cateid);
		$('.cp-quickmenu-allcolumn').removeClass('display');
	});
	$('.navlist em').click(function(){
		navlink = $(this).attr('link');
		$('.location').html('快捷菜单 - '+$(this).html());
		$('#main').attr('src', navlink);
		$('.cp-quickmenu-allcolumn').removeClass('display');
	});
	$('.top-nav a').click(function(){
		$.post('admin_ajax_nav.php', 
			{nav : $(this).attr('link')}, 
			function(data){
				if (data == 'home') {
					window.open ('../index.html', 'newwindow');
				} else if (data == 'main') {
					location.href = 'admin_index.php';
				} else if (data == 'logout') {
					location.href = 'admin_login.php?action=logout';
				} else if (data.indexOf('*') > -1){
					data_array = data.split('*');
					locationhref = data_array[0].split('$');
					$('.location').html(locationhref[0]);
					if (locationhref[1]) $('#main').attr('src', locationhref[1]);
					$('.cp-main-left .cp-main-left-menu').html(data_array[1]);
				}
				$('.cp-quickmenu-allcolumn').removeClass('display');
			}
		);
	});
	$('.delid').click(function(){
		if (confirm("您确定删除吗?此操作将不能恢复!")) {
			return true;
		}
		return false;
	});
	
	$('.product_recycle').click(function(){
		if (confirm("您确定删除吗?此操作将不能恢复!")) {
			//return true;
			$('input[name=action]').val('del');
			document.forms['form1_news'].submit();
		}
		return false;
	});
	
	$('.cp-sitebaseinfo .list ul li').each(function(i){
		$(this).css('background-image', 'url(img/cp-sort'+(i+1)+'.gif)');
	});
	
	$('.updatesort').click(function(){
		ajax_file = 'admin_ajax_sort.php';
		tablename = $(this).attr('tablename');
		delid = document.getElementsByName('delid[]');
		var a='';
		for (i=0; i< delid.length; i++) {
			a = a + (a ? '&' : '');
			a= a + 'id[]='+delid[i].value;
		}
		
		sorts = document.getElementsByName('sort');
		var b='';
		for (i=0; i< sorts.length; i++) {
			b = b + (b ? '&' : '');
			b = b + 'sort[]='+sorts[i].value;
		}
		a && b && (c = a + '&' + b);
		if (a && b && c) {
		$.ajax({
				type:"post",
				url:ajax_file,
				// timeout: 2000,
				data:c+'&tablename='+tablename,
				cache:false, 
				success:function(data){
					if (data == 'ok') {
						alert('排序更新成功！');
						location.reload();
					}
				},
				error:function(data){
					//alert(data);
					alert('排序更新失败！');
					return false;
				}	
		});
		}

	});
	
});

function cp_left_menu(x, locationname, typeid){
	$('.location').html(locationname);
	$('#main').attr('src', typeid);
	$('.cp-main-left-menu a').removeAttr('style');
	x.style.color='red';
}

function checkAll(box1) {
    var ids = document.getElementsByName("delid[]");
	if (ids != null) {
		for (i=0; i<ids.length; i++) {
			var obj = ids[i];
			obj.checked = box1.checked;
		}
	}
}
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval("location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

function admin_search(x, val){
	if (x.value == val) x.value = '';
}

function form_select(id,order,selectname){
	if (order == '1') $("#"+selectname).html('正在数据加载中...');
	$('#product_cate'+(order-1)).attr('s','true').siblings().removeAttr('s');
	$.post('admin_ajax_formselect.php',{id:id, order:order, selectname:selectname, tablename:selectname},
	function(data){
		arealength = $("select[id^='"+selectname+"']").length;
		for (i=order; i <= arealength; i++) {
			if (!document.getElementById(selectname+i)) break;
			$('#'+selectname+i).remove();
		}
		if (order == '1') $("#"+selectname).html('');
		if (data) $("#"+selectname).append(data);
		
		if (order>1) $('select[id='+selectname+(order-1)+'] option[value='+id+']').attr('selected', 'selected');
	});
	/////////////
	//if (selectname == 'product_cate') product_brand(id);
	////////////
}
function product_brand(id) {
	$.post('admin_product_list.php', {cate:id, action:'ajax_brand'},
	function(data){
		//alert(data);
		//$('.productbrand').css('display', '');
		$('.productbrand').html(data);
	});
}