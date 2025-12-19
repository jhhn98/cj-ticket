<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	response.setHeader("cache-control","no-cache"); 
	response.setHeader("expires","0"); 
	response.setHeader("pragma","no-cache"); 
%>
{
	"menuNo" : "<c:out value="${menu.menuNo}"/>",
	"menuList" : [
	<c:forEach var="result" items="${menuList}" varStatus="status">
		{ "menu" : {
		"menuNo" : "<c:out value="${result.menuNo}"/>",
		"menuNm" : "<c:out value="${result.menuNm}"/>",
		"lwprtMenuCo" : "<c:out value="${result.lwprtMenuCo}"/>",
		"menuTy" : "<c:out value="${result.menuTy}"/>",
		"menuShowAt" : "<c:out value="${result.menuShowAt}"/>",
		"menuLevel" : "<c:out value="${result.menuLevel}"/>",
		"menuSortCode" : "<c:out value="${result.menuSortCode}"/>",
        "upendShowAt" : "<c:out value="${result.upendShowAt}"/>"
		}
		}<c:if test="${!status.last}">,</c:if>
	</c:forEach>
	]
}