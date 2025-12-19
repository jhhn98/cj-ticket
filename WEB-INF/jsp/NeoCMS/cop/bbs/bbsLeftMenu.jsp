<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>


<meta name="decorator" content="neo" />
<link rel="stylesheet" href="./css/treeview.css" />


</head>
<body>

<h1 class="skip">게시판 관리</h1>

<div class="subHeader" id="header">게시판 관리</div>

<div class="leftMenuList topMargin"> 
<ul>
	<li><a href="./selectBbsList.do" target="neo_bbs_main"><img src="./images/icon_bolt.gif"/> 게시판 설정</a></li>
	<!--<li><a href="" target="neo_bbs_main"><img src="./images/icon_bolt.gif"/> 게시물 관리</a></li>-->
	<li><a href="./selectBbsSkinList.do" target="neo_bbs_main"><img src="./images/icon_bolt.gif"/> 스킨 관리</a></li>
</ul>
</div>
<!--
<hr style="display: block; height: 1px; border: 0; border-top: 1px solid #ccc; margin: 5px 0 5px 0; padding: 0;"/>

<div class="leftMenuList">
<ul> 
	<li><a href="" target="neo_bbs_main"><img src="./images/icon_bolt.gif"/> 게시판 사용 정보</a></li>
</ul>
</div>
-->

</body>
</html>