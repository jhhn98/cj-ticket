<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>팝업 항목 상세정보</title>
	<meta name="decorator" content="neo" />
</head>
<body>

<script nonce="NEOCMSSCRIPT">
	function fn_deletePopupItem( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>

<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">팝업항목관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">상세정보</span>
</div>
<div class="dataWrap">
	<table>
		<colgroup>
			<col class="specWidth200px"/>
			<col/>
		</colgroup>
		<tbody>
		<tr>
			<th>팝업이름</th>
			<td>${popupItem.popupIemNm}</td>
		</tr>
		<tr>
			<th>표시구분</th>
			<td>${showSeMap[popupItem.showSe]}</td>
		</tr>
		<tr>
			<th>기간</th>
			<td>${popupItem.bgndeYMDHM} ~ ${popupItem.enddeYMDHM}</td>
		</tr>
		<tr>
			<th>링크URL</th>
			<td>${popupItem.linkUrl}</td>
		</tr>
		<tr>
			<th>링크대상</th>
			<td>${linkTrgetMap[popupItem.linkTrget]}</td>
		</tr>
		<tr>
			<th>대체텍스트</th>
			<td>${popupItem.imageReplcText}</td>
		</tr>
		</tbody>
	</table>

	<div class="arrangementWrap marginTop_20">
		<div class="arrLeft">
			<a href="./selectPopupItemList.do?siteId=<c:out value="${selectedSite.siteId}"/>&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}"  class="iconTextButton list"><span>목록</span></a>
		</div>
		<div class="arrRight">
			<a href="./updatePopupItemView.do?popupIemNo=${popupItemVO.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;showSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}"  class="iconTextButton edit"><span>수정</span></a>
			<a href="./deletePopupItem.do?siteId=<c:out value="${selectedSite.siteId}"/>&amp;popupIemNo=${popupItemVO.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;showSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" onclick="fn_deletePopupItem(this.href); return false;"   class="iconTextButton marginLeft_10 delete"><span>삭제</span></a>
		</div>
	</div>

</div>
</body>
</html>