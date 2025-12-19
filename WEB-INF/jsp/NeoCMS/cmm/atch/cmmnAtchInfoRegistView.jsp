<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="ATC_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

    <title>공통첨부파일 등록</title>
    <meta name="decorator" content="neo" />
    <script src="<c:url value='/cmm/validator.do'/>"></script>
    <validator:javascript formName="cmmnAtchInfoVO" staticJavascript="false" xhtml="true" cdata="false"/>
    <spring:hasBindErrors name="cmmnAtchInfoVO">
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
    <span class="depth1_title icon_attch">첨부파일설정</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">공통첨부파일관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">등록</span>
</div>
<div class="contents">

    <form:form modelAttribute="cmmnAtchInfoVO" name="cmmnAtchInfoVO" action="cmmnAtchInfoRegist.do" onsubmit="return validateCmmnAtchInfoVO(this)">
        <input type="hidden" name="fileEncAt" id="fileEncAt" value="N"/>
        <input type="hidden" name="fileEncAt" id="fileLmttExtns" value=""/>
        <table>
            <colgroup>
                <col class="specWidth170px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row" class="essential_input"><form:label path="infoCode">파일정보 코드</form:label></th>
                <td><form:input path="infoCode"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="infoNm">파일정보 명칭</form:label></th>
                <td><form:input path="infoNm"/></td>
            </tr>
            <tr>
                <th scope="row"><form:label path="infoDc">파일정보 설명</form:label></th>
                <td><form:input path="infoDc" style="width:350px;" /></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="storePath">저장경로</form:label></th>
                <td>${realPath } <form:input path="storePath" style="width:200px;" /></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="fileMaxSize">파일 최대 사이즈(MB)</form:label></th>
                <td><form:input path="fileMaxSize"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="fileMaxCo">파일 최대 업로드 개수</form:label></th>
                <td><form:input path="fileMaxCo"/></td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="fileLmttExtns">허용확장자(,로 구분)</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:label path="fileLmttExtns">확장자</form:label>
                                <a href="#n" class="textButton small delete" onclick="resetChosen()" style="float:right;"><span>확장자 선택 초기화</span></a>
                            <select name="fileLmttExtns" id="fileLmttExtns" class="p-input p-input--auto chosen-select" style="width:600px" multiple data-placeholder=" 선택" data-no_results_text="확장자를 선택해주세요." >
                                <option style="display: none;"></option>
                                <c:set var="hasImage" value="0"/>
                                    <optgroup label="일반 타입" >
                                <c:forEach var="mime" items="${mimeTypeList}">
                                    <c:if test="${mime.imgTypeAt eq '0'}">
                                        <c:set var="isChecked" value="false" />
                                        <c:if test="${fn:contains(cmmnAtchInfoVO.fileLmttExtns, mime.mimeTypeExt)}"><c:set var="isChecked" value="true" /></c:if>
                                        <option value="${mime.mimeTypeExt}"  ${isChecked ? "selected='selected'" : ''}>${mime.mimeTypeExt}</option>
                                    </c:if>
                                    <c:if test="${mime.imgTypeAt ne '0'}">
                                        <c:set var="hasImage" value="1"/>
                                    </c:if>
                                </c:forEach>
                                    </optgroup>

                                <c:if test="${hasImage eq '1'}">
                                    <optgroup label="이미지 타입" >
                                    <c:forEach var="mime" items="${mimeTypeList}">
                                        <c:if test="${mime.imgTypeAt ne '0'}">
                                            <c:set var="isChecked" value="false" />
                                            <c:if test="${fn:contains(cmmnAtchInfoVO.fileLmttExtns, mime.mimeTypeExt)}"><c:set var="isChecked" value="true" /></c:if>
                                            <option value="${mime.mimeTypeExt}"  ${isChecked ? "selected='selected'" : ''} >${mime.mimeTypeExt}</option>
                                        </c:if>
                                    </c:forEach>
                                    </optgroup>
                                </c:if>
                            </select>
                        </span>

                    </div>
                </td>
            </tr>
            </tbody>
        </table>

        <div class="arrangementWrap data_button">
            <div class="arrLeft">
                <a href="./cmmnAtchInfoList.do?pageIndex=<c:out value="${cmmnAtchInfoVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>등록</span></button>
            </div>
        </div>

    </form:form>
</div>
<link rel="stylesheet" href="/common/css/chosen.css" />
<script src="/common/js/chosen/chosen.jquery.min.js"></script>
<script src="/common/js/chosen/prism.js"></script>
<script src="/common/js/chosen/init.js"></script>
<script nonce="NEOCMSSCRIPT">
    $(document).ready(function(){
        formLabelText();
        toggleFunction();
        $("#toggle_test").on("change",function(e){
            if($(this).is(":checked")){
                $(".chosen-choices, .chosen-drop").width(600);
            }
        });

    })
</script>
</body>
</html>