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

	<title>NeoCMS Administrator</title>
	<meta name="decorator" content="neo" />


</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_code">코드관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">공통분류코드 관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${cmmnClCodeVO.clCode}"/></span>
</div>

<div class="contents">

	<script src="<c:url value="/common/js/jquery-3.6.0.min.js"/>"></script>
	<script src="<c:url value='/cmm/validator.do'/>"></script>
	<validator:javascript formName="cmmnClCodeVO" staticJavascript="false" xhtml="true" cdata="false"/>

	<spring:hasBindErrors name="cmmnClCodeVO">
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
    <form:form modelAttribute="cmmnClCodeVO" name="cmmnClCodeForm" action="updateCmmnClCode.do" onsubmit="return validateCmmnClCodeVO(this)">

        <div class="form_wrap">
            <form:hidden path="clCode"/>
            <form:hidden path="pageUnit"/>
            <form:hidden path="searchCnd"/>
            <form:hidden path="searchKrwd"/>
            <form:hidden path="pageIndex"/>
            <table>
                <colgroup>
                    <col class="specWidth33per"/>
                    <col class="specWidth33per"/>
                    <col class="specWidth33per"/>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">분류코드</th>
                    <th scope="col" class="essential_input"><form:label path="clCodeNm">분류코드명</form:label></th>
                    <th scope="col"><form:label path="clCodeDc">분류코드설명</form:label></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><c:out value="${cmmnClCodeVO.clCode}"/></td>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="clCodeNm"/> <form:errors path="clCodeNm"/></span>
                        </div>
                    </td>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="clCodeDc"/> <form:errors path="clCodeDc"/></span>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectCmmnClCodeList.do?pageUnit=<c:out value="${cmmnClCodeVO.pageUnit}"/>&amp;searchCnd=<c:out value="${cmmnClCodeVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${cmmnClCodeVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${cmmnClCodeVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton edit"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</body>
</html>