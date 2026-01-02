<#ftl encoding="utf-8"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import ="kr.co.hanshinit.NeoCMS.cmm.service.LoginVO" %>
<%
LoginVO loginVO = (LoginVO)session.getAttribute("loginVO");
%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, maximum-scale=5.0">
    <title>청주시 통합예약</title>
    <link rel="preload" href="/common/font/EDB-R.woff2" as="font" type="font/woff2" crossorigin>
    <link rel="preload" href="/common/font/EDB-R.woff" as="font" type="font/woff" crossorigin>
    <link rel="stylesheet" href="/site/www/css/font.css">
    <link rel="stylesheet" href="/common/css/style-reset.css">
    <link rel="stylesheet" href="/site/www/css/common.css?2512010912">
    <link rel="stylesheet" href="/site/www/css/main.css?251216">
</head>
<body>
<h1>청주시 통합예약 메인</h1>
<header class="userLogin">
    <h2>통합예약 메뉴 및 보조기능</h2>
    <div class="headerWrapper">
        <a href="./index.do" class="headerLogo"><span class="cj-logo"><i>청주시 CHEONGJU CITY</i></span><span class="site-name"><i>통합예약</i></span></a>
        <button type="button" class="mobile-navigation" aria-controls="global-navigation" aria-expanded="false"><svg class="icon-menuBar"><use href="/site/www/images/common/sprite-common-side.svg#icon-menuBar"></use></svg><svg class="icon-close"><use href="/site/www/images/common/sprite-common-side.svg#icon-close"></use></svg><span>메뉴 열기</span></button>

        <jsp:include page="/repository/${siteInfo.siteId}/menu/top.jsp" />

        <aside class="aside-links">
            <ul>
                <c:choose>
                    <c:when test="@@{!empty loginVO}">
                        <li class="myPage">
                            <svg><use href="/site/www/images/common/sprite-common-side.svg#icon-user"></use></svg>
                            <div class="linkLayer">
                                <svg><use href="/site/www/images/common/sprite-common-side.svg#icon-arrTop"></use></svg>
                                <a href="./myPageList.do?key=59"><span>마이페이지</span></a>
                            </div>
                        </li>
                        <li><a href="/logout.do" class="account"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-account-on"></use></svg><span>로그아웃</span></a></li>
                    </c:when>
                    <c:when test="@@{empty loginVO}">
                        <li><a href="/loginView.do?rurl=/www/index.do" class="account"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-account-off"></use></svg><span>로그인</span></a></li>
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
<div class="mainBg"></div>
<main>
    <h2>main content</h2>
    <div class="mainContentGroup group1">
        <div class="colgroup1">
            <section class="reservationSearchWeather">
                <h3>예약 검색</h3>
                <strong><span>모든 예약,</span> 쉽고 빠르게!</strong>
                <!--<div class="weather-wrap">
                    <span class="wtIcon WEATHER_TYPE01"><i>맑음</i></span>
                    <p>
                        <span class="wtText">28.5°<em>맑음</em></span>
                        <span class="dsText">😉 미세 <em>좋음</em></span>
                    </p>
                </div>-->
                <div class="search-wrap">
                    <form name="totSearchForm" method="post" action="./search.do">
                        <fieldset>
                            <legend>예약 검색</legend>
                            <div class="form-wrap">
                                <div class="inner-wrap">
                                    <svg class="srcIcon"><use href="/site/www/images/main/sprite-main.svg#icon-searchImg"></use></svg>
                                    <input type="text" title="검색어 입력" placeholder="어떤 예약을 도와드릴까요?" name="searchKrwd" id="searchKrwd" />
                                    <button type="submit"><svg><use href="/site/www/images/main/sprite-main.svg#icon-search-visual"></use></svg><span>검색버튼</span></button>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </section>
            <section class="event">
                <h3>이벤트 팝업</h3>
                <div class="event-slide">
                    <div class="slide-list">
                        <div class="slide-item">
                            <a href=""><img src="/site/www/images/main/event1.jpg" alt=""></a>
                        </div>
                        <div class="slide-item">
                            <a href=""><img src="/site/www/images/main/event2.jpg" alt=""></a>
                        </div>
                        <div class="slide-item">
                            <a href=""><img src="/site/www/images/main/event1.jpg" alt=""></a>
                        </div>
                        <div class="slide-item">
                            <a href=""><img src="/site/www/images/main/event2.jpg" alt=""></a>
                        </div>
                    </div>
                    <div class="controller">
                        <button type="button" class="prev"><svg><use href="/site/www/images/main/sprite-main.svg#icon-arr-simple"></use></svg><em>이전 슬라이드</em></button>
                        <button type="button" class="next"><svg><use href="/site/www/images/main/sprite-main.svg#icon-arr-simple"></use></svg><em>다음 슬라이드</em></button>
                        <div class="controller-wrap">
                            <div class="count">
                                <span class="current">00</span>
                                <i>-</i>
                                <span class="total">00</span>
                            </div>
                            <button type="button" class="slideControl ctrlStop">
                                <span class="stop">
                                    <svg><use href="/site/www/images/main/sprite-main.svg#icon-pause"></use></svg>
                                    <em>슬라이드 정지</em>
                                </span>
                                <span class="play">
                                    <svg><use href="/site/www/images/main/sprite-main.svg#icon-arr-fill"></use></svg>
                                    <em>슬라이드 재생</em>
                                </span>
                            </button>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <section class="reservationFind">
        <h3>예약 조회</h3>
        <form name="searchMainForm" id="searchMainForm" method="post" action="./selectExprnWebList.do" onsubmit="return fn_searchMainSubmit(this)">
            <fieldset>
                <legend>예약조회</legend>
				<input type="hidden" name="key" id="searchKey" />
                <ol class="reserveStep">
                    <li class="map">
                        <div class="mapInnerWrap">
                            <div class="title-area">
                                <strong class="title">지역선택<span>Step1</span></strong>
                                <div class="mapSelect">
                                    <button type="button" class="initialSelect"><svg><use href="/site/www/images/main/sprite-main.svg#icon-initial"></use></svg><span>Select 초기화</span></button>
                                    <div class="main-customSelect">
                                        <select name="searchAreaGu" id="searchAreaGu" title="구 선택" data-select="all-area">
                                            <option value="">구 선택</option>
                                            <option value="CWGU">청원구</option>
                                            <option value="HDGU">흥덕구</option>
                                            <option value="SDGU">상당구</option>
                                            <option value="SWGU">서원구</option>
                                        </select>
                                        <i><svg><use href="/site/www/images/main/sprite-main.svg#icon-arr-simple"></use></svg></i>
                                    </div>
                                    <div class="main-customSelect">
                                        <select name="searchAreaEmd" id="searchAreaEmd" title="읍/면/동 선택" data-select="detail-area">
                                            <option value="">읍/면/동 선택</option>
                                        </select>
                                        <i><svg><use href="/site/www/images/main/sprite-main.svg#icon-arr-simple"></use></svg></i>
                                    </div>
                                </div>
                            </div>
							
							<jsp:include page="/repository/common/mapArea.jsp" />
							
                        </div>
                    </li>
                    <li class="category">
                        <strong class="title">분류 선택<span>Step2</span></strong>
                        <div class="categoryWrap">
                            <label for="CATEGORY_KEY1" class="category1">
                                <input type="radio" id="CATEGORY_KEY1" name="CATEGORY_KEY" value="EXPRN">
                                <span>
                                    관광&middot;체험
                                    <em class="count"><i>...</i><svg><use href="/site/www/images/main/sprite-main.svg#icon-comment-arr"></use></svg></em>
                                </span>
                            </label>
                            <label for="CATEGORY_KEY2" class="category2">
                                <input type="radio" id="CATEGORY_KEY2" name="CATEGORY_KEY" value="FCLTY">
                                <span>
                                    시설예약
                                    <em class="count"><i>...</i><svg><use href="/site/www/images/main/sprite-main.svg#icon-comment-arr"></use></svg></em>
                                </span>
                            </label>
                            <label for="CATEGORY_KEY3" class="category3">
                                <input type="radio" id="CATEGORY_KEY3" name="CATEGORY_KEY" value="EDU">
                                <span>
                                    교육&middot;강좌
                                    <em class="count"><i>...</i><svg><use href="/site/www/images/main/sprite-main.svg#icon-comment-arr"></use></svg></em>
                                </span>
                            </label>
                            <a href="./index.do" class="label category4"><span>공연&middot;영화</span></a>
                            <a href="./sub.do?key=60" class="label category5"><span>행정서비스</span></a>
                        </div>
                    </li>
                    <li class="state">
                        <strong class="title">예약상태 선택<span>Step3</span></strong>
                        <div class="stateWrap">
                            <div class="radioWrap">
                                <label for="STATE_KEY1">
                                    <input type="radio" id="STATE_KEY1" name="searchOperSttus" value="">
                                    <span>전체</span>
                                </label>
                                <label for="STATE_KEY2">
                                    <input type="radio" id="STATE_KEY2" name="searchOperSttus" value="RCPT_ING">
                                    <span>접수중</span>
                                </label>
                                <label for="STATE_KEY3">
                                    <input type="radio" id="STATE_KEY3" name="searchOperSttus" value="RCPT_WAIT">
                                    <span>접수대기</span>
                                </label>
                            </div>
                            <p>
                                <svg><use href="/site/www/images/main/sprite-main.svg#icon-comment"></use></svg>
                                <span id="searchTxt">지역과 분류를 선택해주세요.<span>
                            </p>
                            <button type="submit">
                                <svg><use href="/site/www/images/main/sprite-main.svg#icon-search-normal"></use></svg>
                                검색
                            </button>
                        </div>
                    </li>
                </ol>
            </fieldset>
        </form>
    </section>
    <section class="reservationList">
        <div class="reservationInnerWrap">
            <h3><span>청주시의 다양한</span>프로그램을 만나보세요.</h3>
            <div class="category">
                <div class="cateDiv">
                    <strong>
                        <svg><use href="/site/www/images/main/sprite-main.svg#icon-people"></use></svg>
                        생애주기별
                    </strong>
                    <button type="button" data-filter-keyword="CATE1_TYPE1" data-target-value="TARGET01"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>영유아</span></button>
                    <button type="button" data-filter-keyword="CATE1_TYPE2" data-target-value="TARGET02"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>아동</span></button>
                    <button type="button" data-filter-keyword="CATE1_TYPE3" data-target-value="TARGET03"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>초등학생</span></button>
                    <button type="button" data-filter-keyword="CATE1_TYPE4" data-target-value="TARGET04"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>청소년</span></button>
                    <button type="button" data-filter-keyword="CATE1_TYPE5" data-target-value="TARGET05"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>성인</span></button>
                    <button type="button" data-filter-keyword="CATE1_TYPE6" data-target-value="TARGET06"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>어르신</span></button>
                    <button type="button" data-filter-keyword="CATE1_TYPE7" data-target-value="TARGET07"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>장애인</span></button>
                    <button type="button" data-filter-keyword="CATE1_TYPE8" data-target-value="TARGET08"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>기타</span></button>
                </div>
                <div class="cateDiv">
                    <strong>
                        <svg><use href="/site/www/images/main/sprite-main.svg#icon-folder"></use></svg>
                        분류별
                    </strong>
                    <button type="button" data-filter-keyword="CATE2_TYPE1" data-resve-value="EXPRN"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>체험견학</span></button>
                    <button type="button" data-filter-keyword="CATE2_TYPE2" data-resve-value="FCLTY"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>시설예약</span></button>
                    <button type="button" data-filter-keyword="CATE2_TYPE3" data-resve-value="EDU"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>교육강좌</span></button>
                    <%/*<button type="button" data-filter-keyword="CATE2_TYPE4" data-resve-value="TOUR"><svg><use href="/site/www/images/main/sprite-main.svg#icon-check"></use></svg><span>공연영화</span></button>*/%>
                </div>
            </div>
            <div class="reserve-item-list"></div>
            <div class="controller">
                <button type="button" class="prev">
                    <svg><use href="/site/www/images/main/sprite-main.svg#icon-arr-simple"></use></svg>
                    <span>이전 슬라이드</span>
                </button>
                <button type="button" class="next">
                    <svg><use href="/site/www/images/main/sprite-main.svg#icon-arr-simple"></use></svg>
                    <span>다음 슬라이드</span>
                </button>
            </div>
        </div>
    </section>
    <div class="mainContentGroup group3">
        <div class="groupInnerWrap">
            <section class="boardGroup">
                <h3>알립니다.</h3>
                <div class="board-tab">
                    <div class="tab-element">
                        <button type="button" class="tab-button current">
                            <svg class="svgBg">
                                <use href="/site/www/images/main/sprite-main.svg#icon-comment2" fill="url(/site/www/images/main/sprite-main.svg#comment-bg)"></use>
                            </svg>
                            <svg class="svgBg dark">
                                <use href="/site/www/images/main/sprite-main.svg#icon-comment2" fill="url(/site/www/images/main/sprite-main.svg#comment-bg2)"></use>
                            </svg>
                            <span>
                            <svg class="icon"><use href="/site/www/images/main/sprite-main.svg#icon-notePin"></use></svg>
                            공지사항
                        </span>
                        </button>
                        <div class="tab-content">
                            <a href="./sub.do?key=70" class="more"><svg><use href="/site/www/images/main/sprite-main.svg#icon-grid"></use></svg><span>공지사항 더보기</span></a>
						<c:if test="@@{!empty boardList1}">
							<ul>
							<c:forEach var="item" items="@@{boardList1}">
                                <li>
                                    <a href="./selectBbsNttView.do?key=70&amp;bbsNo=1&amp;nttNo=<c:out value="@@{item.nttNo}"/>">
                                        <span><c:out value="@@{item.nttSj}"/></span>
                                        <em><c:out value="@@{tsu:toDateFormat(item.frstRegisterPnttm,'yyyyMMddHHmmss','yyyy.MM.dd')}"/></em>
                                    </a>
                                </li>
							</c:forEach>
                            </ul>
						</c:if>
                        </div>
                    </div>
                    <%-- <div class="tab-element">
                        <button type="button" class="tab-button">
                            <svg class="svgBg">
                                <use href="/site/www/images/main/sprite-main.svg#icon-comment2" fill="url(/site/www/images/main/sprite-main.svg#comment-bg)"></use>
                            </svg>
                            <svg class="svgBg dark">
                                <use href="/site/www/images/main/sprite-main.svg#icon-comment2" fill="url(/site/www/images/main/sprite-main.svg#comment-bg2)"></use>
                            </svg>
                            <span>
                            <svg class="icon"><use href="/site/www/images/main/sprite-main.svg#icon-notePin"></use></svg>
                            자주하는 질문
                        </span>
                        </button>
                        <div class="tab-content">
                            <a href="./sub.do?key=71" class="more"><svg><use href="/site/www/images/main/sprite-main.svg#icon-grid"></use></svg><span>자주하는 질문 더보기</span></a>
						<c:if test="@@{!empty boardList2}">
							<ul>
							<c:forEach var="item" items="@@{boardList2}">
                                <li>
                                    <a href="./selectBbsNttView.do?key=71&amp;bbsNo=2&amp;nttNo=<c:out value="@@{item.nttNo}"/>">
                                        <span><c:out value="@@{item.nttSj}"/></span>
                                        <em><c:out value="@@{tsu:toDateFormat(item.frstRegisterPnttm,'yyyyMMddHHmmss','yyyy.MM.dd')}"/></em>
                                    </a>
                                </li>
							</c:forEach>
                            </ul>
						</c:if>
                        </div>
                    </div> --%>
                </div>
            </section>
            <section class="facilitiesGroup">
                <h3>관련시설 바로가기</h3>
                <ul>
                    <li><a href="https://crs.cjuc.or.kr/com/pubPortal.do" target="_blank" title="새창">청주도시공사 통합예약<svg><use href="/site/www/images/main/sprite-main.svg#icon-blank"></use></svg></a></li>
                    <li><a href="https://lll.cheongju.go.kr/main" target="_blank" title="새창">청주시 평생학습관<svg><use href="/site/www/images/main/sprite-main.svg#icon-blank"></use></svg></a></li>
                    <li><a href="https://edu.cheongju.go.kr/edu/index.do" target="_blank" title="새창">정보화교육<svg><use href="/site/www/images/main/sprite-main.svg#icon-blank"></use></svg></a></li>
                    <li><a href="https://library.cheongju.go.kr/lib/front/" target="_blank" title="새창">청주 시립도서관<svg><use href="/site/www/images/main/sprite-main.svg#icon-blank"></use></svg></a></li>
                    <li><a href="https://www.cheongju.go.kr/ac/index.do" target="_blank" title="새창">청주 예술의 전당<svg><use href="/site/www/images/main/sprite-main.svg#icon-blank"></use></svg></a></li>
                </ul>
            </section>
        </div>
    </div>
</main>
<footer>
    <div class="footer-wrapper">
        <nav class="footer-nav">
            <ul>
                <li><a href="https://www.cheongju.go.kr/www/contents.do?key=587" target="_blank" title="새창" class="privacyPolicy">개인정보처리방침</a></li>
                <li><a href="https://www.cheongju.go.kr/www/contents.do?key=586" target="_blank" title="새창">저작권보호정책</a></li>
                <li><a href="#n">홈페이지가이드</a></li>
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
<script src="/lib/jquery-3.7.1.min.js"></script>
<script src="/lib/slick/slick.min.js"></script>
<script src="/site/www/js/commonFunction.js"></script>
<script src="/site/www/js/mainFunction.js?251211"></script>
<script src="/site/www/js/mainSearch.js?251212"></script>

</body>
</html>
