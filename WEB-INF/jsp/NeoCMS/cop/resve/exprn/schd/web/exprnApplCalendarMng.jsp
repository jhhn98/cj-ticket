<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="year" value="${exprnSchdWebVO.year}"/>
<c:set var="month" value="${exprnSchdWebVO.month}"/>
<c:set var="prevMonth" value="${exprnSchdWebVO.prevMonth}"/>
<c:set var="nextMonth" value="${exprnSchdWebVO.nextMonth}"/>
<c:set var="arrCalendar" value="${exprnSchdWebVO.arrCalendar}"/>
<c:set var="operSttus" value="${exprnSchdWebVO.operSttus}"/>
<c:set var="exprnDe" value="${exprnSchdWebVO.exprnDe}"/>

<span class="p-calendar w20p">
    <div class="p-calendar-header">
        <div class="p-calendar-header__inner">
            <span class="p-calendar__month">
                <c:out value="${year}"/>년 <c:out value="${month}"/>월
            </span>
            <button type="button" class="p-calendar__prev-month prevButton" data-year="<c:out value="${prevMonth[0]}"/>" data-month="<c:out value="${prevMonth[1]}"/>">
                <svg width="28" height="28" fill="#999" focusable="false">
                    <title>이전달 이동</title>
                    <use xlink:href="/common/images/program/p-icon.svg#angle-left"></use>
                    <switch><foreignObject width="20" height="20">이전달 이동</foreignObject></switch>
                </svg>
            </button>
            <button type="button" class="p-calendar__next-month nextButton" data-year="<c:out value="${nextMonth[0]}"/>" data-month="<c:out value="${nextMonth[1]}"/>">
                <svg width="28" height="28" fill="#999" focusable="false">
                    <title>다음달 이동</title>
                    <use xlink:href="/common/images/program/p-icon.svg#angle-right"></use>
                    <switch><foreignObject width="20" height="20">다음달 이동</foreignObject></switch>
                </svg>
            </button>
        </div>
    </div>
</span>
<select name="exprnDe" id="exprnDe" class="p-input p-input--auto ymdBtn">
    <option value="">날짜 선택</option>
    <c:forEach var="i" begin="0" end="5">
        <c:forEach var="j" begin="0" end="6">
            <c:if test="${!empty arrCalendar[i][j][0] && arrCalendar[i][j][3] == 'Y'}">
                <fmt:formatNumber var="dayChk" minIntegerDigits="2" value="${arrCalendar[i][j][0]}" type="number"/>
                <c:set var="ymd" value="${year}${month}${dayChk}" />
                <option value="${ymd}" label="${tsu:toDateFormat(ymd, 'yyyyMMdd', 'yyyy년 MM월 dd일 (EE)')}"></option>
            </c:if>
        </c:forEach>
    </c:forEach>
</select>

<select name="exprnSchdNo" id="exprnSchdNo" class="p-input p-input--auto timeList">
    <jsp:include page="exprnApplTimeListMng.jsp" />
</select>
