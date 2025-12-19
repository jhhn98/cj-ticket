<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="SITE_1" scope="request"/>


<!DOCTYPE html>
<html lang="ko">
<head>

	<title>사이트정보 목록</title>
	<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_site">사이트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">목록</span>
</div>
<jsp:include page="./subMenu.jsp" />

<div class="contents is_tab">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">등록된 사이트 수 : <c:out value="${siteCnt}"/>건</span>
		</div>
		<div class="arrRight">
		</div>
	</div>
	<div class="table_fixed_wrap is_topBottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth40px"/>
						<col class="specWidth40px"/>
						<col class="specWidth80px"/>
						<col class="specWidth160px"/>
						<col class="specWidth100px"/>
						<col class="specWidth240px"/>
						<col/>
						<col class="specWidth80px"/>
						<col class="specWidth160px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">기본</th>
						<th scope="col">사이트ID</th>
						<th scope="col">배치관리</th>
						<th scope="col">템플릿</th>
						<th scope="col">사이트명</th>
						<th scope="col">사이트URL</th>
						<th scope="col">활성여부</th>
						<th scope="col">사이트 관리자</th>
					</tr>
					</thead>
					<tbody>
					<c:set var="siteNo" value="1" />
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr data-display="true">
							<td class="textARight"><c:out value="${siteNo}"/></td>
							<td class="textACenter">
                        <c:if test="${'Y' eq result.dfltSiteAt}"><span class="basic_site">기본사이트</span></c:if>
							</td>
							<td class="textACenter"><c:out value="${result.siteId}"/></td>
							<td class="textACenter"><a href="./selectSiteBatchList.do?siteId=<c:out value="${result.siteId}"/>" class="iconTextButton small set"><span>배치관리</span></a></td>
							<td class="textACenter"><a href="./selectTemplateItemList.do?tmplatId=<c:out value="${result.tmplatId}"/>" class="iconTextLink view"><c:out value="${result.tmplatId}"/></a></td>
							<td><a href="./selectSiteInfoView.do?siteId=<c:out value="${result.siteId}"/>&amp;siteSe=<c:out value="${siteInfo.siteSe}"/>" class="iconTextLink info"><c:out value="${result.siteNm}"/></a></td>
							<td class="eng_text"><a href="<c:out value="${result.siteUrl}"/>" target="_blank" title="새창" class="iconTextLink site"> <c:out value="${result.siteUrl}"/></a></td>
							<td class="textACenter"><c:out value="${actvtyAtMap[result.actvtyAt]}"/></td>
							<td class="textACenter"><a href="./selectSiteMngrList.do?siteSe=<c:out value="${siteInfo.siteSe}"/>&amp;siteId=<c:out value="${result.siteId}"/>" class="iconTextButton small user_set"><span>사이트관리자</span></a></td>
						</tr>
						<c:set var="siteNo" value="${siteNo+1}" />
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="8" class="textACenter">등록된 사이트가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>

			</div>
		</div>
	</div>

	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<a href="./sortSiteInfoForm.do?siteSe=<c:out value="${siteInfo.siteSe}"/>" class="iconTextButton sort"><span>순서변경</span></a>&nbsp;
		</div>
		<div class="arrRight">
			<a href="./addSiteInfoView.do?siteSe=<c:out value="${siteInfo.siteSe}"/>" class="iconTextButton write"><span>등록</span></a>
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
