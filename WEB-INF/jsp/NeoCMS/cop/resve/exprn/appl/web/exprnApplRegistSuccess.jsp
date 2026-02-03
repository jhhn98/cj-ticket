<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
</head>

<body>

<ol class="programFlow">
    <li class="selected"><i>1</i>일정선택/개인정보동의</li>
    <li class="selected"><i>2</i>신청자 정보입력</li>
    <li class="selected"><span class="visualHidden">현재 단계</span><i>3</i>예약신청완료</li>
</ol>
<div class="programTitle">
    <c:set var="operSttus" value="${exprnVO.operSttus}"/>
    <c:set var="sttusType" value=""/>
    <c:if test="${operSttus == 'RCPT_WAIT'}">
        <c:set var="sttusType" value="type1"/>
    </c:if>
    <c:if test="${operSttus == 'RCPT_ING'}">
        <c:set var="sttusType" value="type2"/>
    </c:if>
    <c:if test="${operSttus == 'RCPT_END'}">
        <c:set var="sttusType" value="type3"/>
    </c:if>
    <c:if test="${operSttus == 'OPER_ING'}">
        <c:set var="sttusType" value="type2"/>
    </c:if>
    <c:if test="${operSttus == 'OPER_END'}">
        <c:set var="sttusType" value="type3"/>
    </c:if>
    <span class="stateType <c:out value="${sttusType}"/>"><c:out value="${operSttusMap[exprnVO.operSttus]}"/></span>
    <strong><c:out value="${exprnVO.exprnNm}"/></strong>
</div>
<h4>예약정보 확인</h4>
<table class="table default" data-table-response>
    <caption>예약정보 확인</caption>
    <tbody>
    <tr>
        <th scope="row" class="first">예약번호</th>
        <td colspan="3"><c:out value="${exprnApplVO.exprnApplId}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">신청일시</th>
        <td colspan="3"><c:out value="${tsu:toDateFormat(fn:substring(exprnApplVO.applDtMs, 0, 14), 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">운영기관</th>
        <td colspan="3">
            <c:set var="insttNo" value="instt${exprnApplVO.insttNo}"/>
            <c:out value="${expInsttMap[insttNo]}"/>
        </td>
    </tr>
    <tr>
        <th scope="row" class="first">체험일자</th>
        <td colspan="3">
            <c:out value="${tsu:toDateFormat(exprnApplVO.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd(EE)')}"/>
            <c:out value="${tsu:toDateFormat(exprnApplVO.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(exprnApplVO.exprnEndHm, 'HHmm', 'HH:mm')}"/>
        </td>
    </tr>
    <tr>
        <th scope="row" class="first">신청자</th>
        <td colspan="3"><c:out value="${exprnApplVO.applNm}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">연락처</th>
        <td colspan="3"><c:out value="${exprnApplVO.mobileNo1}"/> - <c:out value="${exprnApplVO.mobileNo2}"/> - <c:out value="${exprnApplVO.mobileNo3}"/></td>
    </tr>
    <c:if test="${exprnApplVO.exprnAmt > 0}">
    <tr>
        <th scope="row" class="first">결제방식<c:if test="${exprnApplVO.rsvSttusCd == 'APPL_CMPL' && exprnApplVO.payMthdCd == 'ELCTRN'}">(결제기한)</c:if></th>
        <td colspan="3"><c:out value="${payMthdMap[exprnApplVO.payMthdCd]}"/><c:if test="${exprnApplVO.rsvSttusCd == 'APPL_CMPL' && exprnApplVO.payMthdCd == 'ELCTRN'}"> ( <c:out value="${tsu:toDateFormat(exprnApplVO.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/> 까지 )</c:if></td>
    </tr>
    </c:if>
    </tbody>
</table>

<div class="programAmount<c:if test="${exprnApplVO.exprnAmt == 0}"> payFree</c:if>">
    <div class="innerWrap">
        <c:if test="${exprnApplVO.exprnAmt > 0}">
        <ul>
            <li>
                <strong>이용요금</strong>
                <span><fmt:formatNumber value="${tsu:xssNumberFilter(exprnApplVO.exprnAmt)}" pattern="#,###"/>원</span>
            </li>
            <li>
                <strong>할인(국가유공자감면)</strong>
                <span>-<fmt:formatNumber value="${tsu:xssNumberFilter(exprnApplVO.dscntAmt)}" pattern="#,###"/>원</span>
            </li>
        </ul>
        </c:if>
        <p class="sumAmount">
            <strong>총 결제금액</strong>
            <span><fmt:formatNumber value="${tsu:xssNumberFilter(exprnApplVO.totalPayAmt)}" pattern="#,###"/>원</span>
        </p>
    </div>
</div>
<div class="flexHAlignCenter marginTop20">
    <p class="iconText caution">예약정보 수정, 예약취소 및 결제는 <span class="point-color-green">나의 예약현황'</span>에서 가능합니다.</p>
</div>
<div class="formButtonGroup">
    <a href="./myPageList.do?key=59" class="button"><span>나의 예약현황 보기</span></a>
</div>

</body>
</html>
