<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="p-table p-table--bordered">
    <caption>결제현황 통계 목록</caption>
    <colgroup>
        <col style="width:100px">
        <col style="width:200px">
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><col style="width:180px"></c:if>
        <col>
        <col style="width:120px">
        <col style="width:120px">
        <col style="width:120px">
        <col style="width:120px">
        <col style="width:120px">
        <col style="width:120px">
        <col style="width:120px">
        <col style="width:120px">
    </colgroup>
    <thead>
    <tr>
        <th scope="col">운영년도</th>
        <th scope="col">운영기관</th>
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><th scope="col">과목명</th></c:if>
        <th scope="col">프로그램명</th>
        <th scope="col"><c:out value="${(statsSearchVO.prgSe ne 'FCT') ? '접수' : '결제'}"/>인원</th>
        <th scope="col">무통장입금</th>
        <th scope="col">현장결제</th>
        <th scope="col">전자결제</th>
        <th scope="col">전자결제(%)</th>
        <th scope="col">전자결제<br/>(카드결제)</th>
        <th scope="col">전자결제<br/>(가상계좌)</th>
        <th scope="col">전자결제<br/>(계좌이체)</th>
    </tr>
    </thead>
    <tbody class="text_center">
    <c:forEach var="result" items="${statsPayMthdList}">
        <tr>
            <td><c:out value="${result.operYear}"/></td>
            <td><c:out value="${result.insttNm}"/></td>
            <c:if test="${statsSearchVO.prgSe == 'EDU'}"><td><c:out value="${result.subjectNm}"/></td></c:if>
            <td><c:out value="${result.prgNm}"/></td>
            <td><fmt:formatNumber value="${result.applCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.nbkrcpCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.directCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.elctrnCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.elctrnRate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.elctrnCCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.elctrnVCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.elctrnTCnt}" pattern="#,###"/></td>
        </tr>
    </c:forEach>
    <c:forEach var="result" items="${statsPayMthdTotList}">
        <thead>
        <tr>
            <th colspan="<c:out value="${statsSearchVO.prgSe == 'EDU' ? 4 : 3}"/>">합계</th>
            <th style="background: none;"><fmt:formatNumber value="${result.applTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.nbkrcpTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.directTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.elctrnTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.elctrnTotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.elctrnCTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.elctrnVTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.elctrnTTotCnt}" pattern="#,###"/></th>
        </tr>
        </thead>
    </c:forEach>
    <c:if test="${fn:length(statsPayMthdList) eq 0}">
        <tr>
            <td colspan="<c:out value="${statsSearchVO.prgSe == 'EDU' ? 12 : 11}"/>">등록된 내용이 없습니다.</td>
        </tr>
    </c:if>
    </tbody>
</table>

<div class="col-24 right">
    <a href="./downloadStatsPayMthdXls.do" class="p-button p-button--combine excel" onclick="fn_downloadStatsXls(this.href); return false;">엑셀다운로드</a>
</div>

<script>
    function fn_downloadStatsXls(url) {
        const $form = $('#statsSearchVO');
        var originUrl = $form.attr("action");
        $form.attr("action",url);
        $form.submit();
        $form.attr("action",originUrl);
    }
</script>