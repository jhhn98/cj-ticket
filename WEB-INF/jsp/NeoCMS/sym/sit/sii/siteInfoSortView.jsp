<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="SITE_1" scope="request"/>


<!DOCTYPE html>
<html lang="ko">
<head>

	<title>사이트정보 목록</title>
	<meta name="decorator" content="neo" />
</head>
<body>
<script nonce="NEOCMSSCRIPT">
	function index_up() {
		var form = document.getElementById('siteInfoForm');
		var SelectIndex = form.idx.selectedIndex;
		if( SelectIndex < 0 ) {
			alert('팝업 항목을 선택하여 주세요.');
			return false;
		}
		if( SelectIndex ) {
			temp = form.idx.options[SelectIndex].text;
			form.idx.options[SelectIndex].text = form.idx.options[SelectIndex-1].text;
			form.idx.options[SelectIndex-1].text = temp;
			tempindex = form.idx.options[SelectIndex].value;
			form.idx.options[SelectIndex].value = form.idx.options[SelectIndex-1].value;
			form.idx.options[SelectIndex-1].value = tempindex;
			form.idx.selectedIndex = SelectIndex-1;
		}
	}
	function index_ups() {
		var form = document.getElementById('siteInfoForm');
		var SelectIndex = form.idx.selectedIndex;
		if( SelectIndex < 0 ) {
			alert('팝업 항목을 선택하여 주세요.');
			return false;
		}
		if( SelectIndex ) {
			temp = form.idx.options[SelectIndex].text;
			tempindex = form.idx.options[SelectIndex].value;
			for( var LoopI=SelectIndex-1; LoopI>=0; LoopI-- ) {
				form.idx.options[LoopI+1].text = form.idx.options[LoopI].text;
				form.idx.options[LoopI+1].value = form.idx.options[LoopI].value;
			}
			form.idx.options[0].text = temp;
			form.idx.options[0].value = tempindex;
			form.idx.selectedIndex = 0;
		}
	}
	function index_dn() {
		var form = document.getElementById('siteInfoForm');
		var SelectIndex = form.idx.selectedIndex;
		if( SelectIndex < 0 ) {
			alert('팝업 항목을 선택하여 주세요.');
			return false;
		}
		if( SelectIndex+1 < form.idx.length ) {
			temp = form.idx.options[SelectIndex+1].text;
			form.idx.options[SelectIndex+1].text = form.idx.options[SelectIndex].text;
			form.idx.options[SelectIndex].text = temp;
			tempindex = form.idx.options[SelectIndex+1].value;
			form.idx.options[SelectIndex+1].value = form.idx.options[SelectIndex].value;
			form.idx.options[SelectIndex].value = tempindex;
			form.idx.selectedIndex = SelectIndex+1;
		}
	}
	function index_dns() {
		var form = document.getElementById('siteInfoForm');
		var SelectIndex = form.idx.selectedIndex;
		var SelectLength = form.idx.length-1;
		if( SelectIndex < 0 ) {
			alert('팝업 항목을 선택하여 주세요.');
			return false;
		}
		if( SelectIndex < SelectLength ) {
			temp = form.idx.options[SelectIndex].text;
			tempindex = form.idx.options[SelectIndex].value;
			for( var LoopI=SelectIndex+1; LoopI<=SelectLength; LoopI++ ) {
				form.idx.options[LoopI-1].text = form.idx.options[LoopI].text;
				form.idx.options[LoopI-1].value = form.idx.options[LoopI].value;
			}
			form.idx.options[SelectLength].text = temp;
			form.idx.options[SelectLength].value = tempindex;
			form.idx.selectedIndex = SelectLength;
		}
	}
	function IdxSubmit( form ) {
		form.idxData.value = "";
		for(var i=0; i<form.idx.length; i++)
			form.idxData.value += form.idx.options[i].value + '^';
		fn_ajax_submit(form.id);
		return false;
	}
</script>
<div class="page_location">
	<span class="depth1_title icon_site">사이트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">목록</span>
</div>
<jsp:include page="./subMenu.jsp" />

<div class="contents is_tab">
	<p class="info_text">표시중인 항목만 순서변경이 가능하며 표시되지 않는 팝업는 맨 마지막으로 자동 이동 됩니다.</p>
	<form:form modelAttribute="siteInfo" id="siteInfoForm" name="siteInfoForm" action="sortSiteInfo.do" onsubmit="IdxSubmit(this)">
		<input type="hidden" name="siteSe" id="siteSe" value="<c:out value="${siteInfo.siteSe}"/>"/>
		<form:hidden path="idxData"/>
		<div class="topMargin">
			<select name="idx" style="height:260px;width:100%; border:solid 1px #528ED8" size="16">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<option value="<c:out value="${result.siteId}"/>"><c:out value="${result.siteNm}"/>[<c:out value="${result.siteId}"/>]</option>
				</c:forEach>
			</select>
		</div>
		<div class="arrangementWrap marginTop_20">
			<div class="arrLeft">
				<a href="javascript:" onclick="index_ups()" class="iconButton angle_double_up marginRight_5"><span>맨위로</span></a>
				<a href="javascript:" onclick="index_up()" class="iconButton angle_up marginRight_5"><span>위로</span></a>
				<a href="javascript:" onclick="index_dn()" class="iconButton angle_down marginRight_5"><span>아래로</span></a>
				<a href="javascript:" onclick="index_dns()" class="iconButton angle_double_down"><span>맨아래로</span></a>
			</div>
			<div class="arrRight">
				<a href="./selectSiteInfoList.do?siteSe=<c:out value="${siteInfo.siteSe}"/>" class="iconTextButton list"><span>목록</span></a>
				<button type="submit" class="iconTextButton sort marginLeft_5"><span>순서변경</span></button>
			</div>
		</div>
	</form:form>
</div>


</body>
</html>