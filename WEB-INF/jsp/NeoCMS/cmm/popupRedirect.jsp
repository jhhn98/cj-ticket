<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% pageContext.setAttribute("newLineEscapeChar", "\\n"); %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>팝업창 알림 후 부모창 이동</title>
    <script src="/neo/js/jquery-3.6.0.min.js"></script>
</head>
<body >
<script nonce="NEOCMSSCRIPT">

    try
    {
        $(opener.location).attr("href", "${url}");
    }
    catch (exception)
    {
        window.open('${pageContext.request.scheme}://${pageContext.request.serverName}${url}', 'NeoPopupWindow');
    } finally {
        window.close();
    }

</script>

</body>
</html>