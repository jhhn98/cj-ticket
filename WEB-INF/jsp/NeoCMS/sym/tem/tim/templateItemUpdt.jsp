<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="TMP_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>템플릿항목 등록</title>
	<meta name="decorator" content="neo" />

	<script src="<c:url value='/cmm/validator.do'/>"></script>
	<validator:javascript formName="templateItem" staticJavascript="false" xhtml="true" cdata="false"/>
	<spring:hasBindErrors name="templateItem">
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
	<span class="depth1_title icon_template">템플릿설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title"><c:out value="${template.tmplatNm}"/>(<span class="em_red"><c:out value="${template.tmplatId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title"><c:out value="${templateItem.tmplatIemNm}"/> 수정</span>
</div>

<div class="dataWrap">
    <form:form modelAttribute="templateItem" name="templateItemForm" action="updateTemplateItem.do" enctype="multipart/form-data" onsubmit="return validateTemplateItem(this)">
        <form:hidden path="tmplatId"/>
        <form:hidden path="tmplatIemNo"/>
        <table>
            <colgroup>
                <col class="specWidth140px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">템플릿항목 구분</th>
                <td><c:out value="${tmplatIemSeMap[templateItem.tmplatIemSe]}"/></td>
            </tr>
            <tr>
                <th scope="row">템플릿항목 이름</th>
                <td><c:out value="${templateItem.tmplatIemNm}"/></td>
            </tr>
            <tr>
                <th scope="row">저장될 파일명</th>
                <td class="eng_text"><c:out value="${templateItem.tmplatIemFileNm}"/>.ftl</td>
            </tr>
            <tr>
                <th scope="row" class="essential_input">템플릿항목 파일</th>
                <td><input name="tmplatIemFile" id="tmplatIemFile" type="file" title="첨부파일입력" size="60"/></td>
            </tr>
            </tbody>
        </table>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectTemplateItemList.do?tmplatId=<c:out value="${templateItem.tmplatId}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton edit"><span>수정</span></button>
            </div>
        </div>

    </form:form>
</div>
</body>
</html>