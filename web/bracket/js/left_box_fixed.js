function box_fixed(box_main, box_right) {
	//左侧固定区块
	box_left = $('.box_fixed');

	if ($(box_left).is('.true')) {
		
	box_left_width = box_left.parent().width();
	box_left_height = box_left.height();
	box_left.width(box_left_width);
	box_left_top = box_left.offset().top;		
		
		$(window).scroll(function() {
			if (box_left.height()<$(box_right).height()) {
			inside_left = parseInt(box_left.height()) + 
						  parseInt($(document).scrollTop());
			inside_right = parseInt($(box_right).height()) + 
						   parseInt($(box_right).css('padding-top')) + 
						   parseInt($(box_right).css('padding-bottom')) + 
						   parseInt(box_left_top);
			if ($(document).scrollTop() > box_left_top) {
  				if (inside_left >= inside_right) {
					$(box_main).css('position','relative');
					box_left.css('position','absolute');
  					box_left.css('top',parseInt(inside_right) - parseInt(box_left.height()) - parseInt(box_left_top));
				} else {
					$(box_main).css('position','');
					box_left.css('position','fixed');
  					box_left.css('top',0);
				}
			} else {
				box_left.css('position','static');
  				box_left.css('top','auto');
			}
			}
		});
	}
}