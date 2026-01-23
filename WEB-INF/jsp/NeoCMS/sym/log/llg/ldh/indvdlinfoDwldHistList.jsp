<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="LOG_4" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>개인정보 엑셀 다운로드 이력</title>
	<meta name="decorator" content="neo" />

</head>
<body>

<script src="/neo/js/calendar.js"></script>

<div class="page_location">
	<span class="depth1_title icon_log">접속로그</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">개인정보 엑셀 다운로드 이력</span>
</div>

<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
		</div>
		<div class="arrRight">
			<c:if test="${null eq param.userId || '' eq param.userId}">
				<c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/>
			</c:if>
		</div>
	</div>

	<div class="table_fixed_wrap is_topBottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth50px"/>
						<col class="specWidth100px"/>
						<col class="specWidth100px"/>
						<col />
						<col />
						<col class="specWidth200px"/>
						<col class="specWidth200px"/>
						<col class="specWidth100px"/>
						<col class="specWidth150px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">취급자 ID</th>
						<th scope="col">취급자 이름</th>
						<th scope="col">취급자 IP</th>
						<th scope="col">다운로드 파일명</th>
						<th scope="col">사유</th>
						<th scope="col">기간</th>
						<th scope="col">이력 수</th>
						<th scope="col">다운로드 시점</th>
					</tr>
					</thead>
					<tbody>
					<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
					<c:forEach var="result" items="${indvdlinfoDwldHistList}" varStatus="status">
						<tr data-display="true">
							<td class="textACenter"><c:out value="${currentPageStartNo}"/></td>
							<td class="textACenter"><c:out value="${result.agentInfoId}"/></td>
							<td class="textACenter"><c:out value="${result.agentInfoNm}"/></td>
							<td class="textACenter"><c:out value="${result.agentIp}"/></td>
							<td class="textACenter"><c:out value="${result.dwldFileNm}"/></td>
							<td class="textACenter"><c:out value="${result.dwldResn}"/></td>
							<td class="textACenter">
								<c:if test="${not empty result.histPdBgnde}">
									<c:out value="${tsu:toDateFormat(result.histPdBgnde, 'yyyyMMdd', 'yyyy년 MM월 dd일')}"/>
									~
									<c:out value="${tsu:toDateFormat(result.histPdEndde, 'yyyyMMdd', 'yyyy년 MM월 dd일')}"/>
								</c:if>&nbsp;
							</td>
							<td class="textACenter"><c:out value="${result.histCo}"/></td>
							<td class="textACenter"><c:out value="${tsu:toDateFormat(result.dwldPnttm,'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/></td>
						</tr>
						<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
					</c:forEach>
					<c:if test="${fn:length(indvdlinfoDwldHistList) == 0}">
						<tr>
							<td colspan="9" class="textACenter">개인정보 엑셀 다운로드 이력이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<c:if test="${null eq param.userId || '' eq param.userId}">
				<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectIndvdlinfoDwldHistList.do?pageUnit=${tsu:xssLinkFilter(indvdlinfoDwldHist.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(indvdlinfoDwldHist.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(indvdlinfoDwldHist.searchKrwd)}&amp;pageIndex=" />
			</c:if>
		</div>
		<div class="arrRight">
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

