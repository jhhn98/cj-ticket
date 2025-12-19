<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>팝업 항목 등록</title>
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
    <link rel="stylesheet" href="/common/css/chosen.css"/>
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_program">컴포넌트관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">팝업존항목관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title"><c:out value="${popupZone.popupZoneNm}"/> 목록</span>
</div>
<div class="dataWrap">
    <div class="form_wrap isTop">
        <form:form modelAttribute="popupZoneItemVO" name="popupZoneItemVOForm" action="addPopupZoneItem.do" onsubmit="return validatePopupZoneItemVO(this)" enctype="multipart/form-data">
        <form:hidden path="siteId"/>
        <form:hidden path="popupZoneNo"/>
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
                <th scope="row"><form:label path="multiPopupList">팝업존다중등록</form:label></th>
                <td>
                    <div class="toggle " data-element-name="toggle">
                        <input type="checkbox" id="toggle_koglUseAt" name="toggle_koglUseAt" data-true-value="Y" data-false-value="N"/>
                        <label for="toggle_koglUseAt">
                            사용여부
                            <span class="toggle_ui">on/off</span>
                        </label>
                    </div>
                    <div class="popupZone_layer">
                        <select name="multiPopupList" id="multiPopupList" class="p-input p-input--auto chosen-select" multiple data-placeholder="팝업존 선택" data-no_results_text="선택된 팝업존이 존재하지 않습니다." >
                            <c:forEach items="${allPopupZoneList}" var="pop">
                                <option value="<c:out value="${pop.popupZoneNo}"/>" <c:out value="${pop.popupZoneNo eq popupZoneItemVO.popupZoneNo ? 'selected=\"selected\"':''}"/>><c:out value="${pop.popupZoneNm}"/>(<c:out value="${pop.siteId}"/>)</option>
                            </c:forEach>
                        </select>
                        <script src="/common/js/chosen/chosen.jquery.min.js"></script>
                        <script src="/common/js/chosen/prism.js"></script>
                        <script src="/common/js/chosen/init.js"></script>
                    </div>
                </td>
            </tr>
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
                            <form:textarea path="imageReplcText" style="height:100px;" placeholder="PC 이미지 대체텍스트 입력"/><form:errors path="imageReplcText"/>
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
                            <form:textarea path="imageReplcTextMobile" style="height:100px;" placeholder="모바일 이미지 대체텍스트 입력"/><form:errors path="imageReplcTextMobile"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="imageFileEtc">ETC 이미지</label></th>
                <td>
                    <div class="form_element full">
                        <div class="element_wrap">
                            <input name="imageFileEtc" id="imageFileEtc" type="file" title="ETC 이미지 파일" size="60"/>
                        </div>
                        <div class="element_wrap marginTop_5">
                            <form:textarea path="imageReplcTextEtc" style="height:100px;" placeholder="ETC 이미지 대체텍스트 입력"/><form:errors path="imageReplcTextEtc"/>
                        </div>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
            <a href="./selectPopupZoneItemList.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
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
        $(".chosen-choices, .chosen-drop").width(600);
        $(".search-choice-close").remove();
    })
</script>
</body>
</html>