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
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
</head>
<body>
 
<div>

<div class="p-wrap bbs bbs_list">
<div class="card card--bgcolor p-search">
        <form:form modelAttribute="popupZoneItemVO" name="popupZoneItemVO" method="get">
            <input type="hidden" name="key" value="<c:out value="${key}"/>" />
        	<form:hidden path="popupZoneNo"/>
            <legend>배너존</legend>
            <div class="p-form-group">
            <label for="board_search_sel1" class="skip">검색조건</label>
             <form:select path="searchCnd" title="검색조건" class="p-input">
				<form:option value="all">전체</form:option>
				<form:option value="popupZoneIemNm">제목</form:option>
				<form:option value="imageReplcText">대체텍스트</form:option>		
			</form:select>
            <span class="p-form__split"></span>
            <form:input path="searchKrwd" class="p-input p-input--beside" title="검색단어 입력" placeholder="검색단어 입력"/>
            <span class="p-form-group__button"><button type="submit" class="p-button black">검색</button></span>
            </div>
        </form:form>
        </div>
    </div>

    <div>
        <div class="margin_t_10 small"><span>총 팝업 <em><c:out value="${paginationInfo.totalRecordCount}"/></em></span> &nbsp;&nbsp; <span>페이지 <em><c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/></em></span> </div>
    </div>
    <div id="pop_box">
        <ul class="pop_info">
<c:forEach var="result" items="${popupZoneItemList}" varStatus="status">
	<c:if test="${result.linkUrl ne '' and result.linkUrl ne null}">
			<li>
                <a href="<c:out value="${tsu:xssLinkFilter(result.linkUrl)}"/>" title="새창" target="_blank">
                    <span class="img"><img src="/DATA/popup/<c:out value="${result.imageFileNm}"/>" width="<c:out value="${popupZone.imageWidthSize}"/>" alt="<c:out value="${tsu:xssLinkFilter(result.imageReplcText)}"/>"/></span>
                    <span class="title"><c:out value="${result.popupZoneIemNm}"/></span>
				</a>
			</li>
	</c:if>
	<c:if test="${result.linkUrl eq '' or result.linkUrl eq null}">
			<li>
                <span class="img"><img src="/DATA/popup/<c:out value="${result.imageFileNm}"/>" width="<c:out value="${popupZone.imageWidthSize}"/>" alt="<c:out value="${tsu:xssLinkFilter(result.imageReplcText)}"/>"/></span>
                <span class="title"><c:out value="${result.popupZoneIemNm}"/></span>
			</li>
	</c:if>
</c:forEach>
        </ul>
    </div>
    <div class="p-wrap bbs bbs__list">
        <div class="p-pagination">
            <div class="p-page">
			<ui:pagination paginationInfo="${tsu:xssPagingFilter(paginationInfo)}" type="board" jsFunction="./selectPopupZoneItemWebList.do?key=${tsu:xssLinkFilter(key)}&amp;popupZoneNo=${tsu:xssLinkFilter(popupZoneItemVO.popupZoneNo)}&amp;pageUnit=${tsu:xssLinkFilter(popupZoneItemVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(popupZoneItemVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(popupZoneItemVO.searchKrwd)}&amp;pageIndex=" />
            </div>
        </div>
    </div>
</div>

</body>
</html>