<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="decorator" content="${menuInfo.siteId}" />
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/program.js"></script>
    <title><c:out value="${menuInfo.naviList[0].menuNm}"/> &gt; ${menuInfo.cntntsNm} &gt; 신청서 수정</title>
</head>
<body>

<script src="/common/js/default.js"></script>

<div class="p-wrap">

    <jsp:include page="../incFcltyInfo.jsp" />


    <form:form modelAttribute="fcltyApplVO" name="fcltyApplVO" method="post" action="./updateFcltyAppl.do" onsubmit="return fn_updateFcltyApplCheck(this)">
        <fieldset>
            <legend>(관리자) 시설 사용 신청서 수정</legend>
            <form:hidden path="fcltyApplNo"/>
            <input type="hidden" name="key" value="<c:out value="${key}"/>" />

            <h3>신청자 기본 정보</h3>
            <div>
                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
                <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
            </div>

            <table class="p-table">
                <caption>(관리자) 신청자 기본 정보 수정</caption>
                <colgroup>
                    <col class="w15p">
                    <col />
                </colgroup>
                <tbody class="p-table--th-left">

                <c:if test="${not empty fcltyApplVO.grpNm}">
                    <tr id="grpNmTr">
                        <th scope="row"><form:label path="grpNm">단체명</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td><form:input path="grpNm" class="p-input p-input--auto" maxlength="30" placeholder="단체명" required="required" /></td>
                    </tr>

                    <tr id="useCntTr">
                        <th scope="row"><form:label path="useCnt">사용인원</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="useCnt" class="p-input p-input--auto" oninput="fn_numChk(this)" maxlength="4" placeholder="숫자만 입력 가능합니다." required="required" />명

                            <c:if test="${fcltyVO.nmprMinCnt > 0 || fcltyVO.nmprMaxCnt > 0}">
                              <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                  <em class="em_black">
                                <c:if test="${fcltyVO.nmprMinCnt > 0}">
                                    최소 신청인원 : <c:out value="${fcltyVO.nmprMinCnt}"/> 명
                                </c:if>
                                <c:if test="${fcltyVO.nmprMinCnt > 0 && nmprMaxCnt > 0}"> / </c:if>
                                <c:if test="${fcltyVO.nmprMaxCnt > 0}">
                                    최대 신청인원 : <c:out value="${fcltyVO.nmprMaxCnt}"/> 명
                                </c:if>
                                </em>
                              </span>
                            </c:if>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${empty fcltyApplVO.grpNm}">
                    <form:hidden path="useCnt"/>
                </c:if>

                <tr>
                    <th scope="row"><form:label path="applNm">신청자명</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td><form:input path="applNm" class="p-input p-input--auto" maxlength="20" placeholder="신청자명" required="required" /></td>
                </tr>

                <tr>
                    <th scope="row"><form:label path="genderSe">성별</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <span class="p-form-radio">
                            <form:radiobutton path="genderSe" id="genderSe1" value="M" cssClass="p-form-radio__input"/>
                            <label for="genderSe1" class="p-form-radio__label">남</label>
                        </span>
                        <span class="p-form-radio">
                            <form:radiobutton path="genderSe" id="genderSe2" value="F" cssClass="p-form-radio__input"/>
                            <label for="genderSe2" class="p-form-radio__label">여</label>
                        </span>
                    </td>
                </tr>

                <tr>
                    <th scope="row"><form:label path="birthDe">생년월일</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group p-date w10p" data-date="datepicker" data-date-start-view="3">
                            <form:input path="birthDe" class="p-input p-input--auto" maxlength="10" placeholder="YYYY-MM-DD" required="required" />
                            <span class="p-input__split">
                                <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                            </span>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th scope="row"><form:label path="mobileNo">연락처</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td><form:input path="mobileNo" class="p-input p-input--auto" oninput="fn_numChk(this)" maxlength="12" placeholder="숫자만입력가능" required="required" /></td>
                </tr>

                <tr>
                    <th scope="row"><form:label path="zip">주소</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <div class="p-form-group w20p">
                            <form:input path="zip" class="p-input p-input--auto" placeholder="우편번호 (자동입력)" readonly="true" maxlength="6" required="required"/>
                            <span class="p-input__addon">
                                <button type="button" class="p-button primary addressSearchButton" onclick="openDaumZipAddress();">주소검색</button>
                            </span>
                        </div>
                        <div class="p-form-group w50p">
                            <form:input path="addr" class="p-input" placeholder="주소 (자동입력)" readonly="true" required="required"/>
                        </div>
                        <div class="p-form-group w50p">
                            <form:input path="detailAddr" class="p-input" placeholder="상세주소" maxlength="30" required="required"/>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th scope="row"><form:label path="email1">이메일</form:label></th>
                    <td>
                        <div class="p-form-group w40p">
                            <form:input path="email1" class="p-input p-inpu--auto" maxlength="20" />
                            <span class="p-form__split">@</span>
                            <form:input path="email2" class="p-input p-inpu--auto" maxlength="20"/>
                            <span class="p-form__split"> </span>
                            <select id="email3" class="p-input p-input--auto">
                                <option value="direct">직접입력</option>
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="kakao.com">kakao.com</option>
                                <option value="daum.net">daum.net</option>
                            </select>
                        </div>
                    </td>
                </tr>

                <c:if test="${fcltyVO.resInqUseYn eq 'Y'}">
                <tr>
                    <th scope="row"><form:label path="resInqCd">거주지</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:select class="p-input p-input--auto" path="resInqCd" required="required">
                            <form:option value="" label="= 선택해주세요 =" />
                            <form:options items="${lgldongList}" itemValue="code" itemLabel="codeNm"/>
                        </form:select>
                    </td>
                </tr>
                </c:if>

                <c:if test="${not empty fcltyVO.aditIem1}">
                    <tr>
                        <th scope="row"><form:label path="aditIem1"><c:out value="${fcltyVO.aditIem1}"/></form:label> </th>
                        <td><form:input path="aditIem1" class="p-input w50p" maxlength="100" placeholder="${fcltyVO.aditIem1} 입력" /></td>
                    </tr>
                </c:if>

                <c:if test="${not empty fcltyVO.aditIem2}">
                    <tr>
                        <th scope="row"><form:label path="aditIem2"><c:out value="${fcltyVO.aditIem2}"/></form:label> </th>
                        <td><form:input path="aditIem2" class="p-input w50p" maxlength="100" placeholder="${fcltyVO.aditIem2} 입력" /></td>
                    </tr>
                </c:if>

                <tr>
                    <th scope="row"><form:label path="memo">메모(관리자만 확인 가능)</form:label> </th>
                    <td><form:textarea path="memo" class="p-input w50p" /></td>
                </tr>

                </tbody>
            </table>


            <h3>예약 정보</h3>
            <div>
                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
                <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
            </div>
            <table class="p-table">
                <caption>(관리자) 예약 정보 수정</caption>
                <colgroup>
                    <col class="w15p">
                    <col />
                </colgroup>
                <tbody class="p-table--th-left">

                <tr>
                    <th scope="row">예약번호</th>
                    <td>
                        <c:out value="${fcltyApplVO.fcltyApplId}"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row">신청일시 (밀리초)</th>
                    <td>
                        <c:out value="${tsu:toDateFormat(fcltyApplVO.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd HH:mm:ss (SSS)')}"/>
                    </td>
                </tr>

                <tr>
                    <th scope="row">시설 사용일자</th>
                    <td>
                        <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                        <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyBgnHm, 'HHmm', 'HH:mm')}"/> ~
                        <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyEndHm, 'HHmm', 'HH:mm')}"/>
                        (<c:out value="${fcltyApplVO.tmInterval}"/> 분)
                    </td>
                </tr>

                <tr>
                    <th scope="row"><form:label path="rsvSttusCd">예약상태</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                    <td>
                        <form:select class="p-input p-input--auto" id="rsvSttusCd" path="rsvSttusCd" required="required">
                            <form:option value="" label="= 선택해주세요. =" />
                            <form:options items="${rsvSttusList}" itemValue="code" itemLabel="codeNm" />
                        </form:select>
                    </td>
                </tr>

                <c:if test="${fcltyVO.fcltyAmt > 0}">
                    <tr>
                        <th scope="row"><form:label path="totalPayAmt">시설 사용요금</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="totalPayAmt" class="p-input p-input--auto" maxlength="10" oninput="fn_numChk(this)" placeholder="사용요금" required="required" /> 원
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><form:label path="payMthdCd">사용요금 결제 방법</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:select class="p-input p-input--auto" path="payMthdCd" required="required">
                                <form:option value="" label="= 선택해주세요. =" />
                                <c:forEach items="${payMthdList}" var="item" varStatus="idx">
                                    <c:if test="${item.code ne 'ELCTRN'}">
                                        <form:option value="${item.code}" label="${item.codeNm}" />
                                    </c:if>
                                </c:forEach>
                            </form:select>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">결제기한</th>
                        <td>
                            <c:out value="${tsu:toDateFormat(fcltyApplVO.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><form:label path="paySttusCd">결제상태</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:select class="p-input p-input--auto" path="paySttusCd" required="required">
                                <form:option value="" label="= 선택해주세요. =" />
                                <form:options items="${paySttusList}" itemValue="code" itemLabel="codeNm" />
                            </form:select>
                        </td>
                    </tr>

                    <c:if test="${not empty payDt}">
                        <tr>
                            <th scope="row">결제일시</th>
                            <td>
                                <c:out value="${tsu:toDateFormat(fcltyApplVO.payDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                            </td>
                        </tr>
                    </c:if>
                </c:if>


                <c:if test="${fcltyVO.slctMthdCd eq 'DRWLT'}">
                    <tr>
                        <th scope="row">추첨상태</th>
                        <td>
                            <c:choose>
                                <c:when test="${!empty fcltyApplVO.drwtWinYn}">
                                    <br>추첨완료
                                    <c:if test="${fcltyApplVO.drwtWinYn eq 'Y'}">
                                        <span class="em_blue">(당첨)</span>
                                    </c:if>
                                    <c:if test="${fcltyApplVO.drwtWinYn eq 'N'}">
                                        <span class="em_gray">(미당첨)</span>
                                    </c:if>
                                </c:when>
                                <c:otherwise>미추첨</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:if>

                <c:if test="${fcltyVO.slctMthdCd eq 'CONFM'}">
                    <tr>
                        <th scope="row">승인상태</th>
                        <td>
                            <c:choose>
                                <c:when test="${fcltyApplVO.rsvSttusCd eq 'APPL_CMPL'}">승인</c:when>
                                <c:otherwise>미승인</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:if>

                <c:if test="${fcltyVO.slctMthdCd ne 'FIRST'}">
                    <tr>
                        <th scope="row"><c:out value="${(fcltyVO.slctMthdCd eq 'CONFM') ? '승인' : '당첨'}"/>일시</th>
                        <td>
                            <c:out value="${tsu:toDateFormat(fcltyApplVO.applCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        </td>
                    </tr>
                </c:if>


                <tr>
                    <th scope="row">취소마감일시</th>
                    <td>
                        <c:out value="${tsu:toDateFormat(fcltyApplVO.canclClosDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                    </td>
                </tr>

                <c:if test="${not empty cancelDt}">
                    <tr>
                        <th scope="row">취소일시</th>
                        <td>
                            <c:out value="${tsu:toDateFormat(fcltyApplVO.cancelDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                        </td>
                    </tr>
                </c:if>

                <tr>
                    <th scope="row"><form:label path="cancelReason">취소사유</form:label></th>
                    <td>
                        <form:input path="cancelReason" id="cancelReason" class="p-input w50p" maxlength="100" placeholder="취소사유를 입력해주세요." />
                    </td>
                </tr>

                <c:if test="${fcltyVO.fcltyAmt > 0}">
                    <c:if test="${not empty rfndReqDt}">
                        <tr>
                            <th scope="row">환불요청일시</th>
                            <td>
                                <c:out value="${tsu:toDateFormat(fcltyApplVO.rfndReqDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                            </td>
                        </tr>
                    </c:if>

                    <tr>
                        <th scope="row"><form:label path="rfndReason">환불사유</form:label></th>
                        <td>
                            <form:input path="rfndReason" id="rfndReason" class="p-input w50p" maxlength="100" placeholder="환불사유를 입력해주세요." />
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><form:label path="rfndAmt">환불완료금액</form:label> </th>
                        <td>
                            <form:input path="rfndAmt" id="rfndAmt" class="p-input p-input--auto" maxlength="10" oninput="fn_numChk(this)" placeholder="환불완료금액" /> 원
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><form:label path="rfndBankNm">환불계좌</form:label> </th>
                        <td>
                            <ul>
                                <li>은행명 :
                                    <form:select class="p-input p-input--auto" id="rfndBankNm" path="rfndBankNm">
                                        <form:option value="" label="= 선택해주세요. =" />
                                        <form:options items="${bankList}" itemValue="code" itemLabel="codeNm" />
                                    </form:select>
                                </li>
                                <li>계좌번호 : <form:input path="rfndAcctNo" class="p-input p-input--auto w30p" maxlength="30" oninput="fn_numChk(this)" placeholder="계좌번호" /></li>
                                <li>예금주명 : <form:input path="rfndDpstrNm" class="p-input p-input--auto w30p" maxlength="30" placeholder="예금주명" /></li>
                            </ul>
                        </td>
                    </tr>

                    <c:if test="${not empty rfndCmplDt}">
                        <tr>
                            <th scope="row">환불처리일시</th>
                            <td>
                                <c:out value="${tsu:toDateFormat(fcltyApplVO.rfndCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                            </td>
                        </tr>
                    </c:if>
                </c:if>

                </tbody>
            </table>

            <div class="row margin_t_20">
                <div class="col-12">
                    <button type="button" onclick="window.history.back();" class="p-button cancel">목록</button>
                </div>
                <div class="col-12 right">
                    <button type="submit" class="p-button edit">수정</button>
                </div>
            </div>
        </fieldset>
    </form:form>

</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

    function openDaumZipAddress() {
        new daum.Postcode({
            oncomplete:function(data) {
                $("#zip").val(data.zonecode);
                $("#addr").val(data.address);
                $("#detailAddr").focus();
            }
        }).open();
    }

    function fn_nmprSeCdChk(obj) {
        if (obj === 'IND') {
            $('#grpNmTr').hide();
            $('#useCntTr').hide();
        } else if (obj === 'GRP') {
            $('#grpNmTr').show();
            $('#useCntTr').show();
        }
    }

    $(document).ready(function() {
        <c:if test="${fcltyVO.nmprSeCd eq 'GRP'}">
        $('#grpNmTr').show();
        $('#useCntTr').show();
        </c:if>

        $('#email3').change(function () {
            if ($('#email3').val() == 'direct') {
                $('input[name=email2]').prop('readonly', false);
                $('input[name=email2]').val('');
            } else {
                $('input[name=email2]').prop('readonly', true);
                $('input[name=email2]').val($('#email3').val());
            }
        });

    });

    $(document).on('change', '#fcltySchdNo', function() {
        let totAmt = $("#fcltySchdNo").find("option:selected").data("totAmt");
        let fcltyAmt = $("#fcltySchdNo").find("option:selected").data("fcltyAmt");
        if (Number(totAmt) > 0) {
            $('#amt').text(fcltyAmt);
            $('#fcltyAmt').val(totAmt);
            $('#totalPayAmt').val(totAmt);
        }
    });

    function fn_updateFcltyApplCheck(form) {
        var regexDate = RegExp(/^(19|20)\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/);

        <c:if test="${!empty fcltyApplVO.grpNm}">
            <c:if test="${fcltyVO.nmprMinCnt > 0}">
            const minCnt = '<c:out value="${fcltyVO.nmprMinCnt}"/>';
            if (Number(form.useCnt.value) < Number(minCnt)) {
                alert("최소 신청인원은 "+minCnt+"명 입니다.");
                form.useCnt.focus();
                return false;
            }
            </c:if>
            <c:if test="${fcltyVO.nmprMaxCnt > 0}">
            const maxCnt = '<c:out value="${fcltyVO.nmprMaxCnt}"/>';
            if (Number(form.useCnt.value) > Number(maxCnt)) {
                alert("최대 신청인원은 "+maxCnt+"명 입니다.");
                form.useCnt.focus();
                return false;
            }
            </c:if>
        </c:if>

        if ($('input:radio[name="genderSe"]:checked').val() === null || $('input:radio[name="genderSe"]:checked').val() === undefined) {
            alert("성별을 입력해주세요.");
            $('#genderSe1').focus();
            return false;
        }

        if (!regexDate.test(form.birthDe.value)) {
            alert("생년월일(yyyy-MM-dd) 형식을 확인해주세요.");
            form.birthDe.focus();
            return false;
        }

        <c:if test="${!fn:contains(fcltyApplVO.rsvSttusCd, '_CNCL')}">
            if (($('#rsvSttusCd').val() === 'MNG_CNCL' || $('#rsvSttusCd').val() === 'USR_CNCL') && $('#cancelReason').val() === '') {
                alert('예약상태를 취소로 변경하려면, 취소 사유를 입력해주세요.');
                form.cancelReason.focus();
                return false;
            }
        </c:if>

        <c:if test="${!fn:contains(fcltyApplVO.paySttusCd, 'RFND_') or fcltyApplVO.paySttusCd eq 'PAY_CMPL'}">
            if (($('#paySttusCd').val() === 'RFND_CMPL' || $('#paySttusCd').val() === 'RFND_PART' || $('#paySttusCd').val() === 'RFND_REQ') && $('#rfndReason').val() === '') {
                alert('결제상태를 환불로 변경하려면, 환불 사유를 입력해주세요.');
                form.rfndReason.focus();
                return false;
            }
            if (($('#paySttusCd').val() === 'RFND_CMPL' || $('#paySttusCd').val() === 'RFND_PART')) {
                if ($('#rfndAmt').val() == '') {
                    alert('결제상태를 환불로 변경하려면, 환불완료금액을 입력해주세요.');
                    form.rfndAmt.focus();
                    return false;
                } else if (Number($('#rfndAmt').val()) == 0) {
                    alert('환불완료금액은 0원 이상으로 입력해주세요.');
                    form.rfndAmt.focus();
                    return false;
                }
            }
        </c:if>

        if (!confirm('위 내용대로 수정하시겠습니까?')) {
            return false;
        }
    }

    $(document).on("click", ".prevButton, .nextButton", function () {

        var programCalendar = $('#fcltyCalendar');
        var year = $(this).data('year');
        var month = $(this).data('month');

        $.ajax({
            cache: false,
            url: './fcltyApplCalendarMngAjax.do',
            type: 'POST',
            data: {
                fcltyNo: '<c:out value="${fcltyVO.fcltyNo}"/>',
                year: year,
                month: month
            },
            success: function (res) {
                programCalendar.html(res);
            }, // success
            error: function (request,xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                console.log("code:",request.status);
                console.log("message:",request.responseText);
                console.log("error:"+error)
            }
        });
    });

    $(document).on("change", ".ymdBtn", function (e) {
        var date = $(this).val();

        $.ajax({
            cache: false,
            url: './fcltyApplTimeListMngAjax.do',
            type: 'POST',
            data: {
                fcltyNo: '<c:out value="${fcltyVO.fcltyNo}"/>',
                fcltyDe: date
            },
            success: function (res) {
                $('.timeList').html(res);
            }, // success
            error: function (request,xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                console.log("code:",request.status);
                console.log("message:",request.responseText);
                console.log("error:"+error)
            }
        });
    });
</script>

</body>
</html>
