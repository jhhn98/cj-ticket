<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>


<meta name="decorator" content="neo" />
<link rel="stylesheet" href="./css/popup.css" />
	<link rel="stylesheet" href="./css/neo.css" />
	<link rel="stylesheet" href="./css/subheader.css" />
	<link rel="stylesheet" href="./css/treeview.css" />
	<script src="/neo/js/jquery-3.6.0.min.js"></script>
	<script src="./js/common.js"></script>

<script src="./js/treeview.js"></script>
</head>
<body>

<h1>메뉴검색</h1>

<!-- 메뉴검색 폼  -->
<div id="searchForm">
	<form:form modelAttribute="menuVO" name="menuForm" action="popupMenuTreeView.do" method="post">
		<form:hidden path="upperMenuNo"/>
		<form:hidden path="siteId"/>
		<form:input path="searchKrwd"/>
	</form:form>
</div>

<c:if test="${empty menuVO.searchKrwd}">
<!-- 트리메뉴 구조 -->
<script nonce="NEOCMSSCRIPT">
//하위메뉴 목록 불러오기(json)
function fn_jsonlwprtMenuList(menuNo) {
	fn_getAjax( "./jsonLwprtMenuList.do?siteId=<c:out value="${menuVO.siteId}"/>&menuNo=" + menuNo, "json", fn_setMenuList );
}
</script>
	<div class="treeView"><div class="box">
		<span class="topNode"><a href="#" onclick="fn_menuSelect('<c:out value="${bestMenu.menuNo}"/>','<c:out value="${bestMenu.menuNm}"/>')"><c:out value="${bestMenu.menuNm}"/></a></span>
		<ul id="menuNo_<c:out value="${bestMenu.menuNo}"/>"></ul>
	</div></div>
	<script nonce="NEOCMSSCRIPT">
		$(document).ready(function() {
			fn_jsonlwprtMenuList('<c:out value="${bestMenu.menuNo}"/>');
		});
	</script>
</c:if>

<script nonce="NEOCMSSCRIPT">

	var tmpMenuNo = "<c:out value="${menuVO.upperMenuNo}"/>";

	function fn_menuSelect( menuNo, menuNm ) {
		if( tmpMenuNo == menuNo ) {
			alert("기존과 동일한 상위메뉴를 선택하셨습니다.");
		} else {
			$("#upperMenuNo", opener.document).val(menuNo);
			$("#upperMenuNm", opener.document).text(menuNm);
			window.close();
		}
	}

</script>

<c:if test="${!empty menuVO.searchKrwd}">
<!-- 리스트 구조 -->
<div class="treeView">
<div class="box">
	<ul>
<c:forEach var="menuSearchList" items="${menuSearchList}" varStatus="status">
	<li class="first">
		<img src="./images/icon_<c:out value="${menuSearchList.menuTy}"/><c:if test="${'N' eq menuSearchList.menuShowAt}">_x</c:if>.gif" />
		<a href="#" onclick="fn_menuSelect('<c:out value="${menuSearchList.menuNo}"/>','<c:out value="${menuSearchList.menuNm}"/>')" <c:if test="${'N' eq menuSearchList.menuShowAt}">class="hid"</c:if>><c:out value="${menuSearchList.menuNm}"/></a>
	</li>
</c:forEach>
	</ul>
</div>
</div>
</c:if>

</body>
</html>