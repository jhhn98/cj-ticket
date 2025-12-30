<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="kr.co.hanshinit.NeoCMS.cmm.util.StringUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.hanshinit.NeoCMS.cmm.service.LoginVO" %>
<%
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);	
	
	LoginVO loginAuth = (LoginVO)request.getSession().getAttribute("loginAuth");
	request.setAttribute("loginAuth", loginAuth);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>관리자 로그인</title>
<meta name="title" content="관리자 로그인" />
<meta name="author" content="(주)한신정보기술" />
<meta name="keywords" content="NeoCMS 관리자 로그인" />
<meta name="description" content="NeoCMS 관리자 로그인 페이지 입니다." />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link href="/neo/css/default.css" type="text/css" rel="stylesheet"/>
<link href="/neo/css/fontawesome.css" type="text/css" rel="stylesheet"/>
<link href="/neo/css/login.css" type="text/css" rel="stylesheet"/>
</head>
<body>

<c:if test="${!empty authStr && !empty loginAuth}">

    <div class="loginWrap">
        <h1>NeoCMS 관리자 로그인</h1>
        <div class="login_form_wrap">
            <div class="login_information">
                <p>발송된 인증 문자를 입력해 주세요</p>
            </div>
			<form name="loginForm" id="loginForm" method="post" action="/neo/neoLoginAuth.do" onsubmit="return fn_neoLoginAuthSubmit(this)">
			<fieldset>
                <input type="hidden" name="rurl" id="rurl" value="/staff/index.do"/>
                <div class="login-input id"><input type="text" name="userId2" id="userId2" maxlength="15" placeholder="아이디 입력" title="아이디" disabled="true" value="<c:out value="${loginAuth.userId}"/>" autocomplete="off" /></div>
                <div class="login-input password"><input type="text" name="authStr" id="authStr" maxlength="32" placeholder="인증번호 입력" title="인증번호" autocomplete="off" /></div>
                <div class="login-input submit"><button type="submit"><span>LOGIN</span></button></div>
				<div id="progress" style="width:100%; height:20px; background: #ddd;"></div>
			</fieldset>
            </form>
		<%/*
            <div class="login_information">
                <p>비밀번호 입력 5회 실패시 로그인이 제한됩니다.</p>
            </div>
		*/%>
        </div>
    </div>
    <footer>ⓒ HANSHINIT Corp.</footer>
	
</c:if>

<script src="/neo/js/jquery-3.6.0.min.js"></script>
<c:if test="${empty authStr || empty loginAuth}">
<script nonce="NEOCMSSCRIPT">
	alert("접근 경로가 올바르지 않습니다");
	history.back();
</script>
</c:if>

<script nonce="NEOCMSSCRIPT">
	$(window).on('pageshow', function(event) {
		if (event.originalEvent.persisted) {
			$('input[name="userId2"]').val('');
			$('input[name="authStr"]').val('');
		}
	});

	function fn_neoLoginAuthSubmit(obj) {
		if( !obj.authStr.value ) {
			alert("인증 번호를 입력해 주세요");
			return false;
		}
		
		return true;
	}
</script>

<script>
	let timeLeft = 120;
	const progressBar = document.getElementById('progress');

	const countdown = setInterval(function() {
		let minutes = Math.floor(timeLeft / 60);
		let seconds = timeLeft % 60;
				
		let progressPercent = (timeLeft / 120) * 100;
		progressBar.style.width = progressPercent + '%';
		progressBar.style.backgroundColor = progressPercent < 20 ? 'red' : '#4CAF50';
		
		if (timeLeft <= 0) {
			clearInterval(countdown);
		}
		timeLeft--;
	}, 1000);
</script>

</body>
</html>
