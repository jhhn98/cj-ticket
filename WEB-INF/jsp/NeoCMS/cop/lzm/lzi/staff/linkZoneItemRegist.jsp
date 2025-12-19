<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>링크 항목 수정</title>
<meta name="decorator" content="${menuInfo.siteId}" />
<script  src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="linkZoneItemVO" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="linkZoneItemVO">
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

<div class="p-wrap">

	<div class="col-20">
		<div>
			<span class="p-icon p-icon__info-circle">주의사항</span>
            <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
		</div>

		<form:form modelAttribute="linkZoneItemVO" name="linkZoneItemVOForm" action="./addLinkZoneItem.do" onsubmit="return validateLinkZoneItemVO(this)">
		<input type="hidden" name="key" id="key2" value="<c:out value="${key}"/>" />
        <form:hidden path="siteId"/>
        <form:hidden path="linkZoneNo"/>
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
                <th scope="row"><form:label path="linkZoneIemNm">링크이름</form:label></th>
                <td><form:input path="linkZoneIemNm" size="40"/> <form:errors path="linkZoneIemNm"/></td>
            </tr>
            <tr>
                <th scope="row"><form:label path="showSe">표시구분</form:label></th>
                <td>
					<form:select path="showSe" class="p-input  p-input--auto">
						<form:option value='' label="--선택하세요--" />
						<c:forEach var="opt" items="${showSeList}">
							<option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq linkZoneItemVO.showSe ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
						</c:forEach>
					</form:select>
					<form:errors path="showSe"/>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="bgnde">기간</form:label></th>
                <td>
                    <form:select path="syear" class="p-input  p-input--auto">
                        <c:forEach begin="${linkZoneItemVO.minYear}" end="${linkZoneItemVO.maxYear}" varStatus="idx">
                            <form:option value="${idx.index}" label="${idx.index}" />
                        </c:forEach>
                    </form:select>년
                    <form:select path="smonth" class="p-input  p-input--auto">
                        <c:forEach begin="1" end="12" varStatus="idx">
                            <form:option value="${idx.index}" label="${idx.index}" />
                        </c:forEach>
                    </form:select>월
                    <form:select path="sday" class="p-input  p-input--auto">
                        <c:forEach begin="1" end="31" varStatus="idx">
                            <form:option value="${idx.index}" label="${idx.index}" />
                        </c:forEach>
                    </form:select>일
                    <form:select path="shour" class="p-input  p-input--auto">
                        <c:forEach begin="0" end="23" varStatus="idx">
                            <form:option value="${idx.index}" label="${idx.index}" />
                        </c:forEach>
                    </form:select>시
                    <form:select path="sminute" class="p-input  p-input--auto">
                        <c:forEach begin="0" end="59" varStatus="idx">
                            <form:option value="${idx.index}" label="${idx.index}" />
                        </c:forEach>
                    </form:select>분
                    ~ <br />
                    <form:select path="eyear" class="p-input  p-input--auto">
                        <c:forEach begin="${linkZoneItemVO.minYear}" end="${linkZoneItemVO.maxYear}" varStatus="idx">
                            <form:option value="${idx.index}" label="${idx.index}" />
                        </c:forEach>
                    </form:select>년
                    <form:select path="emonth" class="p-input  p-input--auto">
                        <c:forEach begin="1" end="12" varStatus="idx">
                            <form:option value="${idx.index}" label="${idx.index}" />
                        </c:forEach>
                    </form:select>월
                    <form:select path="eday" class="p-input  p-input--auto">
                        <c:forEach begin="1" end="31" varStatus="idx">
                            <form:option value="${idx.index}" label="${idx.index}" />
                        </c:forEach>
                    </form:select>일
                    <form:select path="ehour" class="p-input  p-input--auto">
                        <c:forEach begin="0" end="23" varStatus="idx">
                            <form:option value="${idx.index}" label="${idx.index}" />
                        </c:forEach>
                    </form:select>시
                    <form:select path="eminute" class="p-input  p-input--auto">
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
                <th scope="row"><form:label path="linkTrget">링크대상</form:label></th>
                <td>
                    <form:select path="linkTrget" class="p-input  p-input--auto">
						<form:option value='' label="--선택하세요--" />
					<c:forEach var="opt" items="${linkTrgetList}">
						<option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq linkZoneItemVO.linkTrget ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
					</c:forEach>
					</form:select>
                </td>
            </tr>
            </tbody>
        </table>
		
       <div class="row margin_t_20">
			<div class="col-12">
                <a href="./selectLinkZoneItemList.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${linkZone.siteId}"/>&amp;linkZoneNo=<c:out value="${linkZoneItemVO.linkZoneNo}"/>&amp;pageUnit=<c:out value="${linkZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${linkZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${linkZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${linkZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${linkZoneItemVO.pageIndex}"/>"  class="p-button cancel">목록</a>
            </div>
            <div class="col-12 right">
                <input type="submit" class="p-button write" value="등록">
            </div>
        </div>
		</form:form>

		
	</div>
</div>

</body>
</html>