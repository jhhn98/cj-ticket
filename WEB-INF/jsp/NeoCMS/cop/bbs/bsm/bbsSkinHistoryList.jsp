<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_2" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 스킨 &gt; 수정 내역 리스트</title>
<meta name="decorator" content="neo" />
<script nonce="NEOCMSSCRIPT">
    <%--
    $(window).resize(sizeContent);
    function sizeContent() {
        var newHeight = ($(window).height() - $("#subHeader").height() - $("#subMenu").height() - $("#fileInfo").height() - 60) + "px";
        $("#contentsCn").css("height", newHeight);
    }
    $(document).ready(sizeContent);
    --%>
    function fn_restoreContents( url ) {
        if( confirm("선택한 콘텐츠로 복원하시겠습니까?") ) {
            window.location = url;
        }
    }
</script>
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_board">게시판관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">게시판스킨</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title">스킨 수정 이력(<span class="em_red eng_text"><c:out value="${bbsSkinHistory.skinId}"/></span>)</span>
</div>
<div class="tab_navigation" id="subMenu">
	<a href="./updateSkinEditorView.do?skinId=<c:out value="${bbsSkinHistory.skinId}"/>&ftlName=<c:out value="${bbsSkinHistory.ftlName}"/>"><span>FTL 편집</span></a>
	<a href="./selectSkinHistoryList.do?skinId=<c:out value="${bbsSkinHistory.skinId}"/>&ftlName=<c:out value="${bbsSkinHistory.ftlName}"/>" class="current"><span>스킨 수정 이력</span></a>
	<a href="./selectSkinHistoryDiff.do?skinId=<c:out value="${bbsSkinHistory.skinId}"/>&ftlName=<c:out value="${bbsSkinHistory.ftlName}"/>"><span>스킨 버전별 비교</span></a>
</div>
<div class="tab_navigation_lank">
	<a href="?skinId=<c:out value="${bbsSkinHistory.skinId}"/>&ftlName=list" class=" <c:out value="${bbsSkinHistory.ftlName eq 'list' || empty bbsSkinHistory.ftlName  ? 'current' : ''}" />"><span>list.ftl</span></a>
	<a href="?skinId=<c:out value="${bbsSkinHistory.skinId}"/>&ftlName=regist" class=" <c:out value="${bbsSkinHistory.ftlName eq 'regist' ? 'current' : ''}" /> "><span>regist.ftl</span></a>
	<a href="?skinId=<c:out value="${bbsSkinHistory.skinId}"/>&ftlName=updt" class=" <c:out value="${bbsSkinHistory.ftlName eq 'updt' ? 'current' : ''}" /> "><span>updt.ftl</span></a>
	<a href="?skinId=<c:out value="${bbsSkinHistory.skinId}"/>&ftlName=view" class=" <c:out value="${bbsSkinHistory.ftlName eq 'view' ? 'current' : ''}" /> "><span>view.ftl</span></a>
	<a href="?skinId=<c:out value="${bbsSkinHistory.skinId}"/>&ftlName=reply" class=" <c:out value="${bbsSkinHistory.ftlName eq 'reply' ? 'current' : ''}" /> "><span>reply.ftl</span></a>
</div>
<div class="contents">
	<div class="table_fixed_wrap is_bottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth80px"/>
						<col/>
						<col/>
						<col/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">수정일</th>
						<th scope="col">수정자</th>
						<th scope="col">복원</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td class="textACenter"><span class="basic_site check">현재적용중</span></td>
						<td><c:out value="${lastUpdtDate}"/></td>
						<td class="textACenter">LIVE버전</td>
						<td class="textACenter"></td>
					</tr>
					<% /*
		<tr>
			<td class="textACenter"><img src="./images/check.png"/></td>
			<td>${menu.cntntsLastUpdusrPnttmYMDHMS}</td>
			<td class="textACenter">${menu.cntntsWrterNm}(<span class="em_red">${menu.cntntsWrterId}</span>)</td>
			<td class="textACenter"><a href="./viewContentsHtml.do?siteId=${menu.siteId}&amp;menuNo=${menu.menuNo}" class="button"><span>HTML보기</span></a></td>
			<td class="textACenter"><a href="/${menu.siteId}/contents.do?key=${menu.menuNo}" class="button blue" target="_blank"><span>미리보기</span></a></td>
			<td class="textACenter"></td>
		</tr> */ %>
					<c:set var="sNumber" value="${bbsSkinHistoryTotCnt}"/>
					<c:forEach var="result" items="${bbsSkinHistoryList}" varStatus="status">
						<tr>
							<td class="textARight"><c:out value="${sNumber}"/></td>
							<td><c:out value="${result.skinLastUpdusrPnttmYMDHMS}"/></td>
							<td class="textACenter"><c:out value="${not empty result.lastUpdusrId ? result.lastUpdusrId : result.frstRegisterId}"/></td>
							<td class="textACenter"><a href="restoreBbsSkinHistory.do?skinId=<c:out value="${bbsSkinHistory.skinId}"/>&ftlName=<c:out value="${bbsSkinHistory.ftlName}"/>&skinHistNo=<c:out value="${result.skinHistNo}"/>" onclick="fn_restoreContents(this.href); return false;" class="iconTextButton history_back small"><span>복원</span></a></td>
						</tr>
						<c:set var="sNumber" value="${sNumber-1}"/>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<p class="info_text">* 복원을 진행할 경우 현재 FTL파일은 백업본으로 DB에저장되며 선택한 버전을 FTL파일에 덮어씁니다.</p>
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