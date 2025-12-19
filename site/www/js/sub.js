$(function(){
	var sideMenu = $(".side_menu > ul"),
		side_depth1 = sideMenu.find(">li"),
		side_depth2 = sideMenu.find(">li>ul>li");

	side_depth1.find('>a').on("click focus",function(){
		var this_item = $(this).parent('li');
		var side_depth2_size= $(this).next('ul').length;
		if(side_depth2_size > 0 ){
			$(this).attr('href','#n');
			if (this_item.hasClass('on')){
				//$(this).next('ul').slideUp(300);
				//this_item.removeClass('on');
			} else{
				side_depth1.find("ul").slideUp(300);
				side_depth1.removeClass('on');

				$(this).next('ul').stop().slideDown(300);
				$(this).parent().addClass('on');
			}
		}
	});
	side_depth2.find('>a').on("click focus",function(){
		side_depth2.removeClass('on');
		$(this).parent().addClass('on');
	});

});


$(function(){
    //상단이동
	var top_move_btn = $(".goto_top");
	top_move_btn.click(function(){
        $("html, body").animate({scrollTop : 0},400);
    });
});

/*
// 만족도조사
function fn_validateCntntsEvalHist( frm ) {
    var valiEvl = false;
    for( var i=0; i<frm.cntntsEvlSe.length; i++ ) {
        if( frm.cntntsEvlSe[i].checked == true ) {
            valiEvl = true;
            break;
        }
    }
    if( !valiEvl ) {
        alert("만족도의 등급을 선택하지 않으셨습니다.\n만족도 등급을 선택하여 주세요.");
        fn_setFocus(frm, 'value5');
        return false;
    }
    return true;
}
*/