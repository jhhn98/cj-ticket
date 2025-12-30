<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>${menuInfo.cntntsNm} 상세</title>
</head>
<body>
<!-- 신청자 정보입력 -->
<ol class="programFlow">
    <li class="selected"><i>1</i>개인정보동의</li>
    <li class="selected"><i>2</i>신청자 정보입력</li>
    <li><i>3</i>예약신청완료</li>
</ol>
<div class="programTitle">
    <%-- [운영상태]
        OPER_CNCL 폐강 | OPER_END 종료 | OPER_ING 운영중
        RCPT_ADD 추가모집 | RCPT_END 접수마감 | RCPT_ING 접수중
        RCPT_WAIT 접수예정 | WAIT_ING 대기자접수
    --%>
    <span class="stateType type2"><c:out value="${operSttusMap[eduLctreVO.operSttus]}"/></span>
    <strong><c:out value="${eduLctreVO.lctreNm}"/></strong>
</div>
<h4>교육 정보</h4>
<div class="programInformation">
    <ul>
        <li>
            <span class="infoTitle">운영기간</span>
            <p>
                <span>
                    <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 8}">
                        <c:set var="lctBgnDe" value="${fn:substring(eduLctreVO.lctBgnDt, 0, 8)}"/>
                        ${fn:substring(lctBgnDe, 0, 4)}-${fn:substring(lctBgnDe, 4, 6)}-${fn:substring(lctBgnDe, 6, 8)}
                    </c:if>
                </span>
                ~
                <span>
                    <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 8}">
                        <c:set var="lctEndDe" value="${fn:substring(eduLctreVO.lctEndDt, 0, 8)}"/>
                        ${fn:substring(lctEndDe, 0, 4)}-${fn:substring(lctEndDe, 4, 6)}-${fn:substring(lctEndDe, 6, 8)}
                    </c:if>
                </span>
            </p>
        </li>
        <li>
            <span class="infoTitle">시간</span>
            <p>
                <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 12}">
                    <c:set var="lctBgnHm" value="${fn:substring(eduLctreVO.lctBgnDt, 8, 12)}"/>
                    <c:out value="${tsu:toDateFormat(lctBgnHm, 'HHmm', 'HH:mm')}"/>
                </c:if>
                ~
                <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 12}">
                    <c:set var="lctEndHm" value="${fn:substring(eduLctreVO.lctEndDt, 8, 12)}"/>
                    <c:out value="${tsu:toDateFormat(lctEndHm, 'HHmm', 'HH:mm')}"/>
                </c:if>
            </p>
        </li>
        <li>
            <span class="infoTitle">요일</span>
            <p>
                <c:if test="${not empty eduLctreVO.lctWeekNm}">
                    <c:out value="${eduLctreVO.lctWeekNm}"/>
                </c:if>
            </p>
        </li>
    </ul>
</div>
<h4>신청자 정보 입력</h4>
<form id="registForm" method="post" action="./addEduAplctWebRegist.do" onsubmit="return validateAndSubmitForm(this);">
    <input type="hidden" name="lctreNo" value="${eduLctreVO.lctreNo}"/>
    <input type="hidden" name="insttNo" value="${eduLctreVO.insttNo}"/>
    <input type="hidden" name="key" value="${eduLctreVO.key}"/>

    <fieldset>
        <legend>신청자 정보</legend>
        <p class="iconText comment"><span class="point-color-red">*</span> 표시는 필수 입력 항목 입니다.</p>
        <table class="table program formTable" data-table-response>
            <caption>신청자 정보 입력-이름, 전화번호, 주소, 작성자, 메모, 선택항목, 이메일</caption>
            <tbody>
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">
<%--                        <label for="name" title="필수 입력 항목입니다.">--%>
                            이름
<%--                            <span class="point-color-red">*</span>--%>
<%--                        </label>--%>
                    </div>
                </th>
                <td>
                    <div class="innerCell">
                        <input type="text" id="name" value="${loginVO.userNm}" class="customInputDefault" readonly>
<%--                        <p class="iconText caution">이름을 정확히 입력하세요.</p>--%>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">생년월일</div>
                </th>
                <td>
                    <div class="innerCell"><c:out value="${tsu:toDateFormat(loginVO.birthday, 'yyyyMMdd', 'yyyy-MM-dd')}"/></div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">
                        <label for="name" title="필수 입력 항목입니다.">
                            전화번호
                            <span class="point-color-red">*</span>
                        </label>
                    </div>
                </th>
                <td>
                    <div class="innerCell">
                        <c:choose>
                            <c:when test="${not empty loginVO.mbtlnum}">
                                <c:set var="mbtlnum" value="${loginVO.mbtlnum}"/>
                                <c:choose>
                                    <c:when test="${fn:length(mbtlnum) == 11}">
                                        ${fn:substring(mbtlnum, 0, 3)}-${fn:substring(mbtlnum, 3, 7)}-${fn:substring(mbtlnum, 7, 11)}
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value="${mbtlnum}"/>
                                    </c:otherwise>
                                </c:choose>
                                <input type="hidden" id="telNo" name="telNo" value="<c:out value='${mbtlnum}'/>"/>
                            </c:when>
                            <c:otherwise>
                                <div class="phoneCode">
                                    <label for="codePrefix">지역번호/국번</label>
                                    <input type="text" id="codePrefix" name="codePrefix" placeholder="010" maxlength="3"
                                           class="customInputDefault" inputmode="numeric">
                                    -
                                    <label for="codeExchange">중간번호/교환번호</label>
                                    <input type="text" id="codeExchange" name="codeExchange" placeholder="0000" maxlength="4"
                                           class="customInputDefault" inputmode="numeric">
                                    -
                                    <label for="codeLine">끝번호/식별번호</label>
                                    <input type="text" id="codeLine" name="codeLine" placeholder="0000" maxlength="4"
                                           class="customInputDefault" inputmode="numeric">
                                    <input type="hidden" id="telNo" name="telNo"/>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">
                        <label for="name" title="필수 입력 항목입니다.">
                        주소
                            <span class="point-color-red">*</span>
                        </label>
                    </div>
                </th>
                <td>
                    <div class="innerCell">
                        <div class="address">
                            <input type="hidden" id="zip" name="zip" class="customInputDefault" value="${eduAplctVO.zip}" placeholder="우편번호" readonly maxlength="5"/>
                            <label for="addr">주소 검색</label>
                            <input type="text" id="addr" name="addr" placeholder="주소(도로명/지번/건물명)를 입력해주세요."
                                   class="customInputDefault addressSearch" readonly>
                            <button type="button" class="addressSearchButton" onclick="fn_openDaumZipAddress();"><span>주소검색</span></button>
                            <label for="addressDetail">끝번호/식별번호</label>
                            <input type="text" id="addressDetail" name="detailAddr" placeholder="상세주소를 입력해주세요."
                                   class="customInputDefault addressDetail">
                        </div>
                    </div>
                </td>
            </tr>

<%--        // 텍스트 입력란
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell"><label for="memo">메모</label></div>
                </th>
                <td>
                    <div class="innerCell"><input type="text" id="memo" placeholder=""
                                                  class="customInputDefault w100per"></div>
                </td>
            </tr>
--%>
            <!-- 감면 사용여부 -->
            <c:if test="${eduLctreVO.dscntUseYn eq 'Y'}">
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell"><label for="dscntCd">감면혜택</label></div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <div class="customSelect inlineBlock">
                                <select id="dscntCd" name="dscntCd">
                                    <option>감면 없음</option>
                                    <c:forEach var="result" items="${dscntList}">
                                        <c:if test="${result.piscYn == 'Y'}">
                                            <option value="PISC_${result.dscntCd}" data-confirm-mthd="pisc"><c:out value="${dscntSeMap[result.dscntCd]}"/>(비대면)</option>
                                        </c:if>
                                        <c:if test="${result.directYn == 'Y'}">
                                            <option value="DIRECT_${result.dscntCd}" data-confirm-mthd="direct"><c:out value="${dscntSeMap[result.dscntCd]}"/>(서류직접제출)</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <table class="table default">
                                <caption>감면 항목</caption>
                                <thead>
                                <tr>
                                    <th scope="col" class="first">감면 항목</th>
                                    <th scope="col">감면혜택조건</th>
                                    <th scope="col">자격확인방법</th>
                                    <th scope="col">감면율</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="result" items="${dscntList}">
                                    <tr>
                                        <td class="first"><c:out value="${dscntSeMap[result.dscntCd]}"/></td>
                                        <td><c:out value="${result.dscntCnd}"/></td>
                                        <td>
                                            <c:if test="${result.piscYn == 'Y'}">
                                                비대면
                                            </c:if>
                                            <c:if test="${result.piscYn == 'Y' && result.directYn == 'Y'}">
                                                ,
                                            </c:if>
                                            <c:if test="${result.directYn == 'Y'}">
                                                서류직접제출
                                            </c:if>
                                        </td>
                                        <td><c:out value="${result.dscntRate}"/>%</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </c:if>

            <!-- 거주지 사용여부 -->
            <c:if test="${eduLctreVO.residenceUseYn eq 'Y'}">
                <input type="hidden" name="resInqTxId" value="">
                <input type="hidden" name="resInqResult" value="">
                <input type="hidden" name="resInqCd" value="">
                <input type="hidden" name="resInqChecked" value="N">
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell">
                            거주지 조회
                            <span class="point-color-red">*</span>
                        </div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <div class="juminNo" id="juminNoInput">
                                <label for="resJuminNoPre">주민번호 앞자리</label>
                                <input type="text" id="resJuminNoPre" placeholder="주민번호 앞자리" class="customInputDefault textAlignCenter" maxlength="6" value="<c:out value="${tsu:toDateFormat(loginVO.birthday, 'yyyyMMdd', 'yyMMdd')}"/>" disabled>
                                &nbsp;-&nbsp;
                                <label for="resJuminNoPost">주민번호 뒷자리</label>
                                <input type="text" id="resJuminNoPost" placeholder="주민번호 뒷자리" class="customInputDefault textAlignCenter" maxlength="7" name="resJuminNoPost">
                                <button type="button" class="customLink bgBlack bigHeight marginLeft10 " onclick="fn_ResideInsttCnfirmCheck();"><span>조회</span></button>
                                <span id="resInqResultText" class="resIngResultText"></span>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:if>

            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">
                        이메일
                        <span class="point-color-red">*</span>
                    </div>
                </th>
                <td>
                    <div class="innerCell">
                        <div class="email">
                            <label for="emailId">E-mail ID</label>
                            <input type="text" id="emailId" name="emailId" class="customInputDefault textAlignCenter">
                             @ 
                            <label for="emailDomain">E-mail Domain name</label>
                            <input type="text" id="emailDomain" name="emailDomain" class="customInputDefault textAlignCenter" readonly>
                            <input type="hidden" id="email" name="email">
                            <label for="emailDomainSelect">E-mail Domain Select</label>
                            <div class="customSelect inlineBlock">
                                <select id="emailDomainSelect" name="">
                                    <option value="">선택해주세요.</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="nate.com">nate.com</option>
                                    <option value="kakao.com">kakao.com</option>
                                    <option value="daum.net">daum.net</option>
                                    <option value="custom">직접입력</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>

            <c:if test="${!empty eduLctreVO.eduAmt and eduLctreVO.eduAmt > 0}">

                <c:if test="${eduLctreVO.dscntUseYn eq 'Y'}">

                </c:if>
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell">
                            <label for="payMthdCd" title="필수 입력 항목입니다.">
                                결제방법
                                <span class="point-color-red">*</span>
                            </label>
                        </div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <div class="customSelect inlineBlock">
                                <%-- 결제방식 공통코드 - ELCTRN : 전자결제 / NBKRCP : 무통장입금 / DIRECT : 현장결제 --%>
                                <select id="payMthdCd" name="payMthdCd">
                                    <option value="">선택해주세요.</option>
                                    <c:forEach var="result" items="${payMthdList}" varStatus="status">
                                        <%-- 강좌에 설정된 결제방식만 표시 --%>
                                        <c:if test="${fn:contains(eduLctreVO.payMthdCd, result.code)}">
                                            <option value="<c:out value="${result.code}"/>"<c:if test="${result.code == eduAplctVO.payMthdCd}"> selected</c:if>><c:out value="${result.codeNm}"/></option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
        <c:if test="${!empty eduLctreVO.eduAmt and eduLctreVO.eduAmt > 0}">
            <div class="programAmount">
                <div class="innerWrap">
                    <ul>
                        <li>
                            <strong>이용요금</strong>
                            <span><fmt:formatNumber value="${eduLctreVO.eduAmt}" pattern="#,###"/> 원</span>
                        </li>
                        <c:if test="${eduLctreVO.dscntUseYn eq 'Y'}">
                            <li>
                                <strong>감면할인</strong>
                                <span>원</span>
                            </li>
                        </c:if>
                    </ul>
                    <p class="sumAmount">
                        <strong>총 결제금액</strong>
                        <span><fmt:formatNumber value="${eduLctreVO.eduAmt}" pattern="#,###"/> 원</span>
                    </p>
                </div>
            </div>
        </c:if>

        <div class="formButtonGroup">
            <a href="" class="button previous"><span>이전</span></a>
            <button type="button" id="submitButton" class="button next"><span>다음</span></button>
        </div>
        <%--
        <button type="button" class="button next" data-modal-button="modal2-1-2"><span>다음</span></button>
        <!--예약신청 승인 감면 대상자 Modal-->
        <button type="button" class="button next" data-modal-button="modal2-2-1"><span>다음</span></button>
        <!--예약신청 거절 Modal-->
        <button type="button" class="button next" data-modal-button="modal2-2-2"><span>다음</span></button>
        <!--예약신청 거절 감면 대상자 아님 Modal-->
        --%>
    </fieldset>
</form>
<%--
<div class="programModal" data-modal-layer="modal2-1-1">
    <div class="modalHeader">
        <strong>예약신청</strong>
    </div>
    <div class="modalBody alignCenter">
        <i class="iconModal confirm"></i>
        <p class="confirmText">신청정보가 <span class="point-color-green">확인되었습니다.</span></p>
    </div>
    <div class="modalFooter">
        <p class="iconText caution"><span class="point-color-green">확인버튼</span>을 눌러야 신청이 완료됩니다.</p>
        <div class="formButtonGroup">
            <button type="submit" class="button bgFill">확인</button>
            <button class="modalCloseButton"><span>닫기</span></button>
        </div>
    </div>
</div>
--%>

<!-- 다음 우편번호 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script nonce="NEOCMSSCRIPT">
    $(document).ready(function() {
        // 이메일 도메인 선택 처리
        $("#emailDomainSelect").on("change", function() {
            var selectedValue = $(this).val();
            if (selectedValue === "custom") {
                $("#emailDomain").prop("readonly", false);
                $("#emailDomain").val("");
                $("#emailDomain").focus();
            } else if (selectedValue !== "") {
                $("#emailDomain").prop("readonly", true);
                $("#emailDomain").val(selectedValue);
            } else {
                $("#emailDomain").prop("readonly", true);
                $("#emailDomain").val("");
            }
            updateEmail();
        });

        // 이메일 ID 또는 도메인 변경 시 이메일 업데이트
        $("#emailId, #emailDomain").on("blur", function() {
            updateEmail();
        });

        // 전화번호 입력 시 자동 조합
        $("#codePrefix, #codeExchange, #codeLine").on("blur", function() {
            updateTelNo();
        });

        // 다음 버튼 클릭 이벤트
        $("#submitButton").on("click", function() {
            if (validateAndSubmitForm(document.getElementById("registForm"))) {
                document.getElementById("registForm").submit();
            }
        });
    });

    /**
     * 전화번호 조합
     * 입력 필드가 있는 경우에만 조합하여 hidden 필드에 저장
     */
    function updateTelNo() {
        if ($("#codePrefix").length > 0 && $("#codeExchange").length > 0 && $("#codeLine").length > 0) {
            var prefix = $("#codePrefix").val() || "";
            var exchange = $("#codeExchange").val() || "";
            var line = $("#codeLine").val() || "";
            var telNo = prefix + exchange + line;
            $("#telNo").val(telNo);
        }
    }

    /**
     * 이메일 조합
     */
    function updateEmail() {
        var emailId = $("#emailId").val() || "";
        var emailDomain = $("#emailDomain").val() || "";
        if (emailId && emailDomain) {
            $("#email").val(emailId + "@" + emailDomain);
        } else {
            $("#email").val("");
        }
    }

    /**
     * 주소 조합 (상세주소 포함)
     */
    function updateAddr() {
        var addr = $("#addr").val() || "";
        var detailAddr = $("#addressDetail").val() || "";
    }

    // 우편번호 찾기
    function fn_openDaumZipAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                $("#zip").val(data.zonecode);
                $("#addr").val(data.address);
                $("#addressDetail").show();
                $("#addressDetail").focus();
                updateAddr();
            }
        }).open();
    }

    function fn_juminNoCheck(juminNo) {

        if(juminNo == "") {
            alert("주민등록번호를 입력해주세요.");
            return false;
        }

        if(juminNo.length != 7) {
            alert("주민등록번호 뒷자리는 숫자 7자리로 입력해주세요.");
            return false;
        }

        if(!$.isNumeric(juminNo)) {
            alert("주민등록번호는 숫자만 입력해주세요.");
            return false;
        }

        return true;
    }

    function fn_ResideInsttCnfirmCheck() {

        $('#ResideInsttCnfirm').text('');

        var juminNoPost = $('#resJuminNoPost').val();
        if(!fn_juminNoCheck(juminNoPost)) {
            $('#resJuminNoPost').focus();
            return false;
        }

        var insttNo = $('input[name=insttNo]').val();
        var prgNo = $('input[name=lctreNo]').val();

        $.ajax({
            cache: false,
            url: '/piscResInqAjax.do',
            type: 'POST',
            data: {
                prgSe: 'EDU',
                juminNoPost: juminNoPost,
                prgNo: prgNo,
                insttNo: insttNo,
            },
            success: function (res) {
                var resInqTxId = res['resInqTxId'];
                var resInqResult = '';
                var resInqResultText = '';
                var RESULT = res['RESULT'];

                if (RESULT == 'JUMIN_NO_FAILR') {
                    alert("주민번호 뒷자리를 확인해주세요.");
                    $('#resJuminNoPost').focus();
                    return false;
                }

                if (RESULT == 'Y') {
                    alert("관내거주자 확인 되었습니다.");

                    var hangkikCd = res['hangkikCd'];
                    resInqResult = hangkikCd;
                    console.log(hangkikCd);

                    var admDong = res['admDong'];
                    resInqResultText += '청주시민(' + admDong + ')';

                    // 관내 거주자인 경우에만 resInqTxId 설정
                    $('input[name=resInqTxId]').val(resInqTxId);
                    $('input[name=resInqResult]').val(resInqResult);
                    $('input[name=resInqCd]').val(hangkikCd);
                    $('input[name=resInqChecked]').val('Y');
                    $('#resInqResultText').text(resInqResultText);
                } else {
                    var msg = '거주지 조회 오류입니다. 관리자에게 문의해주세요.';

                    if(RESULT == 'N' || RESULT == 'PISC_FAIL_04') {
                        msg = '관내 거주자가 아닙니다. 신청 불가합니다.';
                        resInqResult = 4;
                    } else if(RESULT == 'PISC_FAIL_02') {
                        msg = '주민등록번호 오류입니다. 입력하신 주민등록번호를 다시 확인해주세요.';
                        resInqResult = 2;
                    } else if(RESULT == 'PISC_FAIL_03') {
                        msg = '성명 오류입니다. 입력하신 성명을 다시 확인해주세요.';
                        resInqResult = 3;
                    } else if(RESULT == 'PISC_FAIL_09') {
                        msg = '시스템 오류입니다. 관리자에게 문의해주세요.';
                        resInqResult = 9;
                    } else if(RESULT == 'PISC_FAIL_99') {
                        msg = '등록된 이용기관이 아닙니다. 관리자에게 문의해주세요.';
                        resInqResult = 99;
                    } else if(RESULT == 'PISC_FAIL_ELSE') {
                        msg = '잘못된 접근입니다.';
                        resInqResult = 999;
                    }

                    alert(msg);
                    // 관내 거주자가 아닌 경우 resInqTxId 미설정
                    $('input[name=resInqTxId]').val('');
                    $('input[name=resInqResult]').val('');
                    $('input[name=resInqCd]').val('');
                    $('input[name=resInqChecked]').val('Y');
                    $('#resInqResultText').text(msg);
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
    }

    
    function validateAndSubmitForm(form) {
        // 전화번호 조합 (입력 필드가 있는 경우에만)
        updateTelNo();

        // 이메일 조합
        updateEmail();

        // 필수 항목 검증
        var telNo = $("#telNo").val();
        if (!telNo || telNo.length < 10) {
            alert("전화번호를 정확히 입력해주세요.");
            // 입력 필드가 있는 경우에만
            if ($("#codePrefix").length > 0) {
                $("#codePrefix").focus();
            }
            return false;
        }

        // 주소 필수 체크
        var zip = $("#zip").val();
        var addr = $("#addr").val();
        var addressDetail = $("#addressDetail").val();
        if (!zip || !addr) {
            alert("주소를 입력해주세요.");
            $("#addr").focus();
            return false;
        }
        if (!addressDetail) {
            alert("상세주소를 입력해주세요.");
            $("#addressDetail").focus();
            return false;
        }

        // 이메일 필수 체크
        var emailId = $("#emailId").val();
        var emailDomain = $("#emailDomain").val();
        if (!emailId || emailId.trim() === "") {
            alert("이메일 아이디를 입력해주세요.");
            $("#emailId").focus();
            return false;
        }
        if (!emailDomain || emailDomain.trim() === "") {
            alert("이메일 주소를 선택해주세요.");
            $("#emailDomainSelect").focus();
            return false;
        }

        // 이메일 형식 검증
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        var email = $("#email").val();
        if (!emailRegex.test(email)) {
            alert("올바른 이메일 형식이 아닙니다.");
            $("#emailId").focus();
            return false;
        }

        // 유료인 경우 결제방법 필수 체크
        var payAmt = <c:out value="${eduLctreVO.eduAmt != null ? eduLctreVO.eduAmt : 0}"/>;
        if (payAmt > 0) {
            var payMthdCd = $("#payMthdCd").val();
            if (!payMthdCd || payMthdCd === "") {
                alert("결제방식을 선택해주세요.");
                $("#payMthdCd").focus();
                return false;
            }
        }

        <c:if test="${eduLctreVO.residenceUseYn eq 'Y'}">
        // 거주지 조회를 안 한 경우
        if (form.resInqChecked.value != 'Y') {
            form.resJuminNoPost.focus();
            alert("거주지 조회가 필요한 서비스입니다.");
            return false;
        }
        // 거주지 조회를 했지만 관내 거주자가 아닌 경우
        if (!form.resInqTxId.value) {
            form.resJuminNoPost.focus();
            alert("관내 거주자가 아닙니다. 거주자가 아닐 시 해당 교육에 접수 불가합니다.");
            return false;
        }
        </c:if>

        if (!confirm("신청하시겠습니까?")) {
            return false;
        }
        return true;
    }
</script>

</body>

</html>

