<#ftl encoding="utf-8"/>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.5, minimum-scale=1.0, user-scalable=yes" />
    <meta name="title" content="${siteInfo.siteNm!""}" />
    <meta name="keywords" content="${siteInfo.siteKwrd!""}" />
    <meta name="description" content="${siteInfo.siteDc!""}" />
    <meta name="author" content="${siteInfo.siteAuthr!""}" />
    <link rel="stylesheet" href="/common/css/font.css" />
    <link rel="stylesheet" href="/common/css/default.css" />
    <link rel="stylesheet" href="/site/staff/css/common.css" />
    <link rel="stylesheet" href="/site/staff/css/program.css" />
    <!--[if lt IE 9]><script src="/common/js/html5.js"></script><![endif]-->
    <title>${siteInfo.siteNm!""}</title>
</head>
<body class="staff">
<header class="header">
    <div class="wrap clearfix">
        <h1 class="header__logo">프로그램 관리</h1>
        <div class="header__title">
            <!-- @@page-heading-->
        </div>
        <div class="gnb">
            <span class="gnb__name">@@{sessionScope.loginVO.userNm}</span>님
            <a href="/logout.do?mode=LOGIN&rurl=/www/index.do" class="gnb__logout" title="로그아웃">로그아웃 </a>
        </div>
    </div>
</header>
<div class="menu-list-wrap">
    <h2 class="skip">주메뉴</h2>
    <nav class="menu-list"  data-spy="affix" data-offset-top="0" data-longer="true" data-addaffix =".menu-list-wrap">
<jsp:include page="/repository/${siteInfo.siteId}/menu/top.jsp" />
    </nav>
    <!-- //lnb -->
</div>

<div id="container">
    <div class="wrap clearfix">
        <main class="main">
            <article>
                <h2 class="contents-title"></h2>
                <div class="contents">

                </div>
                <!-- //contents -->
            </article>
        </main>

    </div>
    <!-- //wrap -->
</div>
<!-- //container -->

<footer class="footer">
    <div class="wrap">
        <div class="footer_info">
            <p>Copyright ⓒ 2005-2016 HANSHINIT. All RIGHTS RESERVED</p>
        </div>
    </div>
</footer>
<!-- //footer -->


<script src="/common/js/jquery-1.12.4.HS-20200709.min.js"></script>
<script src="/site/staff/js/script.js"></script>
<script src="/common/js/program.js"></script>

</body>
</html>