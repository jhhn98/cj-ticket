<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<title>신청자 관리 &gt; 신청자 수정</title>
</head>
<body>

<div class="p-wrap">
	<div class="col-22">
		<!-- 예약 정보 섹션 -->
		<div class="row p-relative">
			<h3 class="col-10" style="margin-top:-5px;">○ 예약 정보</h3>
		</div>

	<form:form id="updateForm" action="./updateEduAplct.do" method="post" modelAttribute="eduAplctVO" onsubmit="return validateForm(this)">
			<input type="hidden" name="key" value="${key}"/>
			<input type="hidden" name="prgSe" value="EDU"/>
			<input type="hidden" name="lctreNo" value="${eduAplctVO.lctreNo}"/>
			<input type="hidden" name="eduAplyNo" value="${eduAplctVO.eduAplyNo}"/>
			<input type="hidden" name="eduRsvtNo" value="${eduAplctVO.eduRsvtNo}"/>
			<input type="hidden" name="insttNo" value="${eduAplctVO.insttNo}"/>
			<input type="hidden" name="searchLctreNo" value="${not empty eduAplctVO.searchLctreNo ? eduAplctVO.searchLctreNo : eduAplctVO.lctreNo}"/>

		<table class="p-table">
			<colgroup>
				<col class="w10p">
				<col/>
				<col class="w15p">
				<col/>
				<col class="w15p">
				<col/>
			</colgroup>
			<tbody class="p-table--th-left">
			<tr>
				<th scope="row">예약번호</th>
				<td>
					<c:out value="${eduAplctVO.eduRsvtNo}"/>
				</td>
				<th scope="row">예약일시</th>
				<td colspan="4">
					<c:if test="${not empty eduAplctVO.applDtMs && fn:length(eduAplctVO.applDtMs) >= 8}">
						<c:set var="dt" value="${eduAplctVO.applDtMs}" />
						${fn:substring(dt, 0, 4)}-${fn:substring(dt, 4, 6)}-${fn:substring(dt, 6, 8)}
						${fn:substring(dt, 8, 10)}:${fn:substring(dt, 10, 12)}:${fn:substring(dt, 12, 14)}.${fn:substring(dt, 14, 18)}
					</c:if>
				</td>
			</tr>
			<tr>
				<th scope="row">운영기간</th>
				<td>
					<c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 8}">
						<c:set var="lctBgnDe" value="${fn:substring(eduLctreVO.lctBgnDt, 0, 8)}"/>
						${fn:substring(lctBgnDe, 0, 4)}-${fn:substring(lctBgnDe, 4, 6)}-${fn:substring(lctBgnDe, 6, 8)}
					</c:if>
					~
					<c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 8}">
						<c:set var="lctEndDe" value="${fn:substring(eduLctreVO.lctEndDt, 0, 8)}"/>
						${fn:substring(lctEndDe, 0, 4)}-${fn:substring(lctEndDe, 4, 6)}-${fn:substring(lctEndDe, 6, 8)}
					</c:if>
				</td>
				<th scope="row">강좌명</th>
				<td colspan="4">
					<c:out value="${eduLctreVO.lctreNm}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">예약상태</th>
				<td>
					<select id="resveSttusCd" name="resveSttusCd" class="p-input p-input--auto">
						<option value="">선택</option>
						<c:forEach var="item" items="${resveSttusCdList}">
							<option value="${item.code}"${eduAplctVO.resveSttusCd eq item.code ? ' selected="selected"':''}><c:out value="${item.codeNm}"/></option>
						</c:forEach>
					</select>
				</td>
				<c:if test="${eduLctreVO.slctMthdCd eq 'CONFM'}">
				<th scope="row">승인일자</th>
				<td>
					<c:if test="${not empty eduAplctVO.aprvDt && fn:length(eduAplctVO.aprvDt) >= 8}">
						<c:set var="aprvDt" value="${eduAplctVO.aprvDt}" />
						${fn:substring(aprvDt, 0, 4)}-${fn:substring(aprvDt, 4, 6)}-${fn:substring(aprvDt, 6, 8)}
						<c:if test="${fn:length(aprvDt) > 8}">
							${fn:substring(aprvDt, 8, 10)}:${fn:substring(aprvDt, 10, 12)}
						</c:if>
					</c:if>
				</td>
				</c:if>
			<th scope="row">수료여부</th>
			<td>
				<c:if test="${eduAplctVO.fnshYn eq 'Y'}">
					수료
				</c:if>
				<c:if test="${eduAplctVO.fnshYn eq 'N'}">
					미수료
				</c:if>
			</td>
			</tr>
			<tr>
				<th scope="row">취소일자</th>
				<td>
					<c:if test="${not empty eduAplctVO.cancelDt && fn:length(eduAplctVO.cancelDt) >= 8}">
						<c:set var="cancelDt" value="${eduAplctVO.cancelDt}" />
						${fn:substring(cancelDt, 0, 4)}-${fn:substring(cancelDt, 4, 6)}-${fn:substring(cancelDt, 6, 8)}
						<c:if test="${fn:length(cancelDt) > 8}">
							${fn:substring(cancelDt, 8, 10)}:${fn:substring(cancelDt, 10, 12)}
						</c:if>
					</c:if>
				</td>
				<th scope="row">취소사유</th>
				<td colspan="4">
					<c:out value="${eduAplctVO.cancelReason}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">수강비</th>
				<td>
					<c:choose>
						<c:when test="${not empty eduLctreVO.eduAmt && eduLctreVO.eduAmt > 0}">
							<fmt:formatNumber value="${eduLctreVO.eduAmt}" pattern="#,###"/> 원
							<c:if test="${not empty eduAplctVO.payAmt}">
								<span>[ 결제금액 : <fmt:formatNumber value="${eduAplctVO.payAmt}" pattern="#,###"/> 원 ]</span>
							</c:if>
						</c:when>
						<c:otherwise>무료</c:otherwise>
					</c:choose>
				</td>
				<c:choose>
					<c:when test="${not empty eduLctreVO.eduAmt && eduLctreVO.eduAmt > 0}">
						<th scope="row">결제방식</th>
						<td colspan="4">
							<c:out value="${payMthdMap[eduAplctVO.payMthdCd]}"/>
						</td>
					</c:when>
					<c:otherwise>
						<th scope="row">결제방식</th>
						<td colspan="4">-</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<c:if test="${not empty eduLctreVO.eduAmt && eduLctreVO.eduAmt > 0}">
			<tr>
				<th scope="row">결제일자</th>
				<td>
					<c:if test="${not empty eduAplctVO.payDt && fn:length(eduAplctVO.payDt) >= 8}">
						<c:set var="payDt" value="${eduAplctVO.payDt}" />
						${fn:substring(payDt, 0, 4)}-${fn:substring(payDt, 4, 6)}-${fn:substring(payDt, 6, 8)}
						<c:if test="${fn:length(payDt) > 8}">
							${fn:substring(payDt, 8, 10)}:${fn:substring(payDt, 10, 12)}
						</c:if>
					</c:if>
				</td>
				<th scope="row">결제상태</th>
				<td colspan="4">
					<select id="paySttusCd" name="paySttusCd" class="p-input p-input--auto">
						<option value="">선택</option>
						<c:forEach var="item" items="${paySttusCdList}">
							<option value="${item.code}"${eduAplctVO.paySttusCd eq item.code ? ' selected="selected"':''}><c:out value="${item.codeNm}"/></option>
						</c:forEach>
					</select>
					<c:if test="${not empty eduAplctVO.rfndReqDt}">
						<br/>환불요청일 :
						<c:set var="rfndReqDt" value="${eduAplctVO.rfndReqDt}" />
						${fn:substring(rfndReqDt, 0, 4)}-${fn:substring(rfndReqDt, 4, 6)}-${fn:substring(rfndReqDt, 6, 8)}
					</c:if>
					<c:if test="${not empty eduAplctVO.rfndReason}">
						<br/>환불사유 : <c:out value="${eduAplctVO.rfndReason}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th scope="row">납부기한</th>
				<td colspan="6">
					<c:if test="${not empty eduAplctVO.payDeadlineDtHm && fn:length(eduAplctVO.payDeadlineDtHm) >= 8}">
						<c:set var="deadlineDt" value="${eduAplctVO.payDeadlineDtHm}" />
						${fn:substring(deadlineDt, 0, 4)}-${fn:substring(deadlineDt, 4, 6)}-${fn:substring(deadlineDt, 6, 8)}
						<c:if test="${fn:length(deadlineDt) > 8}">
							${fn:substring(deadlineDt, 8, 10)}:${fn:substring(deadlineDt, 10, 12)}
						</c:if>
					</c:if>
				</td>
			</tr>
			<tr>
				<th scope="row">환불계좌</th>
				<td colspan="6">
					<c:if test="${not empty eduAplctVO.rfndBankNm || not empty eduAplctVO.rfndAcctNo || not empty eduAplctVO.rfndDpstrNm}">
						<c:out value="${eduAplctVO.rfndBankNm}"/> 
						<c:out value="${eduAplctVO.rfndAcctNo}"/> 
						<c:out value="${eduAplctVO.rfndDpstrNm}"/>
					</c:if>
				</td>
			</tr>

			</c:if>
			<tr>
				<th scope="row">메모</th>
				<td colspan="6">
					<textarea name="memo" id="memo" class="p-input p-input--auto" rows="1" style="width:40%; height:100px;" maxlength="100" placeholder="메모를 입력하세요"><c:out value="${eduAplctVO.memo}"/></textarea>
				</td>
			</tr>
			</tbody>
		</table>

		<!-- 신청자 정보 섹션 (수정 가능) -->
		<div class="row p-relative margin_t_30">
		<h3 class="col-10" style="margin-top:-5px;">○ 신청자 정보</h3>
		<div class="col-14 right" style="">
			<span class="p-icon p-icon__info-circle">주의사항</span>
			<span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
		</div>
	</div>

		<fieldset>
			<legend>신청자 정보 수정</legend>

			<table class="p-table">
				<colgroup>
					<col class="w15p">
					<col/>
				</colgroup>
				<tbody class="p-table--th-left">
				<tr>
					<th scope="row"><label for="applNm">신청자 <span class="p-form__required--icon">필수</span></label></th>
					<td>
						<input type="text" id="applNm" name="applNm" value="${eduAplctVO.applNm}" class="p-input w15p" maxlength="50" />
						<span id="error_applNm" class="form_error"></span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="birthDe">생년월일 <span class="p-form__required--icon">필수</span></label></th>
					<td>
						<div class="p-date-group" style="width:130px">
							<div class="p-form-group p-date" data-date="datepicker">
								<!-- DB 포맷 YYYYMMDD를 YYYY-MM-DD로 변환하여 표시 -->
								<c:set var="birthDeFormat" value="${eduAplctVO.birthDe}"/>
								<c:if test="${not empty birthDeFormat && fn:length(birthDeFormat) == 8}">
									<c:set var="birthDeFormat" value="${fn:substring(birthDeFormat, 0, 4)}-${fn:substring(birthDeFormat, 4, 6)}-${fn:substring(birthDeFormat, 6, 8)}"/>
								</c:if>
								<input type="text" id="birthDe" name="birthDe" value="${birthDeFormat}" readonly placeholder="YYYY-MM-DD" class="p-input bg-none" />
								<div class="p-input__split"><button type="button" class="p-input__item p-date__icon">달력 열기</button></div>
							</div>
						</div>
						<span id="error_birthDe" class="form_error"></span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="genderSe1">성별 <span class="p-form__required--icon">필수</span></label></th>
					<td>
				<span class="p-form-radio">
								<input type="radio" id="genderSe1" name="genderSe" value="M"${eduAplctVO.genderSe eq 'M' ? ' checked="true"':''} class="p-form-radio__input" />
								<label for="genderSe1" class="p-form-radio__label">남</label>
				</span> &nbsp;
						<span class="p-form-radio">
								<input type="radio" id="genderSe2" name="genderSe" value="F"${eduAplctVO.genderSe eq 'F' ? ' checked="true"':''} class="p-form-radio__input" />
								<label for="genderSe2" class="p-form-radio__label">여</label>
				</span>
						<span id="error_genderSe" class="form_error"></span>
					</td>
				</tr>

				<tr>
					<th scope="row"><label for="telNo1">연락처 <span class="p-form__required--icon">필수</span></label></th>
					<td>
						<c:set var="telNoArr" value="${fn:length(eduAplctVO.telNo) == 11 ? [fn:substring(eduAplctVO.telNo, 0, 3), fn:substring(eduAplctVO.telNo, 3, 7), fn:substring(eduAplctVO.telNo, 7, 11)] : ['010','','']}"/>
						<select id="telNo1" name="telNo1" class="p-input p-input--auto" title="연락처">
							<option value="010"${telNoArr[0] eq '010' ? ' selected="true"':''}>010</option>
							<option value="011"${telNoArr[0] eq '011' ? ' selected="true"':''}>011</option>
							<option value="016"${telNoArr[0] eq '016' ? ' selected="true"':''}>016</option>
							<option value="017"${telNoArr[0] eq '017' ? ' selected="true"':''}>017</option>
							<option value="018"${telNoArr[0] eq '018' ? ' selected="true"':''}>018</option>
							<option value="019"${telNoArr[0] eq '019' ? ' selected="true"':''}>019</option>
						</select> -
						<input type="text" id="telNo2" name="telNo2" value="${telNoArr[1]}" maxlength="4" class="p-input w5p" title="연락처번호2" /> -
						<input type="text" id="telNo3" name="telNo3" value="${telNoArr[2]}" maxlength="4" class="p-input w5p" title="연락처번호3" />
						<input type="hidden" id="telNo" name="telNo" value="${eduAplctVO.telNo}"/>
						<span id="error_telNo" class="form_error"></span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="zip">주소</label></th>
					<td>
						<input type="text" id="zip" name="zip" value="${eduAplctVO.zip}" readonly class="p-input w5p" maxlength="5"/>
						<button type="button" class="p-button edit" onclick="fn_openDaumZipAddress();">우편번호찾기</button>
						<span class="small marginLeft_10">우편번호 검색창이 새창으로 열립니다.</span><br/>
						<input type="text" id="addr" name="addr" value="${eduAplctVO.addr}" readonly class="p-input w50p" /><br/>
						<input type="text" id="detailAddr" name="detailAddr" value="${eduAplctVO.detailAddr}" class="p-input w50p" placeholder="상세주소 입력"/>
						<span id="error_zip" class="form_error"></span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="email">이메일</label></th>
					<td>
						<input type="text" id="email" name="email" value="${eduAplctVO.email}" class="p-input w15p" maxlength="100" placeholder="example@domain.com" />
						<span id="error_email" class="form_error"></span>
					</td>
				</tr>
					<c:if test="${eduLctreVO.residenceUseYn eq 'Y'}">
						<tr>
							<th scope="row">거주지</th>
							<td>
								<c:out value="${lgldongMap[eduAplctVO.resInqCd]}"/>
							</td>
						</tr>
					</c:if>
				<%--<tr>
					<th scope="row"><label for="dscntUseSe1">감면신청</label></th>
					<td>
						<span class="p-form-radio">
								<input type="radio" id="dscntUseSe2" name="dscntUseSe" value="N"${eduAplctVO.dscntUseSe eq 'N' || empty eduAplctVO.dscntUseSe ? ' checked="true"':''} class="p-form-radio__input" onclick="toggleDscntCd(false);" />
								<label for="dscntUseSe2" class="p-form-radio__label">신청 안함</label>
							</span> &nbsp;
							<span class="p-form-radio">
								<input type="radio" id="dscntUseSe1" name="dscntUseSe" value="Y"${eduAplctVO.dscntUseSe eq 'Y' ? ' checked="true"':''} class="p-form-radio__input" onclick="toggleDscntCd(true);" />
								<label for="dscntUseSe1" class="p-form-radio__label">신청</label>
							</span> &nbsp;
						<span class="p-form-radio">
								<input type="radio" id="dscntUseSe3" name="dscntUseSe" value="M"${eduAplctVO.dscntUseSe eq 'M' ? ' checked="true"':''} class="p-form-radio__input" onclick="toggleDscntCd(true);" />
								<label for="dscntUseSe3" class="p-form-radio__label">관리자 승인</label>
						</span>
					</td>
				</tr>--%>

				<tr id="dscntCdRow" style="${eduAplctVO.dscntUseSe eq 'Y' || eduAplctVO.dscntUseSe eq 'M' ? '' : 'display:none;'}">
					<th scope="row"><label for="dscntCd">감면선택</label></th>
					<td>
						<select id="dscntCd" name="dscntCd" class="p-input p-input--auto" onchange="calculatePayAmt();">
							<option value="">선택</option>
							<c:forEach var="item" items="${dscntCdList}">
								<option value="${item.code}" data-rate="${item.dcValue}"${eduAplctVO.dscntCd eq item.code ? ' selected="true"':''}><c:out value="${item.codeNm}"/></option>
							</c:forEach>
						</select>
						<div class="margin_t_10 text_red" id="dscntGuide" style="display:none;">
							※ 선택하신 항목은 관리자 승인 후 할인이 적용됩니다. 관련 서류를 제출해주세요.
						</div>
						<!-- 감면구분 테이블 -->
						<c:if test="${not empty dscntCdList}">
							<div class="margin_t_10" style="width:90%">
								<table class="p-table p-table--bordered">
									<colgroup>
										<col class="w30p">
										<col/>
										<col class="w15p">
										<col class="w10p">
									</colgroup>
									<thead>
									<tr>
										<th>감면구분</th>
										<th style="text-align:center">감면혜택 조건</th>
										<th style="text-align:center">자격확인 방법</th>
										<th style="text-align:center">할인율</th>
									</tr>
									</thead>
									<tbody class="text_center">
									<c:forEach var="item" items="${dscntCdList}" varStatus="sts">
										<tr>
											<td><c:out value="${item.codeNm}"/></td>
											<td><c:out value="${item.codeDc}"/></td>
											<td>비대면 자격인증</td>
											<td><c:out value="${item.dcValue}"/> %</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row">총 결제금액</th>
					<td>
						<!-- 강좌 기본 금액 -->
						<input type="hidden" id="basePayAmt" value="${not empty eduLctreVO.eduAmt ? eduLctreVO.eduAmt : 0}"/>
						<input type="hidden" id="payAmt" name="payAmt" value="${eduAplctVO.payAmt}"/>
						<span class="em_blue" id="payAmtTxt">
							<c:choose>
								<c:when test="${not empty eduAplctVO.payAmt}">
									<fmt:formatNumber value="${eduAplctVO.payAmt}" pattern="#,###"/>
								</c:when>
								<c:when test="${not empty eduLctreVO.eduAmt}">
									<fmt:formatNumber value="${eduLctreVO.eduAmt}" pattern="#,###"/>
								</c:when>
								<c:otherwise>0</c:otherwise>
							</c:choose>
						</span> 원
					</td>
				</tr>
				</tbody>
			</table>

			<div class="row margin_t_15">
				<div class="col-12">
					<c:choose>
						<c:when test="${referer eq 'list'}">
							<%-- eduAplctList.jsp에서 온 경우 --%>
							<a href="./selectEduAplctList.do?<c:out value="${eduAplctSearchVO.params}"/>" class="p-button cancel">목록</a>
						</c:when>
						<c:otherwise>
							<%-- eduAplctListByEdu.jsp에서 온 경우 (기본값) --%>
							<a href="./selectEduAplctListByEdu.do?<c:out value="${eduAplctSearchVO.params}"/>" class="p-button cancel">목록</a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="col-12 right">
					<input type="submit" class="p-button write" value="수정">
				</div>
			</div>
		</fieldset>
	</form:form>
	</div>
</div>

<!-- 다음 우편번호 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script nonce="NEOCMSSCRIPT">
	// 우편번호 찾기
	function fn_openDaumZipAddress() {
		new daum.Postcode({
			oncomplete: function(data) {
				$("#zip").val(data.zonecode);
				$("#addr").val(data.address);
				$("#detailAddr").show();
				$("#detailAddr").focus();
			}
		}).open();
	}

	// 감면코드 표시 토글
	function toggleDscntCd(show) {
		if (show) {
			$("#dscntCdRow").show();
			$("#dscntGuide").show();
		} else {
			$("#dscntCdRow").hide();
			$("#dscntCd").val("");
			$("#dscntGuide").hide();
			calculatePayAmt();
		}
	}

	// 결제금액 계산
	function calculatePayAmt() {
		var baseAmt = parseInt($("#basePayAmt").val()) || 0;
		
		// 기본 금액이 없으면 계산하지 않음
		if (!baseAmt || baseAmt === 0) {
			console.log("기본 금액이 설정되지 않아 계산을 건너뜁니다.");
			return;
		}
		
		var dscntUseSe = $('input[name=dscntUseSe]:checked').val();
		var dscntRate = 0;

		if (dscntUseSe === 'Y' || dscntUseSe === 'M') {
			var selectedOption = $("#dscntCd option:selected");
			if (selectedOption.val()) {
				dscntRate = parseInt(selectedOption.data('rate')) || 0;
			}
		}

		var discountAmt = Math.floor(baseAmt * dscntRate / 100);
		var finalAmt = baseAmt - discountAmt;

		$("#payAmt").val(finalAmt);
		$("#payAmtTxt").text(finalAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	}

	// 폼 검증
	function validateForm(frm) {
		// 신청자명 필수
		if (!frm.applNm.value.trim()) {
			alert("신청자명을 입력해주세요.");
			frm.applNm.focus();
			return false;
		}

		// 생년월일 필수
		if (!frm.birthDe.value.trim()) {
			alert("생년월일을 입력해주세요.");
			frm.birthDe.focus();
			return false;
		}

		// 성별 필수
		if (!$('input:radio[name=genderSe]').is(':checked')) {
			alert('성별을 선택해주세요.');
			frm.genderSe1.focus();
			return false;
		}

		// 연락처 필수
		if (!frm.telNo2.value.trim() || !frm.telNo3.value.trim()) {
			alert('연락처를 입력해주세요.');
			if (!frm.telNo2.value.trim()) frm.telNo2.focus();
			else frm.telNo3.focus();
			return false;
		}

		// 연락처 숫자 검증
		if (isNaN(frm.telNo2.value) || isNaN(frm.telNo3.value)) {
			alert('연락처는 숫자로만 입력해주세요.');
			return false;
		}

		// 연락처 조합
		var telNo = frm.telNo1.value + frm.telNo2.value + frm.telNo3.value;
		frm.telNo.value = telNo;

		if (!confirm("수정하시겠습니까?")) {
			return false;
		}

		return true;
	}

	$(document).ready(function() {
		// 숫자만 입력
		$('#telNo2, #telNo3').on('keyup', function() {
			$(this).val($(this).val().replace(/[^0-9]/g, ""));
		});

		// 초기 결제금액 설정 (기존 값이 없을 때만 계산)
		if (!$("#payAmt").val() || $("#payAmt").val() == '0') {
			calculatePayAmt();
		}

		// 감면 선택 시 가이드 표시
		$('input[name=dscntUseSe]').change(function() {
			if ($(this).val() === 'M') {
				$("#dscntGuide").show();
			} else {
				$("#dscntGuide").hide();
			}
		});

		// 생년월일 datepicker 설정 (날짜 포맷: YYYY-MM-DD, DB 저장 시 YYYYMMDD로 자동 변환)
		$('[data-date="datepicker"]').each(function() {
			var $input = $(this).find('input[type="text"]');
			$input.datepicker({
				dateFormat: 'yy-mm-dd',
				changeMonth: true,
				changeYear: true,
				yearRange: '1900:' + new Date().getFullYear(),
				maxDate: 0
			});
		});
	});
</script>

</body>
</html>
