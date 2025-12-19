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
<meta name="decorator" content="staff" />
<title><c:out value="${menuInfo.cntntsNm}"/> 목록</title>
</head>
<body>

<div class="p-wrap">
	
	<div class="row">
		<div class="col-6">
			<span class="p-total__number">
				총 콘텐츠 <em class="em_black" data-mask="#,##0" data-mask-reverse="true">${paginationInfo.totalRecordCount}</strong></em>건  
				&nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]
			</span>
		</div>
		<div class="col-18 right">
			<form:form modelAttribute="contentsSearchVO" name="contentsSearchForm" method="get">
			<fieldset>
				<legend>콘텐츠 검색</legend>
				<input type="hidden" name="key" value="<c:out value="${param.key}"/>"/>
				<form:hidden path="searchCnd" value="all"/>
				<form:select path="searchSiteId" class="p-input p-input--auto" title="사이트선택">
					<form:option value="">사이트 전체</form:option>
					<c:forEach var="contentsSite" items="${contentsSiteList}">
						<option value="<c:out value="${contentsSite.siteId}"/>"><c:out value="${contentsSite.siteNm}"/>(${contentsSite.cnt})</option>
					</c:forEach>
				</form:select>
				<form:input path="searchKrwd" class="p-input p-input--auto" placeholder="메뉴명(콘텐츠) 입력"/>
				<button type="submit" class="p-button p-button--small p-button--icon primary" title="검색">
					<svg width="16" height="16" fill="#fff" focusable="false"><title>검색</title><use xlink:href="/common/images/program/p-icon.svg#search"></use></svg>
				</button>
			</fieldset>
			</form:form>
		</div>
	</div>
    
	<table class="p-table p-table--bordered">
		<caption>게시판 목록 - 번호, 메뉴, 등록 수, 관등 버튼 등 제공</caption>
		<colgroup>
			<col style="width:60px">
			<col style="width:140px">
			<col>
			<col>
			<col style="width:120px">
			<col style="width:100px">
			<col style="width:100px">
			<col style="width:100px">
			<col style="width:100px">
		</colgroup>
		<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">사이트명</th>
			<th scope="col">메뉴 경로</th>
			<th scope="col">메뉴명</th>
			<th scope="col">담당부서</th>
			<th scope="col">연락처</th>
			<th scope="col">최종수정일</th>
			<th scope="col">담당자 수정</th>
			<th scope="col">콘텐츠 수정</th>
		</tr>
		</thead>
		<tbody class="text_center">
		<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
		<c:forEach var="result" items="${contentsList}">
		<tr>
			<td>${currentPageStartNo}</td>
			<td><c:out value="${result.siteNm}"/></td>
			<td class="p-subject"><a href="/${result.siteId}/sub.do?key=<c:out value="${result.menuNo}"/>" target="_blank" class="p-external-link"><c:out value="${result.menuCours}"/></a></td>
			<td class="text_left"><c:out value="${result.menuNm}"/></td>
			<td><c:out value="${result.deptNm}"/></td>
			<td><c:out value="${result.emplTelno}"/></td>
			<td><time>${tsu:toDateFormat(result.cntntsLastUpdusrPnttm,'yyyyMMddHHmmss','yyyy-MM-dd')}</time></td>
			<td><a href="./updateContentsEmplView.do?key=<c:out value="${param.key}"/>&amp;menuNo=<c:out value="${result.menuNo}"/>&amp;<c:out value="${contentsSearchVO.params}"/>" class="p-button p-button--xsmall edit">담당자 수정</a></td>
			<td><a href="./updateContentsManageView.do?key=<c:out value="${param.key}"/>&amp;menuNo=<c:out value="${result.menuNo}"/>&amp;<c:out value="${contentsSearchVO.params}"/>" class="p-button p-button--xsmall restore">콘텐츠 수정</a></td>
		</tr>
		<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
		</c:forEach>
		<c:if test="${fn:length(contentsList) eq 0}">
		<tr>
			<td colspan="9">검색된 콘텐츠가 없습니다.</td>
		</tr>
		</c:if>
		</tbody>
	</table>
  
	<div class="row margin_t_20">
		<div class="col-12">
			<div class="p-pagination left">
				<div class="p-page">
					<ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectContentsList.do?${tsu:xssLinkFilter(contentsSearchVO.paramsWithOutPageIndex)}&amp;key=${tsu:xssLinkFilter(param.key)}&amp;pageIndex=" />
				</div>
			</div>
		</div>
		<div class="col-12 right">
			<a href="./downloadContentsXls.do?key=${param.key}" onclick="fn_downloadXls(this.href); return false;" class="p-button p-button--combine excel">다운로드</a>
		</div>
	</div>
	
  <script nonce="NEOCMSSCRIPT">
		function fn_downloadXls( url ) {
			if( confirm("콘텐츠 목록을 다운로드 하시겠습니까?") ) {
				window.location = url;
			}
		}	
	</script>
	
</div>

</body>
</html>