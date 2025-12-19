<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>팝업 항목 수정</title>
    <meta name="decorator" content="neo" />
    <script  src="<c:url value='/cmm/validator.do'/>"></script>
    <validator:javascript formName="popupZoneItemVO" staticJavascript="false" xhtml="true" cdata="false"/>
    <spring:hasBindErrors name="popupZoneItemVO">
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
    <span class="depth2_title">팝업존항목관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title"><c:out value="${popupZone.popupZoneNm}"/> 수정</span>
</div>
<div class="dataWrap">
    <form:form modelAttribute="popupZoneItemVO" name="popupZoneItemVOForm" action="updatePopupZoneItem.do" onsubmit="return validatePopupZoneItemVO(this)" enctype="multipart/form-data">
    <div class="form_wrap isTop">
            <form:hidden path="siteId"/>
            <form:hidden path="popupZoneNo"/>
            <form:hidden path="popupZoneIemNo"/>
            <form:hidden path="pageUnit"/>
            <form:hidden path="searchCnd"/>
            <form:hidden path="searchKrwd"/>
            <form:hidden path="searchShowSe"/>
            <form:hidden path="pageIndex"/>
            <table>
                <colgroup>
                    <col class="specWidth200px"/>
                    <col/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="popupZoneIemNm">팝업이름</form:label></th>
                    <td><form:input path="popupZoneIemNm" size="40"/> <form:errors path="popupZoneIemNm"/></td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="showSe">표시구분</form:label></th>
                    <td>
                        <form:select path="showSe">
                            <form:option value='' label="--선택하세요--" />
                            <c:forEach var="opt" items="${showSeList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq popupZoneItemVO.showSe ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="showSe"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="bgnde">기간</form:label></th>
                    <td>
                        <form:select path="syear">
                            <c:forEach begin="${popupZoneItemVO.minYear}" end="${popupZoneItemVO.maxYear}" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>년
                        <form:select path="smonth">
                            <c:forEach begin="1" end="12" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>월
                        <form:select path="sday">
                            <c:forEach begin="1" end="31" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>일
                        <form:select path="shour">
                            <c:forEach begin="0" end="23" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>시
                        <form:select path="sminute">
                            <c:forEach begin="0" end="59" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>분
                        ~
                        <form:select path="eyear">
                            <c:forEach begin="${popupZoneItemVO.minYear}" end="${popupZoneItemVO.maxYear}" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>년
                        <form:select path="emonth">
                            <c:forEach begin="1" end="12" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>월
                        <form:select path="eday">
                            <c:forEach begin="1" end="31" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>일
                        <form:select path="ehour">
                            <c:forEach begin="0" end="23" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>시
                        <form:select path="eminute">
                            <c:forEach begin="0" end="59" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>분
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="linkUrl">링크URL</form:label></th>
                    <td><form:input path="linkUrl" size="60"/> <form:errors path="linkUrl"/></td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="linkTrget">링크대상</form:label></th>
                    <td>
                        <form:select path="linkTrget">
                            <form:option value='' label="--선택하세요--" />
                            <c:forEach var="opt" items="${linkTrgetList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq popupZoneItemVO.linkTrget ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><label for="imageFile">PC 이미지</label></th>
                    <td>
                        <div class="form_element full">
                            <div class="element_wrap">
                                <input name="imageFile" id="imageFile" type="file" title="PC 이미지 파일" size="60"/>
                            </div>
                            <div class="element_wrap marginTop_5">
                                <form:textarea path="imageReplcText" style="height:100px;" placeholder="PC 이미지 대체텍스트 입력"/>
                                <form:errors path="imageReplcText"/>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="imageFileMobile">모바일 이미지</label></th>
                    <td>
                        <div class="form_element full">
                            <div class="element_wrap">
                                <input name="imageFileMobile" id="imageFileMobile" type="file" title="모바일 이미지 파일" size="60"/>
                            </div>
                            <div class="element_wrap marginTop_5">
                                <form:textarea path="imageReplcTextMobile" style="height:100px;" placeholder="모바일 이미지 대체텍스트 입력"/>
                                <form:errors path="imageReplcTextMobile"/>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="imageFileEtc">기타 이미지</label></th>
                    <td>
                        <div class="form_element full">
                            <div class="element_wrap">
                                <form:textarea path="imageReplcTextEtc" style="height:100px;"/>
                                <form:errors path="imageReplcTextEtc"/>
                            </div>
                            <div class="element_wrap marginTop_5">
                                <input name="imageFileEtc" id="imageFileEtc" type="file" title="기타 이미지 파일" size="60"/>
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>

    </div>
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
            <a href="./selectPopupZoneItemList.do?siteId=<c:out value="${popupZone.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
            <button type="submit" class="iconTextButton edit"><span>수정</span></button>
        </div>
    </div>
    </form:form>
</div>

</body>
</html>