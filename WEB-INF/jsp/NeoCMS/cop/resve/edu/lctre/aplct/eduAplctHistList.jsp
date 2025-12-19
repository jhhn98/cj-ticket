<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<title>교육 &gt; <c:out value="${menuInfo.cntntsNm}"/> &gt; 수강생 수강이력</title>
</head>
<body>

<div class="p-wrap">
<div class="col-22">
	<div class="row p-relative">
		<div class="col-6 margin_t_5">
			<a href="./selectEduAplctHistList.do?eduAplyNo=${eduAplctVO.eduAplyNo}&key=${key}" title="목록 초기화">
			<span>총 <strong><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###"/></strong> 건</span> 
			<span class="division_line">[ <strong><c:out value="${paginationInfo.currentPageNo}"/></strong> / <c:out value="${paginationInfo.totalPageCount}"/> 페이지 ]</span>
			</a>
		</div>
		<div class="col-18 right">
			<form method="get" action="./selectEduAplctHistList.do">
			<fieldset>
				<legend>수강이력 검색</legend>
				<input type="hidden" name="key" value="${key}"/>
				<input type="hidden" name="eduAplyNo" value="${eduAplctVO.eduAplyNo}"/>
				<input name="searchApplNm" value="${eduAplctVO.searchApplNm}" title="신청자명 입력" placeholder="신청자명 입력" class="p-input p-input--auto"/>
				<button type="submit" class="p-button p-button--small primary">검색</button>
			</fieldset>
			</form>
		</div>
	</div>

	<div>
		<span class="p-icon p-icon__info-circle">주의사항</span>
		과목 기준으로 수강생의 이력이 표출됩니다.
	</div>

	<table class="p-table p-table--bordered">
		<colgroup>
			<col class="w60">
			<col class="w150">
			<col class="w100">
			<col>
			<col class="w100">
			<col class="w120">
			<col class="w120">
			<col class="w120">
			<col class="w100">
		</colgroup>
		<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">교육기관</th>
			<th scope="col">카테고리</th>
			<th scope="col">강좌명</th>
			<th scope="col">신청자</th>
			<th scope="col">생년월일</th>
			<th scope="col">연락처</th>
			<th scope="col">신청일시</th>
			<th scope="col">예약상태</th>
		</tr>
		</thead>
		<tbody class="text_center">
		<c:set var="pageNo" value="${paginationInfo.currentPageStartNo}" />
		<c:forEach var="result" items="${eduAplctHistList}" varStatus="status">
		<tr>
			<td><c:out value="${pageNo}"/></td>	
			<td><c:out value="${result.insttNm}"/></td>
			<td><c:out value="${result.ctgryNm}"/></td>
			<td class="p-subject">
				<a href="./updateEduAplctView.do?eduAplyNo=${result.eduAplyNo}&amp;<c:out value="${eduAplctVO.params}"/>">
				<c:out value="${result.lctreNm}"/></a>
			</td>
			<td><c:out value="${result.applNm}"/></td>
			<td><c:out value="${result.birthDe}"/></td>
			<td><c:out value="${result.telNo}"/></td>
			<td><c:out value="${result.applDtMs}"/></td>
			<td><c:out value="${resveSttusCdMap[result.resveSttusCd]}"/></td>
		</tr>
			<c:set var="pageNo" value="${pageNo-1}" />
		</c:forEach>
		<c:if test="${fn:length(eduAplctHistList) == 0}">
		<tr>
			<td colspan="9" class="empty">등록된 수강이력이 없습니다</td>
		</tr>
		</c:if>
		</tbody>
	</table>
	
	<div class="row margin_t_10">
		<div class="col-16">
			<ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./${menuInfo.siteId}/selectEduAplctHistList.do?eduAplyNo=${eduAplctVO.eduAplyNo}&amp;${fn:escapeXml(eduAplctVO.paramsExclPi)}&amp;pageIndex=" />
		</div>
		<div class="col-8 right">
			<a href="javascript:window.history.back();" class="p-button info">신청자관리</a>
		</div>
	</div>
</div>
</div>

<script nonce="NEOCMSSCRIPT">
</script>
</body>
</html>