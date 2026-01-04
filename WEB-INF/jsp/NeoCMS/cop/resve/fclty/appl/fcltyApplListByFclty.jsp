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

    <div class="card card--line margin_b_30">
        <h3>시설예약 정보</h3>
        <table class="p-table margin_b_20">
            <caption>시설예약 정보 - 제목, 기관명, 접수기간, 시설기간, 내용, 첨부파일 정보 제공</caption>
            <colgroup>
                <col class="w15p" />
                <col />
                <col class="w15p" />
                <col />
            </colgroup>
            <tbody class="p-table--th-left">
            <tr class="p-table__subject">
                <th scope="row">[년도] 시설명</th>
                <td colspan="3">
                    <span class="p-table__subject_text">[<c:out value="${fcltyVO.operYear}"/>] <c:out value="${fcltyVO.fcltyNm}"/></span>
                </td>
            </tr>
            <tr>
                <th scope="row">운영기관</th>
                <td colspan="3">
                    <c:set var="insttNo" value="instt${fcltyVO.insttNo}"/>
                    <c:out value="${fctInsttMap[insttNo]}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">운영상태</th>
                <td><c:out value="${operSttusMap[fcltyVO.operSttus]}"/></td>
                <th scope="row">표시여부</th>
                <td><c:out value="${fcltyVO.useYn eq 'Y' ? '표시' : '숨김'}"/></td>
            </tr>
            <tr>
                <th scope="row">접수기간</th>
                <td><c:out value="${fcltyVO.rcptBgnDe}"/> <c:out value="${fcltyVO.rcptBgnHh}"/>:<c:out value="${fcltyVO.rcptBgnMm}"/>
                     ~
                    <c:out value="${fcltyVO.rcptEndDe}"/> <c:out value="${fcltyVO.rcptEndHh}"/>:<c:out value="${fcltyVO.rcptEndMm}"/>
                </td>
                <th scope="row">시설예약기간</th>
                <td>
                    <c:out value="${tsu:toDateFormat(fcltyVO.fcltyMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    <c:out value="${not empty fcltyVO.fcltyMinBgnDe ? ' ~ ' : ''}" />
                    <c:out value="${tsu:toDateFormat(fcltyVO.fcltyMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">선발방식</th>
                <td><c:out value="${slctMthdMap[fcltyVO.slctMthdCd]}"/></td>
                <th scope="row">시설료 / 결제방식</th>
                <td>
                    <c:choose>
                        <c:when test="${fcltyVO.fcltyAmt > 0}">
                            <fmt:formatNumber value="${tsu:xssNumberFilter(fcltyVO.fcltyAmt)}" pattern="#,###"/> 원
                        </c:when>
                        <c:otherwise>
                            무료
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="result" items="${fcltyVO.payMthdCdArr}" varStatus="status">
                        <c:if test="${status.first}">/</c:if>
                        <c:out value="${payMthdMap[result]}"/>
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
<%--            <col style="width:60px">--%>
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
<%--            <th scope="col">관리</th>--%>
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
                    <a href="./selectFcltyApplView.do?fcltyApplNo=<c:out value="${result.fcltyApplNo}"/>&amp;<c:out value="${fcltyApplSearchVO.params}"/><c:out value="${fcltyApplSearchVO.paramsMng}"/>&amp;<c:out value="${fcltySearchVO.fcltyParamsMng}"/>&amp;isFcltyList=Y">
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
                    <c:out value="${fn:substring(tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSSS', 'HH:mm:ss.SSS'),0,11)}"/>
                </td>
                <td>
                    <c:if test="${empty grpNm}">개인</c:if>
                    <c:if test="${!empty grpNm}"><c:out value="${result.grpNm}"/></c:if>
                </td>
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
<%--                <td><a href="./updateFcltyApplView.do?fcltyApplNo=<c:out value="${result.fcltyApplNo}"/>&amp;<c:out value="${fcltyApplSearchVO.params}"/>&amp;<c:out value="${fcltyApplSearchVO.paramsMng}"/>&amp;<c:out value="${fcltySearchVO.fcltyParamsMng}"/>" class="p-button p-button--small edit" onclick="alert('개발 진행 중입니다.'); return false;">수정</a></td>--%>
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

    <div class="row">
        <div class="col-6 left">
            <a href="./selectFcltyList.do?<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsMng}"/>" class="p-button cancel">시설예약관리 목록</a>
        </div>
        <div class="col-12 center">
            <c:if test="${fn:length(fcltyApplList) ne 0}">
                <div class="p-pagination">
                    <div class="p-page">
                        <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectFcltyApplListByFclty.do?fcltyNo=${fcltyVO.fcltyNo}&amp;${fcltyApplSearchVO.paramsExclPi}${fcltyApplSearchVO.paramsMng}&amp;pageIndex=" />
                    </div>
                </div>
            </c:if>
        </div>
        <div class="col-6 right">
            <%--<a href="./downloadFcltyApplXls.do" class="p-button p-button--combine excel" onclick="fn_downloadFcltyApplXls(this.href); return false;">엑셀다운로드</a>
            <a href="./addFcltyApplView.do?<c:out value="${fcltyApplSearchVO.params}"/><c:out value="${fcltyApplSearchVO.paramsMng}"/>" class="p-button write">등록</a>--%>
        </div>
    </div>
    <div class="row">
        <div class="col-7 left">
            <%--<button type="button" class="p-button darken" onclick="fn_fcltyApplNoCheckAll()">전체선택</button>
            <select name="paySttus" id="" class="p-input p-input--auto">
                <option value="">결제상태</option>
                <c:forEach var="result" items="${paySttusList}">
                    <option value="<c:out value="${result.code}"/>"><c:out value="${result.codeNm}"/></option>
                </c:forEach>
            </select>
            <button type="button"  class="p-button edit" onclick="fn_fcltyApplSttusChange('paySttus')">변경</button>
            <select name="rsvSttus" id="" class="p-input p-input--auto">
                <option value="">예약상태</option>
                <c:forEach var="result" items="${rsvSttusList}">
                    <option value="<c:out value="${result.code}"/>"><c:out value="${result.codeNm}"/></option>
                </c:forEach>
            </select>
            <button type="button"  class="p-button edit" onclick="fn_fcltyApplSttusChange('rsvSttus')">변경</button>--%>
        </div>
    </div>
</div>

<script>

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
