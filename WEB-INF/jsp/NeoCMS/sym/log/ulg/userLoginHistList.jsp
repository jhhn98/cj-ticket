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
    <span class="depth2_title">로그인 이력</span>
</div>
<div class="tab_navigation">
    <a href="/neo/selectUserInfoList.do" class="current"><span>사용자 관리</span></a></li>
    <a href="/neo/selectIndvdlinfoHistList.do"><span>개인정보처리이력</span></a></li>
    <%--<a href="/neo/selectUserForceLoginHistList.do" ><span>개별로그인이력</span></a></li>--%>
    <a href="/neo/updateUserConfigView.do"><span>사용자 정보 설정 관리</span></a></li>
</div>

<div class="contents">
    <table>
        <colgroup>
            <col class="specWidth15per"/>
            <col class="specWidth35per"/>
            <col class="specWidth15per"/>
            <col class="specWidth35per"/>
        </colgroup>
        <tbody>
        <tr>
            <th scope="row">아이디</th>
            <td><c:out value="${userInfo.userId}"/></td>
            <th scope="row">이름</th>
            <td><c:out value="${userInfo.userNm}"/></td>
        </tr>
        <tr>
            <th scope="row">사용자구분</th>
            <td><c:out value="${userSeMap[userInfo.userSe]}"/></td>
            <th scope="row">사용자가입일</th>
            <td><c:out value="${userInfo.frstRegisterPnttmYMD}"/></td>
        </tr>
        </tbody>
    </table>

    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
        </div>
        <div class="arrRight">
            <a href="./selectUserInfoList.do?<c:if test="${null ne param.pageUnit}">pageUnit=<c:out value="${param.pageUnit}"/>&</c:if>searchCnd=<c:out value="${param.searchCnd}"/>&searchKrwd=<c:out value="${param.searchKrwd}"/><c:if test="${null ne param.pageIndex}">&pageIndex=<c:out value="${param.pageIndex}"/></c:if>" class="iconTextButton list"><span>사용자 목록</span></a>
        </div>
    </div>

    <h2>로그인 이력</h2>
    <div class="table_fixed_wrap" style="height:calc(100% - 240px)">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth60px"/>
                        <col class="specWidth120px"/>
                        <col/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">로그인구분</th>
                        <th scope="col">로그인 일시</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="sNumber" value="${fn:length(userLoginHistList)}" />
                    <c:forEach var="result" items="${userLoginHistList}" varStatus="status">
                        <tr>
                            <td class="textARight"><c:out value="${sNumber}"/></td>
                            <td class="textACenter">
                                <c:choose>
                                    <c:when test="${result.loginSuccesAt eq 'Y'}">
                                        성공
                                    </c:when>
                                    <c:otherwise>
                                        <em class="em_red">실패</em>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${result.loginPnttmYMD}"/></td>
                        </tr>
                        <c:set var="sNumber" value="${sNumber-1}" />
                    </c:forEach>
                    <c:if test="${fn:length(userLoginHistList) == 0}">
                        <tr>
                            <td colspan="3" class="textACenter">로그인 이력이 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%--
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
        </div>
        <div class="arrRight">
            <a href="./selectUserInfoList.do?<c:if test="${null ne param.pageUnit}">pageUnit=<c:out value="${param.pageUnit}"/>&</c:if>searchCnd=<c:out value="${param.searchCnd}"/>&searchKrwd=<c:out value="${param.searchKrwd}"/><c:if test="${null ne param.pageIndex}">&pageIndex=<c:out value="${param.pageIndex}"/></c:if>" class="iconTextButton list"><span>사용자 목록</span></a>
        </div>
    </div>
    --%>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>
</body>
</html>