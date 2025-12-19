<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<c:set var="active_menu" value="USR_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>NEO Administrator - UserLoginLog</title>
<meta name="decorator" content="neo" />


</head>
<body>

<table>
<script src="/neo/js/calendar.js"></script>

<h1 class="subHeader">사용자정보 &gt; 개인정보처리 이력</h1>

<div class="clearfix topMargin">
	<div class="floatLeft">
		총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건
	</div>
	<div class="floatRight">
	<c:if test="${null eq param.userId || '' eq param.userId}">
		<c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/>
	</c:if>
	</div>
</div>

<table>
	<thead>
	<tr>
		<th scope="col">번호</th>
		<th scope="col">취급자 ID</th>
		<th scope="col">취급자 이름</th>
		<th scope="col">취급자 IP</th>
		<th scope="col">다운로드 파일명</th>
		<th scope="col">기간</th>
		<th scope="col">이력 수</th>
		<th scope="col">다운로드 시점</th>
	</tr>
	</thead>
	<tbody>
<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
<c:forEach var="result" items="${indvdlinfoDwldHistList}" varStatus="status">
	<tr>
		<td class="textARight"><c:out value="${currentPageStartNo}"/></td>
		<td class="textACenter" style="background-color:#F6F7F8"><c:out value="${result.agentInfoId}"/></td>
		<td class="textACenter" style="background-color:#F6F7F8"><c:out value="${result.agentInfoNm}"/></td>
		<td class="textACenter"><c:out value="${result.agentIp}"/></td>
		<td class="textACenter"><c:out value="${result.dwldFileNm}"/></td>
		<td class="textACenter">
			<c:out value="${tsu:toDateFormat(result.histPdBgnde, 'yyyyMMdd', 'yyyy년 MM월 dd일')}"/>
			~
			<c:out value="${tsu:toDateFormat(result.histPdEndde, 'yyyyMMdd', 'yyyy년 MM월 dd일')}"/>
		</td>
		<td class="textACenter"><c:out value="${result.histCo}"/></td>
		<td class="textACenter"><c:out value="${tsu:toDateFormat(result.dwldPnttm,'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/></td>
	</tr>
	<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
</c:forEach>
<c:if test="${fn:length(indvdlinfoDwldHistList) == 0}">
	<tr>
		<td colspan="8" class="textACenter">개인정보처리 다운로드 이력이 없습니다.</td>
	</tr>
</c:if>
	</tbody>
</table>

<div class="clearfix topMargin">
	<div class="floatLeft">
	<c:if test="${null eq param.userId || '' eq param.userId}">
		<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectIndvdlinfoDwldHistList.do?pageUnit=${tsu:xssLinkFilter(indvdlinfoDwldHist.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(indvdlinfoDwldHist.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(indvdlinfoDwldHist.searchKrwd)}&amp;pageIndex=" />
	</c:if>
	</div>
	<div class="floatRight">
		<a href="./selectIndvdlinfoHistList.do" class="iconButton"><span>개인정보처리 이력 목록</span></a>
	</div>
</div>

</body>
</html>

