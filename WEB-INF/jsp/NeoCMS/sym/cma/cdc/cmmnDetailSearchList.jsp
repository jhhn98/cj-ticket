<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_1" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>NEO Administrator - CmmnDetailCode</title>
<meta name="decorator" content="neo" />
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">공통분류코드</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title">공통분류코드 전체검색</span>
</div>
<div class="tab_navigation">
	<c:forEach var="result" items="${cmmnClCodeListAll}" varStatus="status">
		<a href="./selectCmmnCodeList.do?clCode=<c:out value="${result.clCode}"/>" <c:if test="${result.clCode eq cmmnClCode.clCode}">class="current"</c:if> ><c:out value="${result.clCodeNm}"/></a></li>
	</c:forEach>
	<a href="./selectCmmnCodeSearchAll.do?searchKrwd="  class="current">공통분류코드 전체검색</a></li>
</div>
<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총 : <c:out value="${fn:length(resultList)}"/> 건</span>
		</div>
		<div class="arrRight">
			<div class="table_search">
				<form name="searchForm" method="post" action="selectCmmnCodeSearchAll.do">
					<span class="srch_element text">
						<input id="searchKrwd" name="searchKrwd" style="width:350px;" type="text" value="<c:out value="${searchKrwd}"/>"/>
					</span>
					<span class="srch_element submit">
						<button type="submit" class="search_button">검색</button>
					</span>
				</form>
			</div>
		</div>
	</div>
	<div class="table_fixed_wrap userLoginHistList">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth100px"/>
						<col class="specWidth200px"/>
						<col class="specWidth100px"/>
						<col class="specWidth200px"/>
						<col class="specWidth100px"/>
						<col class="specWidth200px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">구분코드</th>
						<th scope="col">구분코드명</th>
						<th scope="col">항목코드</th>
						<th scope="col">항목코드명</th>
						<th scope="col">상세코드</th>
						<th scope="col">상세코드명</th>
					</tr>
					</thead>
					<tbody class="textACenter">
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-display="true">
						<td ><a href="./updateCmmnClCodeView.do?clCode=<c:out value="${result.clCode}"/>" class="iconTextLink view"><span><c:out value="${result.clCode}"/></span></a></td>
						<td><c:out value="${result.clCodeNm}"/></td>
						<td><a href="./selectCmmnDetailCodeList.do?clCode=<c:out value="${result.clCode}"/>&amp;code=<c:out value="${result.code}"/>&amp;codeId=<c:out value="${result.codeId}"/>" class="iconTextLink detail"><span><c:out value="${result.codeId}"/></span></a></td>
						<td><c:out value="${result.codeIdNm}"/></td>
						<td><a href="./updateCmmnDetailCodeView.do?clCode=<c:out value="${result.clCode}"/>&amp;code=<c:out value="${result.code}"/>&amp;codeId=<c:out value="${result.codeId}"/>" class="iconTextLink set"><span><c:out value="${result.code}"/></span></a></td>
						<td><c:out value="${result.codeNm}"/></td>
					</tr>
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

</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>
</body>
</html>
