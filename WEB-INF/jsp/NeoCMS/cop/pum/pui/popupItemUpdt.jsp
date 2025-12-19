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
	<meta name="decorator" content="neo" />
	<script src="<c:url value='/cmm/validator.do'/>"></script>
	<validator:javascript formName="popupItemVO" staticJavascript="false" xhtml="true" cdata="false"/>
	<%-- <spring:hasBindErrors name="popupItemVO">
    <script nonce="NEOCMSSCRIPT">
    <c:forEach items="${errors.allErrors}" var="error" varStatus="status">
        <c:if test="${status.first}">

            alert('${error.code}' + "\n " + '${error.arguments}');
        </c:if>
    </c:forEach>
    </script>
    </spring:hasBindErrors> --%>
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
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">팝업항목관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">수정</span>
</div>
<div class="dataWrap">
	<form:form modelAttribute="popupItemVO" name="popupItemVOForm" action="updatePopupItem.do" onsubmit="return validatePopupItemVO(this)" enctype="multipart/form-data">

		<form:hidden path="siteId"/>
		<%-- <form:hidden path="popupNo"/> --%>
		<form:hidden path="popupIemNo"/>
		<%-- <form:hidden path="authdata"/> --%>

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
				<th><em>*</em> <form:label path="popupIemNm">팝업이름</form:label></th>
				<td><form:input path="popupIemNm" size="40"/> <form:errors path="popupIemNm"/></td>
			</tr>
			<tr>
				<th>타입</th>
				<td>
					<form:radiobutton path="type" value="layer" label="레이어" checked="checked"/> &nbsp;
					<form:radiobutton path="type" value="window" label="새창"/>
				</td>
			</tr>
			<tr>
				<th>위치</th>
				<td>
					<label for="popupx">Left :</label><form:input path="popupx" id="popupx" style="width:35px;" maxlength="4" class="InputText"/> px &nbsp;&nbsp;
					<label for="popupy">Top :</label> <form:input path="popupy" id="popupy" style="width:35px;" maxlength="4" class="InputText"/>px
				</td>
			</tr>
			<tr>
				<th>사이즈</th>
				<td>
					<label for="popupw">가로 :</label> <form:input path="popupw" id="popupw" style="width:35px;" maxlength="4" class="InputText"/> px&nbsp;&nbsp;
					<label for="popuph">세로 :</label> <form:input path="popuph" id="popuph" style="width:35px;" maxlength="4" class="InputText"/>px
				</td>
			</tr>
			<tr>
				<th><em>*</em> <form:label path="showSe">표시구분</form:label></th>
				<td>
					<form:select path="showSe">
						<form:option value='' label="--선택하세요--" />
						<form:options items="${showSeList}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
					<form:errors path="showSe"/>
				</td>
			</tr>
			<tr>
				<th><form:label path="bgnde">기간</form:label></th>
				<td>
					<form:select path="syear">
						<c:forEach begin="${popupItemVO.minYear}" end="${popupItemVO.maxYear}" varStatus="idx">
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
						<c:forEach begin="${popupItemVO.minYear}" end="${popupItemVO.maxYear}" varStatus="idx">
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
				<th><form:label path="linkUrl">링크URL</form:label></th>
				<td><form:input path="linkUrl" size="60"/> <form:errors path="linkUrl"/></td>
			</tr>
			<tr>
				<th><form:label path="linkTrget">링크대상</form:label></th>
				<td>
					<form:select path="linkTrget">
						<form:option value='' label="--선택하세요--" />
						<form:options items="${linkTrgetList}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th><em>*</em> <form:label path="imageReplcText">대체텍스트</form:label></th>
				<td><form:textarea path="imageReplcText" style="width:500px; height:100px"/><form:errors path="imageReplcText"/></td>
			</tr>
			<tr>
				<th><label for="imageFile">이미지파일</label></th>
				<td><input name="imageFile" id="imageFile" type="file" title="이미지파일" size="60"/></td>
			</tr>
			<input type="hidden" name="auth" value="N,U,S,A" />
			<% /* <tr>
			<th width="15%">권한</th>
			<td width="85%">
				<form:checkbox path="auth" id="auth0" value="N" /> <label for="auth0">비회원</label><br />
				<form:checkbox path="auth" id="auth1" value="U" /> <label for="auth1">회원</label><br />
				<form:checkbox path="auth" id="auth2" value="S" /> <label for="auth2">관리자</label><br />
				<form:checkbox path="auth" id="auth3" value="A" /> <label for="auth3">최고관리자</label>
			</td>
		</tr> */ %>
			</tbody>
		</table>


		<div class="arrangementWrap marginTop_20">
			<div class="arrLeft">
				<a href="./selectPopupItemList.do?pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}"  class="iconTextButton list"><span>목록</span></a>
			</div>
			<div class="arrRight">
				<button type="submit" class="iconTextButton write"><span>수정</span></button>
			</div>
		</div>
	</form:form>
</div>
<script nonce="NEOCMSSCRIPT">
	/*
        var auth = "${popupItemVO.auth}";
	var authArray = auth.split(",");
	var authArray2 = document.getElementsByName("auth");

	if (authArray.length > 0) {
		for(var i = 0;i < authArray.length;i++) {
			if (authArray[i] == "N") {	
				authArray2[0].checked = true;
			} else if (authArray[i] == "U") {
				authArray2[1].checked = true;
			} else if (authArray[i] == "S") {
				authArray2[2].checked = true;
			} else if (authArray[i] == "A") {
				authArray2[3].checked = true;
			}
		}
	}
*/
</script>

</body>
</html>