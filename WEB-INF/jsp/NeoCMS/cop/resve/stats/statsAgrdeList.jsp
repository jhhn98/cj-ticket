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
    <caption>연령별 통계 목록</caption>
    <colgroup>
        <col style="width:80px">
        <col style="width:200px">
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><col style="width:200px"></c:if>
        <col>
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
        <col style="width:50px">
    </colgroup>
    <thead>
    <tr>
        <th scope="col" rowspan="2">운영년도</th>
        <th scope="col" rowspan="2">운영기관</th>
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><th scope="col" rowspan="2">과목명</th></c:if>
        <th scope="col" rowspan="2">프로그램명</th>
        <th scope="col" colspan="4">20대</th>
        <th scope="col" colspan="4">30대</th>
        <th scope="col" colspan="4">40대</th>
        <th scope="col" colspan="4">50대</th>
        <th scope="col" colspan="4">60대</th>
    </tr>
    <tr>
        <th scope="col">접수인원</th>
        <th scope="col">접수율(%)</th>
        <th scope="col">취소인원</th>
        <th scope="col">취소율(%)</th>
        <th scope="col">접수인원</th>
        <th scope="col">접수율(%)</th>
        <th scope="col">취소인원</th>
        <th scope="col">취소율(%)</th>
        <th scope="col">접수인원</th>
        <th scope="col">접수율(%)</th>
        <th scope="col">취소인원</th>
        <th scope="col">취소율(%)</th>
        <th scope="col">접수인원</th>
        <th scope="col">접수율(%)</th>
        <th scope="col">취소인원</th>
        <th scope="col">취소율(%)</th>
        <th scope="col">접수인원</th>
        <th scope="col">접수율(%)</th>
        <th scope="col">취소인원</th>
        <th scope="col">취소율(%)</th>
    </tr>
    </thead>
    <tbody class="text_center">
    <c:forEach var="result" items="${statsAgrdeList}">
        <tr>
            <td><c:out value="${result.operYear}"/></td>
            <td><c:out value="${result.insttNm}"/></td>
            <c:if test="${statsSearchVO.prgSe == 'EDU'}"><td><c:out value="${result.subjectNm}"/></td></c:if>
            <td><c:out value="${result.prgNm}"/></td>
            <td><fmt:formatNumber value="${result.age20Cnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age20Rate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age20CnclCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age20CnclRate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age30Cnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age30Rate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age30CnclCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age30CnclRate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age40Cnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age40Rate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age40CnclCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age40CnclRate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age50Cnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age50Rate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age50CnclCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age50CnclRate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age60Cnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age60Rate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age60CnclCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.age60CnclRate}" pattern="#,###"/></td>
        </tr>
    </c:forEach>
    <c:forEach var="result" items="${statsAgrdeTotList}">
        <thead>
        <tr>
            <th colspan="<c:out value="${statsSearchVO.prgSe == 'EDU' ? 4 : 3}"/>">합계</th>
            <th style="background: none;"><fmt:formatNumber value="${result.age20TotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age20TotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age20CnclTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age20CnclTotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age30TotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age30TotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age30CnclTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age30CnclTotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age40TotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age40TotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age40CnclTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age40CnclTotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age50TotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age50TotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age50CnclTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age50CnclTotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age60TotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age60TotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age60CnclTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.age60CnclTotRate}" pattern="#,###"/></th>
        </tr>
        </thead>
    </c:forEach>
    <c:if test="${fn:length(statsAgrdeList) eq 0}">
        <tr>
            <td colspan="<c:out value="${statsSearchVO.prgSe == 'EDU' ? 24 : 23}"/>">등록된 내용이 없습니다.</td>
        </tr>
    </c:if>
    </tbody>
</table>

<div class="col-24 right">
    <a href="./downloadStatsAgrdeXls.do" class="p-button p-button--combine excel" onclick="fn_downloadStatsXls(this.href); return false;">엑셀다운로드</a>
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