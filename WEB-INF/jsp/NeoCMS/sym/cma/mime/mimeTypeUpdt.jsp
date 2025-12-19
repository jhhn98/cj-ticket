<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="CMC_3" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    
    <title>NEO Administrator - MimeType</title>
    <meta name="decorator" content="neo" />
    <link rel="stylesheet" href="./css/subheader.css" />
    
    
</head>
<body>

<div class="page_location">
    <span class="depth1_title icon_code">코드관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">마임타입관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title">${mimeTypeVO.mimeTypeNm}</span>
</div>


<div class="contents">
    <form:form modelAttribute="mimeTypeVO" name="mimeTypeVOForm" action="updateMimeType.do">
        <div class="form_wrap">

            <form:hidden path="pageUnit"/>
            <form:hidden path="searchCnd"/>
            <form:hidden path="searchKrwd"/>
            <form:hidden path="pageIndex"/>
            <form:hidden path="mimeNo"/>
            <table>
                <colgroup>
                    <col class="specWidth33per"/>
                    <col class="specWidth33per"/>
                    <col class="specWidth33per"/>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col" class="essential_input"><form:label path="mimeTypeNm">마임타입 이름</form:label></th>
                    <th scope="col" class="essential_input"><form:label path="mimeTypeExt">마임타입 확장자</form:label></th>
                    <th scope="col"><form:label path="mimeTypeInfo">마임타입 설명</form:label></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="mimeTypeNm" placeholder="ex) image/png"/><form:errors path="mimeTypeNm" cssStyle="color:red;"/></span>
                        </div>
                    </td>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="mimeTypeExt" placeholder="ex) png"/><form:errors path="mimeTypeExt" cssStyle="color:red;"/></span>
                        </div>
                    </td>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="mimeTypeInfo" placeholder="ex) png 이미지"/><form:errors path="mimeTypeInfo" cssStyle="color:red;"/></span>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectMimeTypeList.do?pageUnit=${mimeTypeVO.pageUnit}&amp;pageIndex=${mimeTypeVO.pageIndex}&amp;searchCnd=${mimeTypeVO.searchCnd}&amp;searchKrwd=${mimeTypeVO.searchKrwd}" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton edit"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>