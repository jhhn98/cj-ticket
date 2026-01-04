<#ftl encoding="utf-8"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="contentNavigation">
    <a href="./index.do" class="navHome"><span>홈으로</span></a>
    <ul class="contentNavigationList">
        <li>
            <button type="button">${menu.menuNm}</button>
            <ul>
                <#list firstMenuList as fmenu>
                    <li><a href="${fmenu.menuUrl!""}" target="${fmenu.linkTrget}">${fmenu.menuNm}</a></li>
                </#list>
            </ul>
        </li>
        <c:if test="@@{menuInfo.naviList[1] ne null}">
            <li>
                <button type="button">@@{menuInfo.naviList[1].menuNm}</button>
                <ul>
                    <#list secondMenuList as smenu>
                        <c:if test="@@{${smenu.upperMenuNo?string("##0")} eq menuInfo.naviList[0].menuNo}">
                            <li><a href="${smenu.menuUrl!""}" target="${smenu.linkTrget}">${smenu.menuNm}</a></li>
                        </c:if>
                    </#list>
                </ul>
            </li>
        </c:if>
        <c:if test="@@{menuInfo.naviList[2] ne null}">
            <li>
                <button type="button">@@{menuInfo.naviList[2].menuNm}</button>
                <ul>
                    <#list thirdMenuList as tmenu>
                        <li><a href="${tmenu.menuUrl!""}" target="${tmenu.linkTrget}">${tmenu.menuNm}</a></li>
                    </#list>
                </ul>
            </li>
        </c:if>
    </ul>
</nav>
<aside class="asideLinks">
    <ul>
        <li>
            <jsp:include page="/repository/sns_share.jsp"/>
        </li>
        <li><button type="button" class="contentPrint" onclick="window.print();"><svg><use href="/site/www/images/sub/sprite-sub-icon.svg#icon-print"></use></svg><span>컨텐츠 출력</span></button></li>
    </ul>
</aside>