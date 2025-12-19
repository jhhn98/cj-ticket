<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="kr.co.hanshinit.NeoCMS.cmm.service.LoginVO" %>
<%
   LoginVO loginVO = (LoginVO)session.getAttribute("loginVO"); 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>NEO Administrator</title>
<link rel="stylesheet" type="text/css" href="css/neo.css" />
<link rel="stylesheet" type="text/css" href="css/header.css" /> 
</head>
<body>

<div id="header" class="clearfix">
    <h1 id="logo">
        <a href="#" class="logo"><img src="./images/logo_NeoCMS.jpg" width="244" height="17"  alt="NeoCMS Administrator"/></a>
    </h1>
    <div id="loginInfo">
        <span><%= loginVO.getUserNm() %></span>
        <span class="logout"><a href="/neo/logout.do" target="_top">Logout</a></span>
    </div>
    <div id="topMenu1">
        <ul>
            <li class="m01"><a href="./cmmnCodeFrame.do" target="neo_main" style="color:#FFF">공통코드관리</a></li>
            <li class="m01"><a href="./cmmnAtchInfoList.do" target="neo_main" style="color:#FFF">공통첨부파일</a></li>
            <li class="m02"><a href="./selectUserInfoList.do" target="neo_main" style="color:#FFF">사용자정보</a></li>
            <li class="m03"><a href="./departmentFrame.do" target="neo_main" style="color:#FFF">부서정보</a></li>
            <li class="m04"><a href="./selectTemplateList.do" target="neo_main" style="color:#FFF">템플릿관리</a></li>
            <li class="m05"><a href="./selectSiteInfoList.do?siteSe=SECT01" target="neo_main" style="color:#FFF">사이트관리</a></li>
            <li class="m06"><a href="./menuFrame.do" target="neo_main" style="color:#FFF">메뉴관리</a></li>
            <li class="m07"><a href="./bbsFrame.do" target="neo_main" style="color:#FFF">게시판관리</a></li>
            <li class="m08"><a href="./programFrame.do" target="neo_main" style="color:#FFF">컴포넌트관리</a></li>
            <li class="m09"><a href="./conectLogFrame.do" target="neo_main" style="color:#FFF">로그</a></li>
        </ul>
    </div>
</div>

</body>
</html>