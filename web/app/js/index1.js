(function() {


	var mySwiper = new Swiper('.swiper-content',{
		centeredSlides: true,
	    slidesPerView: 1,
		autoplay : 5000,//可选选项，自动滑动
		loop : true,//可选选项，开启循环
		pagination : '.swiper-pagination',
		onSlideChangeStart: function(){
			updateNavPosition()
		}
	})
	var navSwiper = $('.swiper-nav').swiper({
		visibilityFullFit: true,
		slidesPerView:'4',
		
		onSlideClick: function(){
			mySwiper.swipeTo( navSwiper.clickedSlideIndex )
		}
	})
	function updateNavPosition(){
		$('.swiper-nav .active-nav').removeClass('active-nav')
		var activeNav = $('.swiper-nav .swiper-slide').eq(mySwiper.activeIndex).addClass('active-nav')
		if (!activeNav.hasClass('swiper-slide-visible')) {
			if (activeNav.index()>navSwiper.activeIndex) {
				var thumbsPerNav = Math.floor(navSwiper.width/activeNav.width())-1
				navSwiper.swipeTo(activeNav.index()-thumbsPerNav)
			}
			else {
				navSwiper.swipeTo(activeNav.index())
			}
		}
	}
})();
