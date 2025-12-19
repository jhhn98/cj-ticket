<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 수정</title>
<meta name="decorator" content="neo" />
<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="bbsVO" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="bbsVO">
<script nonce="NEOCMSSCRIPT">
    <c:forEach items="${errors.allErrors}" var="error" varStatus="status">
    <c:if test="${status.first}">
    <c:set var="errMsg"><spring:message code="${error.code}" arguments="${error.arguments}" /></c:set>
    alert("<c:out value="${errMsg}"/>");
    </c:if>
    </c:forEach>
</script>
</spring:hasBindErrors>
<c:if test="${!empty message}">
<script nonce="NEOCMSSCRIPT">
    function fn_check_message() {
        alert("<c:out value='${message}'/>");
        <c:if test="${!empty fieldName}">
        $("#<c:out value="${fieldName}"/>").focus();
        </c:if>
    }
    $(window).on("load", function() {
        fn_check_message();
    });
</script>
</c:if>
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_board">게시판관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">게시판관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title">수정</span>
</div>
<div class="dataWrap">
    <form:form modelAttribute="bbsVO" name="bbsVOForm" action="updateBbs.do" onsubmit="return validateBbsVO(this)">
        <form:hidden path="siteId"/>
        <form:hidden path="bbsNo"/>
        <table>
            <colgroup>
                <col class="specWidth160px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">사이트</th>
                <td><c:out value="${bbsVO.siteNm}"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="bbsNm">게시판명</form:label></th>
                <td><form:input path="bbsNm" size="40"/> <form:errors path="bbsNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="skinId">게시판 스킨</form:label></th>
                <td>
                    <form:select path="skinId">
                        <form:option value="" label="--선택하세요--" />
                        <c:forEach var="opt" items="${bbsSkinList}">
                            <option value="<c:out value="${opt.skinId}"/>" <c:out value="${opt.skinId eq bbsVO.skinId ? 'selected=true':''}"/>><c:out value="${opt.skinNm}"/></option>
                        </c:forEach>
                    </form:select> <form:errors path="skinId"/>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectBbsList.do?siteId=<c:out value="${bbsVO.siteId}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>