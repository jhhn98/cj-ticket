<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<title>강사 관리 &gt; 등록</title>
</head>
<body>

<div class="p-wrap">
<div class="col-22">
	<div class="row p-relative">
		<div class="col-12 margin_t_10">
			<span class="p-icon p-icon__info-circle">주의사항</span>
	        <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
		</div>
		<div class="col-12 right margin_t_5">
			<a href="/${menuInfo.siteId}/selectEduInstrList.do?<c:out value="${eduInstrVO.params}"/>" class="p-button cancel">목록 </a>
		</div>
	</div>

	<form:form id="regestForm" action="./addEduInstr.do" method="post" modelAttribute="eduInstrVO" onsubmit="return checkSubmit(this)" enctype="multipart/form-data">
	<fieldset>
       <legend>등록정보 작성</legend>
		<input type="hidden" name="key" value="${key}"/>
		<input type="hidden" name="prgSe" value="EDU"/>
		<c:forEach var="map" items="${eduInstrVO.paramsMap}">
		<input type="hidden" name="${map.key}" value="${map.value}"/>
		</c:forEach>

	<table class="p-table">
		<colgroup>
			<col class="w20p">
			<col/>
		</colgroup>
		<tbody class="p-table--th-left">
	<tr>
		<th scope="row"><label for="insttNo">기관명</label> <span class="p-form__required--icon">필수</span></th>
		<td>
			<form:select path="insttNo" id="insttNo" cssClass="p-input p-input--auto">
				<form:option value="">선택하세요</form:option>
				<c:choose>
					<c:when test="${not empty insttMap}">
						<%-- 기관담당자 또는 강사: 권한 있는 기관만 표시 --%>
						<c:forEach var="item" items="${insttMap}">
							<option value="${item.key}"${item.key eq eduInstrVO.insttNo ? ' selected="selected"':''}>
								${item.value}
							</option>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<%-- 최고관리자: 전체 기관 표시 --%>
						<c:forEach var="instt" items="${eduInsttList}">
							<option value="${instt.insttNo}"${instt.insttNo eq eduInstrVO.insttNo ? ' selected="selected"':''}>
								<c:out value="${instt.insttNm}"/>
							</option>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</form:select>
			<form:errors path="insttNo" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="instrField">강사분야</label></th>
		<td>
			<form:select path="instrField" id="instrField" cssClass="p-input p-input--auto">
				<form:option value="">분야 선택</form:option>
				<form:options items="${svcTyCdList}" itemValue="code" itemLabel="codeNm"/>
			</form:select>
			<form:errors path="instrField" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="userId">아이디</label> <span class="p-form__required--icon">필수</span></th>
		<td>
			<form:input path="userId" id="userId" cssClass="p-input w20p" maxlength="20" />
			<button type="button" onclick="fn_checkUserId();" class="p-button info">중복확인</button>
			<span id="text_checkId" class="text_red margin_l_10">※ 회원가입으로 연동됩니다.</span>
			<form:errors path="userId" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="password">비밀번호</label> <span class="p-form__required--icon">필수</span></th>
		<td>
			<form:password path="password" id="password" cssClass="p-input w20p" maxlength="20" showPassword="false" />
			<form:errors path="password" cssClass="form_error" />
			<span id="weak_pwd" class="em_red margin_l_10" style="display:none;font-weight:bold">비밀번호가 취약합니다. (아래의 비밀번호 작성 안내를 참고해주세요.)</span>
			<span id="power_pwd" class="em_green margin_l_10" style="display:none;font-weight:bold">비밀번호가 강력합니다.</span>
			<p class="guide-gray">
				* 숫자, 특수문자 각 1회 이상, 영문은 2개 이상 사용하여 8자리 이상 입력해주세요<br/>
				* 영문자(a~z, A~Z)가 연속으로 2자 이상 포함되어야 합니다.
			</p>
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="passwordRe">비밀번호 확인</label> <span class="p-form__required--icon">필수</span></th>
		<td>
			<form:password path="passwordRe" id="passwordRe" cssClass="p-input w20p" maxlength="20" showPassword="false" />
			<form:errors path="passwordRe" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="instrNm">강사 이름</label> <span class="p-form__required--icon">필수</span></th>
		<td>
			<form:input path="instrNm" id="instrNm" cssClass="p-input w10p" maxlength="15" />
			<form:errors path="instrNm" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="instrGenderSe">성별</label> <span class="p-form__required--icon">필수</span> </th>
		<td>
			<span class="p-form-radio">
				<form:radiobutton path="instrGenderSe" id="sex1" value="M" cssClass="p-form-radio__input" />
				<label for="sex1" class="p-form-radio__label">남자</label>
			</span> &nbsp;
			<span class="p-form-radio">
				<form:radiobutton path="instrGenderSe" id="sex2" value="F" cssClass="p-form-radio__input" />
				<label for="sex2" class="p-form-radio__label">여자</label>
			</span>
			<form:errors path="instrGenderSe" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="birthDeFmt">생년월일</label> <span class="p-form__required--icon">필수</span> </th>
		<td>
			<div class="p-date-group" style="width:150px; display:inline-block;">
				<div class="p-form-group p-date" data-date="datepicker">
					<form:input path="birthDeFmt" id="birthDeFmt" readonly="true" placeholder="yyyy-mm-dd" cssClass="p-input bg-none" />
					<div class="p-input__split"><button type="button" class="p-input__item p-date__icon">달력 열기</button></div>
				</div>
			</div>
			<form:errors path="birthDe" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="email">이메일</label></th>
		<td>
			<form:input path="email" id="email" type="email" cssClass="p-input w20p" maxlength="100" />
			<form:errors path="email" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="telNo">연락처</label> <span class="p-form__required--icon">필수</span> </th>
		<td>
			<form:input path="telNo" id="telNo" cssClass="p-input w10p" maxlength="11" /><br/>
			<svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
			<em class="em_black">로그인 시 해당 번호로 인증번호가 발송됩니다.</em><br/>
			<form:errors path="telNo" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="zip">주소</label></th>
		<td>
			<form:input path="zip" id="zip" readonly="true" cssClass="p-input w10p" />
			<button type="button" class="p-button edit" onclick="fn_openDaumZipAddress();">주소검색</button>
			<span class="small marginLeft_10">우편번호 검색창이 새창으로 열립니다.</span><br/>
			<form:input path="addr" id="addr" readonly="true" cssClass="p-input w60p" /><br/>
			<form:input path="detailAddr" id="detailAddr" cssClass="p-input w60p" placeholder="상세주소 입력" />
			<form:errors path="zip" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="entrstYear">위촉년도</label></th>
		<td>
			<form:input path="entrstYear" id="entrstYear" maxlength="4" cssClass="p-input w5p" />
			<span class="text_red margin_l_20">예시) 2024</span>
			<form:errors path="entrstYear" cssClass="form_error" />
		</td>
	</tr>
		<%--
		<tr>
			<th scope="row">강사사진</th>
			<td>
				<div class="p-upload w70p">
					<div class="p-form-group">
						<div class="p-form-group__upload">
							<input type="file" name="file1" id="file1" class="p-upload__file--hidden" multiple>
							<span id="filename1" class="p-input disabled"></span>
							<button type="button" class="p-upload__clear clear">선택한 1번 첨부 제거</button>
						</div>
						<div class="p-input__addon">
							<label for="file1" class="p-button p-button--small primary" data-button="upload" data-parent=".p-upload" data-original="#file1" data-showfilename="#filename1"><span class="skip">1번째 </span>파일선택</label>
						</div>
					</div>
				</div>
				<p class="guide-gray">
					※ 이미지는 확장자가 “jpg”, “jpeg”, “gif”, “png” 인 것만 가능합니다.
					<span class="margin_l_10">이미지 최적사이즈 : 가로(300px), 세로(370px)</span>
				</p>
			</td>
		</tr>
		--%>
	<tr>
		<th scope="row"><label for="instrAcdmcr">강사학력</label></th>
		<td>
			<form:textarea path="instrAcdmcr" id="instrAcdmcr" cssClass="p-input" cssStyle="width:100%;height:100px" />
			<form:errors path="instrAcdmcr" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="instrCareer">강사경력</label></th>
		<td>
			<form:textarea path="instrCareer" id="instrCareer" cssClass="p-input" cssStyle="width:100%;height:150px" />
			<form:errors path="instrCareer" cssClass="form_error" />
		</td>
	</tr>
	<tr>
		<th scope="row"><label for="etcCn">기타</label></th>
		<td>
			<form:input path="etcCn" id="etcCn" cssClass="p-input w90p" maxlength="20" />
			<form:errors path="etcCn" cssClass="form_error" />
		</td>
	</tr>
		</tbody>
	</table>

	<div class="row margin_t_15">
		<div class="col-12">
			<a href="/${menuInfo.siteId}/selectEduInstrList.do?<c:out value="${eduInstrVO.params}"/>" class="p-button cancel">목록 </a>
		</div>
		<div class="col-12 right">
			<input type="submit" class="p-button write" value="등록">
		</div>
	</div>
	</fieldset>
	</form:form>
</div>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script nonce="NEOCMSSCRIPT">
// 아이디 중복확인 여부 플래그
var isUserIdChecked = false;

// 다음 우편번호 API
function fn_openDaumZipAddress() {
	new daum.Postcode({
		oncomplete:function(data) {
			$("#zip").val(data.zonecode);
			$("#addr").val(data.address);
			$("#detailAddr").show();
			$("#detailAddr").focus();
		}
	}).open();
}

function hiPw_pattern() {
	var pattern1 = /<spring:eval expression="@prop['password_regexr_pattern']"/>/;
	var pw = $("#password").val(); //비밀번호
	//비밀번호 체크
	if (pattern1.test(pw)) {
		$("#weak_pwd").hide();
		$("#power_pwd").show();
	} else {
		$("#weak_pwd").show();
		$("#power_pwd").hide();
	}
}

// 폼 유효성 검사
function checkSubmit(frm) {
	// 기관명 필수 체크
	if(!frm.insttNo.value) {
		alert("기관명을 선택해주세요.");
		frm.insttNo.focus();
		return false;
	}
	
	// 강사분야 필수 체크
	if(!frm.instrField.value) {
		alert("강사분야를 선택해주세요.");
		frm.instrField.focus();
		return false;
	}
	
	// 아이디 필수 체크
	if(!frm.userId.value) {
		alert("아이디를 입력해주세요.");
		frm.userId.focus();
		return false;
	}
	
	// 아이디 중복확인 체크
	if(!isUserIdChecked) {
		alert("아이디 중복확인을 해주세요.");
		frm.userId.focus();
		return false;
	}
	
	// 비밀번호 필수 체크
	if(!frm.password.value) {
		alert("비밀번호를 입력해주세요.");
		frm.password.focus();
		return false;
	}
	
	// 비밀번호 확인 필수 체크
	if(!frm.passwordRe.value) {
		alert("비밀번호 확인을 입력해주세요.");
		frm.passwordRe.focus();
		return false;
	}
	
	// 비밀번호 일치 여부 체크
	if(frm.password.value != frm.passwordRe.value) {
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		frm.passwordRe.focus();
		return false;
	}
	
	// 강사 이름 필수 체크
	if(!frm.instrNm.value) {
		alert("강사 이름을 입력해주세요.");
		frm.instrNm.focus();
		return false;
	}
	
	// 성별 필수 체크
	var instrGenderSe = $('input[name="instrGenderSe"]:checked').val();
	if(!instrGenderSe) {
		alert("성별을 선택해주세요.");
		$('#sex1').focus();
		return false;
	}
	
	// 생년월일 필수 체크
	if(!$('#birthDeFmt').val()) {
		alert("생년월일을 입력해주세요.");
		$('#birthDeFmt').focus();
		return false;
	}
	
	// 연락처 필수 체크
	if(!frm.telNo.value) {
		alert("연락처를 입력해주세요.");
		frm.telNo.focus();
		return false;
	}

	// 연락처 형식 검증 (숫자)
	var telNo = frm.telNo.value;
	if(/[^0-9-]/g.test(telNo)) {
		alert("연락처는 숫자만 입력 가능합니다.");
		frm.telNo.focus();
		return false;
	}
	
	// 이메일 형식 검증
	var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i;
	if(frm.email.value && !emailRegex.test(frm.email.value)) {
		alert("이메일 형식이 올바르지 않습니다.");
		frm.email.focus();
		return false;
	}
	
	// 위촉년도 형식 검증
	var entrstYear = frm.entrstYear.value.trim();
	if(entrstYear) {
		if(isNaN(entrstYear)) {
			alert("위촉년도는 숫자로만 입력해주세요.");
			frm.entrstYear.focus();
			return false;
		}
		if(entrstYear.length != 4) {
			alert("위촉년도는 4자리 년도로 입력해주세요.");
			frm.entrstYear.focus();
			return false;
		}
	}

	// 최종 등록 확인
	if(!confirm("등록하시겠습니까?")) {
		return false;
	}
	
	return true;
}

// 사용자ID 중복확인
function fn_checkUserId(){
	var userId = $('#userId').val();
	if(!userId) {
		alert("아이디를 입력해주세요.");
		$('#userId').focus();
		return false;
	}
	$.ajax({
		url: './ajaxEduInstrCheckUserId.do?key=${key}',
		type: 'POST',
		cache: false,
		data: { 'userId': userId },
		success: function (res) {
			if(res == 0) {
				alert("아이디를 입력해주세요.");
				$("#text_checkId").text("※ 회원가입으로 연동됩니다.");
				isUserIdChecked = false;
			} else if(res == 1) {
				alert("사용 가능한 아이디입니다.");
				$("#text_checkId").text("✓ 사용 가능한 아이디입니다.");
				$("#text_checkId").removeClass("text_red").addClass("text_green");
				isUserIdChecked = true; // 중복확인 완료 플래그 설정
			} else if(res == 2) {
				alert("이미 등록된 아이디가 존재합니다.");
				$("#text_checkId").text("!! 이미 등록된 아이디가 존재합니다.");
				$("#text_checkId").removeClass("text_green").addClass("text_red");
				isUserIdChecked = false;
			}
		},
		error: function (request, xhr, status) {
			alert("에러가 발생하였습니다.");
			isUserIdChecked = false;
		}
	});
}

$(document).ready(function() {
	// 비밀번호 강도 체크
	$('input#password').keyup(function() {
		hiPw_pattern(this);
	});
	
	// 아이디 입력 필드 변경 시 중복확인 플래그 초기화
	$('#userId').on('input', function() {
		isUserIdChecked = false;
		$("#text_checkId").text("※ 회원가입으로 연동됩니다.");
		$("#text_checkId").removeClass("text_green").addClass("text_red");
	});

	<c:if test="${!empty errorMesag}">
	// 유효성 검사 에러 메시지 표시
	alert('<c:out value="${errorMesag}"/>');
	$('#<c:out value="${errorField}"/>').focus();
	</c:if>
});
</script>

</body>
</html>