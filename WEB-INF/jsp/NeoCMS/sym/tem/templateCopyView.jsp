<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="TMP_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

    <title>템플릿 상세정보</title>
    <meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
    <span class="depth1_title icon_template">템플릿설정</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">상세정보</span>
</div>

<div class="dataWrap">

    <form:form modelAttribute="template" name="templateForm" action="copyTemplate.do" onsubmit="return validateTemplate(this)">
        <div class="form_wrap isTopBottom">
            <form:hidden path="tmplatId" />
            <input type="hidden" name="tmplatSrc" id="tmplatSrc" value="<c:out value="${template.tmplatId}"/>"/>
            <table>
                <colgroup>
                    <col class="specWidth160px"/>
                    <col/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">원본 템플릿아이디</th>
                    <td><c:out value="${template.tmplatId}"/></td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="tmplatNm">템플릿이름</form:label></th>
                    <td><form:input path="tmplatNm" size="40"/> <form:errors path="tmplatNm"/></td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="tmplatDst">템플릿아이디</form:label></th>
                    <td><form:input path="tmplatDst" size="40"/> <form:errors path="tmplatDst"/></td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectTemplateList.do" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>복사</span></button>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>