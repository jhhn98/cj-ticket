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

	<title>템플릿 등록</title>
	<meta name="decorator" content="neo" />

	<script src="<c:url value='/cmm/validator.do'/>"></script>
	<validator:javascript formName="template" staticJavascript="false" xhtml="true" cdata="false"/>
	<spring:hasBindErrors name="template">
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
	<span class="depth2_title">등록</span>
</div>

<div class="dataWrap">
    <form:form modelAttribute="template" name="templateForm" action="addTemplate.do" enctype="multipart/form-data" onsubmit="return validateTemplate(this)">
        <div class="form_wrap">
            <table>
                <colgroup>
                    <col class="specWidth120px"/>
                    <col/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="tmplatId">템플릿 ID</form:label></th>
                    <td>
                        <div class="form_element">
                            <span class="element_wrap"><form:input path="tmplatId"/> <form:errors path="tmplatId"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="tmplatNm">템플릿 이름</form:label></th>
                    <td>
                        <div class="form_element">
                            <span class="element_wrap"><form:input path="tmplatNm"/> <form:errors path="tmplatNm"/></span>
                        </div>
                    </td>
                </tr><%--
    <tr>
        <th><em>*</em> 메인 이미지</th>
        <td><input name="mainImg" id="mainImg" type="file" title="첨부파일입력" size="60"/></td>
    </tr>
    <tr>
        <th><em>*</em> 서브 이미지</th>
        <td><input name="subImg" id="subImg" type="file" title="첨부파일입력" size="60"/></td>
    </tr>--%>
                </tbody>
            </table>

            <div class="arrangementWrap marginTop_20">
                <div class="arrLeft">
                    <a href="./selectTemplateList.do" class="iconTextButton list"><span>목록</span></a>
                </div>
                <div class="arrRight">
                    <button type="submit" class="iconTextButton write"><span>등록</span></button>
                </div>
            </div>

        </div>
    </form:form>
</div>
<script nonce="NEOCMSSCRIPT">
    $(document).ready(function(){
        formLabelText();
    })
</script>
</body>
</html>