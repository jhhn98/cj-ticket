<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="<c:out value="${menuInfo.siteId}" />"/>
    <title><c:out value="${menuInfo.cntntsNm}"/> 게시판</title>
</head>
<body>

    <div class="contents_empty">
        <img src="/common/images/wait_board.jpg" alt="게시판 설정이 필요한 페이지입니다. 빠르고 편리한 서비스를 위해 최선을 다하겠습니다."/>
    </div>

</body>
</html>