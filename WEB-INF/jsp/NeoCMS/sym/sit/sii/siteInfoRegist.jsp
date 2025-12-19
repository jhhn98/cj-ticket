<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="SITE_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

    <title>사이트정보 등록</title>
    <meta name="decorator" content="neo" />
    <script src="./js/common.js"></script>
    <script src="<c:url value='/cmm/validator.do'/>"></script>
    <validator:javascript formName="siteInfo" staticJavascript="false" xhtml="true" cdata="false"/>
    <spring:hasBindErrors name="siteInfo">
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
    <span class="depth1_title icon_site">사이트관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">등록</span>
</div>

<jsp:include page="./subMenu.jsp" />

<div class="dataWrap">
    <form:form modelAttribute="siteInfo" name="siteInfoForm" action="addSiteInfo.do" onsubmit="return validateSiteInfo(this)">
        <div class="form_wrap isTopBottom">

            <form:hidden path="dfltSiteAt" value="N"/>

            <table>
                <colgroup>
                    <col class="specWidth140px"/>
                    <col/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="siteSe">사이트구분</form:label></th>
                    <td>
                        <div class="form_element">
                            <span class="element_wrap">
                                <form:select path="siteSe">
                                    <form:option value='' label="--선택하세요--" />
                                    <c:forEach var="opt" items="${siteSeList}">
                                        <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq siteInfo.siteSe ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                    </c:forEach>
                                </form:select>
                                <form:errors path="siteSe"/>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="siteId">사이트ID</form:label></th>
                    <td>
                        <div class="form_element">
                            <span class="element_wrap"><form:input path="siteId" size="20"/> <form:errors path="siteId"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="siteNm">사이트명</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="siteNm" size="40"/> <form:errors path="siteNm"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="siteAuthr">제작자</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="siteAuthr" size="40"/> <form:errors path="siteAuthr"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="siteKwrd">키워드</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="siteKwrd" size="80"/> <form:errors path="siteKwrd"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="siteDc">사이트설명</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="siteDc" size="80"/> <form:errors path="siteDc"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="siteUrl">사이트URL</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="siteUrl" size="80"/> <form:errors path="siteUrl"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><label for="toggle_actvtyAt">활성여부</label></th>
                    <td>
                        <input type="hidden" name="actvtyAt" id="actvtyAt" value="<c:out value="${siteInfo.actvtyAt}"/>" />
                        <div class="toggle <c:out value="${siteInfo.actvtyAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="toggle_actvtyAt" name="toggle_actvtyAt"  value="Y" data-true-value="Y" data-false-value="N" <c:out value="${siteInfo.actvtyAt eq 'Y' ? 'checked=\"checked\"':''}"/>/>
                            <label for="toggle_actvtyAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <%--
                        <form:select path="actvtyAt">
                            <form:option value='' label="--선택하세요--" />
                            <c:forEach var="opt" items="${actvtyAtList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq siteInfo.actvtyAt ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="actvtyAt"/>
                        --%>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="insttAdres">기관주소</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="insttAdres" size="80"/> <form:errors path="insttAdres"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="insttTelno">기관연락처</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="insttTelno" size="40"/> <form:errors path="insttTelno"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="insttFax">기관팩스</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="insttFax" size="40"/> <form:errors path="insttFax"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="insttEmail">기관이메일</form:label></th>
                    <td>
                        <div class="form_element">
                            <span class="element_wrap"><form:input path="insttEmail" size="40"/> <form:errors path="insttEmail"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="siteCpyrht">사이트저작권</form:label></th>
                    <td>
                        <div class="form_element full">
                            <span class="element_wrap"><form:input path="siteCpyrht" size="80"/> <form:errors path="siteCpyrht"/></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="tmplatId">템플릿</form:label></th>
                    <td>
                        <div class="form_element">
                            <span class="element_wrap">
                                <form:select path="tmplatId">
                                    <form:option value='' label="--선택하세요--" />
                                    <c:forEach var="opt" items="${templateList}">
                                        <option value="<c:out value="${opt.tmplatId}"/>" <c:out value="${opt.tmplatId eq siteInfo.tmplatId ? 'selected=true':''}"/>><c:out value="${opt.tmplatNm}"/></option>
                                    </c:forEach>
                                </form:select>
                                <form:errors path="tmplatId"/>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input">공공누리</th>
                    <td>
                        <%--
                        <form:select path="koglUseAt">
                            <form:option value="">선택</form:option>
                            <form:option value="N">사용안함</form:option>
                            <form:option value="Y">사용함</form:option>
                        </form:select>
                        --%>
                        <input type="hidden" name="koglUseAt" id="koglUseAt" value="<c:out value="${siteInfo.koglUseAt}"/>" />
                        <div class="toggle  <c:out value="${siteInfo.koglUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="toggle_koglUseAt" name="toggle_koglUseAt" <c:out value="${siteInfo.koglUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> data-true-value="Y" data-false-value="N"/>
                            <label for="toggle_koglUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <ul class="kogl_layer">
                            <li>
                                <form:radiobutton path="dfltKoglTy" value="KOGLTY01" checked="checked"/>
                                <label for="dfltKoglTy1">
                                    제1유형 : 출처표시
                                    <em class="kogl_summary">
                                        <i class="kogl_img type1">OPEN 출처표시 공공누리 공공저작물 자유이용허락</i>
                                    </em>
                                </label>
                            </li>
                            <li>
                                <form:radiobutton path="dfltKoglTy" value="KOGLTY02"/>
                                <label for="dfltKoglTy2">
                                    제2유형 : 출처 표시 + 상업적 이용금지
                                    <em class="kogl_summary">
                                        <i class="kogl_img type2">OPEN 출처표시 상업용금지 공공누리 공공저작물 자유이용허락</i>
                                    </em>
                                </label>
                            </li>
                            <li>
                                <form:radiobutton path="dfltKoglTy" value="KOGLTY03"/>
                                <label for="dfltKoglTy3">
                                    제3유형 : 출처 표시 + 변경금지
                                    <em class="kogl_summary">
                                        <i class="kogl_img type3">OPEN 출처표시 변경금지 공공누리 공공저작물 자유이용허락</i>
                                    </em>
                                </label>
                            </li>
                            <li>
                                <form:radiobutton path="dfltKoglTy" value="KOGLTY04"/>
                                <label for="dfltKoglTy4">
                                    제4유형 : 출처표시 + 상업용금지 + 변경금지
                                    <em class="kogl_summary">
                                        <i class="kogl_img type4">OPEN 출처표시 상업용금지 변경금지 공공누리 공공저작물 자유이용허락</i>
                                    </em>
                                </label>
                            </li>
                        </ul>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectSiteInfoList.do?siteSe=<c:out value="${siteInfo.siteSe}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>등록</span></button>
            </div>
        </div>
    </form:form>
</div>
<script nonce="NEOCMSSCRIPT">
    $(document).ready(function(){
        toggleFunction();
        $("#toggle_actvtyAt").on("change",function(e){
            $("#actvtyAt").val($(this).val());
        });
        $("#toggle_koglUseAt").on("change",function(e){
            $("#koglUseAt").val($(this).val());
        });
    })
</script>
</body>
</html>