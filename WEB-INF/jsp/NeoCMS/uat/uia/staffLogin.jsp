<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="kr.co.hanshinit.NeoCMS.cmm.util.StringUtil" %>
<%
	String referer = StringUtil.nvl(request.getHeader("referer"));
	//out.println(referer);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>직원 로그인</title>
<meta name="title" content="직원 로그인" />
<meta name="author" content="(주)한신정보기술" />
<meta name="keywords" content="NeoCMS 직원 로그인" />
<meta name="description" content="NeoCMS 직원 로그인 페이지 입니다." />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link href="/neo/css/default.css" type="text/css" rel="stylesheet"/>
<link href="/neo/css/fontawesome.css" type="text/css" rel="stylesheet"/>
<link href="/neo/css/login.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <div class="loginWrap">
        <h1>NeoCMS 직원 로그인</h1>
        <div class="login_form_wrap">
            <form name="loginForm" id="loginForm" method="post" action="/staff/staffLogin.do" onsubmit="fn_neoLoginSubmit(this)">
                <input type="hidden" name="rurl" id="rurl" value="/staff/index.do"/>
                <div class="login-input id"><input type="text" name="userId" id="userId" maxlength="15" placeholder="아이디 입력" title="아이디"/></div>
                <div class="login-input password"><input type="password" name="userPasswd" id="userPasswd" maxlength="32" placeholder="비밀번호 입력" title="비밀번호"/></div>
                <div class="login-input submit"><button type="submit"><span>LOGIN</span></button></div>
            </form>
            <div class="login_information">
                <p>비밀번호 입력 5회 실패시 로그인이 제한됩니다.</p>
                <p>아이디/비밀번호 분실시<br>한신정보기술 운영지원부서로 연락바랍니다.</p>
            </div>
        </div>
    </div>
    <footer>ⓒ HANSHINIT Corp.</footer>
</body>
<script src="/common/js/jquery-3.6.0.min.js"></script>
<script nonce="NEOCMSSCRIPT">

    $(document).ready(function() {
        $('input[name="id"]').focus();
    });

</script>
</html>
