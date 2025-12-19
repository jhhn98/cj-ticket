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
<title>배너존항목관리 목록</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>
<div class="contents">
	<script nonce="NEOCMSSCRIPT">
		function fn_deleteBannerZoneItem( url ) {
			if( confirm("삭제하시겠습니까?") ) {
				window.location = url;
			}
		}
	</script>
	<div class="row p-relative">
		<div class="col-4 margin_t_5">
            <div class="table_text">조회된 배너 항목 수 : <c:out value="${paginationInfo.totalRecordCount}"/>건</div>
        </div>
		<div class="col-20 right">
			<form:form modelAttribute="bannerZoneItemVO" name="bannerZoneItemVOForm" method="get">
				<input type="hidden" name="key" id="key2" value="<c:out value="${key}"/>" />
				<form:hidden path="siteId" />
				<form:hidden path="bannerZoneNo" />

				<form:select path="searchShowSe" class="p-input  p-input--auto">
					<form:option value="">표시구분 전체</form:option>
					<form:option value="always">표시중인항목(항상표시, 기간)</form:option>
					<form:option value="doNotShow">표시안함</form:option>
					<form:option value="periodDate">기간에 따라표시</form:option>
				</form:select>

				<form:hidden path="searchCnd" />
				<form:input path="searchKrwd" class="p-input  p-input--auto"/>
				<button type="submit" class="p-button p-button--small primary">검색</button>
				<a href="./sortBannerZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>" class="p-button p-button-small edit">순서변경</a>
			</form:form>
		</div>
	</div>
	<table class="p-table p-table--bordered">
		<colgroup>
			<col style="width:70px" />
			<col style="width:<c:out value="${bannerZone.imageWidthSize+20}"/>px"/>
			<col/>
			<col style="width:110px" />
			<col style="width:110px" />
			<col style="width:70px" />
			<col style="width:70px" />
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
		<tbody class="textACenter">
		<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
		<c:forEach var="result" items="${bannerZoneItemList}" varStatus="status">
			<tr data-display="true">
				<td><c:out value="${currentPageStartNo}"/></td>
				<td><img src="/DATA/banner/<c:out value="${result.imageFileNm}"/>" width="<c:out value="${bannerZone.imageWidthSize}"/>" height="<c:out value="${bannerZone.imageHeightSize}"/>"/></td>
				<td class="textALeft">
					<div>
						<a href="./selectBannerZoneItemView.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;key=<c:out value="${key}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;bannerZoneIemNo=<c:out value="${result.bannerZoneIemNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="iconTextLink info"><c:out value="${result.bannerZoneIemNm}"/></a>
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
					</c:if>
				</td>
				<td><c:out value="${result.frstRegisterPnttmYMD}"/></td>
				<td><a href="./updateBannerZoneItemView.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;key=<c:out value="${key}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;bannerZoneIemNo=<c:out value="${result.bannerZoneIemNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="p-button p-button--xsmall edit"><span>수정</span></a></td>
				<td><a href="./deleteBannerZoneItem.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;key=<c:out value="${key}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;bannerZoneIemNo=<c:out value="${result.bannerZoneIemNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" onclick="fn_deleteBannerZoneItem(this.href); return false;" class="p-button p-button--xsmall delete"><span>삭제</span></a></td>
			</tr>
			<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
		</c:forEach>
		<c:if test="${fn:length(bannerZoneItemList) == 0}">
			<tr>
				<td colspan="7" class="textACenter">등록된 배너 항목이 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>

	<div class="row margin_t_20">
		<div class="col-12">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="board" jsFunction="./selectBannerZoneItemList.do?siteId=${tsu:xssLinkFilter(bannerZoneItemVO.siteId)}&amp;key=${tsu:xssLinkFilter(key)}&amp;bannerZoneNo=${tsu:xssLinkFilter(bannerZoneItemVO.bannerZoneNo)}&amp;pageUnit=${tsu:xssLinkFilter(bannerZoneItemVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(bannerZoneItemVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(bannerZoneItemVO.searchKrwd)}&amp;searchShowSe=${tsu:xssLinkFilter(bannerZoneItemVO.searchShowSe)}&amp;pageIndex=" />
		</div>
		<div class="col-12 right">
            <a href="./selectBannerZoneList.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;key=<c:out value="${key}"/>" class="p-button lis"><span>배너존 목록</span></a>
			<a href="./addBannerZoneItemView.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;key=<c:out value="${key}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="p-button write"><span>등록</span></a>
		</div>
	</div>
</div>


</body>
</html>
