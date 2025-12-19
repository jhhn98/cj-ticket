<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_3" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>

<title>NEO Administrator - MimeType</title>
<meta name="decorator" content="neo" />


</head>
<body>


<div class="page_location">
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">마임타입관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title">${mimeType.mimeTypeNm}</span>
</div>


<div class="contents">

	<table>
	<colgroup>
		<col class="specWidth120px"/>
		<col/>
	</colgroup>
	<tbody>
		<tr>
			<th>마임타입 이름</th>
			<td>${mimeType.mimeTypeNm}</td>
		</tr>
		<tr>
			<th>마임타입 확장자</th>
			<td>${mimeType.mimeTypeExt}</td>
		</tr>
		<tr>
			<th>마임타입 설명</th>
			<td>${mimeType.mimeTypeInfo}</td>
		</tr>
		<tr>
			<th>최초등록시점</th>
			<td>${mimeType.frstRegisterPnttm}</td>
		</tr>
		<tr>
			<th>최초등록자ID</th>
			<td>${mimeType.frstRegisterId}</td>
		</tr>
		<tr>
			<th>최종수정시점</th>
			<td>${mimeType.lastUpdusrPnttm}</td>
		</tr>
		<tr>
			<th>최종수정자ID</th>
			<td>${mimeType.lastUpdusrId}</td>
		</tr>
	</tbody>
	</table>

	<div class="clearfix topMargin">
		<div class="floatLeft">
			<a href="./selectMimeTypeList.do?pageUnit=${mimeTypeVO.pageUnit}&amp;pageIndex=${mimeTypeVO.pageIndex}&amp;searchCnd=${mimeTypeVO.searchCnd}&amp;searchKrwd=${mimeTypeVO.searchKrwd}" class="iconButton"><span>목록</span></a>
		</div>
		<div class="floatRight">
		</div>
	</div>
</div>
</body>
</html>