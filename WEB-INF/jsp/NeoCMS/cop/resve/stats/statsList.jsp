<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="decorator" content="${menuInfo.siteId}" />
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/program.js"></script>
    <title><c:out value="${menuInfo.naviList[0].menuNm}"/> &gt; ${menuInfo.cntntsNm}</title>
</head>
<body>
<c:set var="statsSe" value="${statsSearchVO.statsSe}"/>
<nav class="p-nav p-nav--arrow padding_b_0">
    <a href="./selectStatsApplList.do?<c:out value="${statsSearchVO.paramsExclPi}"/>" class="p-nav__link<c:if test="${statsSearchVO.statsSe == 'APPL'}"> active</c:if>">접수통계</a>
    <c:if test="${statsSearchVO.prgSe == 'EDU'}">
        <a href="./selectStatsAtendList.do?<c:out value="${statsSearchVO.paramsExclPi}"/>" class="p-nav__link<c:if test="${statsSearchVO.statsSe == 'ATEND'}"> active</c:if>">참여/수료율통계</a>
    </c:if>
    <a href="./selectStatsAgrdeList.do?<c:out value="${statsSearchVO.paramsExclPi}"/>" class="p-nav__link<c:if test="${statsSearchVO.statsSe == 'AGRDE'}"> active</c:if>">연령별통계</a>
    <a href="./selectStatsGenderList.do?<c:out value="${statsSearchVO.paramsExclPi}"/>" class="p-nav__link<c:if test="${statsSearchVO.statsSe == 'GENDER'}"> active</c:if>">성별통계</a>
    <a href="./selectStatsPayMthdList.do?<c:out value="${statsSearchVO.paramsExclPi}"/>" class="p-nav__link<c:if test="${statsSearchVO.statsSe == 'PAYMTHD'}"> active</c:if>">결제현황통계</a>
</nav>

<div class="row">
    <div class="card h3">
        <c:out value="${statsSearchVO.title}"/>
    </div>
</div>

<div class="row">
    <div class="col-6">
        <span class="p-total__number">
            총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong>${paginationInfo.totalRecordCount}</strong></em>건
            &nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]
        </span>
    </div>
    <div class="col-18 right">
        <form:form modelAttribute="statsSearchVO" name="statsSearchVO" method="get">
            <fieldset>
                <legend>통계 검색</legend>
                <form:hidden path="key"/>
                <form:hidden path="prgSe"/>
                <form:hidden path="statsSe"/>
                <form:select path="searchOperYear" cssClass="p-input p-input--auto" title="운영년도">
                    <c:forEach var="year" begin="2026" end="${tsu:getNowDateTime('yyyy') + 1}" >
                        <form:option value="${year}" label="${year}"/>
                    </c:forEach>
                </form:select>
                <form:select path="searchInsttNo" cssClass="p-input p-input--auto" title="기관">
                    <c:if test="${fn:length(insttList) > 1}"><form:option value="0" label="기관 선택"/></c:if>
                    <c:forEach var="result" items="${insttList}">
                        <form:option value="${result.insttNo}" label="${result.insttNm}"/>
                    </c:forEach>
                </form:select>
                <c:if test="${statsSearchVO.prgSe == 'EDU'}">
                    <form:select path="searchSubjectNo" cssClass="p-input p-input--auto" title="구분">
                        <form:option value="0" label="과목 선택"/>
                        <c:forEach var="result" items="${eduSubjectList}">
                            <form:option value="${result.subjectNo}" label="${result.subjectNm}" class="eduSubjectList ${result.insttNo}" style="display:none;"/>
                        </c:forEach>
                    </form:select>
                </c:if>
                <form:select path="pageUnit" cssClass="p-input p-input--auto" title="목록수">
                    <form:option value="10">10개씩</form:option>
                    <form:option value="20">20개씩</form:option>
                    <form:option value="50">50개씩</form:option>
                    <form:option value="100">100개씩</form:option>
                </form:select>
                <form:input path="searchKrwd" class="p-input w20p" title="검색어" placeholder="프로그램명 입력"/>
                <input value="검색" type="submit" class="p-button p-button--small primary">
            </fieldset>
        </form:form>
    </div>
</div>

<div class="p-wrap">

    <c:if test="${statsSearchVO.statsSe == 'APPL'}">
        <jsp:include page="./statsApplList.jsp" />
        <div class="p-pagination">
            <div class="p-page">
                <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectStatsApplList.do?${statsSearchVO.paramsExclPi}&amp;pageIndex=" />
            </div>
        </div>
    </c:if>

    <c:if test="${statsSearchVO.statsSe == 'ATEND'}">
        <jsp:include page="./statsAtendList.jsp" />
        <div class="p-pagination">
            <div class="p-page">
                <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectStatsAtendList.do?${statsSearchVO.paramsExclPi}&amp;pageIndex=" />
            </div>
        </div>
    </c:if>

    <c:if test="${statsSearchVO.statsSe == 'AGRDE'}">
        <jsp:include page="./statsAgrdeList.jsp" />
        <div class="p-pagination">
            <div class="p-page">
                <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectStatsAgrdeList.do?${statsSearchVO.paramsExclPi}&amp;pageIndex=" />
            </div>
        </div>
    </c:if>

    <c:if test="${statsSearchVO.statsSe == 'GENDER'}">
        <jsp:include page="./statsGenderList.jsp" />
        <div class="p-pagination">
            <div class="p-page">
                <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectStatsGenderList.do?${statsSearchVO.paramsExclPi}&amp;pageIndex=" />
            </div>
        </div>
    </c:if>

    <c:if test="${statsSearchVO.statsSe == 'PAYMTHD'}">
        <jsp:include page="./statsPayMthdList.jsp" />
        <div class="p-pagination">
            <div class="p-page">
                <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectStatsPayMthdList.do?${statsSearchVO.paramsExclPi}&amp;pageIndex=" />
            </div>
        </div>
    </c:if>

</div>

<script>

    $(document).ready(function() {

        <c:set var="searchInsttNo" value="${statsSearchVO.searchInsttNo}"/>
        <c:if test="${searchInsttNo > 0}">
            $('#searchSubjectNo option.${searchInsttNo}').show();
        </c:if>

        $('select[name=searchInsttNo]').on("change", function () {
            $('#searchSubjectNo').val(0);
            $('#searchSubjectNo option.eduSubjectList').hide();
            $('#searchSubjectNo option.' + $(this).val()).show();
        });

    })

</script>
</body>
</html>
