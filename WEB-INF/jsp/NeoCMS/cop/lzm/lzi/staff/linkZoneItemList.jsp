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
<title>링크존항목관리 목록</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<div class="p-wrap">
	
	<div class="row p-relative">
		<div class="col-4 margin_t_5">
			<span>총 <strong>${paginationInfo.totalRecordCount}</strong> 건</span>
			, <span class="division_line">페이지 <strong>${paginationInfo.currentPageNo}</strong> / ${paginationInfo.totalPageCount}</span>
		</div>
		<div class="col-20 right">
			<form:form modelAttribute="linkZoneItemVO" name="linkZoneItemVOForm" method="get">
			<input type="hidden" name="key" id="key2" value="<c:out value="${key}"/>" />
			<form:hidden path="siteId" />
			<form:hidden path="linkZoneNo" />

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
				<form:option value="doNotShow">표시안함</form:option>
				<form:option value="periodDate">기간에 따라표시</form:option>
			</form:select>
		
			<form:select path="searchCnd" class="p-input  p-input--auto">
				<form:option value="all">검색단어 전체</form:option>
				<form:option value="linkZoneIemNm">제목</form:option>
				<form:option value="imageReplcText">대체텍스트</form:option>
			</form:select>
		
			<form:input path="searchKrwd" style="width:auto;" class="p-input  p-input--auto" />
			<button type="submit" class="p-button p-button--small primary">검색</button>
			</form:form>

		</div>
	</div>
	
	<table class="p-table p-table--bordered">
		<colgroup>
			<col style="width:80px" />
			<col />
			<col style="width:150px" />
			<col style="width:120px" />
			<col style="width:100px" />
			<col style="width:100px" />
		</colgroup>
		<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">표시구분</th>
			<th scope="col">등록일</th>
			<th scope="col">수정</th>
			<th scope="col">삭제</th>
		</tr>
		</thead>
		<tbody class="text_center">
	<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
	<c:forEach var="result" items="${linkZoneItemList}" varStatus="status">
		<tr>
			<td><c:out value="${currentPageStartNo}"/></td>
			<td class="text_left">
				<div><a href="./selectLinkZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${linkZoneItemVO.siteId}"/>&amp;linkZoneNo=<c:out value="${linkZoneItemVO.linkZoneNo}"/>&amp;linkZoneIemNo=<c:out value="${result.linkZoneIemNo}"/>&amp;pageUnit=<c:out value="${linkZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${linkZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${linkZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${linkZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${linkZoneItemVO.pageIndex}"/>" class="iconTextLink info"><c:out value="${result.linkZoneIemNm}"/></a></div>
			<div><a href="<c:out value="${result.linkUrl}"/>" target="_blank" class="iconTextLink site eng_text"><c:out value="${result.linkUrl}"/></a></div>
			</td>
			<td>
				<c:out value="${showSeMap[result.showSe]}"/>
				<c:if test="${'periodDate' eq result.showSe}">
				</c:if>
			</td>
			<td><c:out value="${result.frstRegisterPnttmYMD}"/></td>
			<td>
				<a href="./updateLinkZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${linkZoneItemVO.siteId}"/>&amp;linkZoneNo=<c:out value="${linkZoneItemVO.linkZoneNo}"/>&amp;linkZoneIemNo=<c:out value="${result.linkZoneIemNo}"/>&amp;pageUnit=<c:out value="${linkZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${linkZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${linkZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${linkZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${linkZoneItemVO.pageIndex}"/>" class="p-button p-button--xsmall edit">수정</a>
			</td>
			<td>
				<a href="./deleteLinkZoneItem.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${linkZoneItemVO.siteId}"/>&amp;linkZoneNo=<c:out value="${linkZoneItemVO.linkZoneNo}"/>&amp;linkZoneIemNo=<c:out value="${result.linkZoneIemNo}"/>&amp;pageUnit=<c:out value="${linkZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${linkZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${linkZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${linkZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${linkZoneItemVO.pageIndex}"/>" onclick="fn_deleteLinkZoneItem(this.href); return false;" class="p-button p-button--xsmall delete">삭제</a>
			</td>
		</tr>
		<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
	</c:forEach>
	<c:if test="${fn:length(linkZoneItemList) == 0}">
		<tr>
			<td colspan="6" class="textACenter">등록된 링크 항목이 없습니다.</td>
		</tr>
	</c:if>
		</tbody>
	</table>
	
	<div class="row margin_t_20">
		<div class="col-12">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="board" jsFunction="./selectLinkZoneItemList.do?key=${key}&amp;siteId=${tsu:xssLinkFilter(linkZoneItemVO.siteId)}&amp;linkZoneNo=${tsu:xssLinkFilter(linkZoneItemVO.linkZoneNo)}&amp;pageUnit=${tsu:xssLinkFilter(linkZoneItemVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(linkZoneItemVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(linkZoneItemVO.searchKrwd)}&amp;searchShowSe=${tsu:xssLinkFilter(linkZoneItemVO.searchShowSe)}&amp;pageIndex=" />
		</div>
		<div class="col-12 right">
            <a href="./selectLinkZoneList.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${linkZoneItemVO.siteId}"/>" class="p-button cancel">링크존 목록</a>
            <a href="./sortLinkZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${linkZoneItemVO.siteId}"/>&amp;linkZoneNo=<c:out value="${linkZoneItemVO.linkZoneNo}"/>" class="p-button edit">순서변경</a>
			<a href="./addLinkZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${linkZoneItemVO.siteId}"/>&amp;linkZoneNo=<c:out value="${linkZoneItemVO.linkZoneNo}"/>&amp;pageUnit=<c:out value="${linkZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${linkZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${linkZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${linkZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${linkZoneItemVO.pageIndex}"/>" class="p-button p-button-small write">등록</a>
		</div>
	</div>

</div>

<script nonce="NEOCMSSCRIPT">
    function fn_deleteLinkZoneItem( url ) {
        if( confirm("삭제하시겠습니까?") ) {
            window.location = url;
        }
    }
</script>
</body>
</html>
