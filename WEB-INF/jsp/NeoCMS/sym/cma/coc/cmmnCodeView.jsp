<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>NEO Administrator - CmmnCode</title>
<meta name="decorator" content="neo" />


</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">공통분류코드</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${cmmnClCode.clCodeNm}"/>(<span class="em_red"><c:out value="${cmmnClCode.clCode}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${cmmnCodeVO.codeIdNm}"/>(<span class="em_red"><c:out value="${cmmnCodeVO.codeId}"/></span>)</span>
</div>

<div class="tab_navigation">
	<c:forEach var="result" items="${cmmnClCodeListAll}" varStatus="status">
		<a href="./selectCmmnCodeList.do?clCode=<c:out value="${result.clCode}"/>" <c:if test="${result.clCode eq cmmnClCode.clCode}">class="current"</c:if> ><c:out value="${result.clCodeNm}"/></a></li>
	</c:forEach>
	<a href="./selectCmmnCodeSearchAll.do?searchKrwd=">공통분류코드 전체검색</a></li>
</div>

<div class="contents">

	<div class="table_fixed_wrap is_bottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">

				<table>
				<colgroup>
					<col class="specWidth120px"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<th>코드ID</th>
						<td><c:out value="${cmmnCodeVO.codeId}"/></td>
					</tr>
					<tr>
						<th>코드ID명</th>
						<td><c:out value="${cmmnCodeVO.codeIdNm}"/></td>
					</tr>
					<tr>
						<th>코드ID설명</th>
						<td><c:out value="${cmmnCodeVO.codeIdDc}"/></td>
					</tr>
				</tbody>
				</table>

			</div>
		</div>
	</div>


	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<a href="./selectCmmnCodeList.do?clCode=<c:out value="${cmmnCodeVO.clCode}"/>&amp;pageUnit=<c:out value="${cmmnCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnCodeVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
		</div>
		<div class="arrRight">
			<a href="./updateCmmnCodeView.do?clCode=<c:out value="${cmmnCodeVO.clCode}"/>&amp;pageUnit=<c:out value="${cmmnCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnCodeVO.pageIndex}"/>" class="iconTextButton edit"><span>수정</span></a>
			<a href="./deleteCmmnCode.do?clCode=<c:out value="${cmmnCodeVO.clCode}"/>&amp;pageUnit=<c:out value="${cmmnCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnCodeVO.pageIndex}"/>" class="iconTextButton delete"><span>삭제</span></a>
		</div>
	</div>
</body>
</html>