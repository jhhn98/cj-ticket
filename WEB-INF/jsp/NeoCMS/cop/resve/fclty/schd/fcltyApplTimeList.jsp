<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<option value="">시간 선택</option>

<c:choose>
  <c:when test="${fcltyVO.slctMthdCd eq 'FIRST'}">
    <c:set var="rcritTxt" value="1" />
  </c:when>
  <c:otherwise>
    <c:set var="rcritTxt" value="무제한" />
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${fcltyVO.fcltyAmt > 0 and fcltyVO.amtMthd eq 'S'}">
    <c:set var="fcltyAmt">
      <fmt:formatNumber value="${fcltyVO.fcltyAmt}" pattern="#,###"/>원
    </c:set>
    <c:set var="totAmt" value="${fcltyVO.fcltyAmt}" />
  </c:when>
  <c:otherwise>
    <c:set var="fcltyAmt" value="" />
    <c:set var="totAmt" value="" />
  </c:otherwise>
</c:choose>

<c:forEach var="result" items="${fcltyTmList}" varStatus="status">
  <c:set var="fcltyBgnHm" value="${tsu:toDateFormat(result.fcltyBgnHm, 'HHmm', 'HH : mm')}"/>
  <c:set var="fcltyEndHm" value="${tsu:toDateFormat(result.fcltyEndHm, 'HHmm', 'HH : mm')}"/>
  <c:set var="rcritCnt" value="${result.rcritCnt}" />
  <c:set var="applCnt" value="${result.resveCnt}" />

  <c:if test="${fcltyVO.fcltyAmt > 0 and fcltyVO.amtMthd eq 'D'}">
    <c:set var="fcltyAmt">
      <fmt:formatNumber value="${result.timeAmt}" pattern="#,###"/>원
    </c:set>
    <c:set var="totAmt" value="${result.timeAmt}" />
  </c:if>

  <c:set var="timeText" value="${fcltyBgnHm} ~ ${fcltyEndHm} ( ${applCnt} / ${rcritTxt} ) ${fcltyAmt} ${(applCnt >= rcritCnt) ? '| 예약완료/선택불가' : ''}" />
  <c:set var="disabled" value="${(applCnt >= rcritCnt) ? ' disabled' : ''}" />
  <option value="<c:out value="${result.fcltySchdNo}"/>" data-tot-amt="<c:out value="${totAmt}"/>" data-fclty-amt="<c:out value="${fcltyAmt}"/>" label="<c:out value="${timeText}"/>"<c:out value="${disabled}"/>></option>
</c:forEach>

