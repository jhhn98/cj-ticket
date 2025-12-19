
function web_menu(a){
	//상단메뉴
	var lnb = $('#lnb'),
		depth1 = $(".top1menu");
	depth1.find(" > li > div").addClass('top2m');
	depth1.find("ul ul").hide();

	var depth2 = $('.top1menu .top2m'),
		lnbBg= $("#lnb .top2mbg"),
		lnbLeave = $(".visual .btn_number button:first, .gnb li:last a, .side_menu ul li:first a");

	depth2.hide();

	lnb.css("left","");
	depth1.find(" > li > a").off();
	depth1.find(" ul > li a").off();

	var dep1_length = depth1.find(" > li").length;
	//var $depLast_length = depth1.find(" > li:nth-child("+dep1_length+")  li").size();
	//depth1.find(" > li:nth-child("+dep1_length+")  li:nth-child("+$depLast_length+")").addClass('last');

	var dep2_h = 0;
	for (i=1;i <= dep1_length;i++) {
		top2m_h = depth1.find(" > li:nth-child("+i+") .top2m").height();
		if(dep2_h < top2m_h){
			dep2_h = top2m_h;
		}
		depth1.find("> li:nth-child("+i+") .top2m").addClass('m'+i);
	}
	depth2.find("div").css("height", dep2_h);
	lnbBg.css("height", dep2_h+3);

	depth1.find(" > li > a").on('mouseenter focusin',function(event){
		event.preventDefault ();
		depth2.stop().slideDown();
		lnbBg.stop().slideDown();
		depth1.addClass('on');
	});

	depth1.mouseleave(function(){
		depth2.stop().slideUp();
		lnbBg.stop().slideUp();
		depth1.removeClass('on');
		depth2.prev('a.hover').removeClass('hover');
	});

	depth2.on('mouseenter focusin',function(event){
		depth2.prev('a.hover').removeClass('hover');
		$(this).prev('a').addClass('hover');
	});

	//lnb 벗어나면 닫기
	lnbLeave.focusin(function(){
		depth2.stop().slideUp();
		lnbBg.stop().slideUp();
		depth1.removeClass('on');
		depth2.prev('a.hover').removeClass('hover');
	});

};

function mobile_menu(a){
	//상단메뉴
	var depth1 = $(".top1menu"),
		dep1_length = depth1.find(" > li").size(),
		depLast_length = depth1.find(" > li:nth-child("+dep1_length+")  li").length;

	depth1.find(" > li > div").addClass('top2m');
	depth1.off();
	depth1.find(" > li > a").off();
	depth1.find(" ul > li a").off();

	$(".top1menu .top2m, .top1menu .top2m div").css("height","auto");

	depth1.find(" >  li > a").on('click',function(event){
		event.preventDefault ();
		var m_open=$(this).hasClass('active');
		if(m_open==true){
			$(this).siblings().slideUp();
			$(this).removeClass('active');
		}else{
			depth1.find(" > li > div ").stop().slideUp();
			depth1.find(" a ").removeClass('active');
			$(this).siblings().slideDown();
			$(this).addClass('active')
		}
	});

	depth1.find(" ul > li a ").on('click',function(event){
		var depth3_has=$(this).siblings("ul").length;
		if(depth3_has>0){
			event.preventDefault();
		}
		var m_open=$(this).hasClass('active');
		if(m_open==true){
			$(this).siblings().slideUp();
			$(this).removeClass('active');
		}else{
			depth1.find(" ul ul").stop().slideUp();
			depth1.find(" ul a").removeClass('active');
			$(this).siblings().slideDown();
			$(this).addClass('active')
		}
	});
}

$(document).ready(function(){
	var lnb = $('#lnb'),
		m_nav_open = $('.lnb_m_nav'),
		m_nav_close = $('.mask, .lnb_close button'),
		mask = $( '.mask' ),
		bodyFrame = $( 'body, html' );
	 	m_nav_display=false;

	m_nav_open.click(function() {
		var h = $(window).height();
		lnb.animate(  { right : 0 },  500);
		bodyFrame.css("overflow",'hidden');
		mask.show();
	});
	m_nav_close.click(function() {
		lnb.animate(  { right : -280 },  500);
		bodyFrame.css('overflow', '' );
		mask.hide();
	});



});

//검색영역
function header_search(){
	var totalSearch = $('#header .h_search'),
		totalSearch_m_btn =$('.lnb_m_seach .btn_search');
	if ($(window).width() > 640) {
		totalSearch.show();
	} else{
		var searchAvtice = false;
		totalSearch.hide();
	}

	totalSearch_m_btn.click(function() {
		if(searchAvtice){
			searchAvtice = false;
			totalSearch.hide();
		} else {
			searchAvtice = true;
			totalSearch.show();
		}
	});
}

$(function () {
	$(window).on({
		load: function () {
			if ($(window).width() > 640) {
				web_menu();
			}
			else {
				mobile_menu();
			}
			header_search();
		},
		resize: function () {
			if ($(window).width() > 640) {
				web_menu();
			}
			else {
				mobile_menu();
			}
			header_search();
		}
	});
});

// 탭메뉴 공통적으로 사용
function tabOn(tab,num,img) {
	var $tab,$tab_btn;
	var tabid=tab, n=num-1, btn_img=img;

	$tab = $(tabid+'> ul > li');
	$tab_btn = $(tabid+'> ul > li > a');

	$tab_btn.siblings().hide();
	$tab.eq(n).addClass('active');
	$tab.eq(n).children('a').siblings().show();

	if(btn_img =='img'){
		var btn = $tab.eq(n).children('a').find("img");
		btn.attr("src",btn.attr("src").replace("_off","_on"));
	}

	$tab_btn.on("click",function(event){
		var realTarget = $(this).attr('href');

		if(realTarget != "#"){
			return
		}
		if(btn_img =='img'){
			for(var i=0;i<$tab.length;i++){
				var btn = $tab.eq(i).children('a').find("img");
				btn.attr("src",btn.attr("src").replace("_on","_off"));
			}
			var active = $(this).parent().attr('class');
			if(active != 'active'){
				var btn_img_off = $(this).find('img')[0];
				btn_img_off.src =  btn_img_off.src.replace('_off','_on');
			}
		}
		$tab_btn.siblings().hide();
		$tab_btn.parent().removeClass('active');

		$(this).siblings().show();
		$(this).parent().addClass('active');

		event.preventDefault();
	});
}

function tabOrg(tabid,a,img) {
	var $tab, $tab_btn,$obj,$obj_view;
	var tabid = tabid, num = a, btn_img = img;

	$tab = $(tabid+' .tab_item  > li');
	$tab_btn = $(tabid+' .tab_item > li > a');
	$obj = $(tabid+' .tab_obj');
	$obj_view = $(tabid+' .tab_obj.n'+num);

	$tab.eq(num-1).addClass('active');
	$obj_view.show();

	if(btn_img =='img'){
		var btn = $tab.eq(num-1).children('a').find("img");
		btn.attr("src",btn.attr("src").replace("_off","_on"));
	}

	$tab.bind("click",function(event){
		if(btn_img =='img'){
			for(var i=0;i<$tab.length;i++){
				var btn = $tab.eq(i).children('a').find("img");
				btn.attr("src",btn.attr("src").replace("_on","_off"));
			}
			var active = $(this).parent().attr('class');
			if(active != 'active'){
				var btn_img_off = $(this).find('img')[0];
				btn_img_off.src =  btn_img_off.src.replace('_off','_on');
			}
		}

		var this_eq = $tab.index( $(this) );
		$tab.removeClass('active');
		$tab.eq(this_eq).addClass('active');

		$obj.hide();
		$(tabid+' .tab_obj.n'+(this_eq+1)).show();

		event.preventDefault ();
	});
}

$(document).ready(function(){
	//이미지 롤오버 
	 $(".overimg").mouseover(function (){
		var file = $(this).attr('src').split('/');
		var filename = file[file.length-1];
		var path = '';
		for(i=0 ; i < file.length-1 ; i++){
		 path = ( i == 0 )?path + file[i]:path + '/' + file[i];
		}
		$(this).attr('src',path+'/'+filename.replace('_off.','_on.'));
		
	 }).mouseout(function(){
		var file = $(this).attr('src').split('/');
		var filename = file[file.length-1];
		var path = '';
		for(i=0 ; i < file.length-1 ; i++){
		 path = ( i == 0 )?path + file[i]:path + '/' + file[i];
		}
		$(this).attr('src',path+'/'+filename.replace('_on.','_off.'));
	 });
});


