<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>팝업존 수정</title>
<meta name="decorator" content="neo" />
<script  src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="popupZone" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="popupZone">
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
	<span class="depth2_title">팝업존관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${selectedSite.siteNm}"/>(<span class="em_red"><c:out value="${selectedSite.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${popupZone.popupZoneNm}"/> 수정</span>
</div>
<div class="dataWrap">
    <form:form modelAttribute="popupZone" name="popupZoneForm" action="updatePopupZone.do" onsubmit="return validatePopupZone(this)">
        <form:hidden path="popupZoneNo"/>
        <form:hidden path="siteId"/>
        <table class="settingFormTable">
            <colgroup>
                <col class="specWidth200px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row" class="verticalAMiddle">사이트ID</th>
                <td><c:out value="${popupZone.siteId}"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input verticalAMiddle"><form:label path="popupZoneNm">팝업존이름</form:label></th>
                <td><form:input path="popupZoneNm" size="40"/> <form:errors path="popupZoneNm"/></td>
            </tr>
            <tr>
                <th scope="row" class="verticalAMiddle"><form:label path="imageWidthSize">이미지크기</form:label></th>
                <td>
                    <div class="setting_block element_count_three">
                        <div class="element_inlineBlock">
                            <div class="setting_title">PC 이미지 크기</div>
                            <form:label path="imageWidthSize">가로</form:label>
                            <form:input path="imageWidthSize" size="5" maxlength="3"/> px
                             *
                            <form:label path="imageHeightSize">세로</form:label>
                            <form:input path="imageHeightSize" size="5" maxlength="3"/> px
                        </div>
                        <div class="element_inlineBlock">
                            <div class="setting_title">모바일 이미지 크기</div>
                            <form:label path="imageWidthSizeMobile">가로</form:label>
                            <form:input path="imageWidthSizeMobile" size="5" maxlength="3"/> px
                             *
                            <form:label path="imageHeightSizeMobile">세로</form:label>
                            <form:input path="imageHeightSizeMobile" size="5" maxlength="3"/> px
                        </div>
                        <div class="element_inlineBlock">
                            <div class="setting_title">기타 이미지 크기</div>
                            <form:label path="imageWidthSizeEtc">가로</form:label>
                            <form:input path="imageWidthSizeEtc" size="5" maxlength="3"/> px
                             *
                            <form:label path="imageHeightSizeEtc">세로</form:label>
                            <form:input path="imageHeightSizeEtc" size="5" maxlength="3"/> px
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="verticalAMiddle">이미지 리사이징 사용여부</th>
                <td><input type="hidden" name="resizeUseAt" id="resizeUseAt" value="<c:out value="${popupZone.resizeUseAt}"/>" />
                    <div class="toggle <c:out value="${popupZone.resizeUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                        <input type="checkbox" id="toggle_resizeUseAt" <c:out value="${popupZone.resizeUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="toggle_resizeUseAt" data-true-value="Y" data-false-value="N" value="Y"/>
                        <label for="toggle_resizeUseAt">
                            사용여부
                            <span class="toggle_ui">on/off</span>
                        </label>
                    </div>
                    <div>
                        <span>리사이징 타입</span>
                        <select id="resizeType" name="resizeType">
                            <option value="FIX" <c:out value="${popupZone.resizeType eq 'FIX' ? 'selected=\"selected\"':''}"/>>가로 세로 지정크기로 고정형</option>
                            <option value="W_FIX" <c:out value="${popupZone.resizeType eq 'W_FIX' ? 'selected=\"selected\"':''}"/>>가로 고정</option>
                            <option value="H_FIX" <c:out value="${popupZone.resizeType eq 'H_FIX' ? 'selected=\"selected\"':''}"/>>세로 고정</option>
                            <option value="AUTO" <c:out value="${popupZone.resizeType eq 'AUTO' ? 'selected=\"selected\"':''}"/>>비율유지</option>
                        </select>
                        <p class="info_text topMargin em_red_bold">지정된 이미지크기를 기준으로 이미지가 형식에 맞춰 리사이징 됩니다.</p>
                        <p class="info_text topMargin">
                            가로 세로 지정크기로 고정형 : (w:400,h:2000) <img src="./images/icon_arrow_r.gif" style="vertical-align:middle; margin:0 5px 0 5px"/>  (w:<c:out value="${popupZone.imageWidthSize}"/>,h:<c:out value="${popupZone.imageHeightSize}"/>)<br />
                            가로 고정 : (w:400,h:2000) <img src="./images/icon_arrow_r.gif" style="vertical-align:middle; margin:0 5px 0 5px"/> (w:<c:out value="${popupZone.imageWidthSize}"/>,h:비율에맞춰서)<br />
                            세로 고정 : (w:400,h:2000) <img src="./images/icon_arrow_r.gif" style="vertical-align:middle; margin:0 5px 0 5px"/>  (w:비율에맞춰서,h:<c:out value="${popupZone.imageHeightSize}"/>)<br />
                            비율유지 : (w:400,h:2000) <img src="./images/icon_arrow_r.gif" style="vertical-align:middle; margin:0 5px 0 5px"/>  (가로고정 or 세로고정 이미지 크기에 맞게 자동 선택)</p>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectPopupZoneList.do?siteId=<c:out value="${popupZone.siteId}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</div>
<script nonce="NEOCMSSCRIPT">
	$(document).ready(function(){
		toggleFunction();
		$("#toggle_resizeUseAt").on("change",function(e){
			$("#resizeUseAt").val($(this).val());
		});
	})
</script>
</body>
</html>