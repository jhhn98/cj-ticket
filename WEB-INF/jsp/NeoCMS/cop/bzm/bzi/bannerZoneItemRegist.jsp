<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>배너 항목 등록</title>
<meta name="decorator" content="neo"/>
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
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">배너존관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red eng_text"><c:out value="${siteInfo.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bannerZone.bannerZoneNm}"/> 등록</span>
</div>
<div class="dataWrap">
    <form:form modelAttribute="bannerZoneItemVO" name="bannerZoneItemVOForm" action="addBannerZoneItem.do" onsubmit="return validateBannerZoneItemVO(this)" enctype="multipart/form-data">
        <form:hidden path="siteId"/>
        <form:hidden path="bannerZoneNo"/>
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
                <th scope="row" class="essential_input"><form:label path="bannerZoneIemNm">배너이름</form:label></th>
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
                <th scope="row" class="essential_input"><form:label path="showSe">표시구분</form:label></th>
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
                <th scope="row" class="essential_input"><form:label path="linkTrget">링크대상</form:label></th>
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
                <th scope="row" class="essential_input"><form:label path="imageReplcText">대체텍스트</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap el_textarea">
                            <form:textarea path="imageReplcText" style="height:100px"/>
                            <form:errors path="imageReplcText"/>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><label for="imageFile">이미지파일</label></th>
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
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectBannerZoneItemList.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>등록</span></button>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>