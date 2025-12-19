<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_2" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>스킨 수정</title>
<meta name="decorator" content="neo" />
<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="bbsSkin" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="bbsSkin">
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
	<span class="depth2_title">게시판스킨</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title">스킨관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/> 수정</span>
</div>
<div class="dataWrap">
    <form:form modelAttribute="bbsSkin" name="bbsSkinForm" action="updateBbsSkin.do" onsubmit="return validateBbsSkin(this)">
        <form:hidden path="skinId" size="40"/>
        <table>
            <colgroup>
                <col class="specWidth200px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row" class="essential_input"><form:label path="skinNm">스킨이름</form:label></th>
                <td><form:input path="skinNm" size="40"/> <form:errors path="skinNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="listDrctryNm">목록 디렉토리 이름</form:label></th>
                <td><form:input path="listDrctryNm" size="40"/> <form:errors path="listDrctryNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="registDrctryNm">등록 디렉토리 이름</form:label></th>
                <td><form:input path="registDrctryNm" size="40"/> <form:errors path="registDrctryNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="updtDrctryNm">수정 디렉토리 이름</form:label></th>
                <td><form:input path="updtDrctryNm" size="40"/> <form:errors path="updtDrctryNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="viewDrctryNm">보기 디렉토리 이름</form:label></th>
                <td><form:input path="viewDrctryNm" size="40"/> <form:errors path="viewDrctryNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="replyDrctryNm">답변 디렉토리 이름</form:label></th>
                <td><form:input path="replyDrctryNm" size="40"/> <form:errors path="replyDrctryNm"/></td>
            </tr>
            </tbody>
        </table>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectBbsSkinList.do" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>