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
    <title><c:out value="${menuInfo.naviList[0].menuNm}"/> &gt; ${menuInfo.cntntsNm} &gt; 접수관리 목록</title>
</head>
<body>

<div class="p-wrap">

    <jsp:include page="../incFcltyInfo.jsp" />

    <h3>신청자 목록</h3>
    <div class="row margin_b_5">
        <div class="col-12">
			<span class="p-total__number">
				총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong>${paginationInfo.totalRecordCount}</strong></em>건
				&nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]
			</span>
        </div>

        <div class="col-12 right">
            <form:form modelAttribute="fcltyApplSearchVO" name="fcltyApplSearchVO" method="get" class="p-form-inline">
                <form:hidden path="key"/>
                <form:hidden path="fcltyNo"/>
                <c:forEach var="result" items="${fcltySearchVO.paramsMapMng}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <form:select path="pageUnit" cssClass="p-input" title="목록수">
                    <form:option value="10">10개씩</form:option>
                    <form:option value="30">30개씩</form:option>
                    <form:option value="50">50개씩</form:option>
                    <form:option value="100">100개씩</form:option>
                </form:select>
                <form:select path="searchRsvSttus" cssClass="p-input" title="예약상태">
                    <form:option value="" label="예약상태 선택"/>
                    <c:forEach var="result" items="${rsvSttusList}">
                        <form:option value="${result.code}" label="${result.codeNm}"/>
                    </c:forEach>
                </form:select>
                <form:select path="searchPaySttus" cssClass="p-input" title="결제상태">
                    <form:option value="" label="결제상태 선택"/>
                    <c:forEach var="result" items="${paySttusList}">
                        <form:option value="${result.code}" label="${result.codeNm}"/>
                    </c:forEach>
                </form:select>
                <input type="text" name="searchKrwd" id="searchKrwd" class="p-input" title="" value="<c:out value="${fcltyApplSearchVO.searchKrwd}"/>" placeholder="검색단어 입력">
                <button type="submit" class="p-button p-button--small primary">검색</button>
            </form:form>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption>시설 신청 목록 - 번호, 예약번호, 신청자, 생년월일, 성별, 연락처, 신청일, 개인/단체 여부, 예약일자, 결제상태, 예약상태 등 제공</caption>
        <colgroup>
            <col style="width:30px">
            <col style="width:50px">
            <col style="width:150px">
            <col style="width:100px">
            <col style="width:80px">
            <col style="width:50px">
            <col style="width:100px">
            <col style="width:80px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:60px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">선택</th>
            <th scope="col">번호</th>
            <th scope="col">예약번호</th>
            <th scope="col">신청자</th>
            <th scope="col">생년월일</th>
            <th scope="col">성별</th>
            <th scope="col">연락처</th>
            <th scope="col">신청일</th>
            <th scope="col">개인/단체</th>
            <th scope="col">예약일자</th>
            <th scope="col">예약상태</th>
            <th scope="col">결제상태</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${fcltyApplList}">
            <tr>
                <td class="p-table__checkbox">
                    <span class="p-form-checkbox p-form-checkbox--single">
                        <input type="checkbox" name="fcltyApplNoArr" data-sttus="<c:out value="${result.rsvSttusCd}"/>" id="fcltyApplNo<c:out value="${result.fcltyApplNo}"/>"
                               class="p-form-checkbox__input" value="<c:out value="${result.fcltyApplNo}"/>" data-receiver-no="<c:out value="${result.mobileNo}"/>">
                        <label for="fcltyApplNo<c:out value="${result.fcltyApplNo}"/>" class="p-form-checkbox__label">시설 신청 <c:out value="${result.fcltyApplNo}"/>번 </label>
                    </span>
                </td>
                <td>${currentPageStartNo}</td>
                <td>
                    <a href="./selectFcltyApplView.do?fcltyApplNo=<c:out value="${result.fcltyApplNo}"/>&amp;<c:out value="${fcltyApplSearchVO.params}"/><c:out value="${fcltyApplSearchVO.paramsMng}"/>&amp;<c:out value="${fcltySearchVO.fcltyParamsMng}"/>&amp;isFcltyList=Y">
                        <c:out value="${result.fcltyApplId}"/>
                    </a>
                </td>
                <td><c:out value="${result.applNm}"/></td>
                <td><c:out value="${tsu:toDateFormat(result.birthDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/></td>
                <td>
                    <c:if test="${result.genderSe == 'M'}">남</c:if>
                    <c:if test="${result.genderSe == 'F'}">여</c:if>
                </td>
                <td>
                    <c:out value="${result.mobileNo1}"/>-<c:out value="${result.mobileNo2}"/>-<c:out value="${result.mobileNo3}"/>
                </td>
                <td>
                    <c:out value="${tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd')}"/><br/>
                    <c:out value="${fn:substring(tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSSS', 'HH:mm:ss.SSS'),0,11)}"/>
                </td>
                <td>
                    <c:if test="${empty result.grpNm}">개인</c:if>
                    <c:if test="${!empty result.grpNm}">단체(<c:out value="${result.grpNm}"/>)</c:if>
                </td>
                <td>
                    <c:out value="${tsu:toDateFormat(result.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/><br/>
                    <c:out value="${tsu:toDateFormat(result.fcltyBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(result.fcltyEndHm, 'HHmm', 'HH:mm')}"/>
                </td>
                <td>
                    <c:out value="${rsvSttusMap[result.rsvSttusCd]}"/>
                    <c:if test="${fcltyVO.slctMthdCd == 'CONFM' and result.rsvSttusCd eq 'APPL_CMPL' and not empty result.applCmplDt}">
                        <br>승인완료
                    </c:if>
                    <c:if test="${fcltyVO.slctMthdCd == 'DRWLT' && fcltyVO.drwtYn == 'Y'}">
                        <br/>
                        추첨완료
                        <c:if test="${result.drwtWinYn == 'Y'}"><span class="em_blue">(당첨)</span></c:if>
                        <c:if test="${result.drwtWinYn == 'N'}"><span class="em_gray">(미당첨)</span></c:if>
                    </c:if>
                </td>
                <td>
                    <%--TODOSDB: 감면관련 상태값 추가--%>
                    <c:out value="${paySttusMap[result.paySttusCd]}"/>
                    <c:if test="${result.paySttusCd == 'PAY_WAIT'}">
                        <br>결제시한
                        <br/><c:out value="${tsu:toDateFormat(result.payDeadlineDt, 'yyyyMMddHHmmss', 'yy-MM-dd HH:mm:ss')}"/>
                    </c:if>
                </td>
                <td><a href="./updateFcltyApplView.do?fcltyApplNo=<c:out value="${result.fcltyApplNo}"/>&key=<c:out value="${key}"/>" class="p-button p-button--small edit">수정</a></td>
            </tr>
            <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(fcltyApplList) eq 0}">
            <tr>
                <td colspan="13">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="row margin_t_20">
        <div class="col-9 left">
            <a href="./selectFcltyList.do?<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsMng}"/>" class="p-button cancel">시설예약관리 목록</a>
        </div>
        <div class="col-10 center">
            <c:if test="${fn:length(fcltyApplList) ne 0}">
                <div class="p-pagination">
                    <div class="p-page">
                        <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectFcltyApplListByFclty.do?fcltyNo=${fcltyVO.fcltyNo}&amp;${fcltyApplSearchVO.paramsExclPi}${fcltyApplSearchVO.paramsMng}&amp;pageIndex=" />
                    </div>
                </div>
            </c:if>
        </div>
        <div class="col-5 right">
            <c:choose>
                <c:when test="${fcltyVO.operSttus eq 'RCPT_ING'}"><a href="./addFcltyApplView.do?fcltyNo=<c:out value="${fcltyVO.fcltyNo}"/>&key=<c:out value="${key}"/>" class="p-button write">등록</a></c:when>
                <c:otherwise>운영상태가 [접수중]인 경우 등록 가능합니다.</c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="row margin_t_20">
        <div class="col-12 left">

            <button type="button" class="p-button darken" onclick="fn_fcltyApplNoCheckAll()">전체선택</button>

            <select name="rsvSttus" id="" class="p-input p-input--auto">
                <option value="">예약상태</option>
                <c:forEach var="result" items="${rsvSttusList}">
                    <option value="<c:out value="${result.code}"/>"><c:out value="${result.codeNm}"/></option>
                </c:forEach>
            </select>
            <button type="button" class="p-button edit" onclick="fn_fcltyApplRsvSttusChange()">변경</button>

            <c:if test="${fcltyVO.fcltyAmt > 0}">
                <span class="p-form__split-short">/</span>

                <select name="paySttus" id="" class="p-input p-input--auto">
                    <option value="">결제상태</option>
                    <c:forEach var="result" items="${paySttusList}">
                        <option value="<c:out value="${result.code}"/>"><c:out value="${result.codeNm}"/></option>
                    </c:forEach>
                </select>
                <button type="button" class="p-button edit" onclick="fn_fcltyApplPaySttusChange()">변경</button>
            </c:if>
        </div>
        <div class="col-12 right">
            <button type="button" class="p-button primary" id="sms-modal-button">선택SMS발송</button>
            <%--            <a href="./downloadFcltyApplXls.do" class="p-button p-button--combine excel" onclick="fn_downloadFcltyApplXls(this.href); return false;">엑셀다운로드</a>--%>
            <button type="button" class="p-button p-button--combine excel excel-modal">엑셀다운로드</button>
        </div>
    </div>

    <div class="modal" id="send-sms-modal" tabindex="0" role="dialog">
        <div class="modal__body">
            <div class="modal__header">
                <div class="modal__title">선택 SMS 발송</div>
            </div>
            <div class="modal__content">
                <table class="p-table">
                    <caption>SMS 입력</caption>
                    <colgroup>
                        <col class="w20p">
                        <col />
                    </colgroup>
                    <tbody class="p-table--th-left">
                    <tr>
                        <th scope="row" style="text-align: center;">발신자<br/>번호</th>
                        <td>
                            <input type="text" name="senderNo" id="senderNo" class="p-input" placeholder="'-' 제외한 번호로 입력바랍니다.">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" style="text-align: center;">문자<br/>내용</th>
                        <td>
                            <textarea name="smsContents" id="smsContents" class="p-input"></textarea>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal__footer">
                <button type="button" class="p-button default" data-close="modal">닫기</button>
                <button type="button" class="p-button secondary primary" id="send-sms-button">발송</button>
            </div>
            <div class="modal__close">
                <button type="button" data-close="modal" class="modal__close-button">
                    <span>닫기</span>
                </button>
            </div>
        </div>
    </div>

    <div class="modal" id="drwt-result-modal" tabindex="0" role="dialog">
        <div class="modal__body">
            <div class="modal__header">
                <div class="modal__title">추첨 결과 - <c:out value="${fcltyVO.fcltyNm}"/></div>
            </div>
            <div class="modal__content">
                <jsp:include page="../../drwt/drwtList.jsp" />
            </div>
            <div class="modal__footer">
                <button type="button" class="p-button default" data-close="modal">닫기</button>
            </div>
            <div class="modal__close">
                <button type="button" data-close="modal" class="modal__close-button">
                    <span>닫기</span>
                </button>
            </div>
        </div>
    </div>

    <div class="modal" id="excel-default-modal" tabindex="0" role="dialog">
        <div class="modal__body">
            <div class="modal__header">
                <div class="modal__title">개인정보 다운로드 사유 입력</div>
            </div>
            <form name="frm" id="frm" method="post" action="./downloadFcltyApplXls.do?<c:out value="${fcltyApplSearchVO.excelParams}"/>" onsubmit="return fn_chkExcel();">
                <fieldset>
                    <legend>게시물 작성</legend>
                    <div class="modal__content">
                        개인정보보호법에 따라 개인정보가 포함된 자료를 다운로드할 경우 사용목적을 명시해야 합니다. <br>개인정보가 수록된 자료를 다운로드할 경우 취급 및 관리에 유의하여 주십시오.
                        <div class="col-24 margin_t_5">
                            <textarea id="dwldResn" name="dwldResn" placeholder="개인정보 다운로드 사유 입력은 최소 10글자 이상 입력해야만 합니다." class="p-input" cols="80" rows="5" required="required" minlength="10" maxlength="100" style="height: 100px"></textarea>
                        </div>
                    </div>
                    <div class="modal__footer">
                        <button type="submit" class="p-button primary">엑셀 다운로드</button>
                        <button type="button" class="p-button default" data-close="modal">닫기</button>
                    </div>
                </fieldset>
            </form>
            <div class="modal__close">
                <button type="button" data-close="modal" class="modal__close-button">
                    <span>닫기</span>
                </button>
            </div>
        </div>
    </div>
</div>

<script>

    var receiverNoParam = [];
    $("#sms-modal-button").on("click", function () {

        var chkAt = $('input[name=fcltyApplNoArr]').is(":checked");

        if (!chkAt) {
            alert('문자 전송할 대상자를 선택하세요.')
            return false;
        }
        receiverNoParam = [];
        $('#senderNo').val('');
        $('#smsContents').val('');
        $('input[name=fcltyApplNoArr]:checked').each(function () {
            var receiverNo = $(this).data("receiverNo");
            receiverNoParam.push(receiverNo);
        });

        $(this).modalPop({
            target : "#send-sms-modal",
            width  : "500",
            height : "350"
        });
    });

    $("#send-sms-button").on("click", function () {

        var senderNo = $('#senderNo');
        var regexTel1 = RegExp(/^02\d{3,4}\d{4}$/);
        var regexTel2 = RegExp(/^0\d{2}\d{3,4}\d{4}$/);

        if (!senderNo.val()) {
            alert("발신자번호를 입력해주세요.");
            senderNo.focus();
            return false;
        } else {
            if(!regexTel1.test(senderNo.val()) && !regexTel2.test(senderNo.val())) {
                alert("발신자번호는 일반전화 형식으로 입력해주세요. 휴대폰번호는 문자 발송이 제한될 수 있습니다.");
                senderNo.focus();
                return false;
            }
        }

        var smsContents = $('#smsContents');
        if (!smsContents.val()) {
            alert("문자 내용을 입력해주세요.");
            smsContents.focus();
            return false;
        }

        if (confirm('발송하시겠습니까?')) {

            $.ajax({
                cache: false,
                url: './sendSmsMultiAjax.do',
                type: 'POST',
                data: {
                    senderNo: senderNo.val(),
                    receiverNoArr: receiverNoParam,
                    smsContents: smsContents.val()
                },
                success: function (res) {
                    if (res > 0) {
                        alert("문자 전송이 완료되었습니다.");
                    } else if (res == 0) {
                        alert("전송된 내역이 없습니다.");
                    } else if (res == -1) {
                        alert("수신번호를 확인할 수 없습니다.");
                    } else if (res == -2) {
                        alert("발신자번호를 확인할 수 없습니다.");
                    } else if (res == -3) {
                        alert("보내실 메세지 내용을 확인할 수 없습니다.");
                    } else {
                        alert("문자 전송 중 오류가 발생하였습니다.");
                    }
                    location.reload();
                }, // success
                error: function (request, xhr, status) {
                    //alert(request.responseText);
                    alert("에러가 발생하였습니다.");
                    console.log("code:", request.status);
                    console.log("message:", request.responseText);
                    console.log("error:" + error)
                }
            });
        }
    });
    
    $(".excel-modal").on("click", function () {
        <c:if test="${fn:length(fcltyApplList) eq 0}">
            alert('다운로드 할 목록이 없습니다.');
        </c:if>
        <c:if test="${fn:length(fcltyApplList) > 0}">
            $('#dwldResn').val('');
            $(this).modalPop({
                target: "#excel-default-modal",
                width: "600",
                height: "200",
                backdrop: true,
                keyboard: false
            });
        </c:if>
    });

    function fn_chkExcel() {
        if (confirm('엑셀을 다운로드 하시겠습니까?')) {
            $('#excel-default-modal').hide();
            return;
        } else {
            return false;
        }
    }

    function fn_fcltyApplNoCheckAll() {
        var chkAt = $('input[type=checkbox][name=fcltyApplNoArr]').is(":checked");

        if (chkAt) {
            $('input[type=checkbox][name=fcltyApplNoArr]').prop('checked', false);
        } else {
            $('input[type=checkbox][name=fcltyApplNoArr]').prop('checked', true);
        }
    }

    function fn_fcltyApplRsvSttusChange() {
        var chkAt = $('input[name=fcltyApplNoArr]').is(":checked");
        var fcltyApplNoParam = [];
        $('input[name=fcltyApplNoArr]:checked').each(function() {
            fcltyApplNoParam.push($(this).val());
        });

        if (chkAt) {

            var rsvSttus = $('select[name=rsvSttus]').val();
            if (rsvSttus == "") {
                alert("예약상태를 선택해주세요.");
                $('select[name=rsvSttus]').focus();
                return false;
            }

            if (!confirm("예약상태를 변경 하시겠습니까?")) {
                return false;
            }

            $.ajax({
                cache: false,
                url: './updateFcltyApplRsvSttusAjax.do',
                type: 'POST',
                data: {
                    fcltyApplNoArr: fcltyApplNoParam,
                    rsvSttusCd: rsvSttus
                },
                success: function (res) {
                    if (res > 0) {
                        alert("상태 변경이 완료되었습니다.");
                    } else if (res == 0) {
                        alert("변경된 내역이 없습니다.");
                    } else {
                        alert("상태값 변경 중 오류가 발생하였습니다.");
                    }
                    location.reload();
                }, // success
                error: function (request,xhr, status) {
                    //alert(request.responseText);
                    alert("에러가 발생하였습니다.");
                    console.log("code:",request.status);
                    console.log("message:",request.responseText);
                    console.log("error:"+error)
                }
            });

        } else {
            alert("시설 신청 번호를 선택해주세요.");
            return false;
        }
    }

    function fn_fcltyApplPaySttusChange() {
        var chkAt = $('input[name=fcltyApplNoArr]').is(":checked");
        var fcltyApplNoParam = [];
        let chkBool = false;
        $('input[name=fcltyApplNoArr]:checked').each(function() {
            fcltyApplNoParam.push($(this).val());
            if ($(this).data('sttus') === 'APPL_WAIT') {
                chkBool = true;
            }
        });

        if (chkBool) {
            alert('예약상태가 접수대기인 건은 결제상태를 변경할 수 없습니다. 예약상태부터 변경처리 해주세요.');
            return false;
        }

        if (chkAt) {

            var paySttus = $('select[name=paySttus]').val();
            if (paySttus == "") {
                alert("결제상태를 선택해주세요.");
                $('select[name=paySttus]').focus();
                return false;
            }

            if (!confirm("결제상태를 변경 하시겠습니까?")) {
                return false;
            }

            $.ajax({
                cache: false,
                url: './updateFcltyApplPaySttusAjax.do',
                type: 'POST',
                data: {
                    fcltyApplNoArr: fcltyApplNoParam,
                    paySttusCd: paySttus
                },
                success: function (res) {
                    if (res > 0) {
                        alert("상태 변경이 완료되었습니다.");
                    } else if (res == 0) {
                        alert("변경된 내역이 없습니다.");
                    } else {
                        alert("상태값 변경 중 오류가 발생하였습니다.");
                    }
                    location.reload();
                }, // success
                error: function (request,xhr, status) {
                    //alert(request.responseText);
                    alert("에러가 발생하였습니다.");
                    console.log("code:",request.status);
                    console.log("message:",request.responseText);
                    console.log("error:"+error)
                }
            });

        } else {
            alert("시설 신청 번호를 선택해주세요.");
            return false;
        }
    }

    function fn_downloadFcltyApplXls(url) {
        const $form = $('#fcltyApplSearchVO');
        var originUrl = $form.attr("action");
        $form.attr("action",url);

        $form.submit();
        $form.attr("action",originUrl);
    }

    <c:if test="${fcltyVO.slctMthdCd == 'DRWLT'}">
    $('.prepareDrwtProcess').on('click', function () {
        if (confirm("추첨 진행 중 다른 동작은 중복당첨 등의 오류를 일으킬 수 있으니 주의바랍니다.")) {
            $.ajax({
                cache: false,
                url: './preparDrwtProcessAjax.do',
                type: 'POST',
                data: {
                    prgSe: 'FCT',
                    prgNo: <c:out value="${fcltyVO.fcltyNo}"/>
                },
                success: function (res) {
                    var message = res['message'];
                    alert(message);
                    location.reload();
                }, // success
                error: function (request, xhr, status) {
                    //alert(request.responseText);
                    alert("에러가 발생하였습니다.");
                    console.log("code:", request.status);
                    console.log("message:", request.responseText);
                    console.log("error:" + error)
                }
            })
        }
    });

    $('#drwtWinList').on('click', function () {
        selectDrwtWinList();
    })

    function selectDrwtWinList() {
        $.ajax({
            cache: false,
            url: './selectDrwtWinListAjax.do',
            type: 'POST',
            data: {
                prgSe: 'FCT',
                prgNo: <c:out value="${fcltyVO.fcltyNo}"/>
            },
            success: function (res) {
                $('#drwt-result-modal .modal__content').html(res);
            }, // success
            error: function (request, xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                console.log("code:", request.status);
                console.log("message:", request.responseText);
                console.log("error:" + error)
            }
        })
    }

    $(document).on("click", "#winCancel", function () {
        if (confirm("미당첨 처리하시겠습니까?")) {
            $.ajax({
                cache: false,
                url: './updateDrwtWinYn.do',
                type: 'POST',
                data: {
                    drwtNo: $(this).data('drwtNo'),
                    winYn: 'N'
                },
                success: function (res) {
                    if (res > 0) {
                        selectDrwtWinList();
                    }
                }, // success
                error: function (request, xhr, status) {
                    //alert(request.responseText);
                    alert("에러가 발생하였습니다.");
                    console.log("code:", request.status);
                    console.log("message:", request.responseText);
                    console.log("error:" + error)
                }
            })
        }
    });

    $('#drwtProcess').on('click', function () {
        if (confirm("추첨 확정을 진행하시겠습니까?")) {
            $.ajax({
                cache: false,
                url: './drwtProcessAjax.do',
                type: 'POST',
                data: {
                    prgSe: 'FCT',
                    prgNo: <c:out value="${fcltyVO.fcltyNo}"/>
                },
                success: function (res) {
                    var message = res['message'];
                    alert(message);
                    location.reload();
                }, // success
                error: function (request, xhr, status) {
                    //alert(request.responseText);
                    alert("에러가 발생하였습니다.");
                    console.log("code:", request.status);
                    console.log("message:", request.responseText);
                    console.log("error:" + error)
                }
            })
        }
    });
    </c:if>
</script>

</body>
</html>
