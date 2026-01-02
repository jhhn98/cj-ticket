<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<option value="">시간 선택</option>
<c:forEach var="result" items="${exprnTmList}" varStatus="status">
        <c:set var="exprnBgnHm" value="${tsu:toDateFormat(result.exprnBgnHm, 'HHmm', 'HH : mm')}"/>
        <c:set var="exprnEndHm" value="${tsu:toDateFormat(result.exprnEndHm, 'HHmm', 'HH : mm')}"/>

        <c:set var="rcritCnt" value="${result.rcritCnt}" />
        <c:set var="applCnt" value="${result.resveCnt}" />
        <c:set var="timeText" value="${exprnBgnHm} ~ ${exprnEndHm} ( ${applCnt} / ${rcritCnt} )" />
        <option value="<c:out value="${result.exprnSchdNo}"/>" label="<c:out value="${timeText}"/>"></option>
</c:forEach>

