<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>메뉴</h1>

<c:forEach var="siteSeList" items="${siteSeList}" varStatus="status">
	<a href="./selectSiteInfoList.do?siteSe=<c:out value="${siteSeList.code}"/>"><c:out value="${siteSeList.codeNm}"/></a>
</c:forEach>

<br/>

<c:out value="${menuCnt}"/>건

<table width="100%" border="1">
	<tr>
		<th>menuNo</th>
		<th>menuLevel</th>
		<th>menuOrdr</th>
		<th>menuSortCode</th>
		<th>upperMenuNo</th>
		<th>lwprtMenuCo</th>
		<th>menuNm</th>
		<th>menuTy</th>
		<th>deptCode</th>
		<th>deptNm</th>
		<th>emplCode</th>
		<th>emplNm</th>
	</tr>
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<tr>
		<td><c:out value="${result.menuNo}"/></td>
		<td><c:out value="${result.menuLevel}"/></td>
		<td><c:out value="${result.menuOrdr}"/></td>
		<td><c:out value="${result.menuSortCode}"/></td>
		<td><c:out value="${result.upperMenuNo}"/></td>
		<td><c:out value="${result.lwprtMenuCo}"/></td>
		<td><a href="./updateMenuView.do?siteId=<c:out value="${result.siteId}"/>&amp;menuNo=<c:out value="${result.menuNo}"/>"><c:out value="${result.menuNm}"/></a></td>
		<td><c:out value="${result.menuTy}"/></td>
		<td><c:out value="${result.deptCode}"/></td>
		<td><c:out value="${result.deptNm}"/></td>
		<td><c:out value="${result.emplCode}"/></td>
		<td><c:out value="${result.emplNm}"/></td>
	</tr>
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
	<tr>
		<td colspan="13">등록된 메뉴가 없습니다.</td>
	</tr>
	</c:if>
</table>

<a href="./addMenuView.do?siteId=<c:out value="${menu.siteId}"/>&amp;upperMenuNo=3">등록</a>

</body>
</html>