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
    <title>강좌 관리 목록</title>
</head>
<body>

<div class="p-wrap">
    <div class="card">
        <form id="searchListFrm" method="get" action="/${menuInfo.siteId}/selectEduLctreList.do">
            <input type="hidden" name="key" value="${key}"/>
            <input type="hidden" name="prgSe" value="EDU"/>
            <div class="p-form-row">
                <label for="searchInsttNo" class="p-form__label col-2 right">운영기관</label>
                <div class="col-3">
                    <select id="searchInsttNo" name="searchInsttNo" class="p-input"
                            onchange="insttIdChange(this.value)">
                        <option value="">운영기관 선택</option>
                        <c:choose>
                            <c:when test="${not empty insttMap}">
                                <%-- 기관담당자 또는 강사: 권한 있는 기관만 표시 --%>
                                <c:forEach var="item" items="${insttMap}">
                                    <option value="${item.key}"${item.key eq eduLctreVO.searchInsttNo ? ' selected="true"':''}>
                                        ${item.value}
                                    </option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <%-- 최고관리자: 전체 기관 표시 --%>
                                <c:forEach var="instt" items="${eduInsttList}">
                                    <option value="${instt.insttNo}"${instt.insttNo eq eduLctreVO.searchInsttNo ? ' selected="true"':''}>
                                        <c:out value="${instt.insttNm}"/>
                                    </option>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
                <label for="searchCtgryNo" class="p-form__label col-2 right">카테고리</label>
                <div class="col-3">
                    <select id="searchCtgryNo" name="searchCtgryNo" class="p-input"
                            onchange="ctgryIdChange(this.value)">
                        <option value="">카테고리 선택</option>
                        <%-- 기관 선택 시 카테고리 동적 로딩 --%>
                    </select>
                </div>
                <label for="searchOperYear" class="p-form__label col-2 right">교육년도</label>
                <div class="col-2">
                    <select id="searchOperYear" name="searchOperYear" class="p-input">
                        <option value="">년도 선택</option>
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear"/>
                        <c:forEach var="i" begin="0" end="5">
                            <option value="${currentYear + i}"${eduLctreVO.searchOperYear eq (currentYear + i) ? ' selected="true"':''}>${currentYear + i}</option>
                        </c:forEach>
                    </select>
                </div>
                <label for="searchSubjectNo" class="p-form__label col-1 right">과목</label>
                <div class="col-3">
                    <select id="searchSubjectNo" name="searchSubjectNo" class="p-input">
                        <option value="">과목 선택</option>
                        <%-- 카테고리 선택 시 과목 동적 로딩 --%>
                    </select>
                </div>

                <label for="searchOperSttus" class="p-form__label col-2 right">운영상태</label>
                <div class="col-2">
                    <select id="searchOperSttus" name="searchOperSttus" class="p-input">
                        <option value="">전체</option>
                        <c:forEach var="code" items="${operSttusList}">
                            <option value="${code.code}"${eduLctreVO.searchOperSttus eq code.code ? ' selected="true"':''}>
                                <c:out value="${code.codeNm}"/>
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="p-form-row">


                <label for="searchPeriodType" class="p-form__label col-2 right">기간 조회</label>
                <div class="col-2">
                    <select id="searchPeriodType" name="searchPeriodType" class="p-input" title="기간 항목 선택">
                        <option value="">기간 선택</option>
                        <option value="RCPT"${eduLctreVO.searchPeriodType eq 'RCPT' ? ' selected="true"':''}>접수기간
                        </option>
                        <option value="LCT"${eduLctreVO.searchPeriodType eq 'LCT' ? ' selected="true"':''}>교육기간</option>
                    </select>
                </div>
                <div class="col-4">
                    <div class="p-date-group">
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchBgnDe" id="searchBgnDe"
                                   value="<c:if test='${not empty eduLctreVO.searchBgnDe}'><c:out value='${tsu:toDateFormat(eduLctreVO.searchBgnDe, \"yyyyMMdd\", \"yyyy-MM-dd\")}'/></c:if>"
                                   class="p-input"
                                   placeholder="yyyy-mm-dd" readonly/>
                            <div class="p-input__split">
                                <button type="button" class="p-input__item p-date__icon">달력 열기</button>
                            </div>
                        </div>
                        <span class="p-form__split">~</span>
                        <div class="p-form-group p-date" data-date="datepicker">
                            <input type="text" name="searchEndDe" id="searchEndDe" class="p-input"
                                   value="<c:if test='${not empty eduLctreVO.searchEndDe}'><c:out value='${tsu:toDateFormat(eduLctreVO.searchEndDe, \"yyyyMMdd\", \"yyyy-MM-dd\")}'/></c:if>"
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
                        <option value="50"${empty eduLctreVO.pageUnit or eduLctreVO.pageUnit eq 50 ? ' selected':''}>
                            50개씩
                        </option>
                        <option value="100"${eduLctreVO.pageUnit eq 100 ? ' selected':''}>100개씩</option>
                        <option value="200"${eduLctreVO.pageUnit eq 200 ? ' selected':''}>200개씩</option>
                        <option value="500"${eduLctreVO.pageUnit eq 500 ? ' selected':''}>500개씩</option>
                        <option value="1000"${eduLctreVO.pageUnit eq 1000 ? ' selected':''}>1000개씩</option>
                    </select>
                </div>
                <label for="searchLctreNm" class="p-form__label col-2 right">검색어</label>
                <div class="col-6">
                    <input id="searchLctreNm" name="searchLctreNm" value="${eduLctreVO.searchLctreNm}" class="p-input"
                           placeholder="검색어 입력"/>
                </div>
                <div class="col-2">
                    <button type="submit" class="p-button p-button--small primary w100p">검색</button>
                </div>

            </div>

            <div class="p-form-row">


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
            <col class="w10">
            <col class="w60">
            <col class="w100">
            <col class="w120">
            <col class="w120">
            <col>
            <col class="w120">
            <col class="w120">
            <col class="w150">
            <col class="w180">
            <col class="w140">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">선택</th>
            <th scope="col">번호</th>
            <th scope="col">년도</th>
            <th scope="col">강좌명</th>
            <th scope="col">운영기관</th>
            <th scope="col">카테고리</th>
            <th scope="col">접수기간</th>
            <th scope="col">교육기간</th>
            <th scope="col">신청/정원<br/>(대기)</th>
            <th scope="col">선발방식</th>
            <th scope="col">수강료</th>
            <th scope="col">운영상태</th>
            <th scope="col">표시여부</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="pageNo" value="${paginationInfo.currentPageStartNo}"/>
        <c:forEach var="result" items="${eduLctreList}" varStatus="status">
            <tr class="colored">
                <td class="p-table__checkbox">
					<span class="p-form-checkbox p-form-checkbox--single">
						<input type="checkbox" name="lctreNoArr" id="lctreNo<c:out value="${result.lctreNo}"/>"
                               class="p-form-checkbox__input" value="<c:out value="${result.lctreNo}"/>">
						<label for="lctreNo<c:out value="${result.lctreNo}"/>" class="p-form-checkbox__label">강좌 <c:out
                                value="${result.lctreNo}"/>번 </label>
					</span>
                </td>
                <td><c:out value="${pageNo}"/></td>
                <td><c:out value="${result.operYear}"/></td>
                <td class="text_left"><c:out value="${result.lctreNm}"/></td>
                <td><c:out value="${result.insttNm}"/></td>
                <td><c:out value="${result.ctgryNm}"/></td>
                    <%-- 접수기간 --%>
                <td>
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
                    <%-- 교육기간 --%>
                <td>
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
                <td> <%-- 신청/정원 (대기자) --%>
                    <c:out value="${result.rsvCmplCnt != null ? result.rsvCmplCnt : 0}"/> / <c:out value="${result.onlineCnt}"/><br/>
                    <c:if test="${slctMthdMap[result.slctMthdCd] eq '선착순'}">
                        ( <c:out value="${result.waitLstCnt != null ? result.waitLstCnt : 0}"/> / <c:out value="${result.waitCnt}"/> )
                    </c:if>
                </td>
                <td><c:out value="${slctMthdMap[result.slctMthdCd]}"/></td>
                    <%-- 선발방식 slctMthdMap --%>
                <td> <%-- 수강료 --%>
                    <c:choose>
                        <c:when test="${!empty result.eduAmt and result.eduAmt > 0}">
                            <fmt:formatNumber value="${result.eduAmt}" pattern="#,###"/>
                        </c:when>
                        <c:otherwise>무료</c:otherwise>
                    </c:choose>
                </td>
                <td> <%-- 운영상태 --%>
                    <c:out value="${operSttusMap[result.operSttus]}"/>
                    <%--<c:choose>
                        <c:when test="${not empty result.rcptMthdCd}">
                            <c:set var="rcptMthdCodes" value="${fn:split(result.rcptMthdCd, ',')}"/>
                            <c:forEach var="code" items="${rcptMthdCodes}" varStatus="status">
                                <c:out value="${rcptMthdMap[fn:trim(code)]}"/><c:if test="${!status.last}">, </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>--%>
                </td>

                <td>
                    <span class="p-switcher p-switcher--single">
                        <input type="checkbox" class="p-switcher__input" id="operYn${result.lctreNo}"<c:if test="${result.operYn eq 'Y'}"> checked</c:if> value="${result.lctreNo}" onchange="fn_operYn(this, '${result.lctreNo}', '${result.operYn}')">
                        <label for="operYn${result.lctreNo}" class="p-switcher__label"><em class="p-switcher__text blind">사용</em></label>
                    </span>
                </td>
                <td>
                        <a href="./selectEduAplctListByEdu.do?searchLctreNo=${result.lctreNo}&amp;key=${key}" class="p-button p-button--xsmall edit">접수관리</a>
                    <a href="./updateEduLctreView.do?lctreNo=${result.lctreNo}&amp;<c:out value="${eduLctreVO.params}"/>"
                       class="p-button p-button--xsmall edit">수정</a>
                    <a href="./deleteEduLctre.do?lctreNo=${result.lctreNo}&amp;<c:out value="${eduLctreVO.params}"/>"
                       onclick="fn_delete(this.href); return false;" class="p-button p-button--xsmall delete">삭제</a>
                </td>
            </tr>
            <c:set var="pageNo" value="${pageNo-1}"/>
        </c:forEach>
        <c:if test="${fn:length(eduLctreList) == 0}">
            <tr>
                <td colspan="14" class="empty">등록된 정보가 없습니다</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <div class="row">
        <div class="col-6 left">
            <button type="button" class="p-button darken" onclick="fn_operYnCheckAll()">전체선택</button>
            <select name="operYnMulti" id="operYnMulti" class="p-input p-input--auto">
                <option value="">운영여부</option>
                <option value="Y">운영</option>
                <option value="N">미운영</option>
            </select>
            <button type="button" class="p-button edit" onclick="fn_operYnChangeMulti()">변경</button>
        </div>
        <div class="col-12 center">
            <div class="p-pagination">
                <div class="p-page">
                    <ui:pagination paginationInfo="${paginationInfo}" type="board"
                                   jsFunction="./selectEduLctreList.do?${fn:escapeXml(eduLctreVO.paramsExclPi)}&amp;pageIndex="/>
                </div>
            </div>
        </div>
        <div class="col-6 right">
            <a href="./addEduLctreView.do?<c:out value="${eduLctreVO.params}"/>" class="p-button primary">등록</a>
        </div>
    </div>

</div>

<script nonce="NEOCMSSCRIPT">
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
            $('#searchSubjectNo').data('preservedValue', '<c:out value="${eduLctreVO.searchSubjectNo}"/>');
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
        <c:if test="${!empty eduLctreVO.searchInsttNo}">
        // 기관 선택값 저장 (카테고리 필터링 후에도 유지)
        $('#searchCtgryNo').data('preservedValue', '<c:out value="${eduLctreVO.searchCtgryNo}"/>');
        insttIdChange('<c:out value="${eduLctreVO.searchInsttNo}"/>');
        </c:if>
        // 검색 카테고리가 선택되어 있으면 과목 리스트 초기화 (기관이 선택되지 않은 경우에만)
        <c:if test="${!empty eduLctreVO.searchCtgryNo && empty eduLctreVO.searchInsttNo}">
        // 기관이 선택되지 않은 경우에만 직접 호출 (기관 선택 시에는 insttIdChange에서 호출됨)
        ctgryIdChange('<c:out value="${eduLctreVO.searchCtgryNo}"/>');
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

    // 전체선택 버튼 (토글 방식)
    function fn_operYnCheckAll() {
        var chkAt = $('input[type=checkbox][name=lctreNoArr]').is(":checked");

        if (chkAt) {
            $('input[type=checkbox][name=lctreNoArr]').prop('checked', false);
        } else {
            $('input[type=checkbox][name=lctreNoArr]').prop('checked', true);
        }
    }

    // 운영여부 일괄 변경
    function fn_operYnChangeMulti() {
        var chkAt = $('input[name=lctreNoArr]').is(":checked");
        var operYn = $('select[name=operYnMulti]').val();
        var lctreNoParam = $('input[name=lctreNoArr]:checked').serialize();

        if (chkAt) {
            if (operYn == "Y") {
                if (confirm("운영여부를 운영으로 변경 하시겠습니까?")) {
                    fn_operYnChange(lctreNoParam, "Y");
                } else {
                    return false;
                }
            } else if (operYn == "N") {
                if (confirm("운영여부를 미운영으로 변경 하시겠습니까?")) {
                    fn_operYnChange(lctreNoParam, "N");
                } else {
                    return false;
                }
            } else {
                alert("운영여부를 선택해주세요.");
                $('select[name=operYnMulti]').focus();
                return false;
            }
        } else {
            alert("강좌를 선택해주세요.");
            return false;
        }
    }

    // 운영여부 변경 처리 (일괄 변경용)
    function fn_operYnChange(lctreNoParam, operYnParam) {
        var para = document.location.href.split("?");
        var url = './updateEduLctreOperYn.do?' + para[1];

        window.location.href = url + '&' + lctreNoParam + "&operYn=" + operYnParam;
    }

    // 운영여부 개별 토글
    function fn_operYn(element, lctreNo, currentOperYn) {
        var newOperYn = $(element).prop('checked') ? 'Y' : 'N';
        var confirmMsg = newOperYn === 'Y' ? '운영여부를 운영으로 변경하시겠습니까?' : '운영여부를 미운영으로 변경하시겠습니까?';

        if (!confirm(confirmMsg)) {
            $(element).prop('checked', !$(element).prop('checked'));
            return false;
        }

        var url = './updateEduLctreOperYn.do?' + (document.location.href.split("?")[1] || '') +
                  '&lctreNoArr=' + lctreNo + '&operYn=' + newOperYn;
        window.location.href = url;
    }

    function fn_delete(url) {
        if (confirm("한 번 삭제한 정보는 복구할 수 없습니다.\n해당 항목을 정말 삭제하시겠습니까?")) {
            window.location = url;
        }
    }
</script>
</body>
</html>