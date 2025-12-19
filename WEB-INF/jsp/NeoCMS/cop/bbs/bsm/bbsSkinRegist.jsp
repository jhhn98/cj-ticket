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
<title>스킨 등록</title>
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
    <span class="depth4_title">등록</span>
</div>
<div class="dataWrap">
    <form:form modelAttribute="bbsSkin" name="bbsSkinForm" action="addBbsSkin.do" onsubmit="return validateBbsSkin(this)">
        <table>
            <colgroup>
                <col class="specWidth200px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row" class="essential_input"><form:label path="skinId">스킨ID</form:label></th>
                <td><form:input path="skinId" size="40"/> <form:errors path="skinId"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="skinNm">스킨이름</form:label></th>
                <td><form:input path="skinNm" size="40"/> <form:errors path="skinNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="baseSkinId">초기 설정 복사 대상 스킨 ID</form:label></th>
                <td>
                    <form:select path="baseSkinId">
                        <c:forEach var="opt" items="${bbsSkinList}">
                            <option value="<c:out value="${opt.skinId}"/>" <c:out value="${opt.skinId eq bbsSkin.baseSkinId ? 'selected=true':''}"/>><c:out value="${opt.skinNm}"/></option>
                        </c:forEach>
                    </form:select> <form:errors path="baseSkinId"/>
                </td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="listDrctryNm">목록 디렉토리 스킨이름</form:label></th>
                <td><form:select path="listDrctryNm">
                    <option value="-1">새로생성</option>
                    <c:forEach var="opt" items="${bbsSkinList}">
                        <option value="<c:out value="${opt.skinId}"/>" <c:out value="${opt.skinId eq bbsSkin.listDrctryNm ? 'selected=true':''}"/>><c:out value="${opt.skinNm}"/></option>
                    </c:forEach>
                </form:select> <form:errors path="listDrctryNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="registDrctryNm">등록 디렉토리 스킨이름</form:label></th>
                <td><form:select path="registDrctryNm">
                    <option value="-1">새로생성</option>
                    <c:forEach var="opt" items="${bbsSkinList}">
                        <option value="<c:out value="${opt.skinId}"/>" <c:out value="${opt.skinId eq bbsSkin.registDrctryNm ? 'selected=true':''}"/>><c:out value="${opt.skinNm}"/></option>
                    </c:forEach>
                </form:select><form:errors path="registDrctryNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="updtDrctryNm">수정 디렉토리 스킨이름</form:label></th>
                <td><form:select path="updtDrctryNm">
                    <option value="-1">새로생성</option>
                    <c:forEach var="opt" items="${bbsSkinList}">
                        <option value="<c:out value="${opt.skinId}"/>" <c:out value="${opt.skinId eq bbsSkin.updtDrctryNm ? 'selected=true':''}"/>><c:out value="${opt.skinNm}"/></option>
                    </c:forEach>
                </form:select> <form:errors path="updtDrctryNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="viewDrctryNm">보기 디렉토리 스킨이름</form:label></th>
                <td><form:select path="viewDrctryNm">
                    <option value="-1">새로생성</option>
                    <c:forEach var="opt" items="${bbsSkinList}">
                        <option value="<c:out value="${opt.skinId}"/>" <c:out value="${opt.skinId eq bbsSkin.viewDrctryNm ? 'selected=true':''}"/>><c:out value="${opt.skinNm}"/></option>
                    </c:forEach>
                </form:select> <form:errors path="viewDrctryNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="replyDrctryNm">답변 디렉토리 스킨이름</form:label></th>
                <td><form:select path="replyDrctryNm">
                    <option value="-1">새로생성</option>
                    <c:forEach var="opt" items="${bbsSkinList}">
                        <option value="<c:out value="${opt.skinId}"/>" <c:out value="${opt.skinId eq bbsSkin.replyDrctryNm ? 'selected=true':''}"/>><c:out value="${opt.skinNm}"/></option>
                    </c:forEach>
                </form:select> <form:errors path="replyDrctryNm"/></td>
            </tr>
            </tbody>
        </table>
        <div class="arrangementWrap data_button">
            <div class="arrLeft">
                <a href="./selectBbsSkinList.do" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>등록</span></button>
            </div>
        </div>
	</form:form>
</div>
</body>
</html>