<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배너 항목 등록</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="bannerZoneItemVO" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="bannerZoneItemVO">
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
<div class="p-wrap">

    <div class="col-20">
        <div>
            <span class="p-icon p-icon__info-circle">주의사항</span>
            <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
        </div>

    <form:form modelAttribute="bannerZoneItemVO" name="bannerZoneItemVOForm" action="addBannerZoneItem.do" onsubmit="return validateBannerZoneItemVO(this)" enctype="multipart/form-data">
        <input type="hidden" name="key" id="key2" value="<c:out value="${key}"/>" />
        <form:hidden path="siteId"/>
        <form:hidden path="bannerZoneNo"/>
        <form:hidden path="pageUnit"/>
        <form:hidden path="searchCnd"/>
        <form:hidden path="searchKrwd"/>
        <form:hidden path="searchShowSe"/>
        <form:hidden path="pageIndex"/>
        <table class="p-table" id="burialTable">
            <colgroup>
                <col class="w15p">
                <col/>
            </colgroup>
            <tbody class="p-table--th-left">
            <tr>
                <th scope="row" class="essential_input"><form:label path="bannerZoneIemNm">배너이름</form:label><span class="p-form__required--icon">필수</span></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:input path="bannerZoneIemNm" size="40"/>
                            <form:errors path="bannerZoneIemNm"/>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="showSe">표시구분</form:label><span class="p-form__required--icon">필수</span></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:select path="showSe">
                                <form:option value='' label="--선택하세요--" />
                                <c:forEach var="opt" items="${showSeList}">
                                    <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bannerZoneItemVO.showSe ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                </c:forEach>
                            </form:select>
                            <form:errors path="showSe"/>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="bgnde">기간</form:label></th>
                <td>
                    <form:select path="syear">
                        <c:forEach begin="${bannerZoneItemVO.minYear}" end="${bannerZoneItemVO.maxYear}" varStatus="idx">
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
                        <c:forEach begin="${bannerZoneItemVO.minYear}" end="${bannerZoneItemVO.maxYear}" varStatus="idx">
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
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:input path="linkUrl" size="60"/>
                            <form:errors path="linkUrl"/>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="linkTrget">링크대상</form:label><span class="p-form__required--icon">필수</span></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <form:select path="linkTrget">
                                <form:option value='' label="--선택하세요--" />
                                <c:forEach var="opt" items="${linkTrgetList}">
                                    <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bannerZoneItemVO.linkTrget ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                </c:forEach>
                            </form:select>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="imageReplcText">대체텍스트</form:label><span class="p-form__required--icon">필수</span></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap el_textarea">
                            <form:textarea path="imageReplcText"  style="width:500px; height:100px" class="p-input" />
                            <form:errors path="imageReplcText"/>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><label for="imageFile">이미지파일</label><span class="p-form__required--icon">필수</span></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap">
                            <input name="imageFile" id="imageFile" type="file" title="이미지파일" size="60"/>
                        </span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="row margin_t_20">
            <div class="col-12">
                <a href="./selectBannerZoneItemList.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="p-button cancel"><span>목록</span></a>
            </div>
            <div class="col-12 right">
                <button type="submit" class="p-button write"><span>등록</span></button>
            </div>
        </div>
    </form:form>
    </div>

</div>
</body>
</html>