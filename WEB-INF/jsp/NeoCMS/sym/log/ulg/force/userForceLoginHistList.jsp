<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<c:set var="active_menu" value="USR_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>NEO Administrator - UserLoginHist</title>
<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
    <span class="depth1_title icon_user">사용자관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">개별로그인 이력</span>
</div>
<div class="tab_navigation">
    <a href="/neo/selectUserInfoList.do"><span>사용자 관리</span></a></li>
    <a href="/neo/selectIndvdlinfoHistList.do"><span>개인정보처리이력</span></a></li>
    <%--<a href="/neo/selectUserForceLoginHistList.do" class="current"><span>개별로그인이력</span></a></li>--%>
    <a href="/neo/updateUserConfigView.do"><span>사용자 정보 설정 관리</span></a></li>
</div>

<div class="contents is_tab">
    <div class="table_fixed_wrap is_bottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col style="width:10%"/>
                        <col style="width:30%"/>
                        <col style="width:30%"/>
                        <col style="width:30%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">행위자 ID</th>
                        <th scope="col">로그인 대상 ID</th>
                        <th scope="col">로그인 일시</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
                    <c:forEach var="result" items="${userForceLoginHistList}" varStatus="status">
                        <tr>
                            <td class="textARight"><c:out value="${currentPageStartNo}"/></td>
                            <td class="textACenter"><c:out value="${result.adminId}"/></td>
                            <td class="textACenter"><c:out value="${result.userId}"/></td>
                            <td class="textACenter"><c:out value="${result.loginPnttmYMD}"/></td>
                        </tr>
                        <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
                    </c:forEach>
                    <c:if test="${fn:length(userForceLoginHistList) == 0}">
                        <tr>
                            <td colspan="100%" class="textACenter">로그인 이력이 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="arrangementWrap data_button">
        <div class="arrLeft">
            <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectUserForceLoginHistList.do?pageUnit=${tsu:xssLinkFilter(userForceLoginHist.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(userForceLoginHist.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(userForceLoginHist.searchKrwd)}&amp;pageIndex=" />

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