<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{
	"deptCode" : "<c:out value="${dept.deptCode}"/>",
	"deptNm" : "<c:out value="${dept.deptNm}"/>",
	"empList" : [
	<c:forEach var="result" items="${employeeList}" varStatus="status">
		{ "emp" : {
		"deptCode" : "<c:out value="${dept.deptCode}"/>",
		"deptNm" : "<c:out value="${dept.deptNm}"/>",
		"emplCode" : "<c:out value="${result.emplCode}"/>",
		"emplNm" : "<c:out value="${result.emplNm}"/>",
		"emplJob" : "<c:out value="${result.emplJob}"/>",
		"emplEmail" : "<c:out value="${result.emplEmail}"/>",
		"emplTelno" : "<c:out value="${result.emplTelno}"/>",
		"rspofc" : "<c:out value="${result.rspofc}"/>"
		}
		}<c:if test="${!status.last}">,</c:if>
	</c:forEach>
	]	
}