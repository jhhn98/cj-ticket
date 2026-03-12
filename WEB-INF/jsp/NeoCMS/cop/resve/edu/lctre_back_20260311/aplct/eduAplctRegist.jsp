<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>신청자 관리 &gt; 신청자 등록</title>
</head>
<body>

<div class="p-wrap">
    <div class="col-22">
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
                <th scope="row">접수상태</th>
                <td>

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
            </tbody>
        </table>
        <br/>

        <div class="row p-relative">
            <h3 class="col-10" style="margin-top:-5px;">○ 신청자정보</h3>
            <div class="col-14 right" style="">
                <span class="p-icon p-icon__info-circle">주의사항</span>
                <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
            </div>
        </div>

        <form:form id="registForm" action="./addEduAplct.do" method="post" modelAttribute="eduAplctVO"
                   onsubmit="return validateForm(this)">
            <fieldset>
                <legend>신청자 정보 입력</legend>
                 <input type="hidden" name="key" value="${key}"/>
                <input type="hidden" name="prgSe" value="EDU"/>
                 <input type="hidden" name="lctreNo" value="${eduAplctVO.lctreNo}"/>
                 <input type="hidden" name="resveSttusCd" id="resveSttusCdHidden" value=""/> <!-- 예약상태 (form 제출 전 script에서 설정) -->
                 <input type="hidden" name="paySttusCd" value="01"/> <!-- 기본값: 미결제 -->

                <table class="p-table">
                    <colgroup>
                        <col class="w15p">
                        <col/>
                    </colgroup>
                    <tbody class="p-table--th-left">
                    <tr>
                        <th scope="row"><label for="applNm">신청자 <span class="p-form__required--icon">필수</span></label>
                        </th>
                        <td>
                            <input type="text" id="applNm" name="applNm" value="${eduAplctVO.applNm}"
                                   class="p-input w15p" maxlength="50"/>
                            <span id="error_applNm" class="form_error"></span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="birthDe">생년월일 <span class="p-form__required--icon">필수</span></label>
                        </th>
                        <td>
                            <div class="p-date-group" style="width:130px">
                                <div class="p-form-group p-date" data-date="datepicker">
                                    <!-- DB 포맷 YYYYMMDD를 YYYY-MM-DD로 변환하여 표시 -->
                                    <c:set var="birthDeFormat" value="${eduAplctVO.birthDe}"/>
                                    <c:if test="${not empty birthDeFormat && fn:length(birthDeFormat) == 8}">
                                        <c:set var="birthDeFormat"
                                               value="${fn:substring(birthDeFormat, 0, 4)}-${fn:substring(birthDeFormat, 4, 6)}-${fn:substring(birthDeFormat, 6, 8)}"/>
                                    </c:if>
                                    <input type="text" id="birthDe" name="birthDe" value="${birthDeFormat}" readonly
                                           placeholder="YYYY-MM-DD" class="p-input bg-none"/>
                                    <div class="p-input__split">
                                        <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                                    </div>
                                </div>
                            </div>
                            <span id="error_birthDe" class="form_error"></span>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><label for="genderSe1">성별 <span class="p-form__required--icon">필수</span></label>
                        </th>
                        <td>
				<span class="p-form-radio">
								<input type="radio" id="genderSe1" name="genderSe"
                                       value="M"${eduAplctVO.genderSe eq 'M' ? ' checked="true"':''}
                                       class="p-form-radio__input"/>
								<label for="genderSe1" class="p-form-radio__label">남</label>
				</span> &nbsp;
                            <span class="p-form-radio">
								<input type="radio" id="genderSe2" name="genderSe"
                                       value="F"${eduAplctVO.genderSe eq 'F' ? ' checked="true"':''}
                                       class="p-form-radio__input"/>
								<label for="genderSe2" class="p-form-radio__label">여</label>
				</span>
                            <span id="error_genderSe" class="form_error"></span>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><label for="telNo1">연락처 <span class="p-form__required--icon">필수</span></label>
                        </th>
                        <td>
                            <c:set var="telNoArr"
                                   value="${fn:length(eduAplctVO.telNo) == 11 ? [fn:substring(eduAplctVO.telNo, 0, 3), fn:substring(eduAplctVO.telNo, 3, 7), fn:substring(eduAplctVO.telNo, 7, 11)] : ['010','','']}"/>
                            <select id="telNo1" name="telNo1" class="p-input p-input--auto" title="연락처">
                                <option value="010"${telNoArr[0] eq '010' ? ' selected="true"':''}>010</option>
                                <option value="011"${telNoArr[0] eq '011' ? ' selected="true"':''}>011</option>
                                <option value="016"${telNoArr[0] eq '016' ? ' selected="true"':''}>016</option>
                                <option value="017"${telNoArr[0] eq '017' ? ' selected="true"':''}>017</option>
                                <option value="018"${telNoArr[0] eq '018' ? ' selected="true"':''}>018</option>
                                <option value="019"${telNoArr[0] eq '019' ? ' selected="true"':''}>019</option>
                            </select> -
                            <input type="text" id="telNo2" name="telNo2" value="${telNoArr[1]}" maxlength="4"
                                   class="p-input w5p" title="연락처번호2"/> -
                            <input type="text" id="telNo3" name="telNo3" value="${telNoArr[2]}" maxlength="4"
                                   class="p-input w5p" title="연락처번호3"/>
                            <input type="hidden" id="telNo" name="telNo" value="${eduAplctVO.telNo}"/>
                            <span id="error_telNo" class="form_error"></span>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><label for="zip">주소 <span class="p-form__required--icon">필수</span></label></th>
                        <td>
                            <input type="text" id="zip" name="zip" value="${eduAplctVO.zip}" readonly
                                   class="p-input w5p" maxlength="5"/>
                            <button type="button" class="p-button edit" onclick="fn_openDaumZipAddress();">우편번호찾기
                            </button>
                            <span class="small marginLeft_10">우편번호 검색창이 새창으로 열립니다.</span><br/>
                            <input type="text" id="addr" name="addr" value="${eduAplctVO.addr}" readonly
                                   class="p-input w50p"/><br/>
                            <input type="text" id="detailAddr" name="detailAddr" value="${eduAplctVO.detailAddr}"
                                   class="p-input w50p" placeholder="상세주소 입력"/>
                            <span id="error_zip" class="form_error"></span>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><label for="emailId">이메일 <span class="p-form__required--icon">필수</span></label></th>
                        <td>
                            <c:set var="emailParts" value="${fn:split(eduAplctVO.email, '@')}"/>
                            <input type="text" id="emailId" name="email1" value="${emailParts[0]}" class="p-input w15p" />
                            @
                            <input type="text" id="emailDomain" name="email2" value="${emailParts[1]}" class="p-input w15p" />
                            <select id="emailDomainSelect" class="p-input p-input--auto" title="이메일 도메인 선택">
                                <option value="direct">직접입력</option>
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="kakao.com">kakao.com</option>
                            </select>
                            <input type="hidden" id="email" name="email" value="${eduAplctVO.email}"/>
                            <span id="error_email" class="form_error"></span>
                        </td>
                    </tr>
					<%--<c:if test="${eduLctreVO.residenceUseYn eq 'Y'}">
                    <tr>
                        <th scope="row">거주지</th>
                        <td>
                            <c:out value="${lgldongMap[eduAplctVO.resInqCd]}"/>
                        </td>
                    </tr>
					</c:if>--%>

                    <tr>
                        <th scope="row"><label for="dscntUseSe1">감면신청</label></th>
                        <td>
				<span class="p-form-radio">
								<input type="radio" id="dscntUseSe1" name="dscntUseSe"
                                       value="Y"${eduAplctVO.dscntUseSe eq 'Y' ? ' checked="true"':''}
                                       class="p-form-radio__input" onclick="toggleDscntCd(true);"/>
								<label for="dscntUseSe1" class="p-form-radio__label">신청</label>
							</span> &nbsp;
                            <span class="p-form-radio">
								<input type="radio" id="dscntUseSe2" name="dscntUseSe"
                                       value="N"${eduAplctVO.dscntUseSe eq 'N' || empty eduAplctVO.dscntUseSe ? ' checked="true"':''}
                                       class="p-form-radio__input" onclick="toggleDscntCd(false);"/>
								<label for="dscntUseSe2" class="p-form-radio__label">신청 안함</label>
							</span> &nbsp;
                            <span class="p-form-radio">
								<input type="radio" id="dscntUseSe3" name="dscntUseSe"
                                       value="M"${eduAplctVO.dscntUseSe eq 'M' ? ' checked="true"':''}
                                       class="p-form-radio__input" onclick="toggleDscntCd(true);"/>
								<label for="dscntUseSe3" class="p-form-radio__label">관리자 승인</label>
				</span>
                        </td>
                    </tr>

                    <tr id="dscntCdRow"
                        style="${eduAplctVO.dscntUseSe eq 'Y' || eduAplctVO.dscntUseSe eq 'M' ? '' : 'display:none;'}">
                        <th scope="row"><label for="dscntCd">감면선택</label></th>
                        <td>
                            <select id="dscntCd" name="dscntCd" class="p-input p-input--auto"
                                    onchange="calculatePayAmt();">
                                <option value="">선택</option>
                                <c:forEach var="item" items="${dscntCdList}">
                                    <option value="${item.code}"
                                            data-rate="${item.dcValue}"${eduAplctVO.dscntCd eq item.code ? ' selected="true"':''}>
                                        <c:out value="${item.codeNm}"/></option>
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
                            <input type="hidden" id="basePayAmt" value="${eduLctreVO.eduAmt}"/>
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
                        <a href="./selectEduAplctListByEdu.do?lctreNo=${eduAplctVO.lctreNo}&amp;<c:out value="${eduAplctVO.params}"/>"
                           class="p-button cancel">목록</a>
                    </div>
                    <div class="col-12 right">
                        <input type="submit" class="p-button write" value="등록">
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
            oncomplete: function (data) {
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
        // 예약상태는 서버에서 자동 결정되므로 hidden input은 빈 값으로 설정
        $("#resveSttusCdHidden").val("");

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

        // 주소 필수 체크
        if (!frm.zip.value.trim() || !frm.addr.value.trim()) {
            alert("주소를 입력해주세요. 우편번호찾기 버튼을 이용하여 주소를 검색해주세요.");
            $("#zip").focus();
            return false;
        }
        
        if (!frm.detailAddr.value.trim()) {
            alert("상세주소를 입력해주세요.");
            frm.detailAddr.focus();
            return false;
        }

        // 이메일 필수 체크 및 조합
        if (!frm.email1.value.trim()) {
            alert("이메일 아이디를 입력해주세요.");
            frm.email1.focus();
            return false;
        }
        
        if (!frm.email2.value.trim()) {
            alert("이메일 도메인을 입력해주세요.");
            frm.email2.focus();
            return false;
        }
        
        var email = frm.email1.value + '@' + frm.email2.value;
        var regEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
        if (!regEmail.test(email)) {
            alert("올바른 형식의 이메일을 입력해주세요.");
            frm.email1.focus();
            return false;
        }
        frm.email.value = email;

        if (!confirm("등록하시겠습니까?")) {
            return false;
        }

        return true;
    }

    $(document).ready(function () {
        // 이메일 도메인 선택
        $('#emailDomainSelect').change(function () {
            if ($(this).val() == 'direct') {
                $('#emailDomain').prop('readonly', false);
                $('#emailDomain').val('');
                $('#emailDomain').focus();
            } else {
                $('#emailDomain').prop('readonly', true);
                $('#emailDomain').val($(this).val());
            }
        });

        // 숫자만 입력
        $('#telNo2, #telNo3').on('keyup', function () {
            $(this).val($(this).val().replace(/[^0-9]/g, ""));
        });

        // 초기 결제금액 계산
        calculatePayAmt();

        // 감면 선택 시 가이드 표시
        $('input[name=dscntUseSe]').change(function () {
            if ($(this).val() === 'M') {
                $("#dscntGuide").show();
            } else {
                $("#dscntGuide").hide();
            }
        });

        // 생년월일 datepicker 설정 (날짜 포맷: YYYY-MM-DD, DB 저장 시 YYYYMMDD로 자동 변환)
        $('[data-date="datepicker"]').each(function () {
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
