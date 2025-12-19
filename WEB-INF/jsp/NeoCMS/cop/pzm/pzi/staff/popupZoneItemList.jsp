<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title><c:out value="${popupZone.popupZoneNm}"/> 팝업존항목관리 목록</title>
	<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<script nonce="NEOCMSSCRIPT">
	function fn_deletePopupZoneItem( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>

<div class="p-wrap">
	
	<div class="row p-relative">
		<div class="col-6 margin_t_5">
			<span>조회된 팝업 항목 수 <strong>${paginationInfo.totalRecordCount}</strong> 건</span>
			, <span class="division_line">페이지 <strong>${paginationInfo.currentPageNo}</strong> / ${paginationInfo.totalPageCount}</span>
		</div>
		<div class="col-18 right">
	
			<form:form modelAttribute="popupZoneItemVO" name="popupZoneItemVOForm" method="get">
			<input type="hidden" name="key" id="key2" value="<c:out value="${key}"/>" />
			<form:hidden path="siteId" />
			<form:hidden path="popupZoneNo" />
			
			<form:select path="pageUnit" class="p-input  p-input--auto">
				<form:option value="10">10 페이지</form:option>
				<form:option value="20">20 페이지</form:option>
				<form:option value="30">30 페이지</form:option>
				<form:option value="40">40 페이지</form:option>
				<form:option value="50">50 페이지</form:option>
			</form:select>

			<form:select path="searchShowSe" class="p-input  p-input--auto">
				<form:option value="">표시구분 전체</form:option>
				<form:option value="always">표시중인항목(항상표시, 기간)</form:option>
				<form:option value="displayNone">표시중이지않은항목(표시안함,기간)</form:option>
				<form:option value="doNotShow">표시안함</form:option>
				<form:option value="periodDate">기간에 따라표시</form:option>
			</form:select>

			<form:select path="searchCnd" class="p-input  p-input--auto">
				<form:option value="all">검색단어 전체</form:option>
				<form:option value="popupZoneIemNm">제목</form:option>
				<form:option value="imageReplcText">대체텍스트</form:option>
			</form:select>
			<form:input path="searchKrwd" class="p-input  p-input--auto" style="width:auto;"/>
			<button type="submit" class="p-button p-button--small primary">검색</button>
			</form:form>

		</div>
	</div>
	
	<table class="p-table p-table--bordered">
		<colgroup>
			<col style="width:70px;" />
			<col style="width:450px;" />
			<col />
			<col style="width:70px;" />
			<col style="width:110px;" />
			<col style="width:80px;" />
			<col style="width:80px;" />
		</colgroup>
		<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">이미지</th>
			<th scope="col">제목</th>
			<th scope="col">표시구분</th>
			<th scope="col">등록일</th>
			<th scope="col">수정</th>
			<th scope="col">삭제</th>
		</tr>
		</thead>
		<tbody class="text_center">
	<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
	<c:forEach var="result" items="${popupZoneItemList}" varStatus="status">
		<tr data-display="true">
			<td><c:out value="${currentPageStartNo}"/></td>
			<td><img src="/DATA/popup/<c:out value="${result.imageFileNm}"/>" /></td>
			<td class="text_left">
				<div>
					<a href="./selectPopupZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;popupZoneIemNo=<c:out value="${result.popupZoneIemNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" class="iconTextLink info"><c:out value="${result.popupZoneIemNm}"/></a>
				</div>
				<c:if test="${result.linkUrl ne '' and result.linkUrl ne null}">
				<div>
					<a href="<c:out value="${result.linkUrl}"/>" target="_blank" class="iconTextLink site"><c:out value="${result.linkUrl}"/></a>
				</div>
				</c:if>
			</td>
			<td>
				<c:out value="${showSeMap[result.showSe]}"/>
				<c:if test="${'periodDate' eq result.showSe}">
					<br/>
				</c:if>
			</td>
			<td><c:out value="${result.frstRegisterPnttmYMD}"/></td>
			<td>
				<a href="./updatePopupZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;popupZoneIemNo=<c:out value="${result.popupZoneIemNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" class="p-button p-button--xsmall edit">수정</a>
			</td>
			<td>
				<a href="./deletePopupZoneItem.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;popupZoneIemNo=<c:out value="${result.popupZoneIemNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" onclick="fn_deletePopupZoneItem(this.href); return false;" class="p-button p-button--xsmall delete">삭제</a>
			</td>
		</tr>
		<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
	</c:forEach>
	<c:if test="${fn:length(popupZoneItemList) == 0}">
		<tr>
			<td colspan="7" class="text_center">등록된 팝업 항목이 없습니다.</td>
		</tr>
	</c:if>
		</tbody>
	</table>
	
	<div class="row margin_t_20">
		<div class="col-12">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="board" jsFunction="./selectPopupZoneItemList.do?siteId=${tsu:xssLinkFilter(popupZoneItemVO.siteId)}&amp;popupZoneNo=${tsu:xssLinkFilter(popupZoneItemVO.popupZoneNo)}&amp;pageUnit=${tsu:xssLinkFilter(popupZoneItemVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(popupZoneItemVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(popupZoneItemVO.searchKrwd)}&amp;searchShowSe=${tsu:xssLinkFilter(popupZoneItemVO.searchShowSe)}&amp;key=${key}&amp;pageIndex=" />
		</div>
		<div class="col-12 right">
			<a href="./selectPopupZoneList.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;key=<c:out value="${key}"/>" class="p-button cancel">팝업존 목록</a>
            <a href="./sortPopupZoneItemView.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;key=<c:out value="${key}"/>" class="p-button edit">순서변경</a>
			<a href="./addPopupZoneItemView.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>&amp;key=<c:out value="${key}"/>" class="p-button p-button-small write">등록</a>
		</div>
	</div>

</div>

</body>
</html>
