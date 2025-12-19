<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>NeoCMS Administrator</title>
<meta name="decorator" content="neo" />
<link rel="stylesheet" href="./css/treeview.css" />


</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">공통분류코드 관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${cmmnClCodeVO.clCode}"/></span>
</div>


<div class="contents">

	<div class="table_fixed_wrap is_bottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view" >

				<table>
				<colgroup>
					<col class="specWidth120px"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<th>분류코드</th>
						<td><c:out value="${cmmnClCodeVO.clCode}"/></td>
					</tr>
					<tr>
						<th>분류코드명</th>
						<td><c:out value="${cmmnClCodeVO.clCodeNm}"/></td>
					</tr>
					<tr>
						<th>분류코드설명</th>
						<td><c:out value="${cmmnClCodeVO.clCodeDc}"/></td>
					</tr>
				</tbody>
				</table>

			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<a href="./selectCmmnClCodeList.do?pageUnit=<c:out value="${cmmnClCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnClCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnClCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnClCodeVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
		</div>
		<div class="arrRight">
			<a href="./updateCmmnClCodeView.do?clCode=<c:out value="${cmmnClCodeVO.clCode}"/>&amp;pageUnit=<c:out value="${cmmnClCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnClCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnClCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnClCodeVO.pageIndex}"/>" class="iconTextButton edit"><span>수정</span></a>
			<a href="./deleteCmmnClCode.do?clCode=<c:out value="${cmmnClCodeVO.clCode}"/>&amp;pageUnit=<c:out value="${cmmnClCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnClCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnClCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnClCodeVO.pageIndex}"/>" class="iconTextButton delete"><span>삭제</span></a>
		</div>
	</div>
</div>
</body>
</html>