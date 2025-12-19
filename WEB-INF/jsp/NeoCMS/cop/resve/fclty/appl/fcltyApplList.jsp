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

    <div class="card">
        <form:form modelAttribute="fcltyApplSearchVO" name="fcltyApplSearchVO" method="get" class="p-form-group" cssClass="row" onsubmit="return fn_searchFcltyApplCheck(this)">
            <form:hidden path="key"/>
            <div class="p-form-row">
                <label for="" class="p-form__label col-4 right">운영기관</label>
                <div class="col-3">
                    <form:select path="searchInsttNo" class="p-input">
                        <form:option value="0" label="운영기관 선택"/>
                        <form:options items="${fctInsttList}" itemValue="insttNo" itemLabel="insttNm"/>
                    </form:select>
                </div>
                <label for="" class="p-form__label col-2 right">예약상태</label>
                <div class="col-3">
                    <form:select path="searchRsvSttus" cssClass="p-input" title="예약상태">
                        <form:option value="" label="예약상태 선택"/>
                        <c:forEach var="result" items="${rsvSttusList}">
                            <form:option value="${result.code}" label="${result.codeNm}"/>
                        </c:forEach>
                    </form:select>
                </div>
                <label for="" class="p-form__label col-2 right">기간 조회</label>
                <div class="col-2">
                    <form:select path="searchCnd" cssClass="p-input" title="기간 항목 선택">
                        <form:option value="all">기간선택</form:option>
                        <form:option value="APPL">신청기간</form:option>
                        <form:option value="FCT">시설기간</form:option>
                    </form:select>
                </div>
                <div class="col-4">
                    <div class="p-date-group">
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchBgnDeFmt" id="searchBgnDeFmt" value="<c:out value="${fcltyApplSearchVO.searchBgnDeFmt}"/>" class="p-input" placeholder="yyyy-mm-dd"<c:if test="${fcltyApplSearchVO.searchCnd == 'all'}"> disabled</c:if>/>
                            <div class="p-input__split">
                                <button type="button" class="p-input__item  p-date__icon">달력 열기</button>
                            </div>
                        </div>
                        <span class="p-form__split">~</span>
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchEndDeFmt" id="searchEndDeFmt" class="p-input" value="<c:out value="${fcltyApplSearchVO.searchEndDeFmt}"/>" placeholder="yyyy-mm-dd"<c:if test="${fcltyApplSearchVO.searchCnd == 'all'}"> disabled</c:if>/>
                            <div class="p-input__split">
                                <button type="button" class="p-input__item  p-date__icon">달력 열기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="p-form-row">
                <label for="" class="p-form__label col-4 right">목록갯수</label>
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
                <label for="" class="p-form__label col-3 right">결제상태</label>
                <div class="col-3">
                    <form:select path="searchPaySttus" cssClass="p-input" title="결제상태">
                        <form:option value="" label="결제상태 선택"/>
                        <c:forEach var="result" items="${paySttusList}">
                            <form:option value="${result.code}" label="${result.codeNm}"/>
                        </c:forEach>
                    </form:select>
                </div>
                <label for="" class="p-form__label col-2 right">검색어</label>
                <div class="col-4">
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
        <caption>시설 신청 목록 - 번호, 예약번호, 신청자, 생년월일, 성별, 연락처, 신청일시, 개인/단체 여부, 인원, 시설일자, 결제상태, 예약상태 등 제공</caption>
        <colgroup>
            <col style="width:20px">
            <col style="width:50px">
            <col style="width:90px">
            <col style="width:60px">
            <col style="width:50px">
            <col style="width:20px">
            <col style="width:70px">
            <col style="width:50px">
            <col style="width:100px">
            <col style="width:30px">
            <col style="width:60px">
            <col style="width:60px">
            <col style="width:60px">
            <col style="width:30px">
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
                        <input type="checkbox" name="fcltyApplNoArr" id="fcltyApplNo<c:out value="${result.fcltyApplNo}"/>" class="p-form-checkbox__input" value="<c:out value="${result.fcltyApplNo}"/>">
                        <label for="fcltyApplNo<c:out value="${result.fcltyApplNo}"/>" class="p-form-checkbox__label">시설 신청 <c:out value="${result.fcltyApplNo}"/>번 </label>
                    </span>
                </td>
                <td>${currentPageStartNo}</td>
                <td>
                    <a href="./selectFcltyApplView.do?fcltyApplNo=<c:out value="${result.fcltyApplNo}"/>&amp;<c:out value="${fcltyApplSearchVO.params}"/><c:out value="${fcltyApplSearchVO.paramsMng}"/><c:out value="${fcltySearchVO.fcltyParamsMng}"/>">
                        <c:out value="${result.fcltyApplId}"/>
                    </a>
                </td>
                <td><c:out value="${result.applNm}"/></td>
                <td><c:out value="${tsu:toDateFormat(result.birthDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/></td>
                <td>
                    <c:if test="${result.genderSe == 'M'}">남</c:if>
                    <c:if test="${result.genderSe == 'W'}">여</c:if>
                </td>
                <td>
                    <c:out value="${result.mobileNo1}"/>-<c:out value="${result.mobileNo2}"/>-<c:out value="${result.mobileNo3}"/>
                </td>
                <td>
                    <c:out value="${tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd')}"/><br/>
                    <c:out value="${fn:substring(tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSSS', 'HH:mm:ss:SSS'),0,11)}"/>
                </td>
                <td>
                    <c:if test="${empty result.grpNm}">개인</c:if>
                    <c:if test="${!empty result.grpNm}"><c:out value="${result.grpNm}"/></c:if>
                </td>
                <td><c:out value="${result.totalCnt}"/></td>
                <td>
                    <c:out value="${tsu:toDateFormat(result.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/><br/>
                    <c:out value="${tsu:toDateFormat(result.fcltyBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(result.fcltyEndHm, 'HHmm', 'HH:mm')}"/>
                </td>
                <td><c:out value="${rsvSttusMap[result.rsvSttusCd]}"/></td>
                <td>
                    <%--TODOSDB: 감면관련 상태값 추가--%>
                    <c:out value="${paySttusMap[result.paySttusCd]}"/>
                    <c:if test="${result.paySttusCd == 'PAY_WAIT'}">
                        <br/><c:out value="${tsu:toDateFormat(result.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd')}"/>
                        <br/><c:out value="${tsu:toDateFormat(result.payDeadlineDt, 'yyyyMMddHHmmss', 'HH:mm:ss')}"/>
                    </c:if>
                </td>
                <td><a href="./updateFcltyApplView.do?fcltyApplNo=<c:out value="${result.fcltyApplNo}"/>&amp;<c:out value="${fcltyApplSearchVO.params}"/><c:out value="${fcltyApplSearchVO.paramsMng}"/><c:out value="${fcltySearchVO.fcltyParamsMng}"/>" class="p-button p-button--small edit" onclick="alert('개발 진행 중입니다.'); return false;">수정</a></td>
            </tr>
            <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(fcltyApplList) eq 0}">
            <tr>
                <td colspan="14">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="row margin_b_30">
        <div class="col-7 left">
            <%--<button type="button" class="p-button darken" onclick="fn_fcltyApplNoCheckAll()">전체선택</button>
            <select name="paySttus" id="" class="p-input p-input--auto">
                <option value="">결제상태</option>
                <c:forEach var="result" items="${paySttusList}">
                    <option value="<c:out value="${result.code}"/>"><c:out value="${result.codeNm}"/></option>
                </c:forEach>
            </select>
            <button type="button"  class="p-button edit" onclick="fn_fcltyApplSttusChange('paySttus')">변경</button>
            <span class="p-form__split-short">/</span>
            <select name="rsvSttus" id="" class="p-input p-input--auto">
                <option value="">예약상태</option>
                <c:forEach var="result" items="${rsvSttusList}">
                    <option value="<c:out value="${result.code}"/>"><c:out value="${result.codeNm}"/></option>
                </c:forEach>
            </select>
            <button type="button"  class="p-button edit" onclick="fn_fcltyApplSttusChange('rsvSttus')">변경</button>--%>
        </div>
        <div class="col-10 center">
            <div class="p-pagination">
                <div class="p-page">
                    <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectFcltyApplList.do?${fcltyApplSearchVO.paramsExclPi}${fcltyApplSearchVO.paramsMng}&amp;pageIndex=" />
                </div>
            </div>
        </div>
        <div class="col-7 right">
            <%--<a href="./downloadFcltyApplXls.do" class="p-button p-button--combine excel" onclick="fn_downloadFcltyApplXls(this.href); return false;">엑셀다운로드</a>
            <a href="./addFcltyApplView.do?<c:out value="${fcltySearchApplVO.params}"/><c:out value="${fcltyApplSearchVO.paramsMng}"/>" class="p-button write">등록</a>--%>
        </div>
    </div>
</div>

<script>

    $(document).ready(function () {
        $('select[name=searchCnd]').on('change', function () {
            if ($(this).val() == 'all') {
                $('input[name=searchBgnDeFmt]').val('');
                $('input[name=searchEndDeFmt]').val('');
                $('input[name=searchBgnDeFmt]').prop('disabled', true);
                $('input[name=searchEndDeFmt]').prop('disabled', true);
            } else {
                $('input[name=searchBgnDeFmt]').prop('disabled', false);
                $('input[name=searchEndDeFmt]').prop('disabled', false);
            }
        });
    });

    function fn_searchFcltyApplCheck(form) {

        if(form.searchCnd.value != 'all') {

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

    function fn_fcltyApplNoCheckAll() {
        var chkAt = $('input[type=checkbox][name=fcltyApplNoArr]').is(":checked");

        if (chkAt) {
            $('input[type=checkbox][name=fcltyApplNoArr]').prop('checked', false);
        } else {
            $('input[type=checkbox][name=fcltyApplNoArr]').prop('checked', true);
        }
    }

    function fn_fcltyApplSttusChange(sttusNm) {
        var chkAt = $('input[name=fcltyApplNoArr]').is(":checked");
        var fcltyApplNoParam = $('input[name=fcltyApplNoArr]').serialize();

        if (chkAt) {
            if (sttusNm == 'paySttus') {
                var paySttus = $('select[name=paySttus]').val();
                if (paySttus == "") {
                    alert("결제상태를 선택해주세요.");
                    $('select[name=paySttus]').focus();
                    return false;
                }
                if (confirm("결제상태를 변경 하시겠습니까?")) {
                    fn_fcltyApplSttusChangeAjax(fcltyApplNoParam, paySttus);
                } else {
                    return false;
                }
            }

            if (sttusNm == 'rsvSttus') {
                var rsvSttus = $('select[name=rsvSttus]').val();
                if (rsvSttus == "") {
                    alert("예약상태를 선택해주세요.");
                    $('select[name=rsvSttus]').focus();
                    return false;
                }
                if (confirm("예약상태를 변경 하시겠습니까?")) {
                    fn_fcltyApplSttusChangeAjax(fcltyApplNoParam, rsvSttus);
                } else {
                    return false;
                }
            }

        } else {
            alert("시설 신청 번호를 선택해주세요.");
            return false;
        }
    }

    function fn_fcltyApplSttusChangeAjax(fcltyApplNoParam, sttusVal) {
        /*var para = document.location.href.split("?");
        var url = './updateFcltyApplSttus.do?' + para[1];

        window.location.href = url + '&' + fcltyApplNoParam + "&useYn=" + sttusVal;*/
    }

    function fn_downloadFcltyApplXls(url) {
        const $form = $('#fcltyApplSearchVO');
        var originUrl = $form.attr("action");
        $form.attr("action",url);

        $form.submit();
        $form.attr("action",originUrl);
    }
</script>

</body>
</html>
