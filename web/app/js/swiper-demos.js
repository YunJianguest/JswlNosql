/*
Author: Vladimir Kharlampidi, The iDangero.us
*/
document.createElement('header');
document.createElement('footer');

$(function(){
	
	/* Carousel & Loop mode. Infinite Scrolling: */
	swiperLoop = $('.swiper-loop').swiper({
		pagination : '.pagination-loop',
		slidesPerSlide : 3,
		loop:true
	});
	
	
	
	
	//Tabs
	var swiperTabs = $('.swiper-tabs').swiper({
		onlyExternal : true,
		speed:500
	});
	$(".tabs a").bind('touchstart',function(e){
		e.preventDefault()
		$(".tabs .active").removeClass('active')
		$(this).addClass('active')
		e.preventDefault()
		swiperTabs.swipeTo( $(this).index() )
	})
	$(".tabs a").click(function(e){
		e.preventDefault()
	})
	$(".tabs a").mousedown(function(e){
		$(".tabs .active").removeClass('active')
		$(this).addClass('active')
		e.preventDefault()
		swiperTabs.swipeTo( $(this).index() )
	})
	
	
	//Puzzle
	var puzzleParams = {
		mode : "horizontal", 
		speed : 300,
		ratio : 1
	}
	$(".p1").swiper(puzzleParams)
	$(".p2").swiper(puzzleParams)
	$(".p3").swiper(puzzleParams)
	$(".p4").swiper(puzzleParams)
	$(".p5").swiper(puzzleParams)
	$(".p6").swiper(puzzleParams)
	
	
	
	//Movies App
	var swiperMovies = $('.mc-posters').swiper({
		mode : "horizontal", 
		onlyExternal : true,
		speed:1000
	});
	var allowMovieClick = true
	var swiperMControl = $('.mc-control').swiper({
		mode : "horizontal", 
		scrollContainer:true,
		onTouchMove : function(){
			allowMovieClick = false	
		},
		onTouchEnd : function() {
			setTimeout(function(){allowMovieClick = true},100)	
		}
	});
	$('.mc-control img').bind('mousedown',function(e){
		e.preventDefault()
	})
	$('.mc-control img').bind('click',function(e){
		e.preventDefault()
		if (!allowMovieClick) return;
		var index = $(this).index()
		swiperMovies.swipeTo ( index )
		$('.mc-control .active').removeClass('active')
		$(this).addClass('active')
	})

	/* Dynamic Swiper */
	function randomColor () {
		var colors = ('blue red green orange pink').split(' ');
		return colors[ Math.floor( Math.random()*colors.length ) ]
	}
	var count = 5;
	var swiperDyn = $('.swiper-dynamic').swiper({
		pagination:'.pagination-sd'
	})
	$('.sdl-append').click(function(e) {
		e.preventDefault();
		swiperDyn.appendSlide('<h2>Slide '+(++count)+'</h2>', 'swiper-slide '+randomColor()+'-slide')
	});
	$('.sdl-prepend').click(function(e) {
		e.preventDefault();
		swiperDyn.prependSlide('<h2>Slide  '+(++count)+'</h2>', 'swiper-slide '+randomColor()+'-slide')
	});
	$('.sdl-swap').click(function(e) {
		e.preventDefault();
		swiperDyn
			.getFirstSlide()
			.insertAfter(1)
	});
	$('.sdl-insert').click(function(e) {
		e.preventDefault();
		swiperDyn
			.createSlide('<h2>Slide  '+(++count)+'</h2>', 'swiper-slide '+randomColor()+'-slide')
			.insertAfter(0)
	});
	$('.sdl-remove1').click(function(e) {
		e.preventDefault();
		swiperDyn.removeSlide(0)
	});
	$('.sdl-removel').click(function(e) {
		e.preventDefault();
		swiperDyn.removeLastSlide()
	});
	$('.sdl-remove2').click(function(e) {
		e.preventDefault();
		swiperDyn.removeSlide(1)
	});

	//Partial Slides
	$('.swiper-partial').swiper({
		slidesPerSlide:'auto'
	})

	//Threshold
	$('.swiper-threshold').swiper({
		moveStartThreshold:100
	})

	
})

