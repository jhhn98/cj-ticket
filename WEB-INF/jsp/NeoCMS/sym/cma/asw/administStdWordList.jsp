<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_2" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>NEO Administrator - AdministStdWord</title>
<meta name="decorator" content="neo" />


</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">행정표준용어</span>
</div>


<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
			<span class="table_text">Page : <c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/></span>
		</div>
		<div class="arrRight">
			<div class="table_search">
				<form:form modelAttribute="administStdWordVO" name="searchForm" method="get">
					<span class="srch_element select">
						<form:select path="pageUnit" class="select">
							<form:option value="10">10 페이지</form:option>
							<form:option value="20">20 페이지</form:option>
							<form:option value="30">30 페이지</form:option>
							<form:option value="40">40 페이지</form:option>
							<form:option value="50">50 페이지</form:option>
						</form:select>
					</span>
					<span class="srch_element toggle">
                        <%--
						<form:radiobutton path="searchInclsAt" value="Y" label="포함" />
						<form:radiobutton path="searchInclsAt" value="N" label="포함안함" />
						--%>
                        <div class="toggle <c:out value="${administStdWordVO.searchInclsAt == 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="searchInclsAt" <c:out value="${administStdWordVO.searchInclsAt == 'Y' ? 'checked=\"checked\"':''}"/> name="searchInclsAt" value="<c:out value="${administStdWordVO.searchInclsAt eq 'Y' ? 'Y':'N'}"/>" data-true-value="Y" data-false-value="N" />
                            <label for="searchInclsAt">
                                포함
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
					</span>
					<span class="srch_element select">
						<form:select path="searchCnd" class="select">
							<form:option value="all">전체</form:option>
							<form:option value="wordNm">용어</form:option>
							<form:option value="engNm">영문용어</form:option>
							<form:option value="engAbrvNm">영문약어명</form:option>
						</form:select>
					</span>
					<span class="srch_element text">
						<form:input path="searchKrwd" cssClass="txt" placeholder="검색어 입력"/>
					</span>
					<span class="srch_element submit">
						<button type="submit" class="search_button">검색</button>
					</span>
				</form:form>
			</div>
		</div>
	</div>
	<div class="table_fixed_wrap is_topBottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth40px"/>
						<col class="specWidth60px"/>
						<col class="specWidth200px"/>
						<col class="specWidth200px"/>
						<col/>
						<col class="specWidth120px"/>
						<col class="specWidth60px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">구분</th>
						<th scope="col">주제영역</th>
						<th scope="col">용어명</th>
						<th scope="col">영문명</th>
						<th scope="col">영문약어명</th>
						<th scope="col">상태</th>
					</tr>
					</thead>
					<tbody>
					<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-display="true">
						<td class="textARight"><c:out value="${currentPageStartNo}"/></td>
						<td class="textACenter"><c:out value="${result.wordSe}"/></td>
						<td><c:out value="${result.thema}"/></td>
						<td><a href="./selectAdministStdWordView.do?wordNo=<c:out value="${result.wordNo}"/>&amp;pageUnit=<c:out value="${administStdWordVO.pageUnit}"/>&amp;searchInclsAt=<c:out value="${administStdWordVO.searchInclsAt}"/>&amp;pageIndex=<c:out value="${administStdWordVO.pageIndex}"/>&amp;searchCnd=<c:out value="${administStdWordVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${administStdWordVO.searchKrwd}"/>" class="iconTextLink info"><c:out value="${result.wordNm}"/></a></td>
						<td><c:out value="${result.engNm}"/></td>
						<td><c:out value="${result.engAbrvNm}"/></td>
						<td class="textACenter"><c:out value="${result.sttus}"/></td>
					</tr>
						<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="7">검색된 용어가 없습니다.</td>
					</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectAdministStdWordList.do?pageUnit=${tsu:xssLinkFilter(administStdWordVO.pageUnit)}&amp;searchInclsAt=${tsu:xssLinkFilter(administStdWordVO.searchInclsAt)}&amp;searchCnd=${tsu:xssLinkFilter(administStdWordVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(administStdWordVO.searchKrwd)}&amp;pageIndex=" />
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
