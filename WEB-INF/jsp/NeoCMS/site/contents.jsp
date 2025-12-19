<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="decorator" content="<c:out value="${menuInfo.siteId}" />"/>
</head>
<body>

<c:if test="${menuInfo.menuTy eq 'MNTY05'}">
	<c:import var="Content" url="${menuInfo.innerFile}" charEncoding="UTF-8" />
	<c:out value="${Content}" escapeXml="false" />
</c:if>
<c:if test="${menuInfo.menuTy eq 'MNTY08'}">
	<iframe src="<c:out value="${menuInfo.iframeUrl}"/>" style="<c:out value="${menuInfo.iframeStyle ne '' ? menuInfo.iframeStyle : 'width:740px; height:700px'}"/>" title="내부처리 프레임"></iframe>
</c:if>
<c:if test="${menuInfo.menuTy ne 'MNTY05' and menuInfo.menuTy ne 'MNTY08'}">
	<c:import var="Content" url="${contentsFile}" charEncoding="UTF-8" />
	<c:out value="${Content}" escapeXml="false" />
</c:if>

</body>
</html>