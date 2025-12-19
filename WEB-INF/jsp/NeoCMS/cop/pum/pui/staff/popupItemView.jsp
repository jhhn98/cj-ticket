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
	<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<script nonce="NEOCMSSCRIPT">
	function fn_deletePopupItem( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>

<div class="p-wrap">

	<div class="col-20">
		<div>
			<span class="p-icon p-icon__info-circle">주의사항</span>
            <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
		</div>

		<table class="p-table">
			<colgroup>
				<col class="w15p">
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

		<div class="row margin_t_20">
			<div class="col-12">
				<a href="./selectPopupItemList.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${selectedSite.siteId}"/>&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" class="p-button cancel">목록</a>
			</div>
			<div class="col-12 right">
				<a href="./updatePopupItemView.do?key=<c:out value="${key}"/>&amp;popupIemNo=${popupItemVO.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;showSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" class="p-button edit">수정</a>
				
				<a href="./deletePopupItem.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${selectedSite.siteId}"/>&amp;popupIemNo=${popupItemVO.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;showSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" onclick="fn_deletePopupItem(this.href); return false;" class="p-button delete">삭제</a>
			</div>
		</div>
		
	</div>

</div>

</body>
</html>