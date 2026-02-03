<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<ol class="programFlow">
    <li class="selected"><span class="visualHidden">현재 단계</span><i>1</i>일정선택/개인정보동의</li>
    <li><i>2</i>신청자 정보입력</li>
    <li><i>3</i>예약신청완료</li>
</ol>
<div class="programTitle">
    <c:set var="operSttus" value="${fcltyVO.operSttus}"/>
    <c:set var="sttusType" value=""/>
    <c:if test="${operSttus == 'RCPT_WAIT'}">
        <c:set var="sttusType" value="type1"/>
    </c:if>
    <c:if test="${operSttus == 'RCPT_ING'}">
        <c:set var="sttusType" value="type2"/>
    </c:if>
    <c:if test="${operSttus == 'RCPT_END'}">
        <c:set var="sttusType" value="type3"/>
    </c:if>
    <c:if test="${operSttus == 'OPER_ING'}">
        <c:set var="sttusType" value="type2"/>
    </c:if>
    <c:if test="${operSttus == 'OPER_END'}">
        <c:set var="sttusType" value="type3"/>
    </c:if>
    <span class="stateType <c:out value="${sttusType}"/>"><c:out value="${operSttusMap[fcltyVO.operSttus]}"/></span>
    <strong><c:out value="${fcltyVO.fcltyNm}"/></strong>
</div>

<form method="post" name="fcltyApplVO" action="./addFcltyApplWebView.do" onsubmit="return fn_addFcltyApplCheck(this);">
    <input type="hidden" name="key" value="<c:out value="${key}"/>" />
    <input type="hidden" name="fcltyNo" value="<c:out value="${fcltyVO.fcltyNo}"/>" />
    <input type="hidden" name="fcltyDe" id="fcltyDe" value="" />

    <fieldset>
        <legend>예약 일정선택/개인정보제공동의</legend>
        <h4>예약일자/회차 선택</h4>
        <ul class="ul">
            <li>날짜를 먼저 선택하신 후 시간을 선택해주세요.</li>
            <li>당일 하루만 예약신청이 가능합니다. (기간 신청 불가)</li>
            <c:if test="${fcltyVO.mtLmttTime > 0}">
                <li><span class="point-color-red">월별 신청가능 시간은 최대 <c:out value="${fcltyVO.mtLmttTime}"/>시간</span> 입니다.</li>
            </c:if>
        </ul>
        <div class="programCalendar timeSelect">
            <div class="calendar">
                <jsp:include page="../../schd/web/fcltyApplCalendar.jsp" />
            </div>
            <div class="time">
                <div class="timeTitle">시간선택</div>
                <div class="timeScrollWrap">
                    <ul class="timeList">
                        <jsp:include page="../../schd/web/fcltyApplTimeList.jsp" />
                    </ul>
                </div>
            </div>
            <div class="selectConfirm" style="display: none;">
                <strong>예약시간 및 이용료를 확인하세요!</strong>
                <ul>
                    <li>
                        <span class="title">사용일</span>
                        <p class="selectedDate"></p>
                    </li>
                    <li>
                        <span class="title">총 이용시간</span>
                        <p><em class="totalTime">00</em></p>
                    </li>
                    <li>
                        <span class="title">시간</span>
                        <p class="selectedTime">시간을 선택해주세요.</p>
                    </li>
                    <li>
                        <span class="title">금액</span>
                        <p><em class="amount">0</em>원</p>
                    </li>
                </ul>
            </div>
        </div>
        <h4>개인정보 수집 및 동의</h4>
        <div class="privacyAgreement">
            <div class="agreeAll">
                <label for="all" class="customRadioButton">
                    <input type="radio" id="all" name="all">
                    <span class="customStyle">
                        <i class="radioButton"></i>
                        <em>모든 약관에 동의합니다.</em>
                    </span>
                </label>
            </div>
            <div class="agreeElement">
                <div class="agreeBox">
                    <strong class="agreeTitle">개인정보 수집 및 이용 동의 <span class="point-color-red">(필수)</span></strong>
                    <div class="formGroup">
                        <label for="agree1-1" class="customRadioButton">
                            <input type="radio" id="agree1-1" name="agree1" value="Y">
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>동의함</span>
                            </span>
                        </label>
                        <label for="agree1-2" class="customRadioButton">
                            <input type="radio" id="agree1-2" name="agree1" value="N">
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>동의하지 않음</span>
                            </span>
                        </label>
                    </div>
                    <button type="button" class="agreeViewButton" data-toggle-button><span>보기</span></button>
                    <div class="agreeExplanation">
                        <div class="agreeInnerBox">
                            <p>개인정보보호법 제17조에 따라 아래와 같은 사항을 안내하고 동의를 받아 귀하의 개인정보를 이용&middot;제공할 수 있도록 합니다.</p>
                            <ul>
                                <li>1. 제공받는자: 청주시 산하 실과&middot;사업소, 동주민센터</li>
                                <li>2. 제공받는 자의 수집&middot;이용 목적: 청주시 통합예약시스템 서비스 예약자 확인 및 관리</li>
                                <li>3. 제공하는 개인정보 항목
                                    <ul>
                                        <li>- 예약자 정보: 성명, 생년월일, 휴대폰번호, 주소, 성별, 이메일, 차량번호</li>
                                        <li>- 예약자 결제 정보: 성명, 카드번호, 은행명, 계좌번호</li>
                                    </ul>
                                </li>
                                <li>4. 개인정보 보유 및 이용기간
                                    <ul>
                                        <li>- 예약자 정보: 1년간 보관 후 즉시 파기(성명, 단체명, 생년월일, 휴대폰번호, 주소, 성별)</li>
                                        <li>- 예약자 결제정보: 5년간 보관 후 즉시 파기(성명, 카드번호, 은행명, 계좌번호)</li>
                                    </ul>
                                </li>
                                <li>5. 동의를 거부할 권리가 있다는 사실과 동의 거부에 따른 불이익 내용: 개인정보 수집 및 이용&middot;제공에 대해 동의를 거부할 권리가 있으며, 동의 거부 시에는 예약 서비스 이용이 제한됩니다.</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="agreeBox">
                    <strong class="agreeTitle">개인정보 제3자 제공 동의 <span class="point-color-red">(필수)</span></strong>
                    <div class="formGroup">
                        <label for="agree2-1" class="customRadioButton">
                            <input type="radio" id="agree2-1" name="agree2" value="Y">
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>동의함</span>
                            </span>
                        </label>
                        <label for="agree2-2" class="customRadioButton">
                            <input type="radio" id="agree2-2" name="agree2" value="N">
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>동의하지 않음</span>
                            </span>
                        </label>
                    </div>
                    <button type="button" class="agreeViewButton" data-toggle-button><span>보기</span></button>
                    <div class="agreeExplanation">
                        <div class="agreeInnerBox">
                            <p>개인정보보호법 제17조에 따라 아래와 같은 사항을 안내하고 동의를 받아 귀하의 개인정보를 이용&middot;제공할 수 있도록 합니다.</p>
                            <ul>
                                <li>1. 제공받는자: 청주시 산하 실과&middot;사업소, 동주민센터</li>
                                <li>2. 제공받는 자의 수집&middot;이용 목적: 청주시 통합예약시스템 서비스 예약자 확인 및 관리</li>
                                <li>3. 제공하는 개인정보 항목
                                    <ul>
                                        <li>- 예약자 정보: 성명, 생년월일, 휴대폰번호, 주소, 성별, 이메일, 차량번호</li>
                                        <li>- 예약자 결제 정보: 성명, 카드번호, 은행명, 계좌번호</li>
                                    </ul>
                                </li>
                                <li>4. 개인정보 보유 및 이용기간
                                    <ul>
                                        <li>- 예약자 정보: 1년간 보관 후 즉시 파기(성명, 단체명, 생년월일, 휴대폰번호, 주소, 성별)</li>
                                        <li>- 예약자 결제정보: 5년간 보관 후 즉시 파기(성명, 카드번호, 은행명, 계좌번호)</li>
                                    </ul>
                                </li>
                                <li>5. 동의를 거부할 권리가 있다는 사실과 동의 거부에 따른 불이익 내용: 개인정보 수집 및 이용&middot;제공에 대해 동의를 거부할 권리가 있으며, 동의 거부 시에는 예약 서비스 이용이 제한됩니다.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="formButtonGroup">
            <a href="" class="button previous"><span>이전</span></a>
            <button type="submit" class="button next"><span>다음</span></button>
        </div>
    </fieldset>
</form>

<script>

    var selectDate = '';

    $(document).on("click", ".prevButton, .nextButton", function () {

        var programCalendar = $('.calendar');
        var year = $(this).data('year');
        var month = $(this).data('month');

        $.ajax({
            cache: false,
            url: './fcltyApplCalendarAjax.do',
            type: 'POST',
            data: {
                fcltyNo: '<c:out value="${fcltyVO.fcltyNo}"/>',
                year: year,
                month: month
            },
            success: function (res) {
                programCalendar.html(res);
                if (selectDate != '') {
                    $('#ymdBtn'+selectDate).addClass('selected');
                }
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

    $(document).on("click", ".ymdBtn", function () {
        $('.ymdBtn').removeClass('selected');
        $(this).addClass('selected');

        var date = $(this).data('ymd');
        var yoil = $(this).data('yoil');
        selectDate = date;

        $.ajax({
            cache: false,
            url: './fcltyApplTimeListAjax.do',
            type: 'POST',
            data: {
                fcltyNo: '<c:out value="${fcltyVO.fcltyNo}"/>',
                fcltyDe: date
            },
            success: function (res) {
                fn_updateSelectConfirm(res, date, yoil);
                $('input[name=fcltyDe]').val(date);
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

    function fn_updateSelectConfirm(res, date, yoil) {

        $('.timeList').html(res);
        $('.selectConfirm').show();

        var selectedDateTxt = fn_setDateText(date, yoil);
        $('.selectedDate').html(selectedDateTxt);

        $('.totalTime').text('0 시간');
        $('.selectedTime').text('시간을 선택해주세요.');
        $('.amount').text(0);
    }

    function fn_setDateText(date, yoil) {

        date = String(date);
        var y = date.substring(0, 4);
        var m = date.substring(4, 6);
        var d = date.substring(6, 8);
        var dateTxt =  y + '-' + m + '-' + d;
        var weekMap = { '0':'일', '1':'월', '2':'화', '3':'수', '4':'목', '5':'금', '6':'토' };

        return dateTxt + '(' + weekMap[yoil] + ')';
    }

    $(document).on("change", "input[name=fcltySchdNo]", function () {

        $.ajax({
            cache: false,
            url: './fcltyApplCheckAjax.do',
            type: 'POST',
            data: {
                fcltyNo: '<c:out value="${fcltyVO.fcltyNo}"/>',
                fcltyDe: $('#fcltyDe').val(),
                fcltySchdNo : $(this).val()
            },
            success: function (res) {
                var result = res['RESULT'];

                if (result === '200') {

                } else {
                     let msg = '';
                    if (result === 'PARAM_ERROR') {
                        msg = '에러가 발생했습니다. 관리자에게 문의해주세요.';
                    } else if (result === 'ERROR_1') {
                        msg = '예약할 시설을 찾을 수 없습니다.';
                    } else if (result === 'ERROR_2') {
                        msg = '예약할 일정을 찾을 수 없습니다.';
                    } else if (result === 'ERROR_3') {
                        msg = '이미 신청완료된 일정입니다.';
                    } else if (result === 'ERROR_4') {
                        msg = '해당 기관의 월 신청 가능 횟수를 초과하여 신청할 수 없습니다.';
                    } else if (result === 'ERROR_5') {
                        msg = '해당 시설의 일일 신청 가능 시간이 초과되어 신청할 수 없습니다.';
                    } else if (result === 'ERROR_6') {
                        msg = '해당 시설의 월간 신청 가능 시간이 초과되어 신청할 수 없습니다.';
                    }

                    alert(msg);
                    $("input[name='fcltySchdNo']:checked").prop("checked", false);
                    $('.selectedTime').text('시간을 선택해주세요.');
                }
            }, // success
            error: function (request, xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                $('.selectedTime').text('시간을 선택해주세요.');
                console.log("code:",request.status);
                console.log("message:",request.responseText);
                console.log("error:"+error)
            }
        });

        var $fcltySchdNoCheckd = $("input[name='fcltySchdNo']:checked");
        var $totalTime = $('.totalTime');
        var $selectedTime = $('.selectedTime');
        var $amount = $('.amount');

        var totalTimeVal = 0;
        var selectedTimeVal = '';
        var amountVal = 0;

        if ($fcltySchdNoCheckd.length > 0) {

            $("input[name='fcltySchdNo']").not(this).prop("checked", false);

            totalTimeVal += $(this).data('tmInterval');
            amountVal = $(this).data('timeAmt');
            selectedTimeVal = $('#timeText' + $(this).val()).text();

        } else {
            selectedTimeVal = '시간을 선택해주세요.';
        }

        var hh = parseInt(totalTimeVal / 60);
        var mm = totalTimeVal % 60;
        var hm = hh + ' 시간'
        if (mm > 0) {
            hm += ' ' + mm + ' 분';
        }

        $totalTime.text(hm);
        $selectedTime.text(selectedTimeVal);
        $amount.text(amountVal.toLocaleString());

    });

    function fn_addFcltyApplCheck(form){

        if (!form.fcltyDe.value) {
            alert("시설일자를 확인해주세요.");
            $('.calendar').focus();
            return false;
        }

        if ($('input[name=fcltySchdNo]:checked').length < 1) {
            alert("이용하실 시간을 선택해주세요.");
            $('.timeList').focus();
            return false;
        }

        if (!form.agree1.value || form.agree1.value != 'Y') {
            alert("개인정보 수집 및 이용에 동의해주세요.");
            $('#agree1-1').focus();
            return false;
        }

        if (!form.agree2.value || form.agree2.value != 'Y') {
            alert("개인정보 제3자 제공에 동의해주세요.");
            $('#agree2-1').focus();
            return false;
        }

        return true;
    }

    $(document).on("click", ".privacyAgreement #all", function () {
        var $agree1_1 = $('.privacyAgreement #agree1-1');
        var $agree2_1 = $('.privacyAgreement #agree2-1');

        if($(this).is(":checked")) {
            $agree1_1.prop('checked', true);
            $agree2_1.prop('checked', true);
        }
    });

    $(document).on("change", ".privacyAgreement input[name=agree1], .privacyAgreement input[name=agree2]", function () {
        var $agreeAll = $('.privacyAgreement #all');
        var $agree1_1 = $('.privacyAgreement #agree1-1');
        var $agree2_1 = $('.privacyAgreement #agree2-1');

        if($agree1_1.is(':checked') && $agree2_1.is(':checked')) {
            $agreeAll.prop('checked', true);
        } else {
            $agreeAll.prop('checked', false);
        }
    });

</script>

</body>
</html>
