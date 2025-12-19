<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>링크존 등록</title>
	<meta name="decorator" content="neo" />
	<script  src="<c:url value='/cmm/validator.do'/>"></script>
	<validator:javascript formName="linkZone" staticJavascript="false" xhtml="true" cdata="false"/>
	<spring:hasBindErrors name="linkZone">
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
	<span class="depth2_title">링크존관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${selectedSite.siteNm}"/>(<span class="em_red"><c:out value="${selectedSite.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${linkZone.linkZoneNm}"/>  수정</span>
</div>
<div class="dataWrap">
    <form:form modelAttribute="linkZone" name="linkZoneForm" action="updateLinkZone.do" onsubmit="return validateLinkZone(this)">
        <form:hidden path="linkZoneNo"/>
        <form:hidden path="siteId"/>
        <table>
            <colgroup>
                <col class="specWidth200px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">사이트ID</th>
                <td><c:out value="${linkZone.siteId}"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="linkZoneNm">링크존이름</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:input path="linkZoneNm" size="40"/>
                            <form:errors path="linkZoneNm"/>
                        </span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectLinkZoneList.do?siteId=<c:out value="${linkZone.siteId}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton edit"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>