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
    <title>${menuInfo.cntntsNm} 목록</title>
</head>
<body>

<div class="p-wrap">

    <div class="card card--line margin_b_30">
        <h3>체험 정보</h3>
        <table class="p-table margin_b_20">
            <caption>체험 정보 - 제목, 기관명, 접수기간, 체험기간, 내용, 첨부파일 정보 제공</caption>
            <colgroup>
                <col class="w15p" />
                <col />
                <col class="w15p" />
                <col />
            </colgroup>
            <tbody class="p-table--th-left">
            <tr class="p-table__subject">
                <th scope="row">체험명</th>
                <td colspan="3">
                    <span class="p-table__subject_text"><c:out value="${exprnVO.exprnNm}"/></span>
                </td>
            </tr>
            <tr>
                <th scope="row">운영기관</th>
                <td colspan="3">
                    <c:set var="insttNo" value="instt${exprnVO.insttNo}"/>
                    <c:out value="${expInsttMap[insttNo]}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">모집상태</th>
                <td><c:out value="${operSttusMap[exprnVO.operSttus]}"/></td>
                <th scope="row">신청/모집정원</th>
                <td colspan="3">
                    <c:out value="${exprnVO.totResveCnt}/${exprnVO.totRcritCnt}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">접수기간</th>
                <td><c:out value="${exprnVO.rcptBgnDe}"/> <c:out value="${exprnVO.rcptBgnHh}"/>:<c:out value="${exprnVO.rcptBgnMm}"/>
                     ~
                    <c:out value="${exprnVO.rcptEndDe}"/> <c:out value="${exprnVO.rcptEndHh}"/>:<c:out value="${exprnVO.rcptEndMm}"/>
                </td>
                <th scope="row">체험기간</th>
                <td>
                    <c:out value="${tsu:toDateFormat(exprnVO.exprnMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                     ~
                    <c:out value="${tsu:toDateFormat(exprnVO.exprnMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">선발방식</th>
                <td><c:out value="${slctMthdMap[exprnVO.slctMthdCd]}"/></td>
                <th scope="row">체험료 / 결제방식</th>
                <td>
                    <c:choose>
                        <c:when test="${exprnVO.exprnAmt > 0}">
                            <fmt:formatNumber value="${tsu:xssNumberFilter(exprnVO.exprnAmt)}" pattern="#,###"/> 원
                        </c:when>
                        <c:otherwise>
                            무료
                        </c:otherwise>
                    </c:choose>
                     /
                    <c:forEach var="result" items="${exprnVO.payMthdCdArr}" varStatus="status">
                        <c:out value="${payMthdMap[result]}"/>
                        <c:if test="${result == 'NBKRCP'}">
                            [<c:out value="${exprnVO.bankNm}"/> <c:out value="${exprnVO.acctNo}"/> (예금주:<c:out value="${exprnVO.dpstrNm}"/>)]
                        </c:if>
                        <c:if test="${!status.last}">, </c:if>
                    </c:forEach>
                </td>
            </tr>
            <tr>
            </tr>
            </tbody>
        </table>
    </div>

    <h3>신청자 목록</h3>
    <div class="row margin_b_5">
        <div class="col-12">
			<span class="p-total__number">
				총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong>${paginationInfo.totalRecordCount}</strong></em>건
				&nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]
			</span>
        </div>

        <div class="col-12 right">
            <form:form modelAttribute="exprnApplSearchVO" name="exprnApplSearchVO" method="get" class="p-form-inline">
                <form:hidden path="key"/>
                <form:hidden path="exprnNo"/>
                <c:forEach var="result" items="${exprnSearchVO.paramsMapMng}">
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
                <input type="text" name="searchKrwd" id="searchKrwd" class="p-input" title="" value="<c:out value="${exprnApplSearchVO.searchKrwd}"/>" placeholder="검색단어 입력">
                <button type="submit" class="p-button p-button--small primary">검색</button>
            </form:form>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption>체험 신청 목록 - 번호, 예약번호, 신청자, 생년월일, 성별, 연락처, 신청일시, 개인/단체 여부, 인원, 체험일자, 결제상태, 예약상태 등 제공</caption>
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
            <col style="width:50px">
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
            <th scope="col">신청일시</th>
            <th scope="col">개인/단체</th>
            <th scope="col">인원</th>
            <th scope="col">체험일자</th>
            <th scope="col">거주지</th>
            <th scope="col">예약상태</th>
            <th scope="col">결제상태</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${exprnApplList}">
            <tr>
                <td class="p-table__checkbox">
                    <span class="p-form-checkbox p-form-checkbox--single">
                        <input type="checkbox" name="exprnApplNoArr" id="exprnApplNo<c:out value="${result.exprnApplNo}"/>" class="p-form-checkbox__input" value="<c:out value="${result.exprnApplNo}"/>" data-receiver-no="<c:out value="${result.mobileNo}"/>">
                        <label for="exprnApplNo<c:out value="${result.exprnApplNo}"/>" class="p-form-checkbox__label">체험 신청 <c:out value="${result.exprnApplNo}"/>번 </label>
                    </span>
                </td>
                <td>${currentPageStartNo}</td>
                <td>
                    <a href="./selectExprnApplView.do?exprnApplNo=<c:out value="${result.exprnApplNo}"/>&amp;<c:out value="${exprnApplSearchVO.params}"/><c:out value="${exprnApplSearchVO.paramsMng}"/>&amp;<c:out value="${exprnSearchVO.exprnParamsMng}"/>&amp;isExprnList=Y">
                        <c:out value="${result.exprnApplId}"/>
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
                    <c:out value="${tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSS', 'yyyy-MM-dd')}"/><br/>
                    <c:out value="${tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSS', 'HH:mm:ss:SS')}"/>
                </td>
                <td>
                    <c:if test="${result.nmprSeCd == 'IND'}">개인</c:if>
                    <c:if test="${result.nmprSeCd == 'GRP'}">단체(<c:out value="${result.grpNm}"/>)</c:if>
                </td>
                <td><c:out value="${result.totalCnt}"/></td>
                <td>
                    <c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/><br/>
                    <c:out value="${tsu:toDateFormat(result.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(result.exprnEndHm, 'HHmm', 'HH:mm')}"/>
                </td>
                <td><c:out value="${lgldongMap[result.resInqCd]}"/></td>
                <td><c:out value="${rsvSttusMap[result.rsvSttusCd]}"/></td>
                <td>
                    <%--TODOSDB: 감면관련 상태값 추가--%>
                    <c:out value="${paySttusMap[result.paySttusCd]}"/>
                    <c:if test="${result.rsvSttusCd == 'APPL_CMPL' && result.paySttusCd == 'PAY_WAIT'}">
                        <br/><c:out value="${tsu:toDateFormat(result.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd')}"/>
                        <br/><c:out value="${tsu:toDateFormat(result.payDeadlineDt, 'yyyyMMddHHmmss', 'HH:mm:ss')}"/>
                    </c:if>
                </td>
                <td><a href="./updateExprnApplView.do?exprnApplNo=<c:out value="${result.exprnApplNo}"/>&amp;<c:out value="${exprnApplSearchVO.params}"/>&amp;<c:out value="${exprnApplSearchVO.paramsMng}"/>&amp;<c:out value="${exprnSearchVO.exprnParamsMng}"/>&isExprnList=Y" class="p-button p-button--small edit">수정</a></td>
            </tr>
            <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(exprnApplList) eq 0}">
            <tr>
                <td colspan="15">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="row">
        <div class="col-6 left">
            <a href="./selectExprnList.do?<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button cancel">체험 목록</a>
        </div>
        <div class="col-12 center">
            <div class="p-pagination">
                <div class="p-page">
                    <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectExprnApplListByExprn.do?exprnNo=${exprnVO.exprnNo}&amp;${exprnApplSearchVO.paramsExclPi}${exprnApplSearchVO.paramsMng}&amp;pageIndex=" />
                </div>
            </div>
        </div>
        <div class="col-6 right">
            <button type="button" class="p-button primary" id="sms-modal-button">선택SMS발송</button>
            <a href="./downloadExprnApplXls.do" class="p-button p-button--combine excel" onclick="fn_downloadExprnApplXls(this.href); return false;">엑셀다운로드</a>
            <c:if test="${fn:contains(exprnVO.rcptMthdCd, 'TLPHN') || fn:contains(exprnVO.rcptMthdCd, 'VISIT')}">
                <a href="./addExprnApplView.do?exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;<c:out value="${exprnApplSearchVO.params}"/><c:out value="${exprnApplSearchVO.paramsMng}"/>" class="p-button write">등록</a>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class="col-7 left">
            <button type="button" class="p-button darken" onclick="fn_exprnApplNoCheckAll()">전체선택</button>
            <select name="paySttus" id="" class="p-input p-input--auto">
                <option value="">결제상태</option>
                <c:forEach var="result" items="${paySttusList}">
                    <option value="<c:out value="${result.code}"/>"><c:out value="${result.codeNm}"/></option>
                </c:forEach>
            </select>
            <button type="button" class="p-button edit" onclick="fn_exprnApplPaySttusChange()">변경</button>
            <select name="rsvSttus" id="" class="p-input p-input--auto">
                <option value="">예약상태</option>
                <c:forEach var="result" items="${rsvSttusList}">
                    <option value="<c:out value="${result.code}"/>"><c:out value="${result.codeNm}"/></option>
                </c:forEach>
            </select>
            <button type="button" class="p-button edit" onclick="fn_exprnApplRsvSttusChange()">변경</button>
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
</div>

<script>

    function fn_exprnApplNoCheckAll() {
        var chkAt = $('input[type=checkbox][name=exprnApplNoArr]').is(":checked");

        if (chkAt) {
            $('input[type=checkbox][name=exprnApplNoArr]').prop('checked', false);
        } else {
            $('input[type=checkbox][name=exprnApplNoArr]').prop('checked', true);
        }
    }

    function fn_exprnApplRsvSttusChange() {
        var chkAt = $('input[name=exprnApplNoArr]').is(":checked");
        var exprnApplNoParam = [];
        $('input[name=exprnApplNoArr]:checked').each(function() {
            exprnApplNoParam.push($(this).val());
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
                url: './updateExprnApplRsvSttusAjax.do',
                type: 'POST',
                data: {
                    exprnApplNoArr: exprnApplNoParam,
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
            alert("체험 신청 번호를 선택해주세요.");
            return false;
        }
    }

    function fn_exprnApplPaySttusChange() {
        var chkAt = $('input[name=exprnApplNoArr]').is(":checked");
        var exprnApplNoParam = [];
        $('input[name=exprnApplNoArr]:checked').each(function() {
            exprnApplNoParam.push($(this).val());
        });

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
                url: './updateExprnApplPaySttusAjax.do',
                type: 'POST',
                data: {
                    exprnApplNoArr: exprnApplNoParam,
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
            alert("체험 신청 번호를 선택해주세요.");
            return false;
        }
    }

    function fn_downloadExprnApplXls(url) {
        const $form = $('#exprnApplSearchVO');
        var originUrl = $form.attr("action");
        $form.attr("action",url);

        $form.submit();
        $form.attr("action",originUrl);
    }

    var receiverNoParam = [];
    $("#sms-modal-button").on("click", function () {

        var chkAt = $('input[name=exprnApplNoArr]').is(":checked");

        if (!chkAt) {
            alert('문자 전송할 대상자를 선택하세요.')
            return false;
        }
        receiverNoParam = [];
        $('#senderNo').val('');
        $('#smsContents').val('');
        $('input[name=exprnApplNoArr]:checked').each(function () {
            var receiverNo = $(this).data("receiverNo");
            receiverNoParam.push(receiverNo);
        });
        console.log("receiverNoParam", receiverNoParam);
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

</script>

</body>
</html>
