<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html lang="ko">
<head>

    <title>사이트 관리자 등록</title>
    <meta name="decorator" content="neo" />
    <script nonce="NEOCMSSCRIPT">
        <c:if test="${!empty message}">
        function fn_check_message() {
            alert("<c:out value='${message}'/>");
            <c:if test="${!empty fieldName}">
            $("#<c:out value="${fieldName}"/>").focus();
            </c:if>
        }
        $(window).on("load", function() {
            fn_check_message();
        });
        </c:if>
        function fn_validateBbsInfoVO( frm ) {
            return true;
        }
    </script>
</head>
<body>

<div class="page_location">
    <span class="depth1_title icon_site">사이트관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">관리자</span>
</div>
<jsp:include page="../sii/subMenu.jsp" />

<div class="contents">
    <div class="arrangementWrap data_info">
        <div class="arrLeft">
            <span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 명</span>
        </div>
        <div class="arrRight">
            <div class="table_search">
                <form:form modelAttribute="siteMngrVO" name="siteMngrVO" method="get" action="./addSiteMngrView.do">
                    <form:hidden path="siteSe"/>
                    <form:hidden path="siteId"/>
                    <form:label path="searchKrwd">아이디/이름</form:label>
                    <span class="srch_element text">
                     <form:input path="searchKrwd"/>
                    </span>

                    <span class="srch_element submit">
					<button type="submit" class="search_button">검색</button>
				</span>
                </form:form>
            </div>
        </div>
    </div>

    <div class="table_fixed_wrap is_bottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth40px"/>
                        <col class="specWidth80px"/>
                        <col/>
                        <col class="specWidth80px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">아이디</th>
                        <th scope="col">이름</th>
                        <th scope="col">등록</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
                    <c:forEach var="result" items="${userInfoList}" varStatus="status">
                        <tr>
                            <td class="textARight"><c:out value="${currentPageStartNo}"/></td>
                            <td class="textACenter"><c:out value="${result.userId}"/></td>
                            <td><c:out value="${result.userNm}"/></td>
                            <td class="textACenter"><a href="./addSiteMngr.do?siteSe=<c:out value="${siteMngrVO.siteSe}"/>&siteId=<c:out value="${siteMngrVO.siteId}"/>&userId=<c:out value="${result.userId}"/>" class="iconTextButton small write"><span>등록</span></a></td>
                        </tr>
                        <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
                    </c:forEach>
                    <c:if test="${fn:length(userInfoList) == 0}">
                        <tr>
                            <td colspan="4">검색된 회원정보가 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="arrangementWrap data_button">
        <div class="arrLeft">
            <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./addSiteMngrView.do?siteId=${tsu:xssLinkFilter(siteMngrVO.siteId)}&amp;siteSe=${tsu:xssLinkFilter(siteMngrVO.siteSe)}&amp;pageUnit=${tsu:xssLinkFilter(siteMngrVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(siteMngrVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(siteMngrVO.searchKrwd)}&amp;pageIndex=" />
        </div>
        <div class="arrRight">
            <a href="./selectSiteMngrList.do?siteId=<c:out value="${siteMngrVO.siteId}"/>&amp;siteSe=<c:out value="${siteMngrVO.siteSe}"/>" class="iconTextButton list"><span>관리자 목록</span></a>
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