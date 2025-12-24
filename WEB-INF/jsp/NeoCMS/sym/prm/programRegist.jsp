<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="PRG_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>NEO Administrator - ProgramManage</title>
<meta name="decorator" content="neo" />
<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="programVO" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="programVO">
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
    <span class="depth1_title icon_program">컴포넌트관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">컴포넌트 등록</span>
</div>
<div class="dataWrap">
    <form:form modelAttribute="programVO" name="programForm" action="addProgram.do" onsubmit="return validateProgramVO(this)">
        <form:hidden path="pageUnit"/>
        <form:hidden path="searchCnd"/>
        <form:hidden path="searchKrwd"/>
        <form:hidden path="pageIndex"/>
        <table>
            <colgroup>
                <col class="specWidth200px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row" class="essential_input"><form:label path="progrmNm">프로그램명</form:label></th>
                <td><div class="form_element"><span class="element_wrap"><form:input path="progrmNm" size="40"/></span></div><form:errors path="progrmNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="progrmUrl">프로그램URL</form:label></th>
                <td><span class="eng_text">/사이트ID/</span><form:input path="progrmUrl" size="40"/> <form:errors path="progrmUrl"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="manageFnctEnnc">관리기능유무</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:select path="manageFnctEnnc">
                                <form:option value='' label="--선택하세요--" />
                                <c:forEach var="opt" items="${manageFnctEnncList}">
                                    <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq programVO.manageFnctEnnc ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                </c:forEach>
                            </form:select>
                        </span>
                    </div>
                    <form:errors path="manageFnctEnnc"/>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="manageUrl">관리URL</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="manageUrl" size="60"/> <form:errors path="manageUrl"/>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="progrmDc">프로그램설명</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:input path="progrmDc" size="80"/> <form:errors path="progrmDc"/>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="progrmCode">프로그램CODE</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:input path="progrmCode" size="80" maxlength="10"/> <form:errors path="progrmCode"/>
                        </span>
                    </div>
                </td>
            </tr>
			<tr>
                <th scope="row"><form:label path="progrmSe">프로그램 구분</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:input path="progrmSe" size="80" maxlength="10"/> <form:errors path="progrmSe"/>
                        </span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="arrangementWrap data_button">
            <div class="arrLeft">
                <a href="./selectProgramList.do?pageUnit=<c:out value="${programVO.pageUnit}"/>&amp;searchCnd=<c:out value="${programVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${programVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${programVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>등록</span></button>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>