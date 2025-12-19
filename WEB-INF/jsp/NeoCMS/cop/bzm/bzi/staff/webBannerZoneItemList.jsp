<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>



<div class="page_location">
    <span class="depth1_title icon_program">컴포넌트관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">배너존관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title"><c:out value="${bannerZone.bannerZoneNm}"/> 상세정보</span>
</div>
<div class="contents">

<div id="board" class="clearfix">

<div class="boardsearch">
        <form:form modelAttribute="bannerZoneItemVO" name="bannerZoneItemVO" method="get">
            <input type="hidden" name="key" value="<c:out value="${key}"/>" />
        	<form:hidden path="bannerZoneNo"/>
            <legend>배너존</legend>
            <label for="board_search_sel1" class="skip">검색조건</label>
             <form:select path="searchCnd" title="검색조건">
				<form:option value="all">전체</form:option>
				<form:option value="bannerZoneIemNm">제목</form:option>
				<form:option value="imageReplcText">대체텍스트</form:option>		
			</form:select>
            <label for="board_search_text" class="skip">검색어 입력</label>
            <form:input path="searchKrwd" class="text"/>
            <input type="image" src="/common/images/board/search_submit.gif" value="검색" />
        </form:form>
    </div>

    <div class="board_top clearfix">
        <div class="left"></div>
        <div class="right"><span>총 배너 <em><c:out value="${paginationInfo.totalRecordCount}"/></em></span> &nbsp;&nbsp; <span>페이지 <em><c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/></em></span> </div>
    </div>
    <div id="banner_box">
        <ul class="banner_info">
<c:forEach var="result" items="${bannerZoneItemList}" varStatus="status">
	<c:if test="${result.linkUrl ne '' and result.linkUrl ne null}">
            <li>
                <a href="<c:out value="${tsu:xssLinkFilter(result.linkUrl)}"/>" title="새창" target="_blank">
                    <span class="img"><img src="/DATA/banner/<c:out value="${result.imageFileNm}"/>" width="<c:out value="${bannerZone.imageWidthSize}"/>" height="<c:out value="${bannerZone.imageHeightSize}"/>" alt="<c:out value="${tsu:xssLinkFilter(result.imageReplcText)}"/>"/></span>
                    <span class="title"><c:out value="${result.bannerZoneIemNm}"/></span>
                    <span class="link"><c:out value="${result.linkUrl}"/></span>
            	</a>
            </li>
	</c:if>
	<c:if test="${result.linkUrl eq '' or result.linkUrl eq null}">
            <li>
                <span class="img"><img src="/DATA/banner/<c:out value="${result.imageFileNm}"/>" width="<c:out value="${bannerZone.imageWidthSize}"/>" height="<c:out value="${bannerZone.imageHeightSize}"/>" alt="<c:out value="${tsu:xssLinkFilter(result.imageReplcText)}"/>"/></span>
                <span class="title"><c:out value="${result.bannerZoneIemNm}"/></span>
            </li>
	</c:if>
</c:forEach>
        </ul>
    </div>
    <div class="boardNavigation clearfix">
        <div class="pagination a2">
        	<ui:pagination paginationInfo="${tsu:xssPagingFilter(paginationInfo)}" type="web" jsFunction="./selectBannerZoneItemList.do?key=${tsu:xssLinkFilter(key)}&amp;bannerZoneNo=${tsu:xssLinkFilter(bannerZoneItemVO.bannerZoneNo)}&amp;pageUnit=${tsu:xssLinkFilter(bannerZoneItemVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(bannerZoneItemVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(bannerZoneItemVO.searchKrwd)}&amp;pageIndex=" />
        </div>
        <div class="buttonRight"></div>
        <div class="buttonLeft"></div>
    </div>
</div>

</body>
</html>