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
    <title>${menuInfo.cntntsNm} > 신청자 환불 목록</title>
</head>
<body>

<div class="p-wrap">

    <div class="card">
        <form:form modelAttribute="exprnApplSearchVO" name="exprnApplSearchVO" method="get" class="p-form-group" cssClass="row" onsubmit="return fn_searchExprnApplCheck(this)">
            <form:hidden path="key"/>
            <textarea name="dwldResn" hidden="hidden"></textarea>
            <div class="p-form-row">
                <label for="" class="p-form__label col-6 right">운영기관</label>
                <div class="col-3">
                    <form:select path="searchInsttNo" class="p-input">
                        <c:if test="${fn:length(expInsttList) > 1}"><form:option value="0" label="운영기관 선택"/></c:if>
                        <form:options items="${expInsttList}" itemValue="insttNo" itemLabel="insttNm"/>
                    </form:select>
                </div>
                <label for="" class="p-form__label col-2 right">환불요청일</label>
                <div class="col-4">
                    <div class="p-date-group">
                        <input type="hidden" name="searchCnd" value="RFND"/>
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchBgnDeFmt" id="searchBgnDeFmt" value="<c:out value="${exprnApplSearchVO.searchBgnDeFmt}"/>" class="p-input" placeholder="yyyy-mm-dd"/>
                            <div class="p-input__split">
                                <button type="button" class="p-input__item  p-date__icon">달력 열기</button>
                            </div>
                        </div>
                        <span class="p-form__split">~</span>
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchEndDeFmt" id="searchEndDeFmt" class="p-input" value="<c:out value="${exprnApplSearchVO.searchEndDeFmt}"/>" placeholder="yyyy-mm-dd"/>
                            <div class="p-input__split">
                                <button type="button" class="p-input__item  p-date__icon">달력 열기</button>
                            </div>
                        </div>
                    </div>
                </div>
                <label for="" class="p-form__label col-2 right">목록갯수</label>
                <div class="col-2">
                    <form:select path="pageUnit" cssClass="p-input" title="목록수">
                        <form:option value="10">10개씩</form:option>
                        <form:option value="30">30개씩</form:option>
                        <form:option value="50">50개씩</form:option>
                        <form:option value="100">100개씩</form:option>
                        <form:option value="200">200개씩</form:option>
                        <form:option value="500">500개씩</form:option>
                        <form:option value="1000">1000개씩</form:option>
                    </form:select>
                </div>
            </div>

            <div class="p-form-row">
                <label for="" class="p-form__label col-6 right">결제상태</label>
                <div class="col-3">
                    <form:select path="searchPaySttus" cssClass="p-input" title="결제상태">
                        <form:option value="" label="결제상태 선택"/>
                        <c:forEach var="result" items="${paySttusList}">
                            <c:if test="${fn:indexOf(result.code, 'RFND') > -1}">
                                <form:option value="${result.code}" label="${result.codeNm}"/>
                            </c:if>
                        </c:forEach>
                    </form:select>
                </div>
                <label for="" class="p-form__label col-2 right">검색어</label>
                <div class="col-6">
                    <form:input path="searchKrwd" class="p-input" placeholder="예약번호, 신청자명, 단체명 입력"/>
                </div>
                <div class="col-2">
                    <button type="submit" class="p-button p-button--small primary w100p">검색</button>
                </div>
            </div>
        </form:form>
    </div>

    <div class="row">
        <div class="col-12">
			<span class="p-total__number">
				총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong>${paginationInfo.totalRecordCount}</strong></em>건
				&nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]
			</span>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption>체험 신청 환불 목록 - 번호, 운영기관, 체험명, 예약번호, 체험일시, 신청자, 연락처, 결제방식/결제일시/결제금액, 환불요청일시/환불계좌정보, 환불금액, 환불처리일시, 결제상태 등 제공</caption>
        <colgroup>
            <col style="width:100px">
            <col style="width:150px">
            <col />
            <col style="width:180px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:110px">
            <col style="width:150px">
            <col style="width:150px">
            <col style="width:80px">
            <col style="width:100px">
            <col style="width:80px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">운영기관</th>
            <th scope="col">체험명</th>
            <th scope="col">예약번호</th>
            <th scope="col">체험일시</th>
            <th scope="col">신청자</th>
            <th scope="col">연락처</th>
            <th scope="col">결제방식<br/>결제일시<br/>결제금액</th>
            <th scope="col">환불요청일시<br/>환불계좌정보</th>
            <th scope="col">환불금액</th>
            <th scope="col">환불처리일시</th>
            <th scope="col">결제상태</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${exprnApplList}">
            <tr>
                <td>${currentPageStartNo}</td>
                <td>
                    <c:set var="insttNo" value="instt${result.insttNo}"/>
                    <c:out value="${expInsttMap[insttNo]}"/>
                </td>
                <td class="text_left"><c:out value="${result.exprnNm}"/></td>
                <td>
                    <a href="./selectExprnApplView.do?exprnApplNo=<c:out value="${result.exprnApplNo}"/>&amp;<c:out value="${exprnApplSearchVO.params}"/><c:out value="${exprnApplSearchVO.paramsMng}"/><c:out value="${exprnSearchVO.exprnParamsMng}"/>">
                        <c:out value="${result.exprnApplId}"/>
                    </a>
                </td>
                <td>
                    <c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/><br/>
                    <c:out value="${tsu:toDateFormat(result.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(result.exprnEndHm, 'HHmm', 'HH:mm')}"/>
                </td>
                <td><c:out value="${result.applNm}"/></td>
                <td>
                    <c:out value="${result.mobileNo1}"/>-<c:out value="${result.mobileNo2}"/>-<c:out value="${result.mobileNo3}"/>
                </td>
                <td>
                    <c:out value="${payMthdMap[result.payMthdCd]}"/>
                    <c:if test="${result.payMthdCd == 'ELCTRN' && !empty result.tossMethod}">(<c:out value="${result.tossMethod}"/>)</c:if><br/>
                    <c:out value="${tsu:toDateFormat(result.payDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/><br/>
                    <fmt:formatNumber value="${result.totalPayAmt}" pattern="#,##0"/> 원
                </td>
                <td>
                    <c:out value="${tsu:toDateFormat(result.rfndReqDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                    <c:if test="${!(result.payMthdCd == 'ELCTRN' && result.tossMethod != '가상계좌')}">
                        <br/>
                        <c:out value="${bankMap[result.rfndBankNm]}"/><br>
                        <c:out value="${result.rfndAcctNo}"/><br>
                        (예금주 : <c:out value="${result.rfndDpstrNm}"/>)
                    </c:if>
                </td>
                <td><fmt:formatNumber value="${result.rfndAmt}" pattern="#,##0"/> 원</td>
                <td>
                    <c:out value="${tsu:toDateFormat(result.rfndCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd')}"/><br>
                    <c:out value="${tsu:toDateFormat(result.rfndCmplDt, 'yyyyMMddHHmmss', 'HH:mm:ss')}"/>
                </td>
                <td>
                    <c:out value="${paySttusMap[result.paySttusCd]}"/>
                    <c:if test="${result.paySttusCd == 'RFND_REQ'}">
                        <c:if test="${result.payMthdCd == 'ELCTRN' && !empty result.tossMethod}">
                            <a href="" class="p-button p-button--small restore" onclick="fn_exprnApplRfndToss('<c:out value="${result.exprnApplNo}"/>', <c:out value="${result.insttNo}"/>, '<c:out value="${result.tossPaymentKey}"/>'); return false;">환불처리</a>
                        </c:if>
                        <c:if test="${result.payMthdCd == 'NBKRCP' || result.payMthdCd == 'DIRECT'}">
                            <a href="" class="p-button p-button--small restore" onclick="fn_exprnApplRfnd('<c:out value="${result.exprnApplNo}"/>', <c:out value="${result.insttNo}"/>); return false;">환불처리</a>
                        </c:if>
                    </c:if>
                </td>
            </tr>
            <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(exprnApplList) eq 0}">
            <tr>
                <td colspan="13">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="row">
        <div class="col-6">
        </div>
        <div class="col-12 center">
            <div class="p-pagination">
                <div class="p-page">
                    <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectExprnRfndList.do?${exprnApplSearchVO.paramsExclPi}${exprnApplSearchVO.paramsMng}&amp;pageIndex=" />
                </div>
            </div>
        </div>
        <div class="col-6 right">
            <button type="button" class="p-button p-button--combine excel excel-modal">엑셀다운로드</button>
        </div>
    </div>

    <div class="modal" id="excel-default-modal" tabindex="0" role="dialog">
        <div class="modal__body">
            <div class="modal__header">
                <div class="modal__title">개인정보 다운로드 사유 입력</div>
            </div>
            <div class="modal__content">
                개인정보보호법에 따라 개인정보가 포함된 자료를 다운로드할 경우 사용목적을 명시해야 합니다. <br>개인정보가 수록된 자료를 다운로드할 경우 취급 및 관리에 유의하여 주십시오.
                <div class="col-24 margin_t_5">
                    <textarea id="dwldResnFmt" placeholder="개인정보 다운로드 사유 입력은 최소 10글자 이상 입력해야만 합니다." class="p-input" cols="80" rows="5" required="required" minlength="10" maxlength="100" style="height: 100px"></textarea>
                </div>
            </div>
            <div class="modal__footer">
                <a href="./downloadExprnRfndXls.do" class="p-button primary" onclick="fn_chkExcel(this.href); return false;">엑셀 다운로드</a>
                <button type="button" class="p-button default" data-close="modal">닫기</button>
            </div>
            <div class="modal__close">
                <button type="button" data-close="modal" class="modal__close-button">
                    <span>닫기</span>
                </button>
            </div>
        </div>
    </div>
</div>

<script>

    function fn_exprnApplRfndToss(exprnApplNo, insttNo, tossPaymentKey) {

        if (!confirm("환불처리하시겠습니까?")) {
            return false;
        }

        $.ajax({
            cache: false,
            url: '/tosspaymentsCancel.do',
            type: 'POST',
            data: {
                applNo: exprnApplNo,
                insttNo: insttNo,
                prgSe: 'EXP',
                paymentKey: tossPaymentKey
            },
            success: function (res) {
                if (res == 1) {
                    alert("환불처리가 완료되었습니다.");
                } else if (res == 0) {
                    alert("토스페이먼츠 환불처리는 되었으나 상태값 변경 처리 중 오류가 발생했습니다.");
                } else if (res == -1) {
                    alert("프로그램구분 정보를 확인할 수 없습니다.");
                } else if (res == -2) {
                    alert("신청 고유번호 정보를 확인할 수 없습니다.");
                } else if (res == -3) {
                    alert("신청 정보를 확인할 수 없습니다.");
                } else if (res == -999) {
                    alert("토스페이먼츠 환불 요청 중 오류가 발생했습니다.");
                } else {
                    alert("처리 중 오류가 발생했습니다.");
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
    }

    function fn_exprnApplRfnd(exprnApplNo, insttNo) {

        if (!confirm("환불처리하시겠습니까?")) {
            return false;
        }

        $.ajax({
            cache: false,
            url: './updateExprnApplRfndInfoAjax.do',
            type: 'POST',
            data: {
                exprnApplNo: exprnApplNo,
                insttNo: insttNo,
                paySttusCd: 'RFND_CMPL'
            },
            success: function (res) {
                if (res == 1) {
                    alert("환불처리가 완료되었습니다.");
                } else {
                    alert("처리된 내역이 없습니다.");
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
    }

    function fn_searchExprnApplCheck(form) {

        if(form.searchBgnDeFmt.value &&form.searchEndDeFmt.value ) {

            var regexDate = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);

            if (!form.searchBgnDeFmt.value || !form.searchEndDeFmt.value) {

                alert("기간을 조회하시는 경우 시작일자와 종료일자를 확인해주세요.");

                if (!form.searchBgnDeFmt.value) {
                    form.searchBgnDeFmt.focus();
                    return false;
                }

                if (!form.searchEndDeFmt.value) {
                    form.searchEndDeFmt.focus();
                    return false;
                }
            } else {

                if (!regexDate.test(form.searchBgnDeFmt.value)) {
                    alert("날짜는 yyyy-MM-dd 형식으로 입력해주세요.");
                    form.searchBgnDeFmt.focus();
                    return false;
                }

                if (!regexDate.test(form.searchEndDeFmt.value)) {
                    alert("날짜는 yyyy-MM-dd 형식으로 입력해주세요.");
                    form.searchEndDeFmt.focus();
                    return false;
                }

                var searchBgnDe = form.searchBgnDeFmt.value;
                var searchEndDe = form.searchEndDeFmt.value;

                if (searchBgnDe > searchEndDe) {
                    alert('시작일자가 종료일자보다 클 수 없습니다.');
                    form.searchBgnDeFmt.focus();
                    return false;
                }

                const s = new Date(
                    searchBgnDe.substring(0,4),
                    searchBgnDe.substring(5,7) - 1,
                    searchBgnDe.substring(8,10)
                );

                const e = new Date(
                    searchEndDe.substring(0,4),
                    searchEndDe.substring(5,7) - 1,
                    searchEndDe.substring(8,10)
                );

                // 시작일 + 1년
                const sPlus1Year = new Date(s);
                sPlus1Year.setFullYear(s.getFullYear() + 1);

                if (sPlus1Year.getTime() < e.getTime()) {
                    alert('기간 조회는 최대 1년까지 가능합니다.');
                    form.searchBgnDeFmt.focus();
                    return false;
                }
            }
        }
        return true;
    }

    function fn_downloadExprnApplXls(url) {
        const $form = $('#exprnApplSearchVO');
        var originUrl = $form.attr("action");
        $form.attr("action",url);

        $form.submit();
        $form.attr("action",originUrl);
    }

    $(".excel-modal").on("click", function () {
        <c:if test="${fn:length(exprnApplList) eq 0}">
        alert('다운로드 할 목록이 없습니다.');
        </c:if>
        <c:if test="${fn:length(exprnApplList) > 0}">
        $('textarea[name=dwldResn]').val('');
        $('#dwldResnFmt').val('');
        $(this).modalPop({
            target: "#excel-default-modal",
            width: "600",
            height: "200",
            backdrop: true,
            keyboard: false
        });
        </c:if>
    });

    function fn_chkExcel(url) {

        if (!$('#dwldResnFmt').val()) {
            alert("문자 내용을 입력해주세요.");
            $('#dwldResnFmt').focus();
            return false;
        }

        if ($('#dwldResnFmt').val().length < 10) {
            alert("개인정보 다운로드 사유 입력은 최소 10글자 이상 입력해야만 합니다.");
            $('#dwldResnFmt').focus();
            return false;
        }

        if (confirm('엑셀을 다운로드 하시겠습니까?')) {
            $('#excel-default-modal').hide();
            $('textarea[name=dwldResn]').val($('#dwldResnFmt').val());
            fn_downloadExprnApplXls(url);
        } else {
            return false;
        }
    }

</script>

</body>
</html>
