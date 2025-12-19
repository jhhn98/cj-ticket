<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	response.setHeader("cache-control","no-cache"); 
	response.setHeader("expires","0"); 
	response.setHeader("pragma","no-cache"); 
%>
{
"deptCode" : "<c:out value="${dept.deptCode}"/>",
"deptNm" : "<c:out value="${dept.deptNm}"/>",
	"deptList" : [
	<c:forEach var="result" items="${deptList}" varStatus="status">
		{ "dept" : {
			"deptCode" : "<c:out value="${result.deptCode}"/>",
			"deptNm" : "<c:out value="${result.deptNm}"/>",
			"deptSortCode" : "<c:out value="${result.deptSortCode}"/>",
			"lwprtDeptCo" : "<c:out value="${result.lwprtDeptCo}"/>",
			"deptSttus" : "<c:out value="${result.deptSttus}"/>"
			}
		}<c:if test="${!status.last}">,</c:if>
	</c:forEach>
	]	
}   