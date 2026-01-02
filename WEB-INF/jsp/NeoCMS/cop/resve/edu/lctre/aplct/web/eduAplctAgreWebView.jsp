<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>${menuInfo.cntntsNm} 개인정보동의</title>
</head>
<body>

<h3 class="programPageTitle">교육 신청 - 개인정보동의 및 교육 신청</h3>
<ol class="programFlow">
    <li class="selected"><i>1</i>개인정보동의</li>
    <li><i>2</i>신청자 정보입력</li>
    <li><i>3</i>예약신청완료</li>
</ol>
<div class="programTitle">
    <%-- [운영상태]
        OPER_CNCL 폐강 | OPER_END 종료 | OPER_ING 운영중
        RCPT_ADD 추가모집 | RCPT_END 접수마감 | RCPT_ING 접수중
        RCPT_WAIT 접수예정 | WAIT_ING 대기자접수
    --%>
        <c:set var="stateTypeClass" value="type1"/>
        <c:if test="${eduLctreVO.operSttus eq 'RCPT_ING'
                                                    or eduLctreVO.operSttus eq 'RCPT_ADD'
                                                    or eduLctreVO.operSttus eq 'WAIT_ING'}">
            <c:set var="stateTypeClass" value="type2"/>
        </c:if>
        <c:if test="${eduLctreVO.operSttus eq 'OPER_CNCL'
                                                    or eduLctreVO.operSttus eq 'OPER_END'
                                                    or eduLctreVO.operSttus eq 'RCPT_END'
                                                    or eduLctreVO.operSttus eq 'OPER_ING'}">
            <c:set var="stateTypeClass" value="type3"/>
        </c:if>
        <span class="stateType ${stateTypeClass}"><c:out value="${operSttusMap[eduLctreVO.operSttus]}"/></span>
    <strong><c:out value="${eduLctreVO.lctreNm}"/></strong>
</div>
<form id="agreeForm" method="post" action="./addEduAplctWebView.do" onsubmit="return validateAgreement();">
    <input type="hidden" name="lctreNo" value="${eduLctreVO.lctreNo}"/>
    <input type="hidden" name="key" value="${eduLctreVO.key}"/>
    <fieldset>
        <legend>개인정보제공동의</legend>
        <h4>개인정보 수집 및 동의</h4>
        <div class="privacyAgreement prgEdu">
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
                    <div class="agreeExplanation">
                        <div class="agreeInnerBox">
                            <p>개인정보보호법 제17조에 따라 아래와 같은 사항을 안내하고 동의를 받아 귀하의 개인정보를 이용·제공할 수 있도록 합니다.</p>
                            <ul>
                                <li>1. 제공받는자: 원주시 산하 실과·사업소, 동주민센터</li>
                                <li>2. 제공받는 자의 수집·이용 목적: 청주시 통합예약시스템 서비스 예약자 확인 및 관리</li>
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
                                <li>5. 동의를 거부할 권리가 있다는 사실과 동의 거부에 따른 불이익 내용: 개인정보 수집 및 이용·제공에 대해 동의를 거부할 권리가 있으며, 동의 거부
                                    시에는 예약 서비스 이용이 제한됩니다.
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="formGroup">
                        <label for="agree1-1" class="customRadioButton">
                            <input type="radio" id="agree1-1" name="agree1">
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>동의함</span>
                            </span>
                        </label>
                        <label for="agree1-2" class="customRadioButton">
                            <input type="radio" id="agree1-2" name="agree1">
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>동의하지 않음</span>
                            </span>
                        </label>
                    </div>
                </div>
                <div class="agreeBox">
                    <strong class="agreeTitle">개인정보 제3자 제공 동의 <span class="point-color-red">(필수)</span></strong>
                    <div class="agreeExplanation">
                        <div class="agreeInnerBox">
                            <p>개인정보보호법 제17조에 따라 아래와 같은 사항을 안내하고 동의를 받아 귀하의 개인정보를 이용·제공할 수 있도록 합니다.</p>
                            <ul>
                                <li>1. 제공받는자: 원주시 산하 실과·사업소, 동주민센터</li>
                                <li>2. 제공받는 자의 수집·이용 목적: 청주시 통합예약시스템 서비스 예약자 확인 및 관리</li>
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
                                <li>5. 동의를 거부할 권리가 있다는 사실과 동의 거부에 따른 불이익 내용: 개인정보 수집 및 이용·제공에 대해 동의를 거부할 권리가 있으며, 동의 거부
                                    시에는 예약 서비스 이용이 제한됩니다.
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="formGroup">
                        <label for="agree2-1" class="customRadioButton">
                            <input type="radio" id="agree2-1" name="agree2">
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>동의함</span>
                            </span>
                        </label>
                        <label for="agree2-2" class="customRadioButton">
                            <input type="radio" id="agree2-2" name="agree2">
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>동의하지 않음</span>
                            </span>
                        </label>
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

<script nonce="NEOCMSSCRIPT">
    $(document).ready(function() {
        // 전체 동의 버튼 클릭 이벤트
        $("#all").on("change", function() {
            if ($(this).is(":checked")) {
                // 모든 필수 동의 버튼 선택
                $("#agree1-1").prop("checked", true);
                $("#agree2-1").prop("checked", true);
            }
        });

        // 개별 동의 버튼 변경 시 전체 동의 상태 업데이트
        $("input[name='agree1'], input[name='agree2']").on("change", function() {
            updateAllAgreeStatus();
        });

        // 초기 상태 설정
        updateAllAgreeStatus();
    });

    function updateAllAgreeStatus() {
        var agree1Checked = $("#agree1-1").is(":checked");
        var agree2Checked = $("#agree2-1").is(":checked");

        if (agree1Checked && agree2Checked) {
            $("#all").prop("checked", true);
        } else {
            $("#all").prop("checked", false);
        }
    }

    function validateAgreement() {
        // 개인정보 수집 및 이용 동의 확인
        var agree1Checked = $("#agree1-1").is(":checked");
        if (!agree1Checked) {
            alert("개인정보 수집 및 이용 동의는 필수입니다.");
            $("#agree1-1").focus();
            return false;
        }

        // 개인정보 제3자 제공 동의 확인
        var agree2Checked = $("#agree2-1").is(":checked");
        if (!agree2Checked) {
            alert("개인정보 제3자 제공 동의는 필수입니다.");
            $("#agree2-1").focus();
            return false;
        }

        return true;
    }
</script>

</body>
</html>
