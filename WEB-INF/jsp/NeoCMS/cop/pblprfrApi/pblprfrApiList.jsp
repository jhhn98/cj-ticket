<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="<c:out value="${menuInfo.siteId}"/>"/>
    <title><c:out value="${menuInfo.menuNm}"/> 목록</title>
</head>
<body>

<h3>공연행사</h3>
<div class="eventSelectMonth">
    <a href="./selectPblprfrApiList.do?key=<c:out value="${key}"/>&searchYear=<c:out value="${prevMonth[0]}"/>&searchMonth=<fmt:formatNumber value="${prevMonth[1]}" pattern="00"/>" class="moveMonth prev">이전달</a>
    <c:forEach var="result" items="${months}">
        <c:choose>
            <c:when test="${fn:split(result, '-')[0] eq pblprfrApiSearchVO.searchYear && fn:split(result, '-')[1] eq pblprfrApiSearchVO.searchMonth}">
                <a href="./selectPblprfrApiList.do?key=<c:out value="${key}"/>&searchYear=<c:out value="${fn:split(result, '-')[0]}"/>&searchMonth=<c:out value="${fn:split(result, '-')[1]}"/>" class="current"><span class="visualHidden">현재 선택된 달</span><em><c:out value="${fn:split(result, '-')[0]}"/>년</em><span><c:out value="${fn:split(result, '-')[1]}"/>월</span></a>
            </c:when>
            <c:otherwise>
                <a href="./selectPblprfrApiList.do?key=<c:out value="${key}"/>&searchYear=<c:out value="${fn:split(result, '-')[0]}"/>&searchMonth=<c:out value="${fn:split(result, '-')[1]}"/>"><c:out value="${fn:split(result, '-')[1]}"/>월</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <a href="./selectPblprfrApiList.do?key=<c:out value="${key}"/>&searchYear=<c:out value="${nextMonth[0]}"/>&searchMonth=<fmt:formatNumber value="${nextMonth[1]}" pattern="00"/>" class="moveMonth next">다음달</a>
</div>

<div class="tab-eventList">
    <ul>
        <li><button type="button" data-filter-type="all" class="current">전체</button></li>
        <li><button type="button" data-filter-type="type1">예술의전당(대)</button></li>
        <li><button type="button" data-filter-type="type2">예술의전당(소)</button></li>
        <li><button type="button" data-filter-type="type3">청주아트홀</button></li>
        <li><button type="button" data-filter-type="type4">기타</button></li>
    </ul>
</div>

<div class="dataList-program">
    <div class="listWrap thumbnail eventList">
        <ul>
            <!-- 검색결과, 데이터 없을때 -->
            <c:if test="${empty pblprfrApiList}">
                <li class="noDataList">
                    <div class="noData">
                        <div class="noData-innerWrap">
                            <span class="noDataTitle">공연행사 목록을 불러올 수 없습니다.</span>
                            <p>페이지를 새로고침하시거나<span>관리자에게 문의해주세요.</span></p>
                        </div>
                    </div>
                </li>
            </c:if>

            <!-- //검색결과, 데이터 -->
            <c:forEach var="result" items="${pblprfrApiList}">
                <c:choose>
                    <c:when test="${result.place eq '예술의전당(대)'}"><c:set var="type" value="type1"/></c:when>
                    <c:when test="${result.place eq '예술의전당(소)'}"><c:set var="type" value="type2"/></c:when>
                    <c:when test="${result.place eq '청주아트홀'}"><c:set var="type" value="type3"/></c:when>
                    <c:otherwise><c:set var="type" value="type4"/></c:otherwise>
                </c:choose>

                <li data-filter-type="<c:out value="${type}"/>">
                    <a href="<c:out value="${result.link}"/>">
                        <c:choose>
                            <c:when test="${not empty result.img}">
                                <c:choose>
                                    <c:when test="${fn:contains(result.img, 'default_poster.jpg')}">
                                        <span class="image noImage"><img src="/site/www/images/program/no-image.png" alt="<c:out value="${result.title}"/>"></span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="image"><img src="<c:out value="${result.img}"/>" alt="<c:out value="${result.title}"/>"></span>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <span class="image noImage"><img src="/site/www/images/program/no-image.png" alt="<c:out value="${result.title}"/>"></span>
                            </c:otherwise>
                        </c:choose>
                        <span class="title"><c:out value="${result.title}"/></span>
                        <ul class="prgInformation">
                            <li><span>장소</span><c:out value="${result.place}"/></li>
                            <li><span>날짜</span><c:out value="${result.pubDate}"/></li>
                        </ul>
                    </a>
                </li>
            </c:forEach>

        </ul>
    </div>
</div>


</body>
</html>
