<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% pageContext.setAttribute("newLineEscapeChar", "\\n"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
    <script src="<c:url value="/common/js/jquery-3.6.0.min.js"/>"></script>
    <script src="<c:url value="/common/js/redirect.js"/>"></script>
</head>
<body >
<script nonce="NEOCMSSCRIPT">
    alert("<c:out value="${msg}"/>");
    var url = "<c:out value="${url}"/>";
    url = url.replace(/&amp;/g,"&");
    $(location).attr("href", url);
</script>

</body>
</html>