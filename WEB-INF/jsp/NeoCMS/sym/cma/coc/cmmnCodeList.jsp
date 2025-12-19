<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>NEO Administrator - CmmnCode</title>
<meta name="decorator" content="neo" />
</head>
<body>

<script nonce="NEOCMSSCRIPT">
	function fn_delete( url ) {
		return confirm("삭제하시겠습니까?");
	}
</script>
<div class="page_location">
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">공통분류코드</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${cmmnClCode.clCodeNm}"/>(<span class="em_red"><c:out value="${cmmnClCode.clCode}"/></span>)</span>
</div>

<div class="tab_navigation">
	<c:forEach var="result" items="${cmmnClCodeListAll}" varStatus="status">
		<a href="./selectCmmnCodeList.do?clCode=<c:out value="${result.clCode}"/>" <c:if test="${result.clCode eq cmmnClCode.clCode}">class="current"</c:if> ><c:out value="${result.clCodeNm}"/></a></li>
	</c:forEach>
	<a href="./selectCmmnCodeSearchAll.do?searchKrwd=">공통분류코드 전체검색</a></li>
</div>
<div class="contents">

	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
			<span class="table_text">Page : <c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/></span>
		</div>
		<div class="arrRight">
			<div class="table_search">

				<form:form modelAttribute="cmmnCodeVO" name="searchForm" method="get">
					<form:hidden path="clCode"/>

				<span class="srch_element select">
					<form:select path="pageUnit" class="select">
						<form:option value="10">10 페이지</form:option>
						<form:option value="20">20 페이지</form:option>
						<form:option value="30">30 페이지</form:option>
						<form:option value="40">40 페이지</form:option>
						<form:option value="50">50 페이지</form:option>
					</form:select>
				</span>

					<span class="srch_element select">
					<form:select path="searchCnd" class="select">
						<form:option value="all">전체</form:option>
						<form:option value="clCode">분류코드</form:option>
						<form:option value="clCodeNm">분류코드명</form:option>
					</form:select>
				</span>
					<span class="srch_element text">
					<form:input path="searchKrwd" cssClass="txt" style="width:auto;"/>
				</span>
					<span class="srch_element submit">
					<button type="submit" class="search_button">검색</button>
				</span>
				</form:form>
			</div>
		</div>
	</div>


	<div class="table_fixed_wrap userLoginHistList">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view" >

				<table>
					<colgroup>
						<col class="specWidth40px"/>
						<col class="specWidth100px"/>
						<col class="specWidth200px"/>
						<col/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">공통ID</th>
						<th scope="col">코드ID명</th>
						<th scope="col">코드ID설명</th>
						<th scope="col">수정</th>
						<th scope="col">삭제</th>
					</tr>
					</thead>
					<tbody>
					<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-display="true">
						<td class="textARight"><c:out value="${currentPageStartNo}"/></td>
						<td class="textACenter"><c:out value="${result.codeId}"/></td>
						<td><a href="./selectCmmnDetailCodeList.do?clCode=<c:out value="${result.clCode}"/>&amp;codeId=<c:out value="${result.codeId}"/>"  class="iconTextLink info"><c:out value="${result.codeIdNm}"/></a></td>
						<td><c:out value="${result.codeIdDc}"/></td>
						<td class="textACenter"><a href="./updateCmmnCodeView.do?codeId=<c:out value="${result.codeId}"/>&amp;clCode=<c:out value="${result.clCode}"/>&amp;pageUnit=<c:out value="${cmmnCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnCodeVO.pageIndex}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
						<td class="textACenter"><a onclick="fn_delete(this.href)" href="./deleteCmmnCode.do?codeId=<c:out value="${result.codeId}"/>&amp;clCode=<c:out value="${result.clCode}"/>&amp;pageUnit=<c:out value="${cmmnCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnCodeVO.pageIndex}"/>" class="iconTextButton delete small"><span>삭제</span></a></td>
					</tr>
						<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="6">검색된 공통코드가 없습니다.</td>
					</tr>
					</c:if>
					</tbody>
				</table>

			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectCmmnCodeList.do?clCode=${tsu:xssLinkFilter(cmmnCodeVO.clCode)}&amp;pageUnit=${tsu:xssLinkFilter(cmmnCodeVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(cmmnCodeVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(cmmnCodeVO.searchKrwd)}&amp;pageIndex=" />
		</div>
		<div class="arrRight">
			<a href="./addCmmnCodeView.do?clCode=<c:out value="${cmmnCodeVO.clCode}"/>&amp;pageUnit=<c:out value="${cmmnCodeVO.pageUnit}"/>&amp;pageIndex=<c:out value="${cmmnCodeVO.pageIndex}"/>&amp;searchCnd=<c:out value="${cmmnCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnCodeVO.searchKrwd}"/>" class="iconTextButton write"><span>등록</span></a>
		</div>
	</div>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>
</body>
</html>
