<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<c:set var="year" value="${exprnSchdWebVO.year}"/>
<c:set var="month" value="${exprnSchdWebVO.month}"/>
<c:set var="prevMonth" value="${exprnSchdWebVO.prevMonth}"/>
<c:set var="nextMonth" value="${exprnSchdWebVO.nextMonth}"/>
<c:set var="arrCalendar" value="${exprnSchdWebVO.arrCalendar}"/>

<div class="calendar viewPlan">
    <div class="calendarHeader">
        <strong><c:out value="${year}"/>년 <c:out value="${month}"/>월</strong>
        <button class="prevButton" data-year="<c:out value="${prevMonth[0]}"/>" data-month="<c:out value="${prevMonth[1]}"/>">
            <span>이전달 달력 보기</span>
        </button>
        <button class="nextButton" data-year="<c:out value="${nextMonth[0]}"/>" data-month="<c:out value="${nextMonth[1]}"/>">
            <span>다음달 달력 보기</span>
        </button>
    </div>
    <div class="calendarBody">
        <ul class="weekly">
            <li><span>일</span></li>
            <li><span>월</span></li>
            <li><span>화</span></li>
            <li><span>수</span></li>
            <li><span>목</span></li>
            <li><span>금</span></li>
            <li><span>토</span></li>
        </ul>
        <ul class="day">
            <c:set var="lineChk" value="0"/>
            <c:forEach var="i" begin="0" end="5">
                <c:forEach var="j" begin="0" end="6">

                    <c:set var="firstClass" value="${j == 0 ? ' first' : ''}" />
                    <c:set var="lastClass" value="${j == 6 ? ' last' : ''}" />

                    <c:choose>
                        <c:when test="${!empty arrCalendar[i][j][0]}">

                            <fmt:formatNumber var="dayChk" minIntegerDigits="2" value="${arrCalendar[i][j][0]}" type="number"/>
                            <c:set var="ymd" value="${year}${month}${dayChk}" />

                            <c:set var="sundayClass" value="${arrCalendar[i][j][1] == '0' ? ' sunday' : ''}" />
                            <c:set var="todayClass" value="${arrCalendar[i][j][2] == '1' ? ' today' : ''}" />

                            <%-- 예약가능한 날짜가 아니면 disabled 클래스 --%>
                            <c:set var="disabledClass" value="${arrCalendar[i][j][3] != 'Y' ? ' disabled' : ''}" />

                            <%-- 예약현황(신청수/모집수) --%>
                            <c:set var="reserveCount" value="" />
                            <c:if test="${arrCalendar[i][j][3] == 'Y'}">
                                <c:set var="reserveCount" value="${arrCalendar[i][j][4]}" />
                            </c:if>
                            <c:if test="${arrCalendar[i][j][3] == 'F'}">
                                <c:set var="reserveCount" value="예약마감" />
                            </c:if>

                            <li class="<c:out value="${firstClass}"/><c:out value="${lastClass}"/><c:out value="${sundayClass}"/><c:out value="${todayClass}"/>">
                                <div class="viewDay<c:out value="${disabledClass}"/>">
                                    <span class="day"><c:out value="${arrCalendar[i][j][0]}"/></span>
                                    <span class="reserveCount"><c:out value="${reserveCount}"/></span>
                                </div>
                            </li>

                        </c:when>

                        <c:otherwise>
                            <li class="<c:out value="${firstClass}"/><c:out value="${lastClass}"/>"></li>
                        </c:otherwise>

                    </c:choose>
                </c:forEach>
            </c:forEach>
        </ul>
    </div>
    <div class="calendarFooter">
        <div class="selectCount">
            <span class="count">00/00</span>
            <span class="text">신청수/총모집수</span>
        </div>
        <div class="calendarLegend">
            <span class="today">오늘</span>
            <span class="disabled">예약불가</span>
        </div>
    </div>
</div>
