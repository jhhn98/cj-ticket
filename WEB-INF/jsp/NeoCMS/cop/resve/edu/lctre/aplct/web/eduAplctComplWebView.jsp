<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>${menuInfo.cntntsNm} 상세</title>
</head>
<body>
<!-- 예약신청완료 -->
<ol class="programFlow">
    <li class="selected"><i>1</i>개인정보동의</li>
    <li class="selected"><i>2</i>신청자 정보입력</li>
    <li class="selected"><i>3</i>예약신청완료</li>
</ol>
<div class="programTitle">
    <%-- [운영상태]
        OPER_CNCL 폐강 | OPER_END 종료 | OPER_ING 운영중
        RCPT_ADD 추가모집 | RCPT_END 접수마감 | RCPT_ING 접수중
        RCPT_WAIT 접수예정 | WAIT_ING 대기자접수
    --%>
        <c:set var="stateTypeClass" value="type1"/>
        <c:if test="${eduLctreVO.operSttus eq 'RCPT_ING'
                                                    or eduLctreVO.operSttus eq 'RCPT_ADD'
                                                    or eduLctreVO.operSttus eq 'WAIT_ING'}">
            <c:set var="stateTypeClass" value="type2"/>
        </c:if>
        <c:if test="${eduLctreVO.operSttus eq 'OPER_CNCL'
                                                    or eduLctreVO.operSttus eq 'OPER_END'
                                                    or eduLctreVO.operSttus eq 'RCPT_END'
                                                    or eduLctreVO.operSttus eq 'OPER_ING'}">
            <c:set var="stateTypeClass" value="type3"/>
        </c:if>
        <span class="stateType ${stateTypeClass}"><c:out value="${operSttusMap[eduLctreVO.operSttus]}"/></span>
    <strong><c:out value="${eduLctreVO.lctreNm}"/></strong>
</div>
<h4>예약정보 확인</h4>
<table class="table default" data-table-response>
    <caption>예약정보 확인</caption>
    <tbody>
    <tr>
        <th scope="row" class="first">예약번호</th>
        <td colspan="3"><c:out value="${eduAplctVO.eduRsvtNo}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">신청일시</th>
        <td colspan="3">
            <c:if test="${not empty eduAplctVO.applDtMs && fn:length(eduAplctVO.applDtMs) >= 14}">
                ${fn:substring(eduAplctVO.applDtMs, 0, 4)}-${fn:substring(eduAplctVO.applDtMs, 4, 6)}-${fn:substring(eduAplctVO.applDtMs, 6, 8)}
                ${fn:substring(eduAplctVO.applDtMs, 8, 10)}:${fn:substring(eduAplctVO.applDtMs, 10, 12)}
            </c:if>
        </td>
    </tr>
    <tr>
        <th scope="row" class="first">운영기관</th>
        <td colspan="3"><c:out value="${eduLctreVO.insttNm}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">운영기간</th>
        <td colspan="3">
            <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 8}">
                <c:set var="lctBgnDe" value="${fn:substring(eduLctreVO.lctBgnDt, 0, 8)}"/>
                ${fn:substring(lctBgnDe, 0, 4)}-${fn:substring(lctBgnDe, 4, 6)}-${fn:substring(lctBgnDe, 6, 8)}
            </c:if>
            ~
            <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 8}">
                <c:set var="lctEndDe" value="${fn:substring(eduLctreVO.lctEndDt, 0, 8)}"/>
                ${fn:substring(lctEndDe, 0, 4)}-${fn:substring(lctEndDe, 4, 6)}-${fn:substring(lctEndDe, 6, 8)}
            </c:if>
        </td>
    </tr>
    <tr>
        <th scope="row" class="first">시간</th>
        <td>
            <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 12}">
                <c:set var="lctBgnHm" value="${fn:substring(eduLctreVO.lctBgnDt, 8, 12)}"/>
                <c:out value="${tsu:toDateFormat(lctBgnHm, 'HHmm', 'HH:mm')}"/>
            </c:if>
            ~
            <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 12}">
                <c:set var="lctEndHm" value="${fn:substring(eduLctreVO.lctEndDt, 8, 12)}"/>
                <c:out value="${tsu:toDateFormat(lctEndHm, 'HHmm', 'HH:mm')}"/>
            </c:if>
        </td>
        <th scope="row">요일</th>
        <td><c:out value="${eduLctreVO.lctWeekNm}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">이용요금</th>
        <td colspan="3">
            <c:choose>
                <c:when test="${not empty eduLctreVO.eduAmt && eduLctreVO.eduAmt > 0}">
                    <fmt:formatNumber value="${eduLctreVO.eduAmt}" pattern="#,###"/> 원
                </c:when>
                <c:otherwise>무료</c:otherwise>
            </c:choose>
        </td>
    </tr>
    <tr>
        <th scope="row" class="first">신청자</th>
        <td colspan="3"><c:out value="${eduAplctVO.applNm}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">연락처</th>
        <td colspan="3"><c:out value="${eduAplctVO.telNo}"/></td>
    </tr>
    </tbody>
</table>

<%-- 유료/무료 --%>
<c:choose>
    <c:when test="${not empty eduAplctVO.payAmt && eduAplctVO.payAmt > 0}">
        <%-- 유료일 때 --%>
        <div class="programAmount">
            <div class="innerWrap">
                <ul>
                    <li>
                        <strong>이용요금</strong>
                        <span><fmt:formatNumber value="${eduAplctVO.payAmt}" pattern="#,###"/> 원</span>
                    </li>
                    <c:if test="${eduLctreVO.dscntUseYn eq 'Y'}">
                        <li>
                            <strong>할인(국가유공자감면)</strong>
                            <span>0원</span>
                        </li>
                    </c:if>
                </ul>
                <p class="sumAmount">
                    <strong>총 결제금액</strong>
                    <span><fmt:formatNumber value="${eduAplctVO.payAmt}" pattern="#,###"/> 원</span>
                </p>
            </div>
        </div>
        <%--<h4>환불규정</h4>
        <table class="table default" data-table-response>
            <caption>환불규정</caption>
            <tbody>
            <tr>
                <th scope="row" class="first">제목</th>
                <td colspan="3">내용</td>
            </tr>
            </tbody>
        </table>--%>
        <div class="flexHAlignCenter marginTop20">
            <p class="iconText caution">예약정보 수정, 예약취소 및 결제는 <span class="point-color-green">나의 예약현황</span>에서 가능합니다.</p>
        </div>
        <div class="formButtonGroup">
            <a href="./myPageList.do?key=59" class="button"><span>나의 예약현황</span></a>
        </div>
    </c:when>
    <c:otherwise>
        <%-- 무료일 때 --%>
        <div class="programAmount payFree">
            <div class="innerWrap">
                <p class="sumAmount">
                    <strong>총 결제금액</strong>
                    <span>0원</span>
                </p>
            </div>
        </div>

        <div class="flexHAlignCenter marginTop20">
            <p class="iconText caution">예약정보 수정, 예약취소는 <span class="point-color-green">나의 예약현황</span>에서 가능합니다.</p>
        </div>
        <div class="formButtonGroup">
            <a href="./myPageList.do?key=${key}" class="button"><span>나의 예약현황 보기</span></a>
        </div>
    </c:otherwise>
</c:choose>



</body>
</html>

