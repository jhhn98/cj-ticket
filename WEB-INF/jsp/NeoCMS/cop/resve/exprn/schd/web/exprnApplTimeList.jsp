<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<c:forEach var="result" items="${exprnTmList}" varStatus="status">
    <c:set var="i" value="${status.index + 1}"/>

    <%-- 예약마감이면 disabled 클래스 --%>
    <c:set var="disabledClass" value="" />
    <c:if test="${result.closeYn == 'Y'}">
        <c:set var="disabledClass" value=" disabled" />
    </c:if>

    <%-- 예약현황(신청수/모집수) text --%>
    <c:set var="rcritCnt" value="${result.rcritCnt}" />
    <c:set var="applCnt" value="${result.resveCnt}" />
    <c:set var="reserveCountText" value="${applCnt} / ${rcritCnt}" />
    <c:if test="${result.closeYn == 'Y'}">
        <c:set var="reserveCountText" value="예약마감" />
    </c:if>

    <c:set var="exprnBgnHm" value="${tsu:toDateFormat(result.exprnBgnHm, 'HHmm', 'HH:mm')}"/>
    <c:set var="exprnEndHm" value="${tsu:toDateFormat(result.exprnEndHm, 'HHmm', 'HH:mm')}"/>
    <li>
        <label for="time<c:out value="${i}"/>" class="customCheckBox<c:out value="${disabledClass}"/>">
            <input type="checkbox" name="exprnSchdNo" id="time<c:out value="${i}"/>" value="<c:out value="${result.exprnSchdNo}"/>"<c:out value="${disabledClass}"/> data-tm-interval="<c:out value="${result.tmInterval}"/>"/>
            <span class="customStyle">
                <i class="checkbox"></i>
                <span id="timeText<c:out value="${result.exprnSchdNo}"/>"><c:out value="${exprnBgnHm}"/> ~ <c:out value="${exprnEndHm}"/></span>
            </span>
        </label>
        <span class="reserveCountText"><c:out value="${reserveCountText}"/></span>
    </li>
</c:forEach>
