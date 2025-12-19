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


<script nonce="NEOCMSSCRIPT">
function fn_siteChange( siteId ) {
	window.location = "./conectLogLeftView.do?siteId=" + siteId;
}
</script>
</head>
<body>

<h1 class="skip">접속로그</h1>

<div class="subHeader" id="header">
	<!-- <img src="./images/tree_mode.gif"/> -->
	<select name="siteId" onchange="fn_siteChange(this.value)">
<c:forEach var="siteSeList" items="${siteSeList}" varStatus="status">
		<optgroup label="<c:out value="${siteSeList.codeNm}"/>">
	<c:forEach var="siteInfoList" items="${siteInfoList}" varStatus="status">
		<c:if test="${siteSeList.code eq siteInfoList.siteSe}">
		<option value="<c:out value="${siteInfoList.siteId}"/>" <c:if test="${conectLogVO.siteId eq siteInfoList.siteId}">selected="selected"</c:if>><c:out value="${siteInfoList.siteNm}"/></option>
		</c:if>
	</c:forEach>			
		</optgroup>
</c:forEach>
	</select> 
</div>

<div class="leftMenuList topMargin"> 
<ul>
	<li style="border-bottom:solid 1px #9BC3DD; margin-bottom:10px">
		<a href="#"><img src="./images/icon_bolt.gif"/> 접속로그</a>
		<ul style="margin-left:10px; margin-bottom:5px">
			<li><a href="./selectConectLogDalyList.do?siteId=<c:out value="${conectLogVO.siteId}"/>" target="neo_conectLog_main">- 일별 접속로그</a></li>
			<li><a href="./selectConectLogMnbyList.do?siteId=<c:out value="${conectLogVO.siteId}"/>" target="neo_conectLog_main">- 월별 접속로그</a></li>
			<li><a href="./selectConectLogYabyList.do?siteId=<c:out value="${conectLogVO.siteId}"/>" target="neo_conectLog_main">- 연별 접속로그</a></li>
		</ul>
	</li>
	<li style="border-bottom:solid 1px #9BC3DD; padding-bottom:5px; margin-bottom:10px">
		<a href="./selectConectLogOsList.do?siteId=<c:out value="${conectLogVO.siteId}"/>" target="neo_conectLog_main"><img src="./images/icon_bolt.gif"/> 운영체제 접속로그</a>
	</li>
	<li style="border-bottom:solid 1px #9BC3DD; padding-bottom:5px; margin-bottom:10px">
		<a href="./selectConectLogBrwsrList.do?siteId=<c:out value="${conectLogVO.siteId}"/>" target="neo_conectLog_main"><img src="./images/icon_bolt.gif"/> 브라우저 접속로그</a>
	</li>
	<li style="border-bottom:solid 1px #9BC3DD; padding-bottom:5px; margin-bottom:10px">
		<a href="./selectConectLogMenuList.do?siteId=<c:out value="${conectLogVO.siteId}"/>" target="neo_conectLog_main"><img src="./images/icon_bolt.gif"/> 메뉴별 접속로그</a>
	</li>
	<li style="border-bottom:solid 1px #9BC3DD; padding-bottom:5px; margin-bottom:10px">
		<a href="./systemInfoView.do" target="neo_conectLog_main"><img src="./images/icon_bolt.gif"/> 시스템 정보</a>
	</li>
	<li style="border-bottom:solid 1px #9BC3DD; padding-bottom:5; margin-bottom:10px">
		<a href="./selectIpBlockList.do" target="neo_conectLog_main"><img src="./images/icon_bolt.gif"/> IP 차단 관리</a>
	</li>
	<li style="border-bottom:solid 1px #9BC3DD; padding-bottom:5px">
		<a href="./selectCmmLogList.do" target="neo_conectLog_main"><img src="./images/icon_bolt.gif"/> 프로그램 통합처리 로그</a>
	</li>
</ul>
</div>

</body>
</html>