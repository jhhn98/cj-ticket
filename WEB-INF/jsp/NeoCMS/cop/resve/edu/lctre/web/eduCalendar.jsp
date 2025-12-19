<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>


<%-- id="eduCalendar" : 이전/다음 달 이동 시 스크롤 위치 유지용 --%>
<div id="eduCalendar" class="calendar viewPlan">
    <div class="calendarHeader">
        <strong><c:out value="${calendarYear}"/>년 <c:out value="${calendarMonth}"/>월</strong>
        <button class="prevButton" onclick="location.href='?key=${key}&lctreNo=${eduLctreVO.lctreNo}&ym=${prevYear}${prevMonth}#eduCalendar'">
            <span>이전달 달력 보기</span>
        </button>
        <button class="nextButton" onclick="location.href='?key=${key}&lctreNo=${eduLctreVO.lctreNo}&ym=${nextYear}${nextMonth}#eduCalendar'">
            <span>다음달 달력 보기</span>
        </button>
    </div>

    <div class="calendarBody">
        <ul class="weekly">
            <li data-weekly-element><span>일</span></li>
            <li data-weekly-element><span>월</span></li>
            <li data-weekly-element><span>화</span></li>
            <li data-weekly-element><span>수</span></li>
            <li data-weekly-element><span>목</span></li>
            <li data-weekly-element><span>금</span></li>
            <li data-weekly-element><span>토</span></li>
        </ul>

        <div class="scrollWrap-day is-start">
            <ul class="day">
                <c:forEach var="week" items="${calendar}" varStatus="weekStatus">
                    <c:forEach var="day" items="${week}" varStatus="dayStatus">

                        <c:set var="dayNum" value="${day[0]}"/>       <%-- 날짜 (예: 1, 2, ..., 31) --%>
                        <c:set var="weekDay" value="${day[1]}"/>      <%-- 요일 (0:일~6:토) --%>
                        <c:set var="isToday" value="${day[2]}"/>      <%-- 오늘 여부 (1:오늘, 0:아님) --%>

                        <c:choose>
                            <%-- 날짜 있을 때 --%>
                            <c:when test="${not empty dayNum}">
                                <%-- 현재 날짜를 yyyyMMdd 형식으로 변환 (접수 기간 비교용) --%>
                                <c:set var="currentDate" value="${calendarYear}${calendarMonth}${dayNum.length() == 1 ? '0' : ''}${dayNum}"/>

                                <%-- 위치 및 상태 표시용 --%>
                                <c:set var="liClass" value=""/>

                                <%--시작/끝 위치 클래스 --%>
                                <c:if test="${dayStatus.index == 0}">
                                    <c:set var="liClass" value="${liClass} first sunday"/>  <%-- 일요일 --%>
                                </c:if>
                                <c:if test="${dayStatus.index == 6}">
                                    <c:set var="liClass" value="${liClass} last"/>          <%-- 토요일 --%>
                                </c:if>

                                <%-- 오늘 날짜 표시 클래스 --%>
                                <c:if test="${isToday eq '1'}">
                                    <c:set var="liClass" value="${liClass} today"/>
                                </c:if>

                                <%-- [접수 가능 기간 여부] 접수 기간 체크 및 클래스 설정  --%>
                                <c:set var="isReceptionPeriod" value="false"/>

                                <c:if test="${not empty lctBgnDe and not empty lctEndDe}">
                                    <%-- 현재 날짜가 접수 기간 내에 있는지 확인 --%>
                                    <c:if test="${currentDate >= lctBgnDe and currentDate <= lctEndDe}">
                                        <c:set var="isReceptionPeriod" value="true"/>
                                        <c:set var="liClass" value="${liClass} period"/>

                                        <%-- 접수 시작일 --%>
                                        <c:if test="${currentDate eq lctBgnDe}">
                                            <c:set var="liClass" value="${liClass} start"/>
                                        </c:if>

                                        <%-- 접수 종료일 --%>
                                        <c:if test="${currentDate eq lctEndDe}">
                                            <c:set var="liClass" value="${liClass} end"/>
                                        </c:if>
                                    </c:if>
                                </c:if>

                                <%-- 날짜 셀 렌더링 --%>
                                <li class="${fn:trim(liClass)}" data-day-element>
                                    <c:choose>
                                        <%-- 접수 가능 기간 --%>
                                        <c:when test="${isReceptionPeriod eq 'true'}">
                                            <div class="viewDay">
                                                <span class="day"><c:out value="${dayNum}"/></span>
                                            </div>
                                        </c:when>

                                        <%-- 접수 불가 기간 --%>
                                        <c:otherwise>
                                            <div class="viewDay disabled">
                                                <span class="day"><c:out value="${dayNum}"/></span>
                                                <%--<span class="reserveCount">접수불가</span>--%>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:when>

                            <%-- 날짜 없는 경우 --%>
                            <c:otherwise>
                                <c:set var="liClass" value=""/>
                                <c:if test="${dayStatus.index == 0}">
                                    <c:set var="liClass" value="first sunday"/>
                                </c:if>
                                <c:if test="${dayStatus.index == 6}">
                                    <c:set var="liClass" value="last"/>
                                </c:if>
                                <li class="${fn:trim(liClass)}" data-day-element></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="calendarFooter">
        <div class="calendarLegend">
            <span class="today">오늘</span>
            <span class="disabled">접수불가</span>
            <span class="">운영기간</span>
        </div>
    </div>
</div>