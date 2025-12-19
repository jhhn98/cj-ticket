<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="TMP_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>템플릿항목 목록</title>
	<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_template">템플릿설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title"><c:out value="${template.tmplatNm}"/>(<span class="em_red"><c:out value="${template.tmplatId}"/></span>)</span>
</div>

<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">템플릿항목 : <c:out value="${templateItemCnt}"/> 건</span>
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
						<col class="specWidth120px"/>
						<col class="specWidth200px"/>
						<col/>
						<col class="specWidth80px"/>
						<col class="specWidth80px"/>
						<col class="specWidth80px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">템플릿항목구분</th>
						<th scope="col">템플릿항목명</th>
						<th scope="col">템플릿항목경로</th>
						<th scope="col">수정</th>
						<th scope="col">삭제</th>
					</tr>
					</thead>
					<tbody class="textACenter">
					<c:set var="templateItemNo" value="1" />
					<c:forEach var="result" items="${templateItemList}" varStatus="status">
						<tr data-display="true">
							<td class="textARight"><c:out value="${templateItemNo}"/></td>
							<td class="eng_text textACenter"><c:out value="${result.tmplatIemSe}"/></td>
							<td><c:out value="${result.tmplatIemNm}"/></td>
							<td class="eng_text textALeft">/template/<c:out value="${result.tmplatId}"/>/<c:out value="${result.tmplatIemSe}"/>/<c:out value="${result.tmplatIemFileNm}"/>.ftl</td>
							<td class="textACenter"><a href="./updateTemplateItemView.do?tmplatId=<c:out value="${result.tmplatId}"/>&amp;tmplatIemNo=<c:out value="${result.tmplatIemNo}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
							<td class="textACenter">
								<c:if test="${!siteListAt}">
								<a href="./deleteTemplateItem.do?tmplatId=<c:out value="${result.tmplatId}"/>&amp;tmplatIemNo=<c:out value="${result.tmplatIemNo}"/>" onclick="fn_deleteItem(this.href); return false;"  class="iconTextButton delete small"><span>삭제</span></a>
								</c:if>
							</td>
						</tr>
						<c:set var="templateItemNo" value="${templateItemNo+1}" />
					</c:forEach>
					<c:if test="${fn:length(templateItemList) == 0}">
						<tr>
							<td class="textACenter" colspan="6">등록된 템플릿항목이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>


	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<a href="./selectTemplateList.do" class="iconTextButton list "><span>목록</span></a>
		</div>
		<div class="arrRight">
			<a href="./addTemplateItemView.do?tmplatId=<c:out value="${template.tmplatId}"/>" class="iconTextButton write"><span>등록</span></a>
		</div>
	</div>
</div>


<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
	function fn_deleteItem( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>
</body>
</html>
