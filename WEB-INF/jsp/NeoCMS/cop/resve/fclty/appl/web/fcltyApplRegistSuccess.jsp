<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <li class="selected"><i>3</i>예약신청완료</li>
</ol>
<div class="programTitle">
    <c:set var="operSttus" value="${fcltyVO.operSttus}"/>
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
    <span class="stateType <c:out value="${sttusType}"/>"><c:out value="${operSttusMap[fcltyVO.operSttus]}"/></span>
    <strong><c:out value="${fcltyVO.fcltyNm}"/></strong>
</div>
<h4>예약정보 확인</h4>
<table class="table default" data-table-response>
    <caption>예약정보 확인</caption>
    <tbody>
    <tr>
        <th scope="row" class="first">예약번호</th>
        <td colspan="3"><c:out value="${fcltyApplVO.fcltyApplId}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">신청일시</th>
        <td colspan="3"><c:out value="${tsu:toDateFormat(fcltyApplVO.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd HH:mm:ss')}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">운영기관</th>
        <td colspan="3">
            <c:set var="insttNo" value="instt${fcltyApplVO.insttNo}"/>
            <c:out value="${fctInsttMap[insttNo]}"/>
        </td>
    </tr>
    <tr>
        <th scope="row" class="first">시설일자</th>
        <td colspan="3">
            <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd(EE)')}"/>
            <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyEndHm, 'HHmm', 'HH:mm')}"/>
        </td>
    </tr>
    <tr>
        <th scope="row" class="first">신청자</th>
        <td colspan="3"><c:out value="${fcltyApplVO.applNm}"/></td>
    </tr>
    <tr>
        <th scope="row" class="first">연락처</th>
        <td colspan="3"><c:out value="${fcltyApplVO.mobileNo1}"/> - <c:out value="${fcltyApplVO.mobileNo2}"/> - <c:out value="${fcltyApplVO.mobileNo3}"/></td>
    </tr>
    <c:if test="${fcltyApplVO.fcltyAmt > 0}">
    <tr>
        <th scope="row" class="first">결제방식<c:if test="${fcltyApplVO.payMthdCd == 'ELCTRN'}">(결제기한)</c:if></th>
        <td colspan="3"><c:out value="${payMthdMap[fcltyApplVO.payMthdCd]}"/><c:if test="${fcltyApplVO.payMthdCd == 'ELCTRN'}"> ( <c:out value="${tsu:toDateFormat(fcltyApplVO.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/> 까지 )</c:if></td>
    </tr>
    </c:if>
    </tbody>
</table>

<div class="programAmount<c:if test="${fcltyApplVO.fcltyAmt == 0}"> payFree</c:if>">
    <div class="innerWrap">
        <c:if test="${fcltyApplVO.fcltyAmt > 0}">
        <ul>
            <li>
                <strong>이용요금</strong>
                <span><fmt:formatNumber value="${tsu:xssNumberFilter(fcltyApplVO.fcltyAmt)}" pattern="#,###"/>원</span>
            </li>
            <li>
                <strong>할인(국가유공자감면)</strong>
                <span>-<fmt:formatNumber value="${tsu:xssNumberFilter(fcltyApplVO.dscntAmt)}" pattern="#,###"/>원</span>
            </li>
        </ul>
        </c:if>
        <p class="sumAmount">
            <strong>총 결제금액</strong>
            <span><fmt:formatNumber value="${tsu:xssNumberFilter(fcltyApplVO.totalPayAmt)}" pattern="#,###"/>원</span>
        </p>
    </div>
</div>
<div class="flexHAlignCenter marginTop20">
    <p class="iconText caution">예약정보 수정, 예약취소 및 결제는 <span class="point-color-green">나의 예약현황'</span>에서 가능합니다.</p>
</div>
<div class="formButtonGroup">
    <c:if test="${fcltyApplVO.payMthdCd eq 'ELCTRN'}">
        <c:if test="${fcltyApplVO.fcltyAmt > 0}">
            <a href="" class="button" onclick="alert('개발 진행 중입니다.'); return false;"><span>바로 결제하기</span></a>
        </c:if>
    </c:if>
    <a href="./myPageList.do?key=59" class="button"><span>나의 예약현황 보기</span></a>
</div>

</body>
</html>
