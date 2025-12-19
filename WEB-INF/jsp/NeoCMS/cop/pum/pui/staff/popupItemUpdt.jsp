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
<title>팝업 항목 수정</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="popupItemVO" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="popupItemVO">
	<script >
		<c:forEach items="${errors.allErrors}" var="error" varStatus="status">
		<c:if test="${status.first}">
		alert("<spring:message code="${error.code}" arguments="${error.arguments}" />");
		</c:if>
		</c:forEach>
	</script>
</spring:hasBindErrors>
<c:if test="${!empty message}">
	<script nonce="NEOCMSSCRIPT">
		function fn_check_message() {
			alert("<c:out value='${message}'/>");
			<c:if test="${!empty fieldName}">
			$("#${fieldName}").focus();
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

		<form:form modelAttribute="popupItemVO" name="popupItemVOForm" action="./updatePopupItem.do" onsubmit="return validatePopupItemVO(this)" enctype="multipart/form-data">
		<input type="hidden" name="key" id="key2" value="<c:out value="${key}"/>" />
		<form:hidden path="siteId"/>
		<%-- <form:hidden path="popupNo"/> --%>
		<form:hidden path="popupIemNo"/>
		<%-- <form:hidden path="authdata"/> --%>
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
				<th scope="row"><form:label path="popupIemNm">팝업이름 <span class="p-form__required--icon">필수</span></form:label></th>
				<td><form:input path="popupIemNm" size="40" required="required" /> <form:errors path="popupIemNm" /></td>
			</tr>
			<tr>
				<th scope="row">타입</th>
				<td>
					<span class="p-form-radio"><form:radiobutton path="type" value="layer" class="p-form-radio__input" checked="checked" required="required" /><label for="type1" class="p-form-radio__label">레이어</label></span> &nbsp;&nbsp; 
					<span class="p-form-radio"><form:radiobutton path="type" value="window" class="p-form-radio__input" required="required" /><label for="type2" class="p-form-radio__label">새창</label></span>
				</td>
			</tr>
			<tr>
				<th scope="row">위치</th>
				<td>
					<label for="popupx">왼쪽 :</label> <form:input path="popupx" id="popupx" style="width:35px;" maxlength="4" class="p-input" required="required" /> px &nbsp;&nbsp;
					<label for="popupy">위쪽 :</label> <form:input path="popupy" id="popupy" style="width:35px;" maxlength="4" class="p-input" required="required" />px
				</td>
			</tr>
			<tr>
				<th scope="row">사이즈</th>
				<td>
					<label for="popupw">가로 :</label> <form:input path="popupw" id="popupw" style="width:35px;" maxlength="4" class="p-input" required="required" /> px&nbsp;&nbsp; 
					<label for="popuph">세로 :</label> <form:input path="popuph" id="popuph" style="width:35px;" maxlength="4" class="p-input" required="required" />px
				</td>
			</tr>
			<tr>
				<th scope="row"><form:label path="showSe">표시구분 <span class="p-form__required--icon">필수</span></form:label></th>
				<td>
					<form:select path="showSe" class="p-input  p-input--auto" required="required">
						<form:option value='' label="--선택하세요--" />
						<form:options items="${showSeList}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<form:errors path="showSe"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><form:label path="bgnde">기간</form:label></th>
				<td>
					<form:select path="syear" class="p-input  p-input--auto">
						<c:forEach begin="${popupItemVO.minYear}" end="${popupItemVO.maxYear}" varStatus="idx">
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
						<c:forEach begin="${popupItemVO.minYear}" end="${popupItemVO.maxYear}" varStatus="idx">
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
				<td><form:input path="linkUrl" style="width:98%" /> <form:errors path="linkUrl"/></td>
			</tr>
			<tr>
				<th scope="row"><form:label path="linkTrget">링크대상 <span class="p-form__required--icon">필수</span></form:label></th>
				<td>
					<form:select path="linkTrget" class="p-input  p-input--auto" required="required">
						<form:option value='' label="--선택하세요--" />
						<form:options items="${linkTrgetList}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th scope="row"><form:label path="imageReplcText">대체텍스트 <span class="p-form__required--icon">필수</span></form:label></th>
				<td><form:textarea path="imageReplcText" style="width:500px; height:100px" class="p-input" /><form:errors path="imageReplcText"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="imageFile">이미지파일 <span class="p-form__required--icon">필수</span></label></th>
				<td><input name="imageFile" id="imageFile" type="file" title="이미지파일" size="60" /></td>
			</tr>
			<input type="hidden" name="auth" value="N,U,S,A" />
			<% /* <tr>
				<th width="15%">권한</th>
				<td width="85%">
					<form:checkbox path="auth" id="auth0" value="N" checked="checked"/> <label for="auth0">비회원</label><br />
					<form:checkbox path="auth" id="auth0" value="U" checked="checked"/> <label for="auth0">회원</label><br />
					<form:checkbox path="auth" id="auth10" value="S" checked="checked"/> <label for="auth10">관리자</label><br />
					<form:checkbox path="auth" id="auth11" value="A" checked="checked"/> <label for="auth11">최고관리자</label>
				</td>
			</tr> */ %>
		</tbody>
		</table>
		
		<div class="row margin_t_20">
			<div class="col-12">
				<a href="./selectPopupItemList.do?siteId=${popupItemVO.siteId}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}&amp;key=<c:out value="${key}"/>" class="p-button cancel">목록</a>
			</div>
			<div class="col-12 right">
				<input type="submit" class="p-button write" value="수정">
			</div>
		</div>
		</form:form>
	
	</div>

</div>

</body>
</html>