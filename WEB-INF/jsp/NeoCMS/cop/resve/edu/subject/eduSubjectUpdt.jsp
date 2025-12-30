<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy" var="year"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<title>과목 관리 &gt; 수정</title>
</head>
<body>

<div class="p-wrap">
	<div class="row p-relative">
		<div class="col-12 margin_t_10">
			<span class="p-icon p-icon__info-circle">주의사항</span>
	        <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
		</div>
		<div class="col-12 right margin_t_5">
			<a href="./selectEduSubjectList.do?<c:out value="${eduSubjectVO.params}"/>" class="p-button cancel">목록 </a>
		</div>
	</div>

	<form:form modelAttribute="eduSubjectVO" name="eduSubjectVO" action="./updateEduSubject.do" method="post" onsubmit="return checkSubmit(this)">
		<form:hidden path="subjectNo"/>
	<fieldset>
		<legend>등록정보 수정</legend>
		<input type="hidden" name="key" value="${key}"/>
		<input type="hidden" name="prgSe" value="EDU"/>
		<c:forEach var="map" items="${eduSubjectVO.paramsMap}">
		<input type="hidden" name="${map.key}" value="${map.value}"/>
		</c:forEach>
		
	<table class="p-table">
		<colgroup>
			<col class="w15p">
			<col/>
		</colgroup>
		<tbody class="p-table--th-left">
		<tr>
			<th scope="row"><label for="insttNo">기관명</label> <span class="p-form__required--icon">필수</span></th>
			<td>
				<form:select path="insttNo" id="insttNo" class="p-input p-input--auto" onchange="insttNoChange(this.value);">
					<form:option value="" label="기관명 선택"/>
					<c:choose>
						<c:when test="${not empty insttMap}">
							<%-- 기관담당자 또는 강사: 권한 있는 기관만 표시 --%>
							<c:forEach var="item" items="${insttMap}">
								<option value="${item.key}"${item.key eq eduSubjectVO.insttNo ? ' selected="selected"':''}>
									${item.value}
								</option>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<%-- 최고관리자: 전체 기관 표시 --%>
							<c:forEach var="instt" items="${eduInsttList}">
								<option value="${instt.insttNo}"${instt.insttNo eq eduSubjectVO.insttNo ? ' selected="selected"':''}>
									<c:out value="${instt.insttNm}"/>
								</option>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</form:select>
				<span id="error_insttNo" class="form_error"></span>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="ctgryNo">카테고리명</label> <span class="p-form__required--icon">필수</span></th>
			<td>
			<form:select path="ctgryNo" id="ctgryNo" class="p-input p-input--auto">
				<form:option value="">선택하세요</form:option>
			</form:select>
				<span id="text_ctgryNo" class="text_red margin_l_20"></span>
				<span id="error_ctgryNo" class="form_error"></span>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="subjectNm">과목명</label> <span class="p-form__required--icon">필수</span></th>
			<td>
				<input type="text" id="subjectNm" name="subjectNm" value="${eduSubjectVO.subjectNm}" class="p-input w50p" maxlength="50" />
				<span id="error_subjectNm" class="form_error"></span>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="eduBgnHm">교육시간</label></th>
			<td>
				<c:set var="stthr" value="${fn:substring(eduSubjectVO.eduBgnHm,0,2)}" />
				<c:set var="sttmn" value="${fn:substring(eduSubjectVO.eduBgnHm,2,4)}" />
				<c:set var="endhr" value="${fn:substring(eduSubjectVO.eduEndHm,0,2)}" />
				<c:set var="endmn" value="${fn:substring(eduSubjectVO.eduEndHm,2,4)}" />
				<select name="stthr" id="stthr" class="p-input p-input--auto">
					<c:forEach begin="6" end="22" varStatus="idx">
						<c:set var="index" value="" />
						<c:if test='${idx.index lt 10}'><c:set var="index" value="0" /></c:if>
						<c:set var="idxs" value="${index}${idx.index}" />
					<option value="${index}${idx.index}"${stthr eq idxs ? ' selected':''}><c:out value="${index}${idx.index}"/></option>
					</c:forEach>
				</select> :
				<select name="sttmn" id="sttmn" class="p-input p-input--auto">
			<c:forEach begin="0" end="59" var="i">
				<c:set var="minuteStr" value="${i < 10 ? '0' : ''}${i}" />
				<option value="${minuteStr}"${minuteStr eq sttmn ? ' selected':''}>${minuteStr}</option>
					</c:forEach>
				</select>
				<span>~</span>
				<select name="endhr" id="endhr" class="p-input p-input--auto">
					<c:forEach begin="6" end="22" varStatus="idx">
						<c:set var="index" value="" />
						<c:if test='${idx.index lt 10}'><c:set var="index" value="0" /></c:if>
						<c:set var="idxs" value="${index}${idx.index}" />
					<option value="${index}${idx.index}"${endhr eq idxs ? ' selected':''}><c:out value="${index}${idx.index}"/></option>
					</c:forEach>
				</select> :
				<select name="endmn" id="endmn" class="p-input p-input--auto">
			<c:forEach begin="0" end="59" var="i">
				<c:set var="minuteStr" value="${i < 10 ? '0' : ''}${i}" />
				<option value="${minuteStr}"${minuteStr eq endmn ? ' selected':''}>${minuteStr}</option>
					</c:forEach>
				</select>
				<input type="hidden" id="eduBgnHm" name="eduBgnHm" value="${eduSubjectVO.eduBgnHm}" />
				<input type="hidden" id="eduEndHm" name="eduEndHm" value="${eduSubjectVO.eduEndHm}" />
				<span id="error_eduBgnHm" class="form_error"></span>
				<span id="error_eduEndHm" class="form_error"></span>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="target">수강대상</label></th>
			<td>
				<span class="p-form-checkbox">
					<input type="checkbox" id="target" name="target" value="ALL"${fn:contains(eduSubjectVO.targetCd,'ALL') ? ' checked="checked"':''} class="p-form-checkbox__input"/>
					<label for="target" class="p-form-checkbox__label">전체</label>
				</span> &nbsp; 
				<c:forEach var="cbox" items="${targetMap}" varStatus="sts">
				<span class="p-form-checkbox">
					<input type="checkbox" name="targetCdList" id="target${sts.index+1}" value="${cbox.key}"${fn:contains(eduSubjectVO.targetCd,cbox.key) ? ' checked="checked"':''} class="p-form-checkbox__input ctarget"/>
					<label for="target${sts.index+1}" class="p-form-checkbox__label"><c:out value="${cbox.value}"/></label>
				</span> &nbsp; 
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="svcTyCd">서비스유형</label></th>
			<td>
				<select id="svcTyCd" name="svcTyCd" class="p-input p-input--auto">
					<option value="">선택하세요</option>
					<c:forEach var="item" items="${svcTyCdList}">
					<option value="${item.code}"${eduSubjectVO.svcTyCd eq item.code ? ' selected="true"':''}><c:out value="${item.codeNm}"/></option>
					</c:forEach>
				</select>
				<span id="error_svcTyCd" class="form_error"></span>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="chrgeSe1">수강료 구분</label> <span class="p-form__required--icon">필수</span></th>
			<td>
				<span class="p-form-radio">
					<input type="radio" id="chrgeSe1" name="chrgeSe" value="F"${eduSubjectVO.chrgeSe eq 'F' ? ' checked="checked"':''} onclick="chrgeSeChange(this.value);" class="p-form-radio__input" />
					<label for="chrgeSe1" class="p-form-radio__label">무료</label>
				</span> &nbsp; 
				<span class="p-form-radio margin_r_10">
					<input type="radio" id="chrgeSe2" name="chrgeSe" value="U"${eduSubjectVO.chrgeSe eq 'U' ? ' checked="checked"':''} onclick="chrgeSeChange(this.value);" class="p-form-radio__input" disabled="disabled" />
					<label for="chrgeSe2" class="p-form-radio__label">유료</label>
				</span>
				<span id="error_chrgeSe1" class="form_error"></span>
			</td>
		</tr>
		<tr class="tr_eduAmt" id="eduAmt_frm" style="display:none;">
			<th scope="row"><label for="eduAmt">수강료 금액</label> <span class="p-form__required--icon w5p">필수</span></th>
			<td>
				<input type="text" id="eduAmt" name="eduAmt"
					   value="${eduSubjectVO.eduAmt}"
					   class="p-input w10p" maxlength="10" /> 원
				<span id="error_eduAmt" class="form_error"></span>
			</td>
		</tr>
		<%--<tr>
			<th scope="row"><label for="retakeCnt">재수강제한횟수</label></th>
			<td>
				<input type="text" id="retakeCnt" name="retakeCnt" value="${eduSubjectVO.retakeCnt}" class="p-input w5p numberonly" maxlength="3" /> 회
				<span class="text_red margin_l_20">※ "0"을 입력하시면 횟수제한 없습니다.</span>
				<span id="error_retakeCnt" class="form_error"></span>
			</td>
		</tr>--%>
		<tr>
			<th scope="row"><label for="attRate">출석률 기준 미달시<br/>페널티 적용</label></th>
			<td>
				<span>전체 출석일 수 의</span> &nbsp;
				<input type="text" id="attRate" name="attRate" value="${eduSubjectVO.attRate}" class="p-input w5p numberonly" maxlength="3" /> %
				<span id="error_attRate" class="form_error"></span>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="useYn1">사용여부</label> <span class="p-form__required--icon">필수</span></th>
			<td>
				<span class="p-form-radio">
					<input type="radio" id="useYn1" name="useYn" value="Y"${eduSubjectVO.useYn eq 'Y' ? ' checked="checked"':''} class="p-form-radio__input" />
					<label for="useYn1" class="p-form-radio__label">사용</label>
				</span> &nbsp; 
				<span class="p-form-radio">
					<input type="radio" id="useYn2" name="useYn" value="N"${eduSubjectVO.useYn eq 'N' ? ' checked="checked"':''} class="p-form-radio__input" />
					<label for="useYn2" class="p-form-radio__label">미사용</label>
				</span>
				<span id="error_useYn" class="form_error"></span>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="detailCn">상세내용</label></th>
			<td>
				<textarea id="detailCn" name="detailCn" class="p-input" style="width:100%;height:200px"><c:out value="${eduSubjectVO.detailCn}" escapeXml="false"/></textarea>
				<span id="error_detailCn" class="form_error"></span>
			</td><%-- required="required" --%> 
		</tr>
		<tr>
			<th scope="row"><label for="noticeCn">유의사항</label></th>
			<td>
				<textarea id="noticeCn" name="noticeCn" class="p-input" style="width:100%;height:150px"><c:out value="${eduSubjectVO.noticeCn}" escapeXml="false"/></textarea>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="refundPlcyCn">환불정책</label></th>
			<td>
				<textarea id="refundPlcyCn" name="refundPlcyCn" class="p-input" style="width:100%;height:100px"><c:out value="${eduSubjectVO.refundPlcyCn}" escapeXml="false"/></textarea>
			</td>
		</tr>
		</tbody>
	</table>

	<div class="row margin_t_15">
		<div class="col-12">
			<a href="./selectEduSubjectList.do?<c:out value="${eduSubjectVO.params}"/>" class="p-button cancel">목록 </a>
		</div>
		<div class="col-12 right">
			<input type="submit" class="p-button write" value="수정">
		</div>
	</div>
	</fieldset>
	</form:form>

</div>

<script id="specialDisTpl" type="text/template">
	<div class="special">	
		<input type="text" id="sdt{sdIndex}" name="specialDis" value="" class="p-input w400" maxlength="30" />
		<input type="text" id="sdv{sdIndex}" name="specialDis" value="" class="p-input w60" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="text-align:right" maxlength="3" /> %
		<input type="hidden" name="specialDis" value="|"/>
		<button type="button" class="p-button p-button--xsmall delete removeTtbtn margin_l_20">삭제</button>
	</div>
</script> 

<script src="/site/staff/js/common.js"></script>
<script nonce="NEOCMSSCRIPT">
//기관명선택 이벤트
function insttNoChange(val) {
	var isVal = false;
	$('#ctgryNo').empty();
	$('#ctgryNo').append('<option value="">선택하세요</option>');
	<c:forEach var="result" items="${eduCategoryList}">
	 if(val == "${result.insttNo}" ){
		 var option = $("<option value=\"${result.ctgryNo}\"${result.ctgryNo eq eduSubjectVO.ctgryNo ? ' selected':''}>${result.ctgryNm}</option>");
		 $('#ctgryNo').append(option);
		 isVal = true;
	 }
	</c:forEach>
	if(!isVal){
		$('#ctgryNo').append('<option value="">카테고리 없음</option>');
		$('#ctgryNo').attr("disabled", true);
		$('#text_ctgryNo').text("※ 연동된 카테고리가 없습니다.");
	} else {
		$('#ctgryNo').attr("disabled", false);
		$('#text_ctgryNo').text("");
	}
	
	//수강료 구분 선택 이벤트
	<c:if test="${!empty eduSubjectVO.chrgeSe}">chrgeSeChange('<c:out value="${eduSubjectVO.chrgeSe}"/>');</c:if>
	<c:if test="${empty eduSubjectVO.chrgeSe}">chrgeSeChange("F");</c:if>
}

//수강료 구분 선택 이벤트
function chrgeSeChange(val){
	if(val == 'U'){
		$('#eduAmt').removeAttr("disabled");
		$('.tr_eduAmt').show();
		var eduAmtTy = $('input[name=eduAmtTy]:checked').val();
		eduAmtTyChange(eduAmtTy);
	} else {
		$('#eduAmt').val("0");
		$('#eduAmt').attr("disabled", true);
		$("#chrgeSe1").prop('checked', true);
		$('.tr_eduAmt').hide();
		eduAmtTyChange("P");
	}
}

//수강비 유형 선택 이벤트
function eduAmtTyChange(val){
	if(val == 'M'){
		$('#eduAmt_frm').hide();
		$('.month_eduAmt').show();
	} else {
		$('#eduAmt_frm').show();
		$('.month_eduAmt').hide();
	}

}

//특별할인 추가/삭제 이벤트
function checkSpecialDis(tdId, btnId) {
	if($("#"+tdId+" div.special").length < 20) {
		$("#"+btnId).css("display", "inline-block");
		return true;
	} else {
		$("#"+btnId).css("display", "none");
		return false;
	}
}
function validateInput(data) {
	if(data.trim() == "" || data === null || typeof data == 'undefined'){
		return false;
	}else{
		return true;
	}
}
function validateSpecialDis() {
	var flag = true;
	$("#tdSpecialDis div.special").each(function(index){
		var idx = index + 1;
		var val1 = $(this).find("input").eq(0).val();
		var val2 = $(this).find("input").eq(1).val();
		if(!validateInput(val1)) {
			alert(idx +"번째 특별할인 명칭을 입력해주세요."); 
			$("#sdt"+ index).focus(); flag = false; return false;
		}
		if(validateInput(val1)) {
			if(val1.indexOf(',') != -1){
				alert(idx +"번째 특별할인 명칭에 콤마(,)를 사용할 수 없습니다."); 
				$("#sdt"+ index).focus(); flag = false; return false;
			}
		}
		if(!validateInput(val2)) {
			alert(val1 +" 특별할인 설정값을 입력해주세요."); 
			$("#sdv"+ index).focus(); flag = false; return false;
		}
		if(!/^[0-9]+$/.test(val2)){
			alert(val1 +" 특별할인 설정값은 숫자만 입력해야 합니다.");
			$("#sdv"+ index).focus(); flag = false; return false;
		}
		if(parseInt(val2) > 100){
			alert(val1 +" 특별할인 설정값은 100을 초과할 수 없습니다.");
			$("#sdv"+ index).focus(); flag = false; return false;
		}
	});
	return flag;
}

//폼 검사
function checkSubmit(frm) {
	// 시간값 HHMM 형식으로 합쳐 hidden 필드에 설정 (가장 먼저 수행)
	var sttHr = (document.getElementById('stthr')||{}).value || '';
	var sttMn = (document.getElementById('sttmn')||{}).value || '';
	var endHr = (document.getElementById('endhr')||{}).value || '';
	var endMn = (document.getElementById('endmn')||{}).value || '';
	if(sttHr && sttHr.length === 1){ sttHr = '0' + sttHr; }
	if(sttMn && sttMn.length === 1){ sttMn = '0' + sttMn; }
	if(endHr && endHr.length === 1){ endHr = '0' + endHr; }
	if(endMn && endMn.length === 1){ endMn = '0' + endMn; }
	if(sttHr && sttMn){ document.getElementById('eduBgnHm').value = sttHr + sttMn; }
	if(endHr && endMn){ document.getElementById('eduEndHm').value = endHr + endMn; }
	if( !frm.insttNo.value ) {
		alert("기관명을 선택해주세요.");frm.insttNo.focus();return false;
	}
	if( !frm.ctgryNo.value ) {
		alert("카테고리를 선택해주세요.");frm.ctgryNo.focus();return false;
	}
	if( !frm.subjectNm.value ) {
		alert("과목명을 입력하세요.");frm.subjectNm.focus();return false;
	}
	//if( !$('input[name="target"]').is(":checked") ) {alert("수강대상을 선택하세요.");frm.target1.focus();return false;}
	//if( !frm.svcTyCd.value ) {alert("서비스유형을 선택하세요.");frm.svcTyCd.focus();return false;}
	
	if( !$('input[type="radio"][name="chrgeSe"]').is(':checked') ) {
		alert("수강료 구분을 선택해주세요.");$("#chrgeSe1").focus();return false;
	}
	var chrgeSe = $('input[name=chrgeSe]:checked').val();
	var eduAmtTy = $('input[name=eduAmtTy]:checked').val();
	if(chrgeSe == 'U'){
		if(eduAmtTy == 'P'){
			if(!frm.eduAmt.value || frm.eduAmt.value == 0){
				alert("수강료 금액을 입력해주세요.");frm.eduAmt.focus();return false;
			}
			if(frm.eduAmt.value && !/^[0-9,]+$/.test(frm.eduAmt.value)){
				alert("수강료 금액은 숫자,콤마 이외에는 입력할 수 없습니다.");frm.eduAmt.focus();return false;
			}
		} else if(eduAmtTy == 'M'){
			if(!frm.mp0.value){
				alert("성인요금을 입력해주세요.");frm.mp0.focus();return false;
			}
			if(frm.mp0.value && !/^[0-9]+$/.test(frm.mp0.value)){
				alert("성인요금은 숫자 이외에는 입력할 수 없습니다.");frm.mp0.focus();return false;
			}
			if(!frm.mp1.value){
				alert("청소년 요금을 입력해주세요.");frm.mp1.focus();return false;
			}
			if(frm.mp1.value && !/^[0-9]+$/.test(frm.mp1.value)){
				alert("청소년 요금은 숫자 이외에는 입력할 수 없습니다.");frm.mp1.focus();return false;
			}
			if(!frm.mp2.value){
				alert("경로(노인) 요금을 입력해주세요.");frm.mp2.focus();return false;
			}
			if(frm.mp2.value && !/^[0-9]+$/.test(frm.mp2.value)){
				alert("경로(노인) 요금은 숫자 이외에는 입력할 수 없습니다.");frm.mp2.focus();return false;
			}
			if(!frm.mp3.value){
				alert("어린이 요금을 입력해주세요.");frm.mp3.focus();return false;
			}
			if(frm.mp3.value && !/^[0-9]+$/.test(frm.mp3.value)){
				alert("어린이 요금은 숫자 이외에는 입력할 수 없습니다.");frm.mp3.focus();return false;
			}
			if(!frm.md0.value){
				alert("기본할인 3~5개월을 입력해주세요.");frm.md0.focus();return false;
			}
			if(frm.md0.value && !/^[0-9]+$/.test(frm.md0.value)){
				alert("기본할인 3~5개월은 숫자 이외에는 입력할 수 없습니다.");frm.md0.focus();return false;
			}
			if(!frm.md1.value){ alert("기본할인 6개월을 입력해주세요.");frm.md1.focus();return false; }
			if(frm.md1.value && !/^[0-9]+$/.test(frm.md1.value)){ alert("기본할인 6개월은 숫자 이외에는 입력할 수 없습니다.");frm.md1.focus();return false; }
			if(!frm.md2.value){
				alert("여성할인을 입력해주세요.");frm.md2.focus();return false;
			}
			if(frm.md2.value && !/^[0-9]+$/.test(frm.md2.value)){
				alert("여성할인은 숫자 이외에는 입력할 수 없습니다.");frm.md2.focus();return false;
			}
			if(!validateSpecialDis()){ return false; }
		}
	}
	
	/*if(frm.retakeCnt.value && isNaN(frm.retakeCnt.value) ) {
		alert("재수강제한횟수는 숫자만 입력하세요.");frm.retakeCnt.focus();return false;
	}*/
	if(frm.cardinalcnt.value && isNaN(frm.cardinalcnt.value) ) {
		alert("기수별제한횟수는 숫자만 입력하세요.");frm.cardinalcnt.focus();return false;
	}
	if(frm.attRate.value && isNaN(frm.attRate.value) ) {
		alert("패널티출석률은 숫자만 입력하세요.");frm.attRate.focus();return false;
	}
	
	var detailCn = CKEDITOR.instances['detailCn'].getData();
	if (!detailCn) {
        //alert('상세내용을 입력해주세요.');frm.detailCn.focus();return false;
    }
	
	// targetCdList는 Spring이 자동 바인딩하므로 별도 조립 불필요


	// 시작-종료 유효성(선택되어 있으면 비교)
	if(sttHr && sttMn && endHr && endMn){
		var sttVal = parseInt(sttHr + sttMn, 10);
		var endVal = parseInt(endHr + endMn, 10);
		if(sttVal >= endVal){
			alert("종료시간은 시작시간보다 커야 합니다.");
			document.getElementById('endhr').focus();
			return false;
		}
	}

	if( !confirm("수정하시겠습니까?") ) {
		return false;
	}
	return true;
}


$(document).ready(function() {

	function formatNumber(input) {
		let value = input.val().replace(/,/g, ''); // 콤마 제거
		value = value.replace(/[^0-9]/g, ''); // 숫자만 추출

		if (value) {
			input.val(parseInt(value).toLocaleString()); // 콤마 추가해서 표시
		}
	}

	// 폼 submit 전에 콤마 제거
	$('form').on('submit', function() {
		let amount = $('#eduAmt').val().replace(/,/g, '');
		$('#eduAmt').val(amount);
	});

	// 초기값 콤마 표시
	formatNumber($('#eduAmt'));

	// 입력 시 실시간 콤마 추가
	$('#eduAmt').on('input', function() {
		formatNumber($(this));
	});

	$(document).on("keyup", ".numberonly", function(){$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
	//수강대상 선택 이벤트
	$("#target").click(function(){
	    if($(this).is(":checked")){
	        $('input[name="target"]').prop("checked",true);
	    } else {
	        $('input[name="target"]').prop("checked",false);
	    }
	});
	$('.ctarget').click(function() {
		var etlen = $('.ctarget').length;
		var ctlen = $('.ctarget:checked').length; //alert(etlen+"/"+ctlen)
		if(etlen == ctlen) {
			$('#target').prop("checked", true);	
		} else {
			$('#target').prop("checked", false);
		}
	});
	
	//기관명선택 트리거
	<c:if test="${!empty eduSubjectVO.insttNo}">insttNoChange('<c:out value="${eduSubjectVO.insttNo}"/>');</c:if>

<c:if test="${!empty errorMesag}">
	//validate
	alert('<c:out value="${errorMesag}"/>');
	$('#error_<c:out value="${errorField}"/>').show();
	$('#error_<c:out value="${errorField}"/>').text('<c:out value="${errorMesag}"/>');
	$('#<c:out value="${errorField}"/>').focus();
</c:if>
});
</script>

</body>
</html>