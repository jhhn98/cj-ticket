<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.hanshinit.NeoCMS.cmm.util.StringUtil"%>
<%@ page import="kr.co.hanshinit.NeoCMS.cmm.service.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    LoginVO loginVO = (LoginVO)request.getSession().getAttribute("loginVO");

%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, maximum-scale=5.0">
    <title>청주시 통합예약</title>
    <link rel="preload" href="/common/font/EDB-R.woff2" as="font" type="font/woff2" crossorigin>
    <link rel="preload" href="/common/font/EDB-R.woff" as="font" type="font/woff" crossorigin>
    <link rel="stylesheet" href="/site/www/css/font.css">
    <link rel="stylesheet" href="/common/css/style-reset.css">
    <link rel="stylesheet" href="/site/www/css/sub.css">
    <link rel="stylesheet" href="/site/www/css/program.css">
</head>
<body class="login">
<h1>청주시 통합예약 로그인</h1>
<div class="loginBg">
    <div class="circle colorGreen"></div>
    <div class="circle colorBlue"></div>
    <div class="circle colorOrange"></div>
</div>
<main>
    <a href="/www/index.do" class="login-link-index"><span>통합예약 메인 페이지로 이동하기</span></a>
    <h2><span>청주시 CHEONGJU CITY 통합예약 로그인</span></h2>
    <strong class="loginTitle"><span class="point-color-green">청주시의 다양한 예약</span>을 한 곳에서!</strong>
    <p class="loginText">홈페이지서비스이용과 익명의 사용자로 인한 피해를 방지하고자 본인확인제도를 시행하고 있습니다.<br>아래 본인(휴대폰)인증, I-PIN인증, SNS인증 중 하나를 선택하여 본인확인을 해 주시기 바랍니다.</p>
    <ul class="loginType">
        <li>
            <strong>휴대폰 본인인증</strong>
            <p>생년월일과 본인 명의의 휴대폰 정보를 이용하여 가상식별번호를 부여받아 활용하는 본인확인 서비스입니다.</p>
            <a href="#" onclick="fn_smsSubmit(); return false;" class="loginButton"><span>인증하기</span></a>
        </li>
        <li>
            <strong>아이핀 인증</strong>
            <p>본인 명의의 아이핀 인증을 통해 청주시청 통합예약 누리집 서비스를 이용하실 수 있습니다.</p>
            <a href="#" onclick="fn_ipinSubmit(); return false" class="loginButton"><span>인증하기</span></a>
        </li>
    </ul>
    <div class="flexHAlignCenter">
        <p class="iconText caution">본인인증 방법 선택 후 팝업창이 나타나지 않으면, 브라우저의 <span class="point-color-red">팝업차단을 해제</span>해주시기 바랍니다.</p>
    </div>
    <div class="snsLogin">
        <strong>SNS인증</strong>
        <ul class="text">
            <li>SNS 로그인 시 <span class="point-color-red">최초 1회 본인인증이 필요</span>합니다.</li>
            <li>SNS인증 정보는 최초 인증일 기준 <span class="point-color-red">1년 후 자동 삭제</span>됩니다.</li>
        </ul>
        <ul class="link">
            <li><button type="button" onclick="fn_kakao();" >카카오 로그인</button></li>
            <li><button type="button" onclick="fn_naver();" >네이버 로그인</button></li>
<%--            <li><button type="button" onclick="fn_naver();" data-modal-button="login1">네이버 로그인</button></li>--%>
        </ul>
    </div>
</main>
<div class="programModal" data-modal-layer="login1">
    <div class="modalHeader">
        <strong>SNS로그인</strong>
    </div>
    <div class="modalBody">
        <p class="modalLoginText">SNS로그인 시 <span class="point-color-red">최초 1회 본인인증이 필요</span>합니다.</p>
        <div class="modalAgreeBox">
            <strong class="agreeTitle">개인정보 수집 및 이용 동의 <span class="point-color-red">(필수)</span></strong>
            <div class="formGroup">
                <label for="agree1-1" class="customRadioButton">
                    <input type="radio" id="agree1-1" name="agree1">
                    <span class="customStyle">
                        <i class="radioButton"></i>
                        <span>동의함</span>
                    </span>
                </label>
                <label for="agree1-2" class="customRadioButton">
                    <input type="radio" id="agree1-2" name="agree1">
                    <span class="customStyle">
                        <i class="radioButton"></i>
                        <span>동의하지 않음</span>
                    </span>
                </label>
            </div>
            <div class="agreeExplanation">
                <div class="agreeInnerBox">
                    <p>개인정보보호법 제17조에 따라 아래와 같은 사항을 안내하고 동의를 받아 귀하의 개인정보를 이용&middot;제공할 수 있도록 합니다.</p>
                    <ul>
                        <li>1. 제공받는자: 청주시 산하 실과&middot;사업소, 동주민센터</li>
                        <li>2. 제공받는 자의 수집&middot;이용 목적: 청주시 통합예약시스템 서비스 예약자 확인 및 관리</li>
                        <li>3. 제공하는 개인정보 항목
                            <ul>
                                <li>- 예약자 정보: 성명, 생년월일, 휴대폰번호, 주소, 성별, 이메일, 차량번호</li>
                                <li>- 예약자 결제 정보: 성명, 카드번호, 은행명, 계좌번호</li>
                            </ul>
                        </li>
                        <li>4. 개인정보 보유 및 이용기간
                            <ul>
                                <li>- 예약자 정보: 1년간 보관 후 즉시 파기(성명, 단체명, 생년월일, 휴대폰번호, 주소, 성별)</li>
                                <li>- 예약자 결제정보: 5년간 보관 후 즉시 파기(성명, 카드번호, 은행명, 계좌번호)</li>
                            </ul>
                        </li>
                        <li>5. 동의를 거부할 권리가 있다는 사실과 동의 거부에 따른 불이익 내용: 개인정보 수집 및 이용&middot;제공에 대해 동의를 거부할 권리가 있으며, 동의 거부 시에는 예약 서비스 이용이 제한됩니다.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="modalFooter">
        <button type="button" onclick="fn_authCheck('sms'); return false;" class="loginModalButton phone">휴대폰 인증하기</button>
        <button type="button" onclick="fn_authCheck('ipin'); return false;" class="loginModalButton ipin">아이핀 인증하기</button>
        <button class="modalCloseButton"><span>닫기</span></button>
    </div>
</div>
<script src="/site/www/js/subFunction.js"></script>
<script nonce="NEOCMSSCRIPT">
    // 통합 인증 체크 함수 - 동의 확인 후 해당 인증 실행
    function fn_authCheck(authType) {
        var agreeRadio = document.getElementById('agree1-1');

        // 동의 체크 확인
        if(!agreeRadio || !agreeRadio.checked) {
            alert('개인정보 수집 및 이용에 동의해주세요.');
            return false;
        }
        
        // 동의한 경우 선택한 인증 타입에 따라 실행
        if(authType === 'sms') {
            // 휴대폰 본인인증
            fn_smsSubmit();
        } else if(authType === 'ipin') {
            // 아이핀 인증
            fn_ipinSubmit();
        }
    }

    // SNS 로그인 후 최초 1회 본인인증이 필요한 경우 자동으로 모달 띄우기
    <c:if test="${not empty SNS_INTRLCK && snsIntrlckMode ne 'snsSuccess'}">
    window.addEventListener('DOMContentLoaded', function() {
        // 본인인증 모달 표시
        var modal = document.querySelector('[data-modal-layer="login1"]');
        var body = document.querySelector('body');
        var isModalClosed = false; // 모달이 닫혔는지 여부
        
        if(modal) {
            modal.classList.add('show');
            if(body && !body.classList.contains('modalShow')) {
                body.classList.add('modalShow');
            }
            
            // 모달 닫기 버튼 이벤트 추가
            var closeButton = modal.querySelector('.modalCloseButton');
            if(closeButton) {
                closeButton.addEventListener('click', function() {
                    // 모달 닫기 시 SNS 로그인 세션 해제
                    isModalClosed = true;
                    // SNS 로그인 취소 처리
                    window.location.href = '/loginView.do?snsIntrlckMode=snsCancel';
                });
            }
        }
        
        // 페이지를 벗어날 때 (브라우저 닫기, 뒤로가기 등) SNS 로그인 세션 해제
        window.addEventListener('beforeunload', function(e) {
            // 모달이 열려있고 아직 닫히지 않았을 때만 처리
            if(modal && modal.classList.contains('show') && !isModalClosed) {
                // 비동기로 SNS 세션 해제 요청 (페이지 이동 중이므로 navigator.sendBeacon 사용)
                if(navigator.sendBeacon) {
                    navigator.sendBeacon('/loginView.do?snsIntrlckMode=snsCancel');
                }
            }
        });
    });
    </c:if>
</script>
</body>
</html>

<script nonce="NEOCMSSCRIPT">

    <c:if test="${isLogined and !empty rurl}">
    location.href= "${rurl}";
    </c:if>

    function fn_kakao() {
        window.location = '${kakaoAuthUrl}';
    }

    function fn_naver() {
        window.location = '${naverAuthUrl}';
    }

    function fn_facebook() {
        window.location = '${facebookUrl}';
    }
    function fn_google() {
        window.location = '${googleApiUrl}';
    }
</script>

<c:if test="${'NICE' eq userConfig.loginModeRealName}">

    <script nonce="NEOCMSSCRIPT">
        window.name ="Parent_window";

        function fn_smsSubmit(){
            window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
            document.form_chk.target = "popupChk";
            document.form_chk.param_r1.value = 'LOGIN';
            document.form_chk.param_r2.value = '${siteId}';
            document.form_chk.param_r3.value = '${rurl}';
            document.form_chk.submit();
        }
    </script>
    <!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
    <form name="form_chk" method="post" action="#">
        <fieldset>
            <legend>값 체크 폼</legend>
            <input type="hidden" name="m" value="checkplusSerivce" />						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
            <input type="hidden" name="EncodeData" value="${reqInfo}" />		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

            <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
                 해당 파라미터는 추가하실 수 없습니다. -->
            <input type="hidden" name="param_r1" value="" />
            <input type="hidden" name="param_r2" value="" />
            <input type="hidden" name="param_r3" value="" />

            <a href="javascript:fnPopup();"  style="display:none;"> 핸드폰인증</a>
        </fieldset>
    </form>
</c:if>
<c:if test="${'NICE' eq userConfig.loginModeIpin}">
    <script nonce="NEOCMSSCRIPT">
        window.name ="Parent_window1";

        function fn_ipinSubmit(){
            window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_ipin.target = "popupIPIN2";
            document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
            document.form_ipin.param_r1.value = 'LOGIN';
            document.form_ipin.param_r2.value = '${siteId}';
            document.form_ipin.param_r3.value = '${rurl}';
            document.form_ipin.submit();
        }
    </script>
    <!-- 가상주민번호 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
    <form name="form_ipin" method="post">
        <input type="hidden" name="m" value="pubmain">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
        <input type="hidden" name="enc_data" value="${reqIPINInfo}">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

        <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
             해당 파라미터는 추가하실 수 없습니다. -->
        <input type="hidden" name="param_r1" value="">
        <input type="hidden" name="param_r2" value="">
        <input type="hidden" name="param_r3" value="">

        <a href="javascript:fnPopup();"  style="display:none;"><img src="http://image.creditbank.co.kr/static/img/vno/new_img/bt_17.gif" alt="가상주민번호 인증받기" /></a>
    </form>

    <!-- 가상주민번호 서비스 팝업 페이지에서 사용자가 인증을 받으면 암호화된 사용자 정보는 해당 팝업창으로 받게됩니다.
    따라서 부모 페이지로 이동하기 위해서는 다음과 같은 form이 필요합니다. -->
    <form name="vnoform" method="post">
        <input type="hidden" name="enc_data">								<!-- 인증받은 사용자 정보 암호화 데이타입니다. -->

        <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
             해당 파라미터는 추가하실 수 없습니다. -->
        <input type="hidden" name="param_r1" value="">
        <input type="hidden" name="param_r2" value="">
        <input type="hidden" name="param_r3" value="">
    </form>
</c:if>

