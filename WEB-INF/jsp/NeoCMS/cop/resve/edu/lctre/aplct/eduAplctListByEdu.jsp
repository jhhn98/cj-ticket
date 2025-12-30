<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<title>신청자 관리 &gt; 접수자관리 목록</title>
</head>
<body>

<div class="p-wrap">
	<!-- 프로그램 정보 -->
	<h3 class="p-section-title margin_t_20">○ 프로그램 정보</h3>
	<table class="p-table">
		<colgroup>
			<col class="w15p">
			<col/>
			<col class="w15p">
			<col/>
		</colgroup>
		<tbody class="p-table--th-left">
		<tr>
			<th scope="row">강좌명</th>
			<td colspan="4">
				<c:out value="${eduLctreVO.lctreNm}"/>
			</td>
		</tr>
		<tr>
			<th scope="row">기관명</th>
			<td>
				<c:out value="${eduLctreVO.insttNm}"/>
			</td>
			<th scope="row">과목</th>
			<td>
				<c:out value="${eduLctreVO.subjectNm}"/>
			</td>
		</tr>
		<tr>
			<th scope="row">모집기간</th>
			<td>
				<c:if test="${not empty eduLctreVO.rcptBgnDt && fn:length(eduLctreVO.rcptBgnDt) >= 12}">
					<c:set var="rcptBgnDe" value="${fn:substring(eduLctreVO.rcptBgnDt, 0, 8)}"/>
					<c:set var="rcptBgnHm" value="${fn:substring(eduLctreVO.rcptBgnDt, 8, 12)}"/>
					${fn:substring(rcptBgnDe, 0, 4)}-${fn:substring(rcptBgnDe, 4, 6)}-${fn:substring(rcptBgnDe, 6, 8)} ${fn:substring(rcptBgnHm, 0, 2)}:${fn:substring(rcptBgnHm, 2, 4)}
				</c:if>
				~
				<c:if test="${not empty eduLctreVO.rcptEndDt && fn:length(eduLctreVO.rcptEndDt) >= 12}">
					<c:set var="rcptEndDe" value="${fn:substring(eduLctreVO.rcptEndDt, 0, 8)}"/>
					<c:set var="rcptEndHm" value="${fn:substring(eduLctreVO.rcptEndDt, 8, 12)}"/>
					${fn:substring(rcptEndDe, 0, 4)}-${fn:substring(rcptEndDe, 4, 6)}-${fn:substring(rcptEndDe, 6, 8)} ${fn:substring(rcptEndHm, 0, 2)}:${fn:substring(rcptEndHm, 2, 4)}
				</c:if>
			</td>
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
		</tr>
		<tr>
			<th scope="row">신청/모집정원</th>
			<td>
				모집인원 : 총 <c:out value="${eduLctreVO.onlineCnt}"/>명
				(
				<c:out value="${eduLctreVO.rsvCmplCnt != null ? eduLctreVO.rsvCmplCnt : 0}"/>명
				/
				<c:out value="${eduLctreVO.onlineCnt}"/>명
				)
			</td>
			<th scope="row">교육시간/요일</th>
			<td>
				<c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 12}">
					<c:set var="lctBgnHm" value="${fn:substring(eduLctreVO.lctBgnDt, 8, 12)}"/>
					${fn:substring(lctBgnHm, 0, 2)}:${fn:substring(lctBgnHm, 2, 4)}
				</c:if>
				~
				<c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 12}">
					<c:set var="lctEndHm" value="${fn:substring(eduLctreVO.lctEndDt, 8, 12)}"/>
					${fn:substring(lctEndHm, 0, 2)}:${fn:substring(lctEndHm, 2, 4)}
				</c:if>
				<c:if test="${not empty eduLctreVO.lctWeekNm}">
					(<c:out value="${eduLctreVO.lctWeekNm}"/>)
				</c:if>
			</td>
		</tr>
		<tr>
			<th scope="row">이용요금</th>
			<td>
				<c:choose>
					<c:when test="${not empty eduLctreVO.eduAmt && eduLctreVO.eduAmt > 0}">
						<fmt:formatNumber value="${eduLctreVO.eduAmt}" pattern="#,###"/> 원
					</c:when>
					<c:otherwise>무료</c:otherwise>
				</c:choose>
			</td>
			<th scope="row">결제방식</th>
			<td>
			</td>
		</tr>
		<tr>
			<th scope="row">운영상태</th>
			<td>
				<c:out value="${operSttusMap[eduLctreVO.operSttus]}"/>
			</td>
			<th scope="row">선발방법</th>
			<td>
				<c:out value="${slctMthdMap[eduLctreVO.slctMthdCd]}"/>
			</td>
		</tr>
		<tr>
			<th scope="row">폐강조건</th>
			<td>
				<c:choose>
					<c:when test="${eduLctreVO.closeMinCnt > 0}">
						<c:out value="${eduLctreVO.closeMinCnt}"/>명 미만
					</c:when>
					<c:otherwise>
						폐강 설정 없음.
					</c:otherwise>
				</c:choose>
			</td>
			<th scope="row">패널티 설정</th>
			<td>
				<c:choose>
					<c:when test="${eduLctreVO.attendMinRate > 0}">
						출석률 기준 미달 시 패널티 적용 :
						전체 출석일 수의 <c:out value="${eduLctreVO.attendMinRate}"/>%
					</c:when>
					<c:otherwise>
						패널티 설정 없음.
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<%-- 추첨 영역 --%>
		<c:if test="${not empty eduLctreVO.drwtDt}">
		<tr>
			<th scope="row">추첨</th>
			<td colspan="3">
				<c:set var="drwtDe" value="${fn:substring(eduLctreVO.drwtDt, 0, 8)}"/>
				<c:choose>
					<%-- 추첨일자 이전: 추첨대기 텍스트 표시 --%>
					<c:when test="${drwtDe > eduLctreVO.today}">
						<c:if test="${fn:length(drwtDe) >= 8}">
							추첨대기 (${fn:substring(drwtDe, 0, 4)}-${fn:substring(drwtDe, 4, 6)}-${fn:substring(drwtDe, 6, 8)})
						</c:if>
					</c:when>
					<%-- 추첨일자 이후: 예비추첨실행 버튼 활성화 --%>
					<c:otherwise>
						<button type="button" class="p-button primary" onclick="fn_executeTempDrwt()">예비추첨실행</button>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		</c:if>
		</tbody>
	</table>

	<h3 class="p-section-title margin_t_20">○ 신청자목록</h3>
	<div class="row p-relative">
		<div class="col-6 margin_t_5">
			<a href="/${menuInfo.siteId}/selectEduAplctListByEdu.do?" title="목록 초기화">
				<span>총 <strong><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###"/></strong> 건</span>
				<span class="division_line">[ <strong><c:out value="${paginationInfo.currentPageNo}"/></strong> / <c:out value="${paginationInfo.totalPageCount}"/> 페이지 ]</span>
			</a>
		</div>
		<div class="col-18 right">
			<form id="searchListFrm" method="get" action="/${menuInfo.siteId}/selectEduAplctListByEdu.do">
				<input type="hidden" name="key" value="${key}"/>
				<input type="hidden" name="prgSe" value="EDU"/>
				<input type="hidden" name="searchLctreNo" value="${eduLctreVO.lctreNo}"/>

				<fieldset>
					<legend>신청자 검색</legend>
					<!-- 목록수 -->
					<select id="pageUnit" name="pageUnit" class="p-input p-input--auto">
						<option value="10"${eduAplctVO.pageUnit eq 10 ? ' selected="true"':''}>10개씩</option>
						<option value="50"${eduAplctVO.pageUnit eq 50 ? ' selected="true"':''}>50개씩</option>
						<option value="100"${eduAplctVO.pageUnit eq 100 ? ' selected="true"':''}>100개씩</option>
					</select>
					<!-- 결제상태 -->
					<select id="searchPaySttusCd" name="searchPaySttusCd" class="p-input p-input--auto">
						<option value="">결제 상태</option>
						<c:forEach var="item" items="${paySttusCdList}">
							<option value="${item.code}"${eduAplctVO.searchPaySttusCd eq item.code ? ' selected="true"':''}><c:out value="${item.codeNm}"/></option>
						</c:forEach>
					</select>
					<!-- 예약상태 -->
					<select id="searchResveSttusCd" name="searchResveSttusCd" class="p-input p-input--auto">
						<option value="">예약 상태</option>
						<c:forEach var="item" items="${resveSttusCdList}">
							<option value="${item.code}"${eduAplctVO.searchResveSttusCd eq item.code ? ' selected="true"':''}><c:out value="${item.codeNm}"/></option>
						</c:forEach>
					</select>
					<!-- 신청자명 -->
					<input name="searchApplNm" value="${eduAplctVO.searchApplNm}" title="신청자명 입력" placeholder="신청자명 입력" class="p-input p-input--auto"/>
					<button type="submit" class="p-button p-button--small primary">검색</button>
				</fieldset>
			</form>
		</div>
	</div>
	<table class="p-table p-table--bordered">
		<colgroup>
			<col class="w10">
			<col class="w60">
			<col class="w100">
			<col class="w120">
			<col class="w100">
			<col class="w100">
			<col class="w120">
			<col class="w100">
			<col class="w100">
			<col class="w100">
			<col class="w100">
			<col class="w140">
		</colgroup>
		<thead>
		<tr>
			<th scope="col">
				<input type="checkbox" id="checkAll" name="checkAll" class="allCheck" title="전체선택"/>
			</th>
			<th scope="col">번호</th>
			<th scope="col">신청자</th>
			<th scope="col">생년월일</th>
			<th scope="col">성별</th>
			<th scope="col">연락처</th>
			<th scope="col">신청일</th>
			<c:if test="${eduLctreVO.residenceUseYn eq 'Y'}"><th scope="col">거주지</th></c:if>
			<th scope="col">결제상태(결제수단)<br/>결제기한</th>
			<th scope="col">예약상태</th>
			<th scope="col">수강이력</th>
			<th scope="col">관리</th>
		</tr>
		</thead>
		<tbody class="text_center">
		<c:set var="pageNo" value="${paginationInfo.currentPageStartNo}" />
		<c:forEach var="result" items="${eduAplctList}" varStatus="status">
			<tr class="colored">
				<td><input type="checkbox" name="chk" value="${result.eduAplyNo}" /></td>
				<td><c:out value="${pageNo}"/></td>
				<td class="text_left"><c:out value="${result.applNm}"/></td>
				<td>
					<!-- 생년월일 포맷 (YYYY.MM.DD) -->
					<c:if test="${not empty result.birthDe && fn:length(result.birthDe) == 8}">
						${fn:substring(result.birthDe, 0, 4)}.${fn:substring(result.birthDe, 4, 6)}.${fn:substring(result.birthDe, 6, 8)}
					</c:if>
				</td>
				<td>
					<c:choose>
						<c:when test="${result.genderSe eq 'M'}">남</c:when>
						<c:when test="${result.genderSe eq 'F'}">여</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose>
				</td>
				<td>
					<!-- 연락처 포맷 (010-1234-5678) -->
					<c:if test="${not empty result.telNo && fn:length(result.telNo) == 11}">
						${fn:substring(result.telNo, 0, 3)}-${fn:substring(result.telNo, 3, 7)}-${fn:substring(result.telNo, 7, 11)}
					</c:if>
				</td>
				<td>
					<!-- 신청일 -->
					<c:if test="${not empty result.applDtMs && fn:length(result.applDtMs) >= 8}">
						<c:set var="dt" value="${result.applDtMs}" />
						${fn:substring(dt, 0, 4)}-${fn:substring(dt, 4, 6)}-${fn:substring(dt, 6, 8)}<br/>
						${fn:substring(dt, 8, 10)}:${fn:substring(dt, 10, 12)}:${fn:substring(dt, 12, 14)}.${fn:substring(dt, 14, 16)}
					</c:if>
				</td>
				<%-- 거주지 --%>
				<c:if test="${eduLctreVO.residenceUseYn eq 'Y'}">
				<td>
					<c:out value="${lgldongMap[result.resInqCd]}"/>
				</td>
				</c:if>
			<td>
				<!-- 결제상태 -->
				<c:out value="${paySttusCdMap[result.paySttusCd]}"/>
				<%-- 결제수단 표시 --%>
				<c:if test="${not empty result.payMthdCd}">
					(<c:out value="${payMthdMap[result.payMthdCd]}"/>)
				</c:if>
				<%-- 결제기한 표시 (전자결제이고 결제대기 상태일 때만) --%>
				<c:if test="${result.payMthdCd == 'ELCTRN' && result.paySttusCd == 'PAY_WAIT' && not empty result.payDeadlineDtHm}">
					<c:if test="${fn:length(result.payDeadlineDtHm) >= 12}">
						<br/><c:out value="${tsu:toDateFormat(result.payDeadlineDtHm, 'yyyyMMddHHmm', 'yyyy-MM-dd')}"/>
						<c:out value="${tsu:toDateFormat(result.payDeadlineDtHm, 'yyyyMMddHHmm', 'HH:mm')}"/>
					</c:if>
				</c:if>
			</td>
			<td>
				<!-- 예약상태 -->
				<c:out value="${resveSttusCdMap[result.resveSttusCd]}"/>
			</td>
				<td>
					<%-- 관리자 등록은 이력보기 미표출 --%>
					<c:if test="${result.adminYn ne 'Y'}">
						<a href="./selectEduAplctHistList.do?eduAplyNo=${result.eduAplyNo}&amp;<c:out value="${eduAplctVO.params}"/>" class="p-button p-button--xsmall edit">이력보기</a>
					</c:if>
				</td>
				<td>
					<a href="./updateEduAplctView.do?eduAplyNo=${result.eduAplyNo}&amp;insttNo=${result.insttNo}&amp;<c:out value="${eduAplctVO.params}"/>" class="p-button p-button--xsmall edit">수정</a>
					<a href="./deleteEduAplct.do?eduAplyNo=${result.eduAplyNo}&amp;<c:out value="${eduAplctVO.params}"/>"
					   onclick="fn_delete(this.href, '<c:out value="${result.applNm}"/>'); return false;" class="p-button p-button--xsmall delete">삭제</a>
				</td>
			</tr>
			<c:set var="pageNo" value="${pageNo-1}" />
		</c:forEach>
		<c:if test="${fn:length(eduAplctList) == 0}">
			<tr>
				<td colspan="12" class="empty">등록된 정보가 없습니다</td>
			</tr>
		</c:if>
		</tbody>
	</table>

	<div class="row margin_t_10">
		<div class="col-8 left">
			<button type="button" class="p-button darken" onclick="fn_checkAll()">전체선택</button>
			<select name="paySttusCdMulti" id="paySttusCdMulti" class="p-input p-input--auto">
				<option value="">결제상태</option>
				<c:forEach var="item" items="${paySttusCdList}">
					<option value="${item.code}"><c:out value="${item.codeNm}"/></option>
				</c:forEach>
			</select>
			<select name="resveSttusCdMulti" id="resveSttusCdMulti" class="p-input p-input--auto">
				<option value="">예약상태</option>
				<c:forEach var="item" items="${resveSttusCdList}">
					<option value="${item.code}"><c:out value="${item.codeNm}"/></option>
				</c:forEach>
			</select>
			<button type="button" class="p-button edit" onclick="fn_changeStatusMulti()">변경</button>
		</div>
		<div class="col-8 center">
			<ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="/${menuInfo.siteId}/selectEduAplctListByEdu.do?${eduAplctVO.paramsExclPi}&amp;pageIndex=" />
		</div>
        <div class="col-8 right">
			<button type="button" data-button="modal" class="p-button sms-modal-btn">선택 SMS발송</button>
            <a href="./selectEduLctreList.do?key=${key}"  class="p-button primary">프로그램 목록</a>
			<a href="./addEduAplctView.do?lctreNo=<c:out value="${eduLctreVO.lctreNo}"/>&amp;<c:out value="${eduAplctVO.params}"/>"  class="p-button primary">추가 입력</a>
		</div>
	</div>
	<div class="row margin_t_10">
		<div class="col-12 left">
			<span class="p-icon p-icon__info-circle-solid">주의사항</span>
			엑셀업로드 시 업로드 양식에 맞춰서 기입 후 업로드 부탁드립니다.<br/>
			<span class="p-icon p-icon__info-circle-solid">주의사항</span>
			올바르지 않은 양식으로 업로드 시 오류가 발생할 수 있습니다.<br/>
			<span class="p-icon p-icon__info-circle-solid">주의사항</span>
			오기입된 정보가 있는지 다시 한 번 확인 바랍니다.<br/>
			<span class="p-icon p-icon__info-circle-solid">주의사항</span>
			유료강좌에서 일괄업로드 시에는 결제상태를 수기로 변경해주셔야 합니다.<br/>
			<a href="/DATA/edu/eduAplctUpload.xls" class="p-button p-button--combine excel">신청자 일괄업로드 양식 다운로드</a>
			<a href="#" onclick="fnExcelUpload(); return false;" class="p-button p-button--combine excel">신청자 일괄업로드</a>
		</div>
		<div class="col-12 right">
			<a href="#" onclick="fnExcelDownload(); return false;" class="p-button p-button--combine download">신청자정보 엑셀다운로드</a>
			<a href="./selectAtendList.do?lctreNo=${eduLctreVO.lctreNo}&amp;key=${key}"  class="p-button edit">출석관리</a>
		</div>
	</div>

</div>

<!-- SMS 발송 모달 -->
<div class="modal" id="smsModal" tabindex="0" role="dialog">
	<div class="modal__body">
		<div class="modal__header">
			<div class="modal__title">SMS 발송</div>
		</div>
		<div class="modal__content">
			<table class="p-table">
				<colgroup>
					<col class="w20p">
					<col/>
				</colgroup>
				<tbody class="p-table--th-left">
				<tr>
					<th scope="row">기관명</th>
					<td>
						<c:out value="${eduLctreVO.insttNm}"/>
					</td>
				</tr>
				<tr>
					<th scope="row">전화번호</th>
					<td>
						<input type="text" id="senderPhone" class="p-input" placeholder="숫자만 입력 (0431231234)" maxlength="11" value="<c:out value="${eduLctreVO.telNo}"/>"/>
						<p class="p-form__help">※ 회신받을 전화번호는 숫자만 입력 가능합니다.</p>
					</td>
				</tr>
				<tr>
					<th scope="row">전송메시지 <span class="p-form__required--icon">필수</span></th>
					<td>
						<textarea id="smsMessage" class="p-input" rows="5" placeholder="전송할 메시지를 입력하세요" maxlength="2000" style="width:100%; resize:vertical;"></textarea>
						<div class="text_right margin_t_5">
							<span id="messageLength">0</span> / 2000자
						</div>
					</td>
				</tr>
				</tbody>
			</table>
			<div class="text_center margin_t_10">
				<button type="button" class="p-button primary" onclick="fnSendSmsMessage()">문자전송</button>
			</div>
		</div>
		<div class="modal__footer">
			<button type="button" class="p-button default" data-close="modal">닫기</button>
		</div>
		<div class="modal__close">
			<button type="button" data-close="modal" class="modal-button_close"><span>X</span></button>
		</div>
	</div>
</div>

<script nonce="NEOCMSSCRIPT">
	// 엑셀다운로드
	function fnExcelDownload() {
		// 현재 검색 조건 유지하여 엑셀 다운로드
		var param = document.location.href.split("?");
		var url = './downloadEduAplctListByEdu.do?' + (param[1] || 'key=${key}&searchLctreNo=${eduLctreVO.lctreNo}');
		window.location.href = url;
	}
	
	// SMS 발송 모달 열기
	$(".sms-modal-btn").on("click", function () {
		var checked = $("input[name='chk']:checked");
		
		// 선택된 신청자 확인
		if (checked.length == 0) {
			alert("SMS를 발송할 신청자를 선택해주세요.");
			return false;
		}
		
		// 모달 열기
		$(this).modalPop({
			target: "#smsModal",
		width: "600",
		height: "auto"
	});
	
	// 입력 필드 초기화
	$('#smsMessage').val('');
	$('#messageLength').text('0');
});
	
	// SMS 모달 닫기
	function fnCloseSmsModal() {
		$('#smsModal button[data-close="modal"]').first().trigger('click');
	}
	
	// 메시지 글자수 카운트
	$('#smsMessage').on('input', function() {
		var length = $(this).val().length;
		$('#messageLength').text(length);
	});
	
	// 전화번호 숫자만 입력 (하이픈 자동 제거)
	$('#senderPhone').on('input', function() {
		var value = $(this).val().replace(/[^0-9]/g, '');
		$(this).val(value);
	});
	
	// 문자 전송
	function fnSendSmsMessage() {
		var senderPhone = $('#senderPhone').val().trim();
		var message = $('#smsMessage').val().trim();
		
		// 입력값 검증
		if (!senderPhone) {
			alert("전화번호를 입력해주세요.");
			$('#senderPhone').focus();
			return;
		}
		
		// 전화번호 형식 검증 (숫자만 9~11자리)
		if (senderPhone.length < 9 || senderPhone.length > 11) {
			alert("전화번호는 9~11자리 숫자만 입력 가능합니다.");
			$('#senderPhone').focus();
			return;
		}
		
		if (!message) {
			alert("전송할 메시지를 입력해주세요.");
			$('#smsMessage').focus();
			return;
		}
		
		// 선택된 신청자 정보 수집
		var checked = $("input[name='chk']:checked");
		var eduAplyNoArr = [];
		
		checked.each(function() {
			eduAplyNoArr.push($(this).val());
		});
		
		if (!confirm(checked.length + "명에게 문자를 발송하시겠습니까?")) {
			return;
		}
		
		// AJAX로 서버에 SMS 발송 요청
		$.ajax({
			url: './sendSmsToApplcnt.do',
			type: 'POST',
			data: {
				senderPhone: senderPhone,
				message: message,
				eduAplyNoArr: eduAplyNoArr,
				lctreNo: '${eduLctreVO.lctreNo}',
				key: '${key}'
			},
			traditional: true, // 배열 전송을 위해 필요
			dataType: 'json',
			beforeSend: function() {
				$("body").css("cursor", "wait");
			},
			success: function(response) {
				$("body").css("cursor", "default");
				
				if (response.success) {
					alert(response.message);
					fnCloseSmsModal();
					// 체크박스 초기화
					$("input[name='chk']").prop('checked', false);
					$("#checkAll").prop('checked', false);
				} else {
					alert(response.message || "SMS 발송 중 오류가 발생했습니다.");
				}
			},
			error: function(xhr, status, error) {
				$("body").css("cursor", "default");
				alert("SMS 발송 중 오류가 발생했습니다.\n" + error);
			}
		});
	}
	
	// 모달 배경 클릭 시 닫기
	$(document).on('click', '#smsModal', function(e) {
		if (e.target.id === 'smsModal') {
			fnCloseSmsModal();
		}
	});
	
	// 엑셀업로드
	function fnExcelUpload() {
		var lctreNo = '${eduLctreVO.lctreNo}';
		if (!lctreNo) {
			alert("강좌를 먼저 선택해주세요.");
			return;
		}
		
		// 파일 선택 input 생성
		var fileInput = document.createElement("input");
		fileInput.type = "file";
		fileInput.accept = ".xls,.xlsx";
		fileInput.style.display = "none";
		
		fileInput.onchange = function(e) {
			var file = e.target.files[0];
			if (!file) return;
			
			// 파일 확장자 확인
			var fileName = file.name;
			var fileExt = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
			if (fileExt !== 'xls' && fileExt !== 'xlsx') {
				alert("엑셀 파일만 업로드 가능합니다(.xls, .xlsx)");
				return;
			}
			
			// 파일 크기 확인 (10MB 제한)
			if (file.size > 10 * 1024 * 1024) {
				alert("파일 크기는 10MB를 초과할 수 없습니다.");
				return;
			}
			
			if (confirm(fileName + " 파일을 업로드하시겠습니까?\n\n※ 엑셀양식에 맞춰서 업로드해주셔야 정상 업로드됩니다.")) {
				// FormData 생성하여 업로드
				var formData = new FormData();
				formData.append("file", file);
				formData.append("lctreNo", lctreNo);
				formData.append("key", "${key}");
				
				// AJAX 요청
				$.ajax({
					url: './uploadEduAplctExcel.do',
					type: 'POST',
					data: formData,
					processData: false,
					contentType: false,
					dataType: 'json',
					beforeSend: function() {
						// 로딩 표시
						$("body").css("cursor", "wait");
					},
					success: function(response) {
						$("body").css("cursor", "default");
						
						if (response.success) {
							// 성공 메시지 표시
							alert(response.message);
							// 목록 페이지로 이동
							if (response.redirectUrl) {
								location.href = response.redirectUrl;
							} else {
								location.reload();
							}
						} else {
							// 실패 메시지 표시
							alert(response.message || "업로드 중 오류가 발생했습니다.");
						}
					},
					error: function(xhr, status, error) {
						$("body").css("cursor", "default");
						alert("엑셀 업로드 중 오류가 발생했습니다.\n" + error);
					}
				});
			}
		};
		
		document.body.appendChild(fileInput);
		fileInput.click();
		document.body.removeChild(fileInput);
	}

	// 신청자 삭제
	function fn_delete(url, name) {
		if(confirm(name + "님의 정보를 삭제하시겠습니까? 삭제 시 복구가 불가능합니다.")) {
			location.href = url;
		}
	}


	// 전체선택 (체크박스 헤더)
	$("#checkAll").on("change", function() {
		$("input[name='chk']").prop("checked", $(this).prop("checked"));
	});

	// 전체선택 버튼 (토글 방식)
	function fn_checkAll() {
		var chkAt = $('input[type=checkbox][name=chk]').is(":checked");
		
		if (chkAt) {
			$('input[type=checkbox][name=chk]').prop('checked', false);
		} else {
			$('input[type=checkbox][name=chk]').prop('checked', true);
		}
	}

	// 예비추첨실행
	function fn_executeTempDrwt() {
		if (confirm("예비추첨을 실행하시겠습니까?")) {
			// TODO: 예비추첨 기능 구현 필요
			alert("예비추첨실행 기능 준비중입니다.");
		}
	}

	// 상태 일괄 변경 (결제상태 또는 예약상태)
	function fn_changeStatusMulti() {
		var chkAt = $('input[name=chk]').is(":checked");
		var paySttusCd = $('#paySttusCdMulti').val();
		var resveSttusCd = $('#resveSttusCdMulti').val();
		
		// 선택된 신청자 확인
		if (!chkAt) {
			alert("신청자를 선택해주세요.");
			return false;
		}
		
		// 변경할 상태 확인
		if (!paySttusCd && !resveSttusCd) {
			alert("변경할 상태(결제상태 또는 예약상태)를 선택해주세요.");
			return false;
		}
		
		// 두 가지 상태 모두 선택한 경우
		if (paySttusCd && resveSttusCd) {
			alert("결제상태와 예약상태 중 하나만 선택해서 변경할 수 있습니다.");
			return false;
		}
		
		var confirmMsg = "";
		if (paySttusCd) {
			var paySttusCdNm = $('#paySttusCdMulti option:selected').text();
			confirmMsg = "선택한 신청자의 결제상태를 '" + paySttusCdNm + "'로 변경하시겠습니까?";
		} else if (resveSttusCd) {
			var resveSttusCdNm = $('#resveSttusCdMulti option:selected').text();
			confirmMsg = "선택한 신청자의 예약상태를 '" + resveSttusCdNm + "'로 변경하시겠습니까?";
		}
		
		if (!confirm(confirmMsg)) {
			return false;
		}
		
		// 체크된 항목들을 serialize로 파라미터화
		var eduAplyNoParam = $('input[name=chk]:checked').map(function() {
			return 'eduAplyNoArr=' + $(this).val();
		}).get().join('&');
		
		// 기존 URL 파라미터 가져오기
		var para = document.location.href.split("?");
		var url = './updateEduAplctStatus.do?' + (para[1] || 'key=${key}&searchLctreNo=${eduLctreVO.lctreNo}');
		// 상태 변경 처리
		if (paySttusCd) {
			window.location.href = url + '&' + eduAplyNoParam + '&paySttusCd=' + paySttusCd;
		} else if (resveSttusCd) {
			window.location.href = url + '&' + eduAplyNoParam + '&resveSttusCd=' + resveSttusCd;
		}
	}
</script>
</body>
</html>
