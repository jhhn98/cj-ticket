<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_1" scope="request"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">공통분류코드</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${cmmnClCode.clCodeNm}"/>(<span class="em_red"><c:out value="${cmmnClCode.clCode}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${cmmnCode.codeIdNm}"/>(<span class="em_red"><c:out value="${cmmnCode.codeId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth5_title"><c:out value="${cmmnDetailCodeVO.codeNm}"/>(<span class="em_red"><c:out value="${cmmnDetailCodeVO.code}"/></span>) 수정</span>
</div>

<div class="tab_navigation">
	<c:forEach var="result" items="${cmmnClCodeListAll}" varStatus="status">
		<a href="./selectCmmnCodeList.do?clCode=<c:out value="${result.clCode}"/>" <c:if test="${result.clCode eq cmmnClCode.clCode}">class="current"</c:if> ><c:out value="${result.clCodeNm}"/></a></li>
	</c:forEach>
	<a href="./selectCmmnCodeSearchAll.do?searchKrwd=">공통분류코드 전체검색</a></li>
</div>

<div class="contents">

	<table border="1" width="100%">
	<colgroup>
		<col width="120"/>
		<col/>
	</colgroup>
	<tbody>
		<tr>
			<th>코드</th>
			<td><c:out value="${cmmnDetailCodeVO.code}"/></td>
		</tr>
		<tr>
			<th>코드명</th>
			<td><c:out value="${cmmnDetailCodeVO.codeNm}"/></td>
		</tr>
		<tr>
			<th>코드설명</th>
			<td><c:out value="${cmmnDetailCodeVO.codeDc}"/></td>
		</tr>
	</tbody>
	</table>

	<a href="./selectCmmnDetailCodeList.do?codeId=<c:out value="${cmmnDetailCodeVO.codeId}"/>&amp;pageUnit=<c:out value="${cmmnDetailCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnDetailCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnDetailCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnDetailCodeVO.pageIndex}"/>">목록</a>
	<a href="./updateCmmnDetailCodeView.do?code=<c:out value="${cmmnDetailCodeVO.code}"/>&amp;pageUnit=<c:out value="${cmmnDetailCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnDetailCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnDetailCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnDetailCodeVO.pageIndex}"/>">수정</a>
	<a href="./deleteCmmnDetailCode.do?code=<c:out value="${cmmnDetailCodeVO.code}"/>&amp;pageUnit=<c:out value="${cmmnDetailCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnDetailCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnDetailCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnDetailCodeVO.pageIndex}"/>">삭제</a>
</div>
</body>
</html>