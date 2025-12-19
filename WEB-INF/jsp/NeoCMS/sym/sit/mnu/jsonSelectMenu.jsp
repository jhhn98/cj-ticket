<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    response.setHeader("cache-control","no-cache");
    response.setHeader("expires","0");
    response.setHeader("pragma","no-cache");
%>
{
"menuNo" : "<c:out value="${menu.menuNo}"/>",
"menuNm" : "<c:out value="${menu.menuNm}"/>"
}