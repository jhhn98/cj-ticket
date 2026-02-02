<#ftl encoding="utf-8"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import ="kr.co.hanshinit.NeoCMS.cmm.service.LoginVO" %>
<%
LoginVO loginVO = (LoginVO)session.getAttribute("loginVO");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, maximum-scale=5.0">
    <link rel="canonical" href="https://ticket.cheongju.go.kr/www/sub.do?key=@@{menuInfo.menuNo}">
    <title>
        <c:choose>
            <c:when test="@@{not empty menuInfo and not empty menuInfo.menuNm}">
                @@{menuInfo.menuNm} | 청주시 통합예약
            </c:when>
            <c:otherwise>
                청주시 통합예약
            </c:otherwise>
        </c:choose>
    </title>
    <meta property="og:type" content="website">
    <meta property="og:title" content="@@{menuInfo.menuNm} | 청주시 통합예약">
    <meta property="og:description"
          content="청주시 @@{menuInfo.menuNm} 정보를 확인하고 예약하세요.">
    <meta property="og:url"
          content="https://ticket.cheongju.go.kr/www/sub.do?key=@@{menuInfo.menuNo}">
    <meta property="og:site_name" content="청주시 통합예약">
    <link rel="preload" href="/common/font/EDB-R.woff2?260105" as="font" type="font/woff2" crossorigin>
    <link rel="preload" href="/common/font/EDB-R.woff?260105" as="font" type="font/woff" crossorigin>
    <link rel="stylesheet" href="/site/www/css/font.css?260105">
    <link rel="stylesheet" href="/common/css/style-reset.css">
    <link rel="stylesheet" href="/site/www/css/common.css?260123">
    <link rel="stylesheet" href="/site/www/css/sub.css?260105">
    <link rel="stylesheet" href="/site/www/css/contents.css?260105">
    <link rel="stylesheet" href="/site/www/css/program.css?260105">
    <link rel="stylesheet" href="/common/css/program.css">
    <script src="/common/js/jquery-1.12.4.HS-20200709.min.js"></script>
    <script src="/common/js/fs_sns.js"></script>
	<decorator:head/>
</head>
<body>
<a href="#contents" class="skip-link">본문 바로가기</a>
<h1>@@{menuInfo.menuNm}</h1>
<div class="bg-circle">
    <div class="circle colorGreen"></div>
    <div class="circle colorBlue"></div>
    <div class="circle colorOrange"></div>
</div>
<header class="userLogin"><!-- 로그인 상태일 경우 userLogin 클래스 추가 -->
    <h2>통합예약 메뉴 및 보조기능</h2>
    <div class="headerWrapper">
        <a href="./index.do" class="headerLogo"><span class="cj-logo"><i>청주시 CHEONGJU CITY</i></span><span class="site-name"><i>통합예약</i></span></a>
        <button type="button" class="mobile-navigation" aria-controls="global-navigation" aria-expanded="false"><svg class="icon-menuBar"><use href="/site/www/images/common/sprite-common-side.svg#icon-menuBar"></use></svg><svg class="icon-close"><use href="/site/www/images/common/sprite-common-side.svg#icon-close"></use></svg><span>메뉴 열기</span></button>
        <jsp:include page="/repository/${siteInfo.siteId}/menu/top.jsp" />
        <aside class="aside-links">
            <ul>
                <!--
                <li class="myPage">
                    <svg><use href="/site/www/images/common/sprite-common-side.svg#icon-user"></use></svg>
                    <div class="linkLayer">
                        <svg><use href="/site/www/images/common/sprite-common-side.svg#icon-arrTop"></use></svg>
                        <a href="./"><span>마이페이지</span></a>
                    </div>
                </li>
                -->
                <!--<li><a href="./login.do" class="account"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-account-off"></use></svg><span>로그인</span></a></li>-->
                <!--<li><a href="./logout.do" class="account"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-account-on"></use></svg><span>로그아웃</span></a></li>-->
                <c:choose>
                    <c:when test="@@{!empty loginVO}">
                        <li class="myPage">
                            <a href="./myPageList.do?key=59"><span class="acc-skip">마이페이지 바로가기</span><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-user"></use></svg></a>
                            <div class="linkLayer">
                                <svg><use href="/site/www/images/common/sprite-common-side.svg#icon-arrTop"></use></svg>
                                <a href="./myPageList.do?key=59"><span>마이페이지</span></a>
                            </div>
                        </li>
                        <li><a href="/logout.do" class="account"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-account-on"></use></svg><span>로그아웃</span></a></li>
                    </c:when>
                    <c:when test="@@{empty loginVO}">
                        <c:if test="@@{!empty key}">
                            <li><a href="/loginView.do?rurl=/@@{siteInfo.siteId}/sub.do?key=@@{menuInfo.menuNo}" class="account"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-account-off"></use></svg><span>로그인</span></a></li>
                        </c:if>
                        <c:if test="@@{empty key}">
                            <li><a href="/loginView.do" class="account"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-account-off"></use></svg><span>로그인</span></a></li>
                        </c:if>
                    </c:when>
                </c:choose>
                <li class="feature">
                    <span>화면조정</span>
                    <button type="button" class="viewZoom in"><span>확대</span></button>
                    <button type="button" class="viewZoom out"><span>축소</span></button>
                    <button type="button" class="contrast">
                        <svg class="off"><use href="/site/www/images/common/sprite-common-side.svg#icon-contrast-off"></use></svg>
                        <svg class="on"><use href="/site/www/images/common/sprite-common-side.svg#icon-contrast-on"></use></svg>
                        <span>고대비 모드 켜기</span>
                    </button>
                </li>
            </ul>
        </aside>
    </div>
</header>

<c:if test="@@{!empty key}">

<main id="contents">
    <h2 class="page-title">
        <c:choose>
            <c:when test="@@{menuInfo.naviList[3] ne null}">
                @@{menuInfo.naviList[3].menuNm}
            </c:when>
            <c:when test="@@{menuInfo.naviList[2] ne null}">
                @@{menuInfo.naviList[2].menuNm}
            </c:when>
            <c:when test="@@{menuInfo.naviList[1] ne null}">
                @@{menuInfo.naviList[1].menuNm}
            </c:when>
            <c:otherwise>
                @@{menuInfo.naviList[0].menuNm}
            </c:otherwise>
        </c:choose>
    </h2>
    <section class="content-option">
        <jsp:include page="/repository/${siteInfo.siteId}/menu/left_@@{menuInfo.naviList[0].menuNo}.jsp"/>
    </section>
    <article class="content-area">
        <section class="content<c:if test="@@{menuInfo.menuTy eq 'MNTY04'}"> program</c:if>">
            <decorator:body />
        </section>
    </article>
    <!--<input type="text" title="" placeholder="text">
    <input type="text" title="" placeholder="텍스트입니다.">
    <input type="email" title="" placeholder="email">
    <input type="password" title="" placeholder="password">
    <input type="number" title="" placeholder="12353452345">
    <input type="date" title="" placeholder="2025/08/04">
    <button type="button">button</button>
    <textarea title="" placeholder="textarea" rows="10" cols="10">겄겅겆겉겊겋게겐겔겜겝겟겠겡겨격겪견겯결겸겹겻겼경곁계곈곌곕곗고곡곤곧골곪곬곯곰곱곳공곶과곽관괄괆괌괍괏광괘괜괠괩괬괭괴괵괸괼굄굅굇굉교굔굘굡굣구국군굳굴굵굶굻굼굽굿궁궂궈궉권궐궜궝궤궷귀귁귄귈귐귑귓규균귤그극근귿글긁금급긋긍긔기긱긴긷길긺김깁깃깅깆깊까깍깎깐깔깖깜깝깟깠깡깥깨깩깬깰깸깹깻깼깽꺄꺅꺌꺼꺽꺾껀껄껌껍껏껐껑께껙껜껨껫껭껴껸껼꼇꼈꼍꼐꼬꼭꼰꼲꼴꼼꼽꼿꽁꽂꽃꽈꽉꽐꽜꽝꽤꽥꽹꾀꾄꾈꾐꾑꾕꾜꾸꾹꾼꿀꿇꿈꿉꿋꿍꿎꿔꿜꿨</textarea>
    <select title="">
        <option value="1">개객갠갤갬갭갯갰</option>
        <option value="2">돋돌돎돐돔돕돗동돛돝돠돤돨돼됐되된될됨됩됫됴두둑둔둘둠둡둣둥둬뒀뒈뒝뒤뒨뒬뒵뒷뒹</option>
    </select>-->
</main>

</c:if>

<c:if test="@@{empty key}">

<main class="searchMain">

	<decorator:body />

</main>

</c:if>

<footer>
    <div class="footer-wrapper">
        <nav class="footer-nav">
            <ul>
                <li><a href="https://www.cheongju.go.kr/www/contents.do?key=587" target="_blank" title="새창" class="privacyPolicy">개인정보처리방침</a></li>
                <li><a href="https://www.cheongju.go.kr/www/contents.do?key=586" target="_blank" title="새창">저작권보호정책</a></li>
            </ul>
        </nav>
        <address>[28527] 충청북도 청주시 상당구 상당로69번길 38 (청주시청 임시청사)</address>
        <ul class="site-info">
            <li>대표전화 : <em>043－201－0001</em></li>
            <li>상호명 : <em>청주시 통합예약</em></li>
            <li>대표자명 : <em>이범석</em></li>
            <li>사업자등록번호 : <em>301－83－00793</em></li>
        </ul>
        <p class="copyright">COPYRIGHT CHEONGJU CITY. ALL RIGHTS RESERVED.</p>
    </div>
</footer>
<div class="programModal" data-modal-layer="modal1-1">
    <div class="modalHeader">
        <strong>예약신청</strong>
    </div>
    <div class="modalBody alignCenter">
        <i class="iconModal confirm"></i>
        <p class="confirmText">신청정보가 <span class="point-color-green">확인되었습니다.</span></p>
    </div>
    <div class="modalFooter">
        <p class="iconText caution"><span class="point-color-green">확인버튼</span>을 눌러야 신청이 완료됩니다.</p>
        <div class="formButtonGroup">
            <button type="submit" class="button bgFill">확인</button>
            <button class="modalCloseButton"><span>닫기</span></button>
        </div>
    </div>
</div>
<div class="programModal" data-modal-layer="modal1-2">
    <div class="modalHeader">
        <strong>예약신청</strong>
    </div>
    <div class="modalBody alignCenter">
        <i class="iconModal cancel"></i>
        <strong class="confirmText">신청이 <span class="point-color-red">취소되었습니다.</span></strong>
        <p>동일 시간대 예약 인원이 초과되어 신청이 취소되었습니다.<br>선착순 접수 방식에 따른 부득이한 조치이오니 너른 양해 부탁드립니다.</p>
    </div>
    <div class="modalFooter">
        <div class="formButtonGroup">
            <button type="submit" class="button bgFill">확인</button>
            <button class="modalCloseButton"><span>닫기</span></button>
        </div>
    </div>
</div>
<div class="programModal" data-modal-layer="modal2-1-1">
    <div class="modalHeader">
        <strong>예약신청</strong>
    </div>
    <div class="modalBody alignCenter">
        <i class="iconModal confirm"></i>
        <p class="confirmText">신청정보가 <span class="point-color-green">확인되었습니다.</span></p>
    </div>
    <div class="modalFooter">
        <p class="iconText caution"><span class="point-color-green">확인버튼</span>을 눌러야 신청이 완료됩니다.</p>
        <div class="formButtonGroup">
            <button type="submit" class="button bgFill">확인</button>
            <button class="modalCloseButton"><span>닫기</span></button>
        </div>
    </div>
</div>
<div class="programModal" data-modal-layer="modal2-1-2">
    <div class="modalHeader">
        <strong>예약신청</strong>
    </div>
    <div class="modalBody alignCenter">
        <i class="iconModal confirm"></i>
        <p class="confirmText">감면 대상자입니다.</p>
    </div>
    <div class="modalFooter">
        <div class="formButtonGroup">
            <button type="submit" class="button bgFill">확인</button>
            <button class="modalCloseButton"><span>닫기</span></button>
        </div>
    </div>
</div>
<div class="programModal" data-modal-layer="modal2-2-1">
    <div class="modalHeader">
        <strong>예약신청</strong>
    </div>
    <div class="modalBody alignCenter">
        <i class="iconModal cancel"></i>
        <strong class="confirmText">신청이 <span class="point-color-red">취소되었습니다.</span></strong>
        <p>동일 시간대 예약 인원이 초과되어 신청이 취소되었습니다.<br>선착순 접수 방식에 따른 부득이한 조치이오니 너른 양해 부탁드립니다.</p>
    </div>
    <div class="modalFooter">
        <div class="formButtonGroup">
            <button type="submit" class="button bgFill">확인</button>
            <button class="modalCloseButton"><span>닫기</span></button>
        </div>
    </div>
</div>
<div class="programModal" data-modal-layer="modal2-2-2">
    <div class="modalHeader">
        <strong>예약신청</strong>
    </div>
    <div class="modalBody alignCenter">
        <i class="iconModal cancel"></i>
        <strong class="confirmText">감면 대상자가 아닙니다.</strong>
    </div>
    <div class="modalFooter">
        <div class="formButtonGroup">
            <button type="submit" class="button bgFill">확인</button>
            <button class="modalCloseButton"><span>닫기</span></button>
        </div>
    </div>
</div>
<div class="programModal" data-modal-layer="modal3">
    <div class="modalHeader">
        <strong>예약취소</strong>
    </div>
    <div class="modalBody">
        <strong class="modalSubTitle">신청하신 예약내용을 취소하시겠습니까?</strong>
        <p>취소사유 및 납부하신 이용요금을 환불 받으실 계좌정보를 정확하게 입력해주세요.</p>
    </div>
    <div class="modalBody2">
        <strong class="modalSubTitle">환불계좌정보</strong>
        <table class="table modalTable">
            <caption>환불계좌정보</caption>
            <colgroup>
                <col style="width:30%">
                <col>
            </colgroup>
            <tbody>
            <input type="hidden" name="prgSe" id="prgSe">
            <input type="hidden" name="rfndApplNo" id="rfndApplNo">
            <tr>
                <th scope="row"><div class="innerCell"><label for="rfndBankNm">은행명<span class="point-color-red">*</span></label></div></th>
                <td>
                    <div class="innerCell">
                        <div class="customSelect inlineBlock">
                            <select id="rfndBankNm" name="rfndBankNm">
                                <option value="">은행 선택</option>
                                <option value="39">경남은행</option>
                                <option value="34">광주은행</option>
                                <option value="12">단위농협(지역농축협)</option>
                                <option value="32">부산은행</option>
                                <option value="45">새마을금고</option>
                                <option value="64">산림조합</option>
                                <option value="88">신한은행</option>
                                <option value="48">신협</option>
                                <option value="27">씨티은행</option>
                                <option value="20">우리은행</option>
                                <option value="71">우체국예금보험</option>
                                <option value="50">저축은행중앙회</option>
                                <option value="37">전북은행</option>
                                <option value="35">제주은행</option>
                                <option value="90">카카오뱅크</option>
                                <option value="89">케이뱅크</option>
                                <option value="92">토스뱅크</option>
                                <option value="81">하나은행</option>
                                <option value="03">IBK기업은행</option>
                                <option value="06">KB국민은행</option>
                                <option value="31">iM뱅크(대구)</option>
                                <option value="02">한국산업은행</option>
                                <option value="11">NH농협은행</option>
                                <option value="23">SC제일은행</option>
                                <option value="07">Sh수협은행</option>
                                <option value="30">수협중앙회</option>

                            </select>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><div class="innerCell"><label for="rfndAcctNo">계좌번호<span class="point-color-red">*</span></label></div></th>
                <td>
                    <div class="innerCell">
                        <input type="text" name="rfndAcctNo" id="rfndAcctNo" class="customInputDefault">
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><div class="innerCell"><label for="rfndDpstrNm">예금주<span class="point-color-red">*</span></label></div></th>
                <td>
                    <div class="innerCell">
                        <input type="text" name="rfndDpstrNm" id="rfndDpstrNm" class="customInputDefault">
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><div class="innerCell"><label for="rfndReason">취소사유<span class="point-color-red">*</span></label></div></th>
                <td>
                    <div class="innerCell">
                        <input type="text" name="rfndReason" id="rfndReason" class="customInputDefault">
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="modalFooter">
        <div class="formButtonGroup">
            <button type="submit" class="button bgFill" onclick="fn_applRfnd();">환불요청</button>
            <button type="submit" class="button" data-modal-close>취소</button>
            <button class="modalCloseButton" data-modal-close><span>닫기</span></button>
        </div>
    </div>
</div>
<script src="/lib/jquery-3.7.1.min.js"></script>
<script src="/lib/slick/slick.min.js"></script>
<script src="/site/www/js/commonFunction.js?260105"></script>
<script src="/site/www/js/subFunction.js?260105"></script>
<%--
<!--아래 스크립트들은 시설/체험 상세보기 페이지에만 추가되게 해주세요-->
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=21afdca76805d74b4e167d981b8fe3e3&autoload=false"></script>
<script>
    if (document.getElementById('map')) {
        kakao.maps.load(function () {
            const container = document.getElementById('map');
            if (!container) return;

            const options = {
                center: new kakao.maps.LatLng(37.5665, 126.9780),
                level: 3,
            };

            const map = new kakao.maps.Map(container, options);

            // ---- 여기 아래만 추가 ----
            const markerPosition = new kakao.maps.LatLng(37.5665, 126.9780);

            const marker = new kakao.maps.Marker({
                position: markerPosition
            });

            marker.setMap(map);
        });
    }
</script>
--%>
</body>
</html>
