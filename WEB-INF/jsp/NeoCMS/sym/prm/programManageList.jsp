<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="PRG_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>


<meta name="decorator" content="neo" />
<link rel="stylesheet" href="./css/treeview.css" />


</head>
<body>

<script nonce="NEOCMSSCRIPT">
$(window).resize(sizeContent);
function sizeContent() {
	var newHeight = ($(window).height() - $("#header").height() - 35) + "px";
	$("#divBox").css("height", newHeight);
}
$(document).ready(sizeContent);

function fn_programGroupChange(value) {
	window.location = "./programManageList.do?group=" + value;
}
</script>

<h1 class="skip">프로그램목록</h1>

<div class="subHeader" id="header">프로그램 목록</div>

<div class="topMargin" style="width:100%; height:300px; overflow-y:scroll;" id="divBox"><div>
<ul>
<c:forEach var="result" items="${programList}" varStatus="status">
	<li><a href="<c:out value="${result.manageUrl}"/>" target="neo_programManageFrame_main"><img src="./images/icon_bolt.gif"/> <c:out value="${result.progrmNm}"/></a></li>
</c:forEach>
</ul>
</div></div>
 
</body>
</html>