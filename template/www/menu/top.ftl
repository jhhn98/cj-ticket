<#ftl encoding="utf-8"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav id="global-navigation" class="navigation">
    <div class="mobile-navigation-head">
        <a href="./index.do" class="mobileHeaderLogo"><span class="cj-logo"><i>청주시 CHEONGJU CITY</i></span><span class="site-name"><i>통합예약</i></span></a>
        <c:choose>
            <c:when test="@@{!empty loginVO}">
                <div class="navi_myPage">
                    <svg><use href="/site/www/images/common/sprite-common-side.svg#icon-user"></use></svg>
                    <div class="navi_linkLayer">
                        <svg><use href="/site/www/images/common/sprite-common-side.svg#icon-arrTop"></use></svg>
                        <a href="./myPageList.do?key=59"><span>마이페이지</span></a>
                    </div>
                </div>
                <a href="/logout.do" class="navi_account"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-account-on"></use></svg><span>로그아웃</span></a>
            </c:when>
            <c:when test="@@{empty loginVO}">
               <a href="/loginView.do?rurl=/www/index.do" class="navi_account"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-account-off"></use></svg><span>로그인</span></a>
            </c:when>
        </c:choose>
        <form method="post" action="./search.do">
            <fieldset>
                <legend>통합예약 검색</legend>
                <div class="mobile-search">
                    <input type="text" title="검색어 입력" placeholder="어떤 예약을 도와드릴까요?" name="searchKrwd" id="searchKrwd" />
                    <button type="submit"><svg><use href="/site/www/images/common/sprite-common-side.svg#icon-view"></use></svg><span>검색</span></button>
                </div>
            </fieldset>
        </form>
    </div>
    <ul data-navigation="depth1Wrap" class="navDepth1Wrap">
        <#assign dep1=1>
        <#list firstMenuList as fmenu>
            <li class="current">
                <a href="${fmenu.menuUrl!""}" target="${fmenu.linkTrget}" data-navigation-depth="1" class="navDepth1">
                    ${fmenu.menuNm}
                    <!-- 하위메뉴가 존재할 때만 넣어주세요 -->
                    <#if fmenu.lwprtMenuCo != 0><svg class="mobile-icon"><use href="/site/www/images/common/sprite-common-side.svg#icon-menu-arr"></use></svg></#if>
                </a>
                <#if fmenu.lwprtMenuCo != 0>
                    <div class="navDepth2Wrapper" data-navigation="depth2Wrap">
                        <div class="innerWrapper">
                            <div class="navigationTitle">
                                <strong>${fmenu.menuNm}</strong>
                            </div>
                            <ul class="navDepth2Wrap">
                                <#list secondMenuList as smenu>
                                    <#if fmenu.menuNo = smenu.upperMenuNo>
                                        <li <#if smenu.lwprtMenuCo != 0> class="current"</#if>>
                                            <a href="${smenu.menuUrl!""}" target="${smenu.linkTrget}" data-navigation-depth="2" class="navDepth2">
                                                ${smenu.menuNm}
                                                <!-- 하위메뉴가 존재할 때만 넣어주세요 -->
                                                <#if smenu.lwprtMenuCo != 0><svg class="mobile-icon"><use href="/site/www/images/common/sprite-common-side.svg#icon-menu-arr"></use></svg></#if>
                                                <svg class="mobile-icon"><use href="/site/www/images/common/sprite-common-side.svg#icon-menu-arr"></use></svg>
                                                <!-- a target=_blank 일 경우 넣어주세요. -->
                                                <#if smenu.linkTrget = "_blank"><svg class="icon-blank"><use href="/site/www/images/common/sprite-common-side.svg#icon-blank"></use></svg></#if>

                                            </a>
                                            <#if smenu.lwprtMenuCo != 0>
                                                <ul data-navigation="depth3Wrap" class="navDepth3Wrap">
                                                    <#list thirdMenuList as tmenu>
                                                        <#if smenu.menuNo = tmenu.upperMenuNo>
                                                            <li><a href="${tmenu.menuUrl!""}" target="${tmenu.linkTrget}" data-navigation-depth="3" class="navDepth3">
                                                                    ${tmenu.menuNm}
                                                                    <!-- a target=_blank 일 경우 넣어주세요. -->
                                                                    <#if smenu.linkTrget = "_blank"><svg class="icon-blank"><use href="/site/www/images/common/sprite-common-side.svg#icon-blank"></use></svg></#if>
                                                                </a>
                                                            </li>
                                                        </#if>
                                                    </#list>
                                                </ul>
                                            </#if>
                                        </li>
                                    </#if>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </#if>
            </li>
        </#list>
        <li data-visible-on="mobile"><!-- 홈페이지가이드 메뉴도 함께 표출해주세요~ data-visible-on="mobile" 이 속성을 꼭 넣어주셔야 합니다! 부탁드립니다! -->
            <a href="#" data-navigation-depth="1" class="navDepth1">
                홈페이지가이드
                <!-- 하위메뉴가 존재할 때만 넣어주세요 -->
                <svg class="mobile-icon"><use href="/site/www/images/common/sprite-common-side.svg#icon-menu-arr"></use></svg>
            </a>
            <div class="navDepth2Wrapper" data-navigation="depth2Wrap">
                <div class="innerWrapper">
                    <div class="navigationTitle">
                        <strong>홈페이지가이드</strong>
                    </div>
                    <ul class="navDepth2Wrap">
                        <li><a href="#" data-navigation-depth="2" class="navDepth2">개인정보처리방침</a></li>
                        <li><a href="#" data-navigation-depth="2" class="navDepth2">저작권 정책</a></li>
                    </ul>
                </div>
            </div>
        </li>
    </ul>
</nav>