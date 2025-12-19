<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>NeoCMS Administrator - CmmnCodeFrameLeft</title>
<meta name="decorator" content="neo" />
<link rel="stylesheet" href="./css/treeview.css" />


<style type="text/css">
.leftMenuList li img { vertical-align:top; }
</style>
</head>
<body>

<h1 class="subHeader"><a href="./selectCmmnClCodeList.do" target="neo_cmmnCodeFrame_main" style="line-height: 15px;">공통분류코드 관리 <img src="/common/images/program/p-icon-view.svg#cog" width="15" height="15" alt="설정"></a></h1>
<div id="searchForm" style="margin-top:5px;">
	<form id="menuVO" name="menuForm" action="selectCmmnCodeSearchAll.do" method="post" target="neo_cmmnCodeFrame_main">
		<input id="searchKrwd" name="searchKrwd" type="text" value="">
	</form>
</div>
<div class="leftMenuList topMargin">
<ul>
<c:forEach var="result" items="${cmmnClCodeList}" varStatus="status">
	<li><a href="./selectCmmnCodeList.do?clCode=<c:out value="${result.clCode}"/>" target="neo_cmmnCodeFrame_main"><img src="./images/icon_tag.gif"/> <c:out value="${result.clCodeNm}"/></a></li>
</c:forEach>
</ul>
</div>

<hr style="display: block; height: 1px; border: 0; border-top: 1px solid #ccc; margin: 5px 0 5px 0; padding: 0;"/>

<div class="leftMenuList">
<ul>
	<li><a href="./selectAdministStdWordList.do" target="neo_cmmnCodeFrame_main"><img src="./images/icon_font.gif"/> 행정표준용어사전</a></li>
	<li><a href="./selectMimeTypeList.do" target="neo_cmmnCodeFrame_main"><img src="./images/icon_tag.gif"/> 첨부파일 확장자(마임타입) 관리</a></li>
</ul>
</div>

</body>
</html>