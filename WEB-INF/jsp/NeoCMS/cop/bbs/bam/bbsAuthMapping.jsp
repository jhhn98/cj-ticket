<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_3" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="neo" />
    <script src="/neo/js/jquery-3.6.0.min.js"></script>
    <script src="/neo/js/common.js"></script>
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_board">게시판 관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title">사용자 구분 - 게시판 권한 매핑설정</span>
</div>
<div class="contents is_null">
    <div class="arrangementWrap marginBottom_5">
        <div class="arrLeft">
        </div>
        <div class="arrRight">
        </div>
    </div>
    <form action="./updateBbsAuthMapping.do" method="post" name="bbsAuthForm" id="bbsAuthForm">
        <div class="contents_scroll_area specWidth50per">
            <table class="authManage">
                <colgroup>
                    <col class="specWidth40per"/>
                    <col class="specWidth40per"/>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col" class="first"><a href="selectCmmnDetailCodeList.do?clCode=SYS&code=EMPL&codeId=USINDV" class="iconTextLink set "><span>사용자 구분</span></a></th>
                    <th scope="col" ><a href="selectCmmnDetailCodeList.do?clCode=PRC&code=BBSR02&codeId=BBSI09" class="iconTextLink set"><span>게시판 권한 구분</span></a></th>
                </tr>
                </thead>
                <tbody class="textACenter">
                <c:forEach var="res" items="${authorUserList}" varStatus="idx">
                    <tr>
                        <td class="first"><c:out value="${res.codeNm}"/>(<c:out value="${res.code}"/>)</td>
                        <td><select id="${res.code}" name="${res.code}">
                            <c:forEach var="bbsRes" items="${authorBbsList}" varStatus="idx">
                                <c:set var="selcted" value="" />
                                <c:forEach var="bam" items="${listMap}" varStatus="idx_bam"><c:if test="${(res.code eq bam.usrAuthCode) and (bam.bbsAuthCode eq bbsRes.code)}"><c:set var="selcted" value="selected=\"selected\"" /></c:if></c:forEach>
                                <option value="<c:out value="${bbsRes.code}"/>" <c:out value="${selcted}"/>><c:out value="${bbsRes.codeNm}"/>(<c:out value="${bbsRes.code}"/>)</option>
                            </c:forEach>
                            </select>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="arrangementWrap marginTop_15 specWidth100per">
                <div class="arrLeft">
                    <a href="./selectBbsListAuthManage.do" class="iconTextButton list"><span>게시판 권한설정</span></a>
                </div>
                <div class="arrRight">
                    <button type="submit" class="iconTextButton write "><span>저장</span></button>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>