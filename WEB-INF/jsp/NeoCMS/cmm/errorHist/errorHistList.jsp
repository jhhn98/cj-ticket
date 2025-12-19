<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="LOG_9" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>에러로그조회</title>
    <meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
    <span class="depth1_title icon_log">접속로그</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title">에러로그 목록</span>
</div>

<div class="contents">
    <div class="arrangementWrap data_info">
        <div class="arrLeft">
            <span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건(<c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/>)</span>
        </div>
        <div class="arrRight">
            <div class="table_search">
                <form:form modelAttribute="errorHistVO" name="searchForm" method="post" action="selectErrorHist.do">
					<span class="srch_element select">
                        <form:select path="pageUnit">
                            <form:option value="10">10 페이지</form:option>
                            <form:option value="20">20 페이지</form:option>
                            <form:option value="30">30 페이지</form:option>
                            <form:option value="40">40 페이지</form:option>
                            <form:option value="50">50 페이지</form:option>
                        </form:select>
                    </span>
                    <span class="srch_element text">
                        <form:input path="searchKrwd" cssClass="txt" placeholder="검색어 입력"/>
                    </span>
                    <span class="srch_element submit">
                        <button type="submit" class="search_button">검색</button>
                    </span>
                </form:form>
            </div>
        </div>
    </div>
    <div class="table_fixed_wrap is_topBottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth50px"/>
                        <col class="specWidth85px"/>
                        <col/>
                        <col class="specWidth200px"/>
                        <col class="specWidth100px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">발생시간</th>
                        <th scope="col">패키지명</th>
                        <th scope="col">메소드명</th>
                        <th scope="col">내용보기</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
                    <c:forEach var="result" items="${errorHistList}" varStatus="status">
                        <fmt:parseDate value="${tsu:xssLinkFilter(result.frstRegisterPnttm)}" var="frstRegisterPnttm" pattern="yyyyMMddHHmmss"/>
                        <tr data-display="true">
                            <td class="textACenter" ><c:out value="${currentPageStartNo}" /></td>
                            <td class="textACenter" ><c:out value="${result.occrrncPnttmYMDHM}" /></td>
                            <td class="textACenter" ><c:out value="${result.pckageNm}" /></td>
                            <td class="textACenter" ><c:out value="${result.methodNm}" /></td>
                            <td class="textACenter" ><a href="./errorHistView.do?errorHistNo=<c:out value="${result.errorHistNo}" />&amp;pageUnit=${tsu:xssLinkFilter(errorHistVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(errorHistVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(errorHistVO.searchKrwd)}&amp;pageIndex=${tsu:xssLinkFilter(errorHistVO.pageIndex)}" class="textButton small search"><span>상세보기</span></a></td>
                        </tr>
                        <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
                    </c:forEach>
                    <c:if test="${fn:length(errorHistList) == 0}">
                        <tr>
                            <td colspan="5" class="textACenter">검색된 정보가 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="arrangementWrap data_button">
        <div class="arrLeft">
            <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectErrorHist.do?pageUnit=${tsu:xssLinkFilter(errorHistVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(errorHistVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(errorHistVO.searchKrwd)}&amp;pageIndex=" />
        </div>
        <div class="arrRight">
        </div>
    </div>
</div>


<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>
</body>
</html>

