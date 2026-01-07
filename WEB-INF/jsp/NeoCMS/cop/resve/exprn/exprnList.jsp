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
    <title>${menuInfo.cntntsNm} > 체험 목록</title>
</head>
<body>

<div class="p-wrap">

    <div class="card">
        <form:form modelAttribute="exprnSearchVO" name="exprnSearchVO" method="get" class="p-form-group" cssClass="row" onsubmit="return fn_searchExprnCheck(this)">
            <form:hidden path="key"/>
            <div class="p-form-row">
                <label for="" class="p-form__label col-4 right">운영기관</label>
                <div class="col-3">
                    <form:select path="searchInsttNo" class="p-input">
                        <c:if test="${fn:length(expInsttList) > 1}"><form:option value="0" label="운영기관 선택"/></c:if>
                        <form:options items="${expInsttList}" itemValue="insttNo" itemLabel="insttNm"/>
                    </form:select>
                </div>
                <label for="" class="p-form__label col-2 right">운영년도</label>
                <div class="col-2">
                    <form:select path="searchOperYear" class="p-input">
                        <form:option value="" label="연도 선택"/>
                        <c:set var="year" value="${fn:substring(exprnSearchVO.today,0,4)}"/>
                        <c:forEach var="i" begin="2025" end="${year + 2}">
                            <form:option value="${i}" label="${i}"/>
                        </c:forEach>
                    </form:select>
                </div>
                <label for="" class="p-form__label col-2 right">기간 조회</label>
                <div class="col-2">
                    <form:select path="searchCnd" cssClass="p-input" title="기간 항목 선택">
                        <form:option value="all">기간선택</form:option>
                        <form:option value="RCPT">접수기간</form:option>
                        <form:option value="EXPRN">체험기간</form:option>
                    </form:select>
                </div>
                <div class="col-4">
                    <div class="p-date-group">
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchBgnDeFmt" id="searchBgnDeFmt" value="<c:out value="${exprnSearchVO.searchBgnDeFmt}"/>" class="p-input" placeholder="yyyy-mm-dd"<c:if test="${exprnSearchVO.searchCnd == 'all'}"> disabled</c:if>/>
                            <div class="p-input__split">
                                <button type="button" class="p-input__item  p-date__icon">달력 열기</button>
                            </div>
                        </div>
                        <span class="p-form__split">~</span>
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchEndDeFmt" id="searchEndDeFmt" class="p-input" value="<c:out value="${exprnSearchVO.searchEndDeFmt}"/>" placeholder="yyyy-mm-dd"<c:if test="${exprnSearchVO.searchCnd == 'all'}"> disabled</c:if>/>
                            <div class="p-input__split">
                                <button type="button" class="p-input__item  p-date__icon">달력 열기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="p-form-row">
                <label for="" class="p-form__label col-4 right">운영상태</label>
                <div class="col-3">
                    <form:select path="searchOperSttus" cssClass="p-input" title="운영상태">
                        <form:option value="" label="운영상태 선택"/>
                        <c:forEach var="result" items="${operSttusList}">
                            <form:option value="${result.code}" label="${result.codeNm}"/>
                        </c:forEach>
                    </form:select>
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
                <label for="" class="p-form__label col-2 right">체험명</label>
                <div class="col-6">
                    <form:input path="searchKrwd" class="p-input" placeholder="검색단어 입력"/>
                </div>
                <div class="col-2">
                    <button type="submit" class="p-button p-button--small primary w100p">검색</button>
                </div>
            </div>
        </form:form>
    </div>

    <div class="row">
        <div class="col-6">
            <span class="p-total__number">
                총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong>${paginationInfo.totalRecordCount}</strong></em>건
                &nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]
            </span>
        </div>
    </div>
    <table class="p-table p-table--bordered">
        <caption>체험 목록 - 번호, 년도, 체험명, 운영기관, 접수기간, 체험기간, 선별방법, 운영상태, 표시여부 등 제공</caption>
        <colgroup>
            <col style="width:40px">
            <col style="width:80px">
            <col style="width:50px">
            <col>
            <col style="width:150px">
            <col style="width:130px">
            <col style="width:100px">
            <col style="width:90px">
            <col style="width:90px">
            <col style="width:80px">
            <col style="width:80px">
            <col style="width:70px">
            <col style="width:300px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col"></th>
            <th scope="col">번호</th>
            <th scope="col">운영연도</th>
            <th scope="col">체험명</th>
            <th scope="col">운영기관</th>
            <th scope="col">접수기간</th>
            <th scope="col">체험기간</th>
            <th scope="col">선발방법</th>
            <th scope="col">신청/모집</th>
            <th scope="col">체험료</th>
            <th scope="col">운영상태</th>
            <th scope="col">운영여부</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${exprnList}">
            <tr>
                <td class="p-table__checkbox">
                    <span class="p-form-checkbox p-form-checkbox--single">
                        <input type="checkbox" name="exprnNoArr" id="exprnNo<c:out value="${result.exprnNo}"/>" class="p-form-checkbox__input" value="<c:out value="${result.exprnNo}"/>">
                        <label for="exprnNo<c:out value="${result.exprnNo}"/>" class="p-form-checkbox__label">체험 <c:out value="${result.exprnNo}"/>번 </label>
                    </span>
                </td>
                <td>${currentPageStartNo}</td>
                <td><c:out value="${result.operYear}"/></td>
                <td class="text_left"><a href="./selectExprnView.do?exprnNo=<c:out value="${result.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>"><c:out value="${result.exprnNm}"/></a></td>
                <td>
                    <c:set var="insttNo" value="instt${result.insttNo}"/>
                    <c:out value="${expInsttMap[insttNo]}"/>
                </td>
                <td>
                    <c:out value="${result.rcptBgnDe}"/> <c:out value="${result.rcptBgnHh}"/>:<c:out value="${result.rcptBgnMm}"/>
                    <br/> ~ <br/>
                    <c:out value="${result.rcptEndDe}"/> <c:out value="${result.rcptEndHh}"/>:<c:out value="${result.rcptEndMm}"/>
                </td>
                <td>
                    <c:out value="${tsu:toDateFormat(result.exprnMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    <br/> ~ <br/>
                    <c:out value="${tsu:toDateFormat(result.exprnMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                </td>
                <td>
                    <%-- 선발방식 공통코드 - FIRST : 선착순 / CONFM : 승인 / DRWLT : 추첨 --%>
                    <c:out value="${slctMthdMap[result.slctMthdCd]}"/>
                    <c:if test="${result.slctMthdCd == 'DRWLT'}">
                        <br/>
                        <c:out value="${result.drwtDe}"/>
                        <br/>
                        <c:out value="${tsu:toDateFormat(result.drwtHm, 'HHmm', 'HH:mm')}"/>
                    </c:if>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${result.slctMthdCd == 'CONFM'}">
                            <c:out value="${result.totResveCmplCnt} / ${result.totRcritCnt}"/>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${result.totResveCnt} / ${result.totRcritCnt}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${result.exprnAmt > 0}">
                        <fmt:formatNumber value="${result.exprnAmt}" pattern="#,##0"/> 원
                    </c:if>
                    <c:if test="${result.exprnAmt == 0}">
                        무료
                    </c:if>
                </td>
                <td>
                    <c:out value="${operSttusMap[result.operSttus]}"/>
                </td>
                <td>
                    <span class="p-switcher p-switcher--single">
                        <input id="useYn_<c:out value="${result.exprnNo}"/>" type="checkbox" class="p-switcher__input"<c:if test="${result.useYn eq 'Y'}"> checked</c:if> value="<c:out value="${result.exprnNo}"/>" onchange="fn_useYnChangeSingle(<c:out value="${result.exprnNo}"/>)">
                        <label for="useYn_<c:out value="${result.exprnNo}"/>" class="p-switcher__label"><em class="p-switcher__text blind">운영</em></label>
                    </span>
                </td>
                <td>
                    <a href="./selectExprnApplListByExprn.do?exprnNo=<c:out value="${result.exprnNo}"/>&amp;key=<c:out value="${exprnSearchVO.key}"/>&amp;<c:out value="${exprnSearchVO.exprnParamsMng}"/>" class="p-button p-button--small info">접수관리</a>
                    <a href="./updateExprnSchdView.do?exprnNo=<c:out value="${result.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button p-button--small config">일정관리</a>
                    <a href="./updateExprnView.do?exprnNo=<c:out value="${result.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button p-button--small edit">수정</a>
                    <a href="./deleteExprn.do?exprnNo=<c:out value="${result.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button p-button--small delete" onclick="return fn_delete();">삭제</a>
                </td>
            </tr>
            <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(exprnList) eq 0}">
            <tr>
                <td colspan="13">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="row">
        <div class="col-6 left">
            <button type="button" class="p-button darken" onclick="fn_useYnCheckAll()">전체선택</button>
            <select name="useYnMulti" id="" class="p-input p-input--auto">
                <option value="">운영여부</option>
                <option value="Y">운영</option>
                <option value="N">미운영</option>
            </select>
            <button type="button"  class="p-button edit" onclick="fn_useYnChangeMulti()">변경</button>
        </div>
        <div class="col-12 center">
            <div class="p-pagination">
                <div class="p-page">
                    <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectExprnList.do?${exprnSearchVO.paramsExclPi}${exprnSearchVO.paramsMng}&amp;pageIndex=" />
                </div>
            </div>
        </div>
        <div class="col-6 right">
            <a href="./downloadExprnXls.do" class="p-button p-button--combine excel" onclick="fn_downloadExprnXls(this.href); return false;">엑셀다운로드</a>
            <a href="./addExprnView.do?<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsMng}"/>" class="p-button write">등록</a>
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

    function fn_searchExprnCheck(form) {

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
            }
        }
        return true;
    }

    function fn_useYnCheckAll() {
        var chkAt = $('input[type=checkbox][name=exprnNoArr]').is(":checked");

        if (chkAt) {
            $('input[type=checkbox][name=exprnNoArr]').prop('checked', false);
        } else {
            $('input[type=checkbox][name=exprnNoArr]').prop('checked', true);
        }
    }

    function fn_useYnChangeSingle(exprnNo) {
        var chkAt = $('#useYn_' + exprnNo).is(":checked");
        var exprnNoParam = "exprnNoArr=" + exprnNo;

        if (chkAt) {
            if (confirm("운영여부를 운영으로 변경 하시겠습니까?")) {
                fn_useYnChange(exprnNoParam, "Y");
            } else {
                $('#useYn_'+exprnNo).prop('checked', false);
                return false;
            }

        } else {
            if (confirm("운영여부를 미운영으로 변경 하시겠습니까?")) {
                fn_useYnChange(exprnNoParam, "N");
            } else {
                $('#useYn_'+exprnNo).prop('checked', true);
                return false;
            }
        }
    }

    function fn_useYnChangeMulti() {
        var chkAt = $('input[name=exprnNoArr]').is(":checked");
        var useYn = $('select[name=useYnMulti]').val();
        var exprnNoParam = $('input[name=exprnNoArr]').serialize();

        if (chkAt) {
            if (useYn == "Y") {
                if (confirm("운영여부를 운영으로 변경 하시겠습니까?")) {
                    fn_useYnChange(exprnNoParam, "Y");
                } else {
                    return false;
                }
            } else if (useYn == "N") {
                if (confirm("운영여부를 미운영으로 변경 하시겠습니까?")) {
                    fn_useYnChange(exprnNoParam, "N");
                } else {
                    return false;
                }
            } else {
                alert("운영여부를 선택해주세요.");
                $('select[name=useYnMulti]').focus();
                return false;
            }

        } else {
            alert("체험 번호를 선택해주세요.");
            return false;
        }
    }

    function fn_useYnChange(exprnNoParam, useYnParam) {
        var para = document.location.href.split("?");
        var url = './updateExprnUseYn.do?' + para[1];

        window.location.href = url + '&' + exprnNoParam + "&useYn=" + useYnParam;
    }

    function fn_delete() {
        return confirm("삭제하시겠습니까?");
    }

    function fn_downloadExprnXls(url) {
        const $form = $('#exprnSearchVO');
        var originUrl = $form.attr("action");
        $form.attr("action",url);

        const formScpript = document.getElementById('exprnSearchVO');
        if(!fn_searchExprnCheck(formScpript)) {
            return false;
        }

        $form.submit();
        $form.attr("action",originUrl);
    }
</script>

</body>
</html>
