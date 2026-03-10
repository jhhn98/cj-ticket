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
    <caption>접수 통계 목록</caption>
    <colgroup>
        <col style="width:100px">
        <col style="width:250px">
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><col style="width:250px"></c:if>
        <col>
        <col style="width:120px">
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><col style="width:100px"></c:if>
        <col style="width:100px">
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><col style="width:100px"></c:if>
        <col style="width:100px">
        <col style="width:100px">
        <col style="width:100px">
    </colgroup>
    <thead>
    <tr>
        <th scope="col">운영년도</th>
        <th scope="col">운영기관</th>
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><th scope="col">과목명</th></c:if>
        <th scope="col">프로그램명</th>
        <th scope="col">정원</th>
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><th scope="col">대기정원</th></c:if>
        <th scope="col">접수인원</th>
        <c:if test="${statsSearchVO.prgSe == 'EDU'}"><th scope="col">대기인원</th></c:if>
        <th scope="col">접수율(%)</th>
        <th scope="col">취소인원</th>
        <th scope="col">취소율(%)</th>
    </tr>
    </thead>
    <tbody class="text_center">
    <c:forEach var="result" items="${statsApplList}">
        <tr>
            <td><c:out value="${result.operYear}"/></td>
            <td><c:out value="${result.insttNm}"/></td>
            <c:if test="${statsSearchVO.prgSe == 'EDU'}"><td><c:out value="${result.subjectNm}"/></td></c:if>
            <td><c:out value="${result.prgNm}"/></td>
            <td><fmt:formatNumber value="${result.rcptNmpr}" pattern="#,###"/></td>
            <c:if test="${statsSearchVO.prgSe == 'EDU'}">
                <td><fmt:formatNumber value="${result.waitNmpr}" pattern="#,###"/></td>
            </c:if>
            <td><fmt:formatNumber value="${result.applCnt}" pattern="#,###"/> </td>
            <c:if test="${statsSearchVO.prgSe == 'EDU'}">
                <td><fmt:formatNumber value="${result.waitCnt}" pattern="#,###"/></td>
            </c:if>
            <td><fmt:formatNumber value="${result.applRate}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.cnclCnt}" pattern="#,###"/></td>
            <td><fmt:formatNumber value="${result.cnclRate}" pattern="#,###"/></td>
        </tr>
    </c:forEach>
    <c:forEach var="result" items="${statsApplTotList}">
        <thead>
        <tr>
            <th colspan="<c:out value="${statsSearchVO.prgSe == 'EDU' ? 4 : 3}"/>">합계</th>
            <th style="background: none;"><fmt:formatNumber value="${result.totRcptNmpr}" pattern="#,###"/></th>
            <c:if test="${statsSearchVO.prgSe == 'EDU'}">
                <th style="background: none;"><fmt:formatNumber value="${result.totWaitNmpr}" pattern="#,###"/></th>
            </c:if>
            <th style="background: none;"><fmt:formatNumber value="${result.applTotCnt}" pattern="#,###"/></th>
            <c:if test="${statsSearchVO.prgSe == 'EDU'}">
                <th style="background: none;"><fmt:formatNumber value="${result.waitTotCnt}" pattern="#,###"/></th>
            </c:if>
            <th style="background: none;"><fmt:formatNumber value="${result.applTotRate}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.cnclTotCnt}" pattern="#,###"/></th>
            <th style="background: none;"><fmt:formatNumber value="${result.cnclTotRate}" pattern="#,###"/></th>
        </tr>
        </thead>
    </c:forEach>
    <c:if test="${fn:length(statsApplList) eq 0}">
        <tr>
            <td colspan="<c:out value="${statsSearchVO.prgSe == 'EDU' ? 9 : 8}"/>">등록된 내용이 없습니다.</td>
        </tr>
    </c:if>
    </tbody>
</table>

<div class="col-24 right">
    <a href="./downloadStatsApplXls.do" class="p-button p-button--combine excel" onclick="fn_downloadStatsXls(this.href); return false;">엑셀다운로드</a>
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