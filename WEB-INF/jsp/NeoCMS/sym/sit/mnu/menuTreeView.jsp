<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<c:set var="active_menu" value="MENU_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="decorator" content="neo" />

<script src="/common/js/jquery-ui.js"></script>
<script src="./js/common.js"></script>
<script nonce="NEOCMSSCRIPT">
	var isMenuSelectMode = false;
    //하위메뉴 표시하기
    function fn_setMenuList( data ) {

        // 상위메뉴 번호
        var upperMenuNo = data.menuNo;
        // 메뉴 목록
        var menuList = data.menuList;
        // 메뉴 수
        var menuCnt = data.menuList.length;
        if( menuCnt > 0 ) {
            // 기존 하위 메뉴 제거
            $("#ul_menuNo_" + upperMenuNo).remove();
            // 상위메뉴에 UL추가
            $("#menuNo_" + upperMenuNo).append("<ul class=\"treeViewList\" id=\"ul_menuNo_" + upperMenuNo + "\"></ul>");

            var i = 0;
            $.each( menuList, function(key) {

                i++;

                var menu = menuList[key].menu;
                var menuNo = menu.menuNo;
                var menuNm = menu.menuNm;
                var lwprtMenuCo = menu.lwprtMenuCo;
                var menuTy = menu.menuTy;
                var menuShowAt = menu.menuShowAt;
                var menuLevel = menu.menuLevel;
                var menuSortCode = menu.menuSortCode;
                var menuTyImg = "icon_" + menuTy;
                var upendShowAt = menu.upendShowAt;

                // 숨김메뉴 아이콘 & 메뉴명 색
                var menuNmClass = "";
                if( menuShowAt == "N" ) {
                    menuTyImg = menuTyImg + "_x";
                    menuNmClass = " data-menu-hide=\"true\"";
                }
                // 메뉴 li 클래스
                var menuLiClass = i == menuCnt ? " class=\"last\"" : "";

                if( menuLevel == 1 ) {
                    //menuLiClass = "class=\"first\"";
                }

                var menuExpBtn = lwprtMenuCo > 0 ? "<button type=\"button\" id=\"treeExp_" + menuNo + "\" data-name=\"" + menuNm + "\" class=\"treeView-icon zoom-in\" onclick=\"fn_jsonlwprtMenuList('" + menuNo + "')\"></button>" : "";

                var lwprtMenuClass = lwprtMenuCo > 0 ? " data-lwprt-menu=\"exist\"" : "";

                // 메뉴타입별 아이콘
                var menuIcon = "<a href=\"/${bestMenu.siteId}/sub.do?key=" + menuNo + "\" target=\"_blank\" class=\"menu-icon " + menuTy + "\">" + menuTy + "</a>";

				var flagOne = "";
				if(isMenuSelectMode == true){
					flagOne = "flag_on";
				}

                var menuNmLink = "<a onclick=\"moveMenuTree('"+menuSortCode+"',this.href);return false;\" id=\"btn_"+menuSortCode+"\" data-menuno=\"" + menuNo + "\" data-upend-showat=\"" + upendShowAt + "\"class=\"menu_selector " + flagOne + "\" href=\"./updateMenuView.do?siteId=${bestMenu.siteId}&amp;menuNo=" + menuNo + "\">" + menuNm + "</a>";

                // 하위메뉴
                var menuLi = "<li" + menuLiClass + " id=\"menuNo_" + menuNo + "\" data-menusort=\"" + menuSortCode + "\" data-menuno=\"" + menuNo + "\"" + lwprtMenuClass + " " + menuNmClass + ">" + menuExpBtn + "<span class=\"menu_name\">" + menuIcon + " " + menuNmLink + "</span></li>";

                // 하위메뉴 추가
                $("#ul_menuNo_" + upperMenuNo).append(menuLi);
            });


            if( !$("#menuNo_"+upperMenuNo).parent().attr("id") == "treeView"){ //최상위 메뉴가 아니라면
				if($("#treeExp_"+ upperMenuNo).length > 0){
					$("#treeExp_" + upperMenuNo).attr("class", "treeView-icon zoom-out");
					$("#treeExp_" + upperMenuNo).attr("onclick", "fn_closeMenu('" + upperMenuNo + "')");
				}else{
					$("#menuNo_"+upperMenuNo).prepend('<button type="button" id="treeExp_'+upperMenuNo+'" data-name="add" class="treeView-icon zoom-in" onclick="fn_jsonlwprtMenuList(\''+upperMenuNo+'\')"></button>')
					$("#treeExp_" + upperMenuNo).attr("class", "treeView-icon zoom-out");
					$("#treeExp_" + upperMenuNo).attr("onclick", "fn_closeMenu('" + upperMenuNo + "')");
				}
			}


        }else{
			// 기존 하위 메뉴 제거
			$("#ul_menuNo_" + upperMenuNo).remove();
			$("#treeExp_" + upperMenuNo).remove();
			$("#ul_menuNo_" + upperMenuNo).remove();

			// 상위메뉴에 UL추가
			//$("#menuNo_" + upperMenuNo).append("<ul class=\"treeViewList\" id=\"ul_menuNo_" + upperMenuNo + "\"></ul>");

		}
    }
    function fn_closeMenu( menuNo ) {
        $("#ul_menuNo_" + menuNo).remove();
        $("#treeExp_" + menuNo).attr("class", "treeView-icon zoom-in");
        $("#treeExp_" + menuNo).attr("onclick", "fn_jsonlwprtMenuList('" + menuNo + "')");
    }
    function fn_siteChange( siteId ) {
        window.location = "./menuTreeView.do?siteId=" + siteId;
    }
	function fn_searchMenu(menuSort){
		for(i=2;i<menuSort.length;i+=2){
			console.log("--fn_searchMenu--"+menuSort);
			var menuUpper = menuSort.substr(0,i);
			var menuNo = $('[data-menusort='+menuUpper+']').data("menuno");
			console.log(menuUpper+" -- " +menuNo);
			fn_jsonlwprtMenuList(menuNo);
		}
	}
    function fn_searchMenuHighLight(menuSort){
        var menuNo = $('[data-menusort='+menuSort+']').data("menuno");

        $("#menuNo_"+menuNo).addClass('searchHighLight');
    }
</script>
</head>
<body>
<div class="treeView_menu">
	<div id="header" class="subHeader">
		<a href="./addAllMenuView.do" class="upload_menu" title="메뉴 엑셀 업로드">메뉴 엑셀 업로드</a>
        <a onclick="moveExcelDownload(this.href);return false;" href="./downloadMenuXls.do?siteId=<c:out value="${bestMenu.siteId}"/>" class="download_menu" title="메뉴 엑셀 다운로드">메뉴 엑셀 다운로드</a>
		<a href="./allMenuAuthList.do?siteId=<c:out value="${bestMenu.siteId}"/>&amp;upperMenuNo=<c:out value="${bestMenu.menuNo}"/>" class="auth_menu" title="메뉴 관리자 설정">메뉴 관리자 설정</a>
		<a onclick="moveTreeContents(this.href);return false;" href="./addMenuView.do?siteId=<c:out value="${bestMenu.siteId}"/>&amp;upperMenuNo=<c:out value="${bestMenu.menuNo}"/>" target="neo_menu_main" class="add_menu" title="최상위 메뉴 추가">최상위 메뉴 추가</a>
		<a onclick="moveTreeContents(this.href);return false;" href="./sortMenuView.do?siteId=<c:out value="${bestMenu.siteId}"/>&amp;menuNo=<c:out value="${bestMenu.menuNo}"/>" target="neo_menu_main" class="order_menu" title="최상위 메뉴 순서변경">최상위 메뉴 순서변경</a>
	</div>
	<!-- 메뉴검색 폼  -->
	<div id="searchForm" class="treeSearch">
		<form:form modelAttribute="menuVO" name="menuForm" id="menuForm" action="menuTreeView.do" method="post" onsubmit="return fn_ajax_search_form_submit();">
			<form:hidden path="upperMenuNo"/>
			<form:hidden path="siteId"/>
			<form:select path="searchCnd" id="searchCndMenu" class=" searchSlct" >
				<form:option value="menuNm" label="메뉴명" />
				<form:option value="menuNo" label="메뉴번호" />
				<form:option value="deptNm" label="부서명" />
				<form:option value="emplNm" label="담당자명" />
				<form:option value="emplTelno" label="담당연락처" />
			</form:select>
			<form:input path="searchKrwd" class="searchKrwd" placeholder="검색어 입력"/>
			<button type="submit" class="searchBtn">메뉴 검색</button>
		</form:form>
	</div>

	<!-- 트리메뉴 구조 -->
	<script nonce="NEOCMSSCRIPT">
		//하위메뉴 목록 불러오기(json)
		function fn_jsonlwprtMenuList(menuNo) {
			fn_getAjaxSync( "./jsonLwprtMenuList.do?siteId=<c:out value="${menuVO.siteId}"/>&menuNo=" + menuNo, "json", fn_setMenuList );
			$("#treeExp_" + menuNo).attr("class", "treeView-icon zoom-out");
			$("#treeExp_" + menuNo).attr("onclick", "fn_closeMenu('" + menuNo + "')");
		}
	</script>
	<div class="treeView" id="treeView">
		<div class="treeViewWrap" id="menuNo_<c:out value="${bestMenu.menuNo}"/>"></div>
	</div>
	<script nonce="NEOCMSSCRIPT">
		$(document).ready(function() {
			fn_jsonlwprtMenuList('<c:out value="${bestMenu.menuNo}"/>');

			<c:if test="${!empty menuVO.searchKrwd}">
			<c:forEach var="menuSearch" items="${menuSearchList}" varStatus="status">
			fn_searchMenu('<c:out value="${menuSearch.menuSortCode}"/>');
			</c:forEach>
			<c:forEach var="menuSearch" items="${menuSearchList}" varStatus="status">
			fn_searchMenuHighLight('<c:out value="${menuSearch.menuSortCode}"/>');
			</c:forEach>
			</c:if>
		});


		function fn_ajax_search_form_submit(){
			var form_id = "menuForm";
			//$("#departmentForm").attr("action","jsonSearchDepart.do");
			var formData = $("#"+form_id).serialize();
			jQuery(spinner).css('display', '');
			$.ajax({
				cache: false,
				url: "jsonSearchMenu.do", // 요기에
				type: 'POST',
				data: formData,
				async:false,
				success: function (res) {
					jQuery(spinner).css('display', 'none');
					$("#menuNo_<c:out value="${bestMenu.menuNo}"/>").html("");
					fn_jsonlwprtMenuList('<c:out value="${bestMenu.menuNo}"/>');
					for(var mn_idx=0;mn_idx<res.menuSearchList.length;mn_idx++){
						//res.departmentList[mn_idx].deptSortCode;
						if(res.menuSearchList[mn_idx].menuSortCode == null ) continue;
						fn_searchMenu(res.menuSearchList[mn_idx].menuSortCode);
					}

					for(var mn_idx=0;mn_idx<res.menuSearchList.length;mn_idx++){
						if(res.menuSearchList[mn_idx].menuSortCode == null ) continue;
						fn_searchMenuHighLight(res.menuSearchList[mn_idx].menuSortCode);
					}
					//$(".treeView_content").html(res);
				}, // success
				error: function (request,xhr, status) {
					//alert(request.responseText);
                alert("에러가 발생하였습니다.");
					jQuery(spinner).css('display', 'none');
				},
				complete: function () {
					jQuery(spinner).css('display', 'none');
					downloadLinkPass();
				}
			});
			return false;
		}

	</script>

</div>

<div class="treeView_content">
</div>
<script nonce="NEOCMSSCRIPT">

	function moveMenuTree(menuSortCode, moveurl){
		if(isMenuSelectMode == true){
			var menuNm = $("#btn_"+menuSortCode).html();
			var menuNo = $("#btn_"+menuSortCode).data("menuno");
			$("#select_upperMenuNo").val(menuNo);
			$("#upperMenuNm").html(menuNm);
			isMenuSelectMode = false;

			$(".menu_selector").removeClass("flag_on");
			$("#info_menu_text").hide();
			$("#upperMenuBtn").html("변경취소");

		}else{
			moveTreeContents(moveurl);
		}


	}
	function moveTreeContents(menuUrl){
		return  moveTreeContents(menuUrl,false);
	}
	function moveTreeContents(menuUrl,isCallHistory){
		jQuery(spinner).css('display', '');
		$.ajax({
			url: menuUrl,
			method: 'post',
			success: function(res) {
				//console.log(res);
				$(".treeView_content").html(res);
				jQuery(spinner).css('display', 'none');

			},
			error       : function( request, status, error ) {
				if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
					alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
					location.href = "/neo/index.do";
				}else{
					//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				alert("에러가 발생하였습니다. 새로고침 후 다시확인하여주세요");
				}
				jQuery(spinner).css('display', 'none');
			},
			complete: function(){
				jQuery(spinner).css('display', 'none');
				downloadLinkPass();
				var origin = location.origin;
				const target = menuUrl.replace(origin,'');
				if(isCallHistory == false || isCallHistory == undefined){
					//사용자가 클릭 등의 액션으로 페이지가 이동되었다면 history에 저장함. 이 값은 뒤로가기 에서 사용됨.
					history.pushState({target:target}, 'NeoCMS 메뉴관리', location);
				}
			}

		});
		return false;
	}
	function fn_ajax_file_submit(form_id,file_id){

		var data = new FormData($("#"+form_id)[0]);
		if(typeof validateMenu !== 'undefined' && $.isFunction(validateMenu)){
			try{
				if(!validateMenu(document.getElementById(form_id))){
					return false;
				}
			}catch(Exception){ console.log('empty vilidator'); }
		}
		var url = $("#"+form_id).attr("action");
		jQuery(spinner).css('display', '');
		$.ajax({
			url: url,
			method: 'post',
			enctype: 'multipart/form-data',
			data: data,
			processData: false,
			contentType: false,
			error       : function( request, status, error ) {
				////alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				alert("에러가 발생하였습니다. 새로고침 후 다시확인하여주세요");
				$(".treeView_content").html(request.responseText);
				$(".spinner").hide();
			},
			success: function(res) {
				$(".treeView_content").html(res);
			},
			complete: function(){
				$(".spinner").hide();
				downloadLinkPass();


			}

		});
	}

	function fn_ajax_submit(form_id){
		if(typeof validateMenu !== 'undefined' && $.isFunction(validateMenu)){
			try{
				if(!validateMenu(document.getElementById(form_id))){
					return false;
				}
			}catch(Exception){ console.log('empty vilidator'); }
		}
		var formData = $("#"+form_id).serialize();
		var url = $("#"+form_id).attr("action");
		jQuery(spinner).css('display', '');
		$.ajax({
			cache: false,
			url: url, // 요기에
			type: 'POST',
			data: formData,
			success: function (res) {
				//console.log(res);
				jQuery(spinner).css('display', 'none');
				$(".treeView_content").html(res);
			}, // success
			error: function (request,xhr, status) {
				//alert(request.responseText);
                alert("에러가 발생하였습니다.");
				//$(".treeContents").html(request.responseText);
				jQuery(spinner).css('display', 'none');
			},
			complete: function () {
				jQuery(spinner).css('display', 'none');
				downloadLinkPass();
			}
		});
	}

	function moveExcelDownload(url){
		if(confirm("현재 사이트의 메뉴 리스트를 엑셀로 다운로드 하시겠습니까?")){
			location.href = url;
			jQuery(spinner).css('display', 'none');
			return false;
		}
		return false;
	}

		$(window).on('popstate', function(event) {
			var data = event.originalEvent.state;
			if(data.target != null && data.target != undefined){
				event.preventDefault();
				//메뉴 트리 우측의 컨텐츠내용을 history에 저장된 값으로 치환하고
				//isCallHistory 매개변수를 true를 입력하여서 히스토리에 기록되는것을 막음.
				moveTreeContents(data.target,true);
			}else{
				//그외의 경우 정상적인 뒤로가기 기능이 작동.
			}
		});

<%--		<c:if test="${param.target}" >--%>
<%--			moveTreeContents("<c:out value="${param.target}"/>");--%>
<%--		</c:if>--%>

</script>
</body>
</html>