<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>NEO Administrator - CmmnDetailCode</title>
<meta name="decorator" content="neo" />
<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="cmmnDetailCodeVO" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="cmmnDetailCodeVO">
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
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">공통분류코드</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${cmmnClCode.clCodeNm}"/>(<span class="em_red"><c:out value="${cmmnClCode.clCode}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${cmmnCode.codeIdNm}"/>(<span class="em_red"><c:out value="${cmmnCode.codeId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth5_title"><c:out value="${cmmnDetailCodeVO.codeNm}"/>(<span class="em_red"><c:out value="${cmmnDetailCodeVO.code}"/></span>) 수정</span>
</div>
<div class="tab_navigation">
	<c:forEach var="result" items="${cmmnClCodeListAll}" varStatus="status">
		<a href="./selectCmmnCodeList.do?clCode=<c:out value="${result.clCode}"/>" <c:if test="${result.clCode eq cmmnClCode.clCode}">class="current"</c:if> ><c:out value="${result.clCodeNm}"/></a></li>
	</c:forEach>
	<a href="./selectCmmnCodeSearchAll.do?searchKrwd=">공통분류코드 전체검색</a></li>
</div>
<div class="dataWrap">
    <form:form modelAttribute="cmmnDetailCodeVO" name="cmmnDetailCodeForm" action="updateCmmnDetailCode.do" onsubmit="return validateCmmnDetailCodeVO(this)">
        <form:hidden path="clCode"/>
        <form:hidden path="code"/>
        <form:hidden path="codeId"/>
        <form:hidden path="pageUnit"/>
        <form:hidden path="searchCnd"/>
        <form:hidden path="searchKrwd"/>
        <form:hidden path="pageIndex"/>
        <table>
            <colgroup>
                <col class="specWidth120px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">코드</th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><c:out value="${cmmnDetailCodeVO.code}"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="codeNm">코드명</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="codeNm"/><form:errors path="codeNm"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="codeDc">코드설명</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="codeDc"/><form:errors path="codeDc"/></span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectCmmnDetailCodeList.do?clCode=<c:out value="${cmmnDetailCodeVO.clCode}"/>&amp;codeId=<c:out value="${cmmnDetailCodeVO.codeId}"/>&amp;pageUnit=<c:out value="${cmmnDetailCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnDetailCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnDetailCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnDetailCodeVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton edit"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>