<#ftl encoding="utf-8"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="menu-list-wrap">
    <h2 class="skip">주메뉴</h2>
    <nav class="menu-list"  data-spy="affix" data-offset-top="0" data-longer="true" data-addaffix =".menu-list-wrap">
        <c:if test="@@{!empty firstMenuList}">
            <ul>
                <c:forEach var="fmenu" items="@@{firstMenuList}">
                    <li class="menu-list__item<c:if test="@@{menuInfo.naviList[0].menuNo eq fmenu.menuNo}"> active</c:if>">
        <a href="@@{fn:escapeXml(fmenu.menuUrl)}" class="menu-list__link"<c:if test="@@{fmenu.linkTrget eq '_blank'}"> title="새창"</c:if> target="@@{fn:escapeXml(fmenu.linkTrget)}">@@{fn:escapeXml(fmenu.menuNm)}</a>
        <c:if test="@@{fmenu.lwprtMenuCo ne 0}">
            <ul class="submenu-list">
                <c:forEach var="smenu" items="@@{secondMenuList}">
                    <c:if test="@@{fmenu.menuNo eq smenu.upperMenuNo}">
                        <li class="submenu-list__item<c:if test="@@{menuInfo.naviList[1].menuNo eq smenu.menuNo}"> active</c:if>">
                    <a href="@@{fn:escapeXml(smenu.menuUrl)}" class="submenu-list__link"<c:if test="@@{smenu.linkTrget eq '_blank'}"> title="새창"</c:if> target="@@{fn:escapeXml(smenu.linkTrget)}">@@{fn:escapeXml(smenu.menuNm)}</a>
                    <c:if test="@@{smenu.lwprtMenuCo ne 0}">
                        <ul>
                            <c:forEach var="tmenu" items="@@{thirdMenuList}">
                                <c:if test="@@{smenu.menuNo eq tmenu.upperMenuNo}">
                                    <li class="submenu-list__item<c:if test="@@{menuInfo.naviList[2].menuNo eq tmenu.menuNo}"> active</c:if>">
                                <a href="@@{fn:escapeXml(tmenu.menuUrl)}" class="submenu-list__link"<c:if test="@@{tmenu.linkTrget eq '_blank'}"> title="새창"</c:if> target="@@{fn:escapeXml(tmenu.linkTrget)}">@@{fn:escapeXml(tmenu.menuNm)}</a>
                                </li>
                    </c:if>
                </c:forEach>
            </ul>
        </c:if>
        </li>
        </c:if>
        </c:forEach>
        </ul>
        </c:if>
        </li>
        </c:forEach>
        </ul>
        </c:if>
    </nav>
    <!-- //lnb -->
</div>