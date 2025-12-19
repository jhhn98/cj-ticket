<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="LOG_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>접속로그</title>
	<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_log">접속로그</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">브라우저별 접속로그</span>
</div>

<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총방문 수 :  <c:out value="${totCnt}"/> HIT!</span>
		</div>

		<div class="arrRight">
		</div>
	</div>

	<div class="table_fixed_wrap is_bottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">

				<table>
					<colgroup>
						<col class="specWidth100px"/>
						<col />
						<col class="specWidth80px"/>
						<col class="specWidth80px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">일별</th>
						<th scope="col">그래프</th>
						<th scope="col">접속 수</th>
						<th scope="col">비율</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="conectLog" items="${conectLogList}" varStatus="status">
						<tr>
							<td class="textACenter"><c:out value="${conectLog.itemNm}"/></td>
							<td>
								<div style="width:<c:out value="${conectLog.rate}"/>%; background-color:#B30000; height:5px; margin-bottom:2px">&nbsp;</div>
								<div style="width:<c:out value="${conectLog.rate2}"/>%; background-color:#00AFE9; height:5px">&nbsp;</div>
							</td>
							<td class="textARight"><c:out value="${conectLog.cnt}"/></td>
							<td class="textARight"><c:out value="${conectLog.rate}"/> %</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(conectLogList) == 0}">
						<tr>
							<td colspan="4" class="textACenter">로그가 없습니다.</td>
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