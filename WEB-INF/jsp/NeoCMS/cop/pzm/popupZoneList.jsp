<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>팝업존관리 목록</title>
	<meta name="decorator" content="neo" />
	<script nonce="NEOCMSSCRIPT">
		function fn_changeSite( val ) {
			window.location = "./selectPopupZoneList.do?siteId=" + val;
		}
	</script>
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">팝업존관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${selectedSite.siteNm}"/>(<span class="em_red"><c:out value="${selectedSite.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">목록</span>
</div>
<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">등록된 팝업존 수 : <c:out value="${fn:length(popupZoneList)}"/> 건</span>
		</div>
		<div class="arrRight"></div>
	</div>
	<div class="table_fixed_wrap is_topBottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth40px"/>
						<col class="specWidth100px"/>
						<col/>
						<col class="specWidth100px"/>
						<col class="specWidth160px"/>
						<col class="specWidth100px"/>
						<col class="specWidth80px"/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">사이트명</th>
						<th scope="col">팝업존이름</th>
						<th scope="col">팝업존항목수</th>
						<th scope="col">이미지크기(가로 * 세로)</th>
						<th scope="col">파라미터</th>
						<th scope="col">등록일</th>
						<th scope="col">수정</th>
						<th scope="col">삭제</th>
					</tr>
					</thead>
					<tbody class="textACenter">
					<c:set var="sNumber" value="${fn:length(popupZoneList)}" />
					<c:forEach var="result" items="${popupZoneList}" varStatus="status">
						<tr data-display="true">
							<td class="textARight"><c:out value="${sNumber}"/></td>
							<td><c:out value="${siteInfoMap[result.siteId]}"/></td>
							<td class="textALeft"><a href="./selectPopupZoneItemList.do?siteId=<c:out value="${popupZone.siteId}"/>&amp;popupZoneNo=<c:out value="${result.popupZoneNo}"/>" class="iconTextLink info"><c:out value="${result.popupZoneNm}"/></a></td>
							<td class="textARight"><c:out value="${result.popupZoneIemCo}"/></td>
							<td><c:out value="${result.imageWidthSize}"/>px * <c:out value="${result.imageHeightSize}"/>px</td>
							<td>&amp;popupZoneNo=<c:out value="${result.popupZoneNo}"/></td>
							<td><c:out value="${result.frstRegisterPnttmYMD}"/></td>
							<td><a href="./updatePopupZoneView.do?siteId=<c:out value="${popupZone.siteId}"/>&amp;popupZoneNo=<c:out value="${result.popupZoneNo}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
							<td><a href="./deletePopupZone.do?siteId=<c:out value="${popupZone.siteId}"/>&amp;popupZoneNo=<c:out value="${result.popupZoneNo}"/>" onclick="fn_deletePopupZone(this.href); return false;" class="iconTextButton delete small"><span>삭제</span></a></td>
						</tr>
						<c:set var="sNumber" value="${sNumber-1}" />
					</c:forEach>
					<c:if test="${fn:length(popupZoneList) == 0}">
						<tr>
							<td colspan="9">등록된 팝업존이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft"></div>
		<div class="arrRight">
			<a href="./addPopupZoneView.do?siteId=<c:out value="${popupZone.siteId}"/>" class="iconTextButton write"><span>등록</span></a>
		</div>
	</div>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
	function fn_deletePopupZone( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>
</body>
</html>
