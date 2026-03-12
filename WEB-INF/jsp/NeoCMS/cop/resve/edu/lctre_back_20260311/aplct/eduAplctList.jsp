<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>신청자 관리 목록</title>
    <link rel="stylesheet" type="text/css" href="/common/js/jquery-ui-1.12.1/jquery-ui.css"/>
    <script type="text/javascript" src="/common/js/jquery-ui-1.12.1/jquery-ui.min.js" nonce="NEOCMSSCRIPT"></script>
</head>
<body>

<div class="p-wrap">
    <div class="card">
        <form id="searchListFrm" method="get" action="/${menuInfo.siteId}/selectEduAplctList.do">
            <input type="hidden" name="key" value="${key}"/>
            <input type="hidden" name="prgSe" value="EDU"/>
            <div class="p-form-row">
                <label for="searchInsttNo" class="p-form__label col-2 right">운영기관</label>
                <div class="col-3">
                    <select id="searchInsttNo" name="searchInsttNo" class="p-input"
                            onchange="insttIdChange(this.value)">
                        <option value="">운영기관 선택</option>
                        <c:forEach var="instt" items="${eduInsttList}">
                            <option value="${instt.insttNo}"${instt.insttNo eq eduAplctVO.searchInsttNo ? ' selected="true"':''}>
                                <c:out value="${instt.insttNm}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <label for="searchCtgryNo" class="p-form__label col-2 right">카테고리</label>
                <div class="col-3">
                    <select id="searchCtgryNo" name="searchCtgryNo" class="p-input"
                            onchange="ctgryIdChange(this.value)">
                        <option value="">카테고리 선택</option>
                        <%-- 기관 선택 시에만 카테고리 표시 (JavaScript로 동적 로딩) --%>
                    </select>
                </div>
                <label for="searchOperYear" class="p-form__label col-2 right">교육년도</label>
                <div class="col-2">
                    <select id="searchOperYear" name="searchOperYear" class="p-input">
                        <option value="">년도 선택</option>
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear"/>
                        <c:forEach var="i" begin="0" end="5">
                            <option value="${currentYear + i}"${eduAplctVO.searchOperYear eq (currentYear + i) ? ' selected="true"':''}>${currentYear + i}</option>
                        </c:forEach>
                    </select>
                </div>
                <label for="searchSubjectNo" class="p-form__label col-1 right">과목</label>
                <div class="col-3">
                    <select id="searchSubjectNo" name="searchSubjectNo" class="p-input">
                        <option value="">과목 선택</option>
                        <%-- 카테고리 선택 시에만 과목 표시 (JavaScript로 동적 로딩) --%>
                    </select>
                </div>
            </div>

            <div class="p-form-row">
                <label for="searchPeriodType" class="p-form__label col-2 right">기간 조회</label>
                <div class="col-2">
                    <select id="searchPeriodType" name="searchPeriodType" class="p-input" title="기간 항목 선택">
                        <option value="">기간 선택</option>
                        <option value="RCPT"${eduAplctVO.searchPeriodType eq 'RCPT' ? ' selected="true"':''}>접수기간
                        </option>
                        <option value="LCT"${eduAplctVO.searchPeriodType eq 'LCT' ? ' selected="true"':''}>교육기간</option>
                    </select>
                </div>
                <div class="col-4">
                    <div class="p-date-group">
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchBgnDe" id="searchBgnDe"
                                   value="<c:if test='${not empty eduAplctVO.searchBgnDe}'><c:out value='${tsu:toDateFormat(eduAplctVO.searchBgnDe, \"yyyyMMdd\", \"yyyy-MM-dd\")}'/></c:if>"
                                   class="p-input"
                                   placeholder="yyyy-mm-dd" readonly/>
                            <div class="p-input__split">
                                <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                            </div>
                        </div>
                        <span class="p-form__split">~</span>
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchEndDe" id="searchEndDe" class="p-input"
                                   value="<c:if test='${not empty eduAplctVO.searchEndDe}'><c:out value='${tsu:toDateFormat(eduAplctVO.searchEndDe, \"yyyyMMdd\", \"yyyy-MM-dd\")}'/></c:if>"
                                   placeholder="yyyy-mm-dd"
                                   readonly/>
                            <div class="p-input__split">
                                <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                            </div>
                        </div>
                    </div>
                </div>

                <label for="pageUnit" class="p-form__label col-2 right">목록갯수</label>
                <div class="col-2">
                    <select id="pageUnit" name="pageUnit" class="p-input">
                        <option value="50"${empty eduAplctVO.pageUnit or eduAplctVO.pageUnit eq 50 ? ' selected':''}>
                            50개씩
                        </option>
                        <option value="100"${eduAplctVO.pageUnit eq 100 ? ' selected':''}>100개씩</option>
                        <option value="200"${eduAplctVO.pageUnit eq 200 ? ' selected':''}>200개씩</option>
                        <option value="500"${eduAplctVO.pageUnit eq 500 ? ' selected':''}>500개씩</option>
                        <option value="1000"${eduAplctVO.pageUnit eq 1000 ? ' selected':''}>1000개씩</option>
                    </select>
                </div>
            </div>

            <div class="p-form-row">
                <label for="searchResveSttusCd" class="p-form__label col-2 right">예약상태</label>
                <div class="col-3">
                    <select id="searchResveSttusCd" name="searchResveSttusCd" class="p-input">
                        <option value="">전체</option>
                        <c:forEach var="item" items="${resveSttusCdList}">
                            <option value="${item.code}"${eduAplctVO.searchResveSttusCd eq item.code ? ' selected="true"':''}>
                                <c:out value="${item.codeNm}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <label for="searchPaySttusCd" class="p-form__label col-2 right">결제상태</label>
                <div class="col-3">
                    <select id="searchPaySttusCd" name="searchPaySttusCd" class="p-input">
                        <option value="">전체</option>
                        <c:forEach var="item" items="${paySttusCdList}">
                            <option value="${item.code}"${eduAplctVO.searchPaySttusCd eq item.code ? ' selected="true"':''}>
                                <c:out value="${item.codeNm}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <label for="searchApplNm" class="p-form__label col-2 right">검색어</label>
                <div class="col-4">
                    <input id="searchApplNm" name="searchApplNm" value="${eduAplctVO.searchApplNm}" class="p-input"
                           placeholder="신청자명 입력"/>
                </div>
                <div class="col-2">
                    <button type="submit" class="p-button p-button--small primary w100p">검색</button>
                </div>
            </div>
        </form>
    </div>

    <div class="col-6">
		<span class="p-total__number">
			총 <em class="em_black" data-mask="#,##0"
                  data-mask-reverse="true"><strong><c:out value="${paginationInfo.totalRecordCount}"/></strong></em>건
			&nbsp;[ <em class="em_b_black"><c:out value="${paginationInfo.currentPageNo}"/></em>/<c:out value="${paginationInfo.totalPageCount}"/> 페이지 ]
		</span>
    </div>

    <table class="p-table p-table--bordered">
        <colgroup>
            <col style="width: 10px">
            <col style="width: 50px">
            <col style="width: 100px">
            <col style="width: 120px">
            <col style="width: 180px">
            <col style="width: 160px">
            <col style="width: 160px">
            <col style="width: 80px">
            <col style="width: 80px">
            <col style="width: 130px">
            <col style="width: 100px">
            <col style="width: 100px">
            <col style="width: 150px">
            <col style="width: 100px">
            <col style="width: 100px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">
                <input type="checkbox" id="checkAll" name="checkAll" class="allCheck" title="전체선택"/>
            </th>
            <th scope="col">번호</th>
            <th scope="col">예약번호</th>
            <th scope="col">운영기관</th>
            <th scope="col">강좌명</th>
            <th scope="col">접수기간</th>
            <th scope="col">교육기간</th>
            <th scope="col">신청자명</th>
            <th scope="col">생년월일</th>
            <th scope="col">연락처</th>
            <th scope="col">예약상태</th>
            <th scope="col">신청일시</th>
            <th scope="col">결제상태 (결제수단)<br/>결제기한</th>
            <th scope="col">수료여부</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="pageNo" value="${paginationInfo.currentPageStartNo}"/>
        <c:forEach var="result" items="${eduAplctList}" varStatus="status">
            <tr class="colored">
                <td>
                    <input type="checkbox" name="chk" value="${result.eduAplyNo}"/>
                </td>
                <td><c:out value="${pageNo}"/></td>
                <td><c:out value="${result.eduRsvtNo}"/></td>
                <td><c:out value="${result.insttNm}"/></td>
                <td class="text_left"><c:out value="${result.lctreNm}"/></td>
                <td>
                    <%-- 접수기간 --%>
                    <c:if test="${not empty result.rcptBgnDt && fn:length(result.rcptBgnDt) >= 8}">
                        <c:set var="rcptBgnDe" value="${fn:substring(result.rcptBgnDt, 0, 8)}"/>
                        ${fn:substring(rcptBgnDe, 0, 4)}-${fn:substring(rcptBgnDe, 4, 6)}-${fn:substring(rcptBgnDe, 6, 8)}
                    </c:if>
                    ~
                    <c:if test="${not empty result.rcptEndDt && fn:length(result.rcptEndDt) >= 8}">
                        <c:set var="rcptEndDe" value="${fn:substring(result.rcptEndDt, 0, 8)}"/>
                        ${fn:substring(rcptEndDe, 0, 4)}-${fn:substring(rcptEndDe, 4, 6)}-${fn:substring(rcptEndDe, 6, 8)}
                    </c:if><br/>
                    <c:if test="${not empty result.rcptBgnDt && fn:length(result.rcptBgnDt) >= 12}">
                        <c:set var="rcptBgnHm" value="${fn:substring(result.rcptBgnDt, 8, 12)}"/>
                        <c:out value="${tsu:toDateFormat(rcptBgnHm, 'HHmm', 'HH:mm')}"/>
                    </c:if>
                    ~
                    <c:if test="${not empty result.rcptEndDt && fn:length(result.rcptEndDt) >= 12}">
                        <c:set var="rcptEndHm" value="${fn:substring(result.rcptEndDt, 8, 12)}"/>
                        <c:out value="${tsu:toDateFormat(rcptEndHm, 'HHmm', 'HH:mm')}"/>
                    </c:if>
                </td>
                <td>
                    <%-- 교육기간 --%>
                    <c:if test="${not empty result.lctBgnDt && fn:length(result.lctBgnDt) >= 8}">
                        <c:set var="lctBgnDe" value="${fn:substring(result.lctBgnDt, 0, 8)}"/>
                        ${fn:substring(lctBgnDe, 0, 4)}-${fn:substring(lctBgnDe, 4, 6)}-${fn:substring(lctBgnDe, 6, 8)}
                    </c:if>
                    ~
                    <c:if test="${not empty result.lctEndDt && fn:length(result.lctEndDt) >= 8}">
                        <c:set var="lctEndDe" value="${fn:substring(result.lctEndDt, 0, 8)}"/>
                        ${fn:substring(lctEndDe, 0, 4)}-${fn:substring(lctEndDe, 4, 6)}-${fn:substring(lctEndDe, 6, 8)}
                    </c:if><br/>
                    <c:if test="${not empty result.lctBgnDt && fn:length(result.lctBgnDt) >= 12}">
                        <c:set var="lctBgnHm" value="${fn:substring(result.lctBgnDt, 8, 12)}"/>
                        <c:out value="${tsu:toDateFormat(lctBgnHm, 'HHmm', 'HH:mm')}"/>
                    </c:if>
                    ~
                    <c:if test="${not empty result.lctEndDt && fn:length(result.lctEndDt) >= 12}">
                        <c:set var="lctEndHm" value="${fn:substring(result.lctEndDt, 8, 12)}"/>
                        <c:out value="${tsu:toDateFormat(lctEndHm, 'HHmm', 'HH:mm')}"/>
                    </c:if>
                </td>
                <td><c:out value="${result.applNm}"/></td>
                <td>
                    <%-- 생년월일 포맷 (YYYY.MM.DD) --%>
                    <c:if test="${not empty result.birthDe && fn:length(result.birthDe) == 8}">
                        ${fn:substring(result.birthDe, 0, 4)}.${fn:substring(result.birthDe, 4, 6)}.${fn:substring(result.birthDe, 6, 8)}
                    </c:if>
                </td>
                <td>
                    <%-- 연락처 포맷 (010-1234-5678) --%>
                    <c:if test="${not empty result.telNo && fn:length(result.telNo) == 11}">
                        ${fn:substring(result.telNo, 0, 3)}-${fn:substring(result.telNo, 3, 7)}-${fn:substring(result.telNo, 7, 11)}
                    </c:if>
                    <c:if test="${empty result.telNo or fn:length(result.telNo) != 11}">
                        <c:out value="${result.telNo}"/>
                    </c:if>
                </td>
                <td>
                    <c:out value="${resveSttusCdMap[result.resveSttusCd]}"/>
                    <c:if test="${not empty result.drwtWinYn}">
                        <br/>추첨완료
                        <c:if test="${result.drwtWinYn eq 'Y'}">
                            <span class="em_blue">(당첨)</span>
                        </c:if>
                        <c:if test="${result.drwtWinYn eq 'N'}">
                            <span class="em_gray">(미당첨)</span>
                        </c:if>
                    </c:if>
                </td>
                <td>
                    <c:if test="${not empty result.applDtMs && fn:length(result.applDtMs) >= 14}">
                        <c:set var="applDe" value="${fn:substring(result.applDtMs, 0, 8)}"/>
                        <c:set var="applHm" value="${fn:substring(result.applDtMs, 8, 12)}"/>
                        <c:set var="applSs" value="${fn:substring(result.applDtMs, 12, 14)}"/>
                        ${fn:substring(applDe, 0, 4)}-${fn:substring(applDe, 4, 6)}-${fn:substring(applDe, 6, 8)}<br/>
                        ${fn:substring(applHm, 0, 2)}:${fn:substring(applHm, 2, 4)}.${applSs}
                    </c:if>
                </td>
                <td>
                    <c:out value="${paySttusCdMap[result.paySttusCd]}"/>
                    <%-- 결제수단 표시 --%>
                    <c:if test="${not empty result.payMthdCd}">
                        (<c:out value="${payMthdMap[result.payMthdCd]}"/>)
                    </c:if>
                    <%-- 결제기한 표시 (전자결제이고 결제대기 상태일 때만) --%>
                    <c:if test="${result.payMthdCd == 'ELCTRN' && result.paySttusCd == 'PAY_WAIT' && not empty result.payDeadlineDtHm}">
                        <br/><c:out value="${tsu:toDateFormat(result.payDeadlineDtHm, 'yyyyMMddHHmm', 'yyyy-MM-dd')}"/>
                        <c:out value="${tsu:toDateFormat(result.payDeadlineDtHm, 'yyyyMMddHHmm', 'HH:mm')}"/>
                    </c:if>
                </td>
                <td>
                    <%-- 수료여부 --%>
                    <c:choose>
                        <c:when test="${result.fnshYn eq 'Y'}">수료</c:when>
                        <c:when test="${result.fnshYn eq 'N'}">미수료</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="./updateEduAplctView.do?eduAplyNo=${result.eduAplyNo}&amp;insttNo=${result.insttNo}&amp;referer=list&amp;<c:out value="${eduAplctVO.params}"/>"
                       class="p-button p-button--xsmall edit">수정</a>
                    <%--<a href="./deleteEduAplct.do?eduAplyNo=${result.eduAplyNo}&amp;referer=list&amp;<c:out value="${eduAplctVO.params}"/>"
                       onclick="fn_delete(this.href); return false;" class="p-button p-button--xsmall delete">삭제</a>--%>
                </td>
            </tr>
            <c:set var="pageNo" value="${pageNo-1}"/>
        </c:forEach>
        <c:if test="${fn:length(eduAplctList) == 0}">
            <tr>
                <td colspan="15" class="empty">등록된 정보가 없습니다</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <div class="row">
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
            <div class="p-pagination">
                <div class="p-page">
                    <ui:pagination paginationInfo="${paginationInfo}" type="board"
                                   jsFunction="./selectEduAplctList.do?${fn:escapeXml(eduAplctVO.paramsExclPi)}&amp;pageIndex="/>
                </div>
            </div>
        </div>
        <div class="col-8 right">
            <button type="button" class="p-button p-button--combine excel excel-modal">엑셀다운로드</button>
        </div>
    </div>

</div>

<!-- 엑셀 다운로드 사유 입력 모달 -->
<div class="modal" id="excel-default-modal" tabindex="0" role="dialog">
    <div class="modal__body">
        <div class="modal__header">
            <div class="modal__title">개인정보 다운로드 사유 입력</div>
        </div>
        <form name="excelDownloadFrm" id="excelDownloadFrm" method="post" action="./downloadEduAplctListByEdu.do?<c:out value="${eduAplctVO.paramsExclPi}"/>" onsubmit="return fn_chkExcel();">
            <fieldset>
                <legend>엑셀 다운로드</legend>
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
    </div>
</div>

<script nonce="NEOCMSSCRIPT">
    // 엑셀다운로드 모달 열기
    $(".excel-modal").on("click", function () {
<c:if test="${fn:length(eduAplctList) eq 0}">
    alert('다운로드 할 목록이 없습니다.');
</c:if>
<c:if test="${fn:length(eduAplctList) > 0}">
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
            // 모달 닫기
            $('#excel-default-modal button[data-close="modal"]').first().trigger('click');
            return true;
        } else {
            return false;
        }
    }

    // 기관명 선택 이벤트 - 카테고리 동적 로딩
    function insttIdChange(val) {
        var isVal = false;
        var selectedCtgryNo = $('#searchCtgryNo').data('preservedValue') || '';
        $('#searchCtgryNo').empty();
        $('#searchCtgryNo').append('<option value="">카테고리 선택</option>');
        <c:forEach var="result" items="${eduCategoryList}">
        if (val == "${result.insttNo}") {
            var isSelected = (selectedCtgryNo == "${result.ctgryNo}") ? ' selected' : '';
            var option = $("<option value=\"${result.ctgryNo}\"" + isSelected + ">${result.ctgryNm}</option>");
            $('#searchCtgryNo').append(option);
            isVal = true;
        }
        </c:forEach>
        if (!isVal) {
            $('#searchCtgryNo').empty();
            $('#searchCtgryNo').append('<option value="">카테고리 없음</option>');
            $('#searchCtgryNo').attr("disabled", true);
        } else {
            $('#searchCtgryNo').attr("disabled", false);
        }
        // 카테고리 변경 시 과목도 초기화 (저장된 카테고리 선택값 유지)
        var currentCtgryNo = $('#searchCtgryNo').val();
        if (currentCtgryNo) {
            $('#searchSubjectNo').data('preservedValue', '<c:out value="${eduAplctVO.searchSubjectNo}"/>');
            ctgryIdChange(currentCtgryNo);
        } else {
            $('#searchSubjectNo').empty();
            $('#searchSubjectNo').append('<option value="">과목 선택</option>');
        }
    }

    // 카테고리 선택 이벤트 - 과목 동적 로딩
    function ctgryIdChange(val) {
        var isVal = false;
        var selectedSubjectNo = $('#searchSubjectNo').data('preservedValue') || '';
        $('#searchSubjectNo').empty();
        $('#searchSubjectNo').append('<option value="">과목 선택</option>');
        <c:forEach var="result" items="${eduSubjectList}">
        if (val == "${result.ctgryNo}") {
            var isSelected = (selectedSubjectNo == "${result.subjectNo}") ? ' selected' : '';
            var option = $("<option value=\"${result.subjectNo}\"" + isSelected + ">${result.subjectNm}</option>");
            $('#searchSubjectNo').append(option);
            isVal = true;
        }
        </c:forEach>
        if (!isVal) {
            $('#searchSubjectNo').empty();
            $('#searchSubjectNo').append('<option value="">과목 없음</option>');
            $('#searchSubjectNo').attr("disabled", true);
        } else {
            $('#searchSubjectNo').attr("disabled", false);
        }
        // preservedValue 초기화
        $('#searchSubjectNo').removeData('preservedValue');
    }

    // 페이지 로딩 시 초기화
    $(document).ready(function () {
        // 검색 기관이 선택되어 있으면 카테고리 리스트 초기화
        <c:if test="${!empty eduAplctVO.searchInsttNo}">
        // 기관 선택값 저장 (카테고리 필터링 후에도 유지)
        $('#searchCtgryNo').data('preservedValue', '<c:out value="${eduAplctVO.searchCtgryNo}"/>');
        insttIdChange('<c:out value="${eduAplctVO.searchInsttNo}"/>');
        </c:if>
        // 검색 카테고리가 선택되어 있으면 과목 리스트 초기화
        <c:if test="${!empty eduAplctVO.searchCtgryNo && empty eduAplctVO.searchInsttNo}">
        // 기관이 선택되지 않은 경우에만 직접 호출 (기관 선택 시에는 insttIdChange에서 호출됨)
        ctgryIdChange('<c:out value="${eduAplctVO.searchCtgryNo}"/>');
        </c:if>

        // 기간조회 타입 변경 이벤트
        $('select[name=searchPeriodType]').on('change', function () {
            if ($(this).val() == '') {
                $('input[name=searchBgnDe]').val('');
                $('input[name=searchEndDe]').val('');
                $('input[name=searchBgnDe]').prop('disabled', true);
                $('input[name=searchEndDe]').prop('disabled', true);
            } else {
                $('input[name=searchBgnDe]').prop('disabled', false);
                $('input[name=searchEndDe]').prop('disabled', false);
            }
        });

        // 페이지 로드 시 초기 상태 설정
        if ($('select[name=searchPeriodType]').val() == '') {
            $('input[name=searchBgnDe]').prop('disabled', true);
            $('input[name=searchEndDe]').prop('disabled', true);
        }
    });

    function fn_delete(url) {
        if (confirm("한 번 삭제한 정보는 복구할 수 없습니다.\n해당 항목을 정말 삭제하시겠습니까?")) {
            window.location = url;
        }
    }

    // 전체선택 체크박스
    $(document).ready(function() {
        $('#checkAll').on('change', function() {
            $('input[name=chk]').prop('checked', $(this).prop('checked'));
        });
    });

    // 전체선택 버튼 (토글 방식)
    function fn_checkAll() {
        var chkAt = $('input[type=checkbox][name=chk]').is(":checked");
        
        if (chkAt) {
            $('input[type=checkbox][name=chk]').prop('checked', false);
            $('#checkAll').prop('checked', false);
        } else {
            $('input[type=checkbox][name=chk]').prop('checked', true);
            $('#checkAll').prop('checked', true);
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
        var url = './updateEduAplctStatus.do?' + (para[1] || 'key=<c:out value="${key}"/>');
        
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
