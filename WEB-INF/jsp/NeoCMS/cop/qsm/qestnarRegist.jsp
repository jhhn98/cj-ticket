<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<link rel="stylesheet" href="/common/css/board.css" />
	<script src="/common/js/calendar.js"></script>
	<title>${menuInfo.cntntsNm}</title>
</head>
<body>

<script  src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="qestnar" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="qestnar">
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
	<div class="col-15">
		<script type="text/javascript" src="/neo/js/calendar.js"></script>

		<script language="javascript">

			function validateQestnar( form ) {

				if( !form.qestnarSj.value ) {
					alert("제목을 입력해주세요.");
					form.qestnarSj.focus();
					return false;
				}

				if( !form.bgnde.value ) {
					alert("시작일을 입력해주세요.");
					form.bgnde.focus();
					return false;
				}

				if( !form.endde.value ) {
					alert("종료일을 입력해주세요.");
					form.endde.focus();
					return false;
				}

				return true;
			}
		</script>
		<h1 class="subHeader">설문조사 &gt; 등록 </h1>

		<form:form modelAttribute="qestnar" name="qestnar" action="addMngQestnar.do?&key=${key}&siteId=${searchVO.siteId}&amp;${searchVO.params}" onsubmit="return validateQestnar(this)">
			<table class="p-table">
				<colgroup>
					<col width="200"/>
					<col/>
				</colgroup>
				<tbody>
				<tr>
					<th><em>*</em> <form:label path="qestnarSj">설문조사 제목</form:label></th>
					<td><form:input path="qestnarSj" size="40" class="p-input p-input--auto"/> <form:errors path="qestnarSj"/></td>
				</tr>
				<tr>
					<th><form:label path="qestnarDc">설문조사 설명</form:label></th>
					<td><form:textarea path="qestnarDc" class="p-input p-input--auto" title="설문조사 설명" cols="100" rows="5"/></td>
				</tr>
				<tr>
					<th><em>*</em> <form:label path="bgnde">시작일</form:label></th>
					<td>
						<div class="p-date-group">
							<div class="p-form-group p-date" data-date="datepicker">
								<form:input path="bgnde" style="width:95px;" placeholder="일자선택" class="p-input" maxlength="10" value="${tsu:toDateFormat(qestnar.bgnde,'yyyyMMdd','yyyy-MM-dd')}"/>
								<div class="p-input__split"><button type="button" class="p-input__item  p-date__icon">달력 열기</button></div> &nbsp;
								<span>
									<form:select path="bhour" class="p-input p-input--auto">
										<c:forEach begin="0" end="23" varStatus="idx">
											<form:option value="${idx.index}" label="${idx.index} 시" />
										</c:forEach>
									</form:select>
									<form:select path="bminute" class="p-input p-input--auto">
										<c:forEach begin="0" end="59" varStatus="idx">
											<form:option value="${idx.index}" label="${idx.index} 분" />
										</c:forEach>
									</form:select>
								</span>
							</div>
						</div>
						<%--<a href="#" onClick="ds_sh(document.getElementById('bgnde')); return false;" style="vertical-align:sub"><img src="./images/btn_calendar.gif" alt="달력"/></a>
						<form:input path="bgnde" class="p-input p-input--auto" onClick="ds_sh(this);" size="8" readonly="readonly"/>
						<form:select path="bhour" class="p-input p-input--auto">
							<c:forEach begin="0" end="23" varStatus="idx">
								<form:option value="${idx.index}" label="${idx.index} 시" />
							</c:forEach>
						</form:select>
						<form:select path="bminute" class="p-input p-input--auto">
							<c:forEach begin="0" end="59" varStatus="idx">
								<form:option value="${idx.index}" label="${idx.index} 분" />
							</c:forEach>
						</form:select>
						<form:errors path="bgnde"/>--%>
					</td>
				</tr>
				<tr>
					<th><em>*</em> <form:label path="endde">종료일</form:label></th>
					<td>
						<div class="p-date-group">
							<div class="p-form-group p-date" data-date="datepicker">
								<form:input path="endde" style="width:95px;" placeholder="일자선택" class="p-input" maxlength="10" value="${tsu:toDateFormat(qestnar.endde,'yyyyMMdd','yyyy-MM-dd')}"/>
								<div class="p-input__split"><button type="button" class="p-input__item  p-date__icon">달력 열기</button></div> &nbsp;
								<span>
									<form:select path="ehour" class="p-input p-input--auto">
										<c:forEach begin="0" end="23" varStatus="idx">
											<form:option value="${idx.index}" label="${idx.index} 시" />
										</c:forEach>
									</form:select>
									<form:select path="eminute" class="p-input p-input--auto">
										<c:forEach begin="0" end="59" varStatus="idx">
											<form:option value="${idx.index}" label="${idx.index} 분" />
										</c:forEach>
									</form:select>
								</span>
							</div>
						</div>
					<%--
						<a href="#" onClick="ds_sh(document.getElementById('endde')); return false;" style="vertical-align:sub"><img src="./images/btn_calendar.gif" alt="달력"/></a>
						<form:input path="endde" class="p-input p-input--auto" onClick="ds_sh(this);" size="8" readonly="readonly"/>
						<form:select path="ehour" class="p-input p-input--auto">
							<c:forEach begin="0" end="23" varStatus="idx">
								<form:option value="${idx.index}" label="${idx.index} 시" />
							</c:forEach>
						</form:select>
						<form:select path="eminute" class="p-input p-input--auto">
							<c:forEach begin="0" end="59" varStatus="idx">
								<form:option value="${idx.index}" label="${idx.index} 분" />
							</c:forEach>
						</form:select>
						<form:errors path="endde"/></td>--%>
				</tr>
				<tr>
					<th><form:label path="useAt">표시여부</form:label></th>
					<td><form:radiobutton path="useAt" value="Y"  checked="checked" />표시 &nbsp;
						<form:radiobutton path="useAt" value="N"/>미표시
					</td>
				</tr>
				</tbody>
			</table>
			<div class="row margin_t_20">
				<div class="col-12">
				</div>
				<div class="col-12 right">
					<span class="button blue"><input type="submit" value="등록"  class="p-button write"/></span>
					<a href="./selectQestnarMngList.do?siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button delete"><span>목록</span></a>
				</div>
			</div>
		</form:form>


	</div>
</div>

</body>
</html>