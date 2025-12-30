<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

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

    <div class="row">
        <div class="col-6">
			<span class="p-total__number">
				총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong>${paginationInfo.totalRecordCount}</strong></em>건
				&nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]
			</span>
        </div>
        <div class="col-18 right">
            <form:form modelAttribute="dscntSearchVO" name="dscntSearchVO" method="get">
                <fieldset>
                    <legend>감면혜택 검색</legend>
                    <form:hidden path="key"/>
                    <form:hidden path="pageUnit"/>
                    <form:hidden path="pageIndex"/>
                    <form:select path="searchInsttNo" cssClass="p-input p-input--auto" title="기관">
                        <c:if test="${fn:length(insttList) > 1}"><form:option value="0" label="기관 선택"/></c:if>
                        <c:forEach var="result" items="${insttList}">
                            <form:option value="${result.insttNo}" label="${result.insttNm}"/>
                        </c:forEach>
                    </form:select>
                    <form:select path="searchDscntCd" cssClass="p-input p-input--auto" title="구분">
                        <form:option value="" label="구분 선택"/>
                        <form:options items="${dscntSeList}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <input value="검색" type="submit" class="p-button p-button--small primary">
                </fieldset>
            </form:form>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption>감면혜택 목록 - 번호, 운영기관명, 감면코드명, 감면혜택조건, 감면율, 자격확인방법, 사용여부 등 제공</caption>
        <colgroup>
            <col style="width:100px">
            <col style="width:200px">
            <col style="width:200px">
            <col>
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:200px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">운영기관</th>
            <th scope="col">감면구분</th>
            <th scope="col">감면혜택조건</th>
            <th scope="col">감면율</th>
            <th scope="col">비대면<br/>사용여부</th>
            <th scope="col">서류직접제출<br/>사용여부</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${dscntList}">
            <tr>
                <td>${currentPageStartNo}</td>
                <td>
                    <c:set var="insttNo" value="instt${result.insttNo}"/>
                    <c:out value="${insttMap[insttNo]}"/>
                </td>
                <td><a href="./selectDscntView.do?dscntNo=<c:out value="${result.dscntNo}"/>&amp;<c:out value="${dscntSearchVO.params}"/>"><c:out value="${dscntSeMap[result.dscntCd]}"/></a></td>
                <td><c:out value="${result.dscntCnd}"/></td>
                <td><c:out value="${result.dscntRate}"/>%</td>
                <td>
                    <span class="p-switcher p-switcher--single">
                        <input id="piscYn_<c:out value="${result.dscntNo}"/>" type="checkbox" class="p-switcher__input"<c:if test="${result.piscYn eq 'Y'}"> checked</c:if> value="<c:out value="${result.dscntNo}"/>" onchange="fn_piscYnCheck(<c:out value="${result.dscntNo}"/>)">
                        <label for="piscYn_<c:out value="${result.dscntNo}"/>" class="p-switcher__label"><em class="p-switcher__text blind">운영</em></label>
                    </span>
                </td>
                <td>
                    <span class="p-switcher p-switcher--single">
                        <input id="directYn_<c:out value="${result.dscntNo}"/>" type="checkbox" class="p-switcher__input"<c:if test="${result.directYn eq 'Y'}"> checked</c:if> value="<c:out value="${result.dscntNo}"/>" onchange="fn_directYnCheck(<c:out value="${result.dscntNo}"/>)">
                        <label for="directYn_<c:out value="${result.dscntNo}"/>" class="p-switcher__label"><em class="p-switcher__text blind">운영</em></label>
                    </span>
                </td>
                <td>
                    <a href="./updateDscntView.do?dscntNo=<c:out value="${result.dscntNo}"/>&amp;<c:out value="${dscntSearchVO.params}"/>" class="p-button p-button--combine edit">수정</a>
                    <a href="./deleteDscnt.do?dscntNo=<c:out value="${result.dscntNo}"/>&amp;<c:out value="${dscntSearchVO.params}"/>" class="p-button p-button--combine delete" onclick="return fn_delete();">삭제</a>
                </td>
            </tr>
            <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(dscntList) eq 0}">
            <tr>
                <td colspan="8">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="p-pagination">
        <div class="p-page">
            <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectInsttList.do?${dscntSearchVO.paramsExclPi}&amp;pageIndex=" />
        </div>
    </div>
    <div class="text_right">
        <a href="./addDscntView.do?<c:out value="${dscntSearchVO.params}"/>" class="p-button p-button--combine write">등록</a>
    </div>
    
</div>

<script>

    function fn_piscYnCheck(dscntNo) {
        var para = document.location.href.split("?");
        var url = './updateDscntPiscYn.do?' + para[1] + '&dscntNo=' + dscntNo;
        var chkAt = $('#piscYn_' + dscntNo).is(":checked");

        if (chkAt) {
            if (confirm("비대면 사용여부를 사용으로 변경 하시겠습니까?")) {
                window.location.href = url + "&piscYn=Y";
            } else {
                $('#piscYn_'+dscntNo).prop('checked', false);
                return false;
            }

        } else {
            if (confirm("비대면 사용여부를 미사용으로 변경 하시겠습니까?")) {
                window.location.href = url + "&piscYn=N";
            } else {
                $('#piscYn_'+dscntNo).prop('checked', true);
                return false;
            }
        }
    }

    function fn_directYnCheck(dscntNo) {
        var para = document.location.href.split("?");
        var url = './updateDscntDirectYn.do?' + para[1] + '&dscntNo=' + dscntNo;
        var chkAt = $('#directYn_' + dscntNo).is(":checked");

        if (chkAt) {
            if (confirm("서류직접제출 사용여부를 사용으로 변경 하시겠습니까?")) {
                window.location.href = url + "&directYn=Y";
            } else {
                $('#directYn_'+dscntNo).prop('checked', false);
                return false;
            }

        } else {
            if (confirm("서류직접제출 사용여부를 미사용으로 변경 하시겠습니까?")) {
                window.location.href = url + "&directYn=N";
            } else {
                $('#directYn_'+dscntNo).prop('checked', true);
                return false;
            }
        }
    }

    function fn_useYnCheck(dscntNo) {
        var para = document.location.href.split("?");
        var url = './updateDscntUseYn.do?' + para[1] + '&dscntNo=' + dscntNo;
        var chkAt = $('#useYn_' + dscntNo).is(":checked");

        if (chkAt) {
            if (confirm("사용여부를 사용으로 변경 하시겠습니까?")) {
                window.location.href = url + "&useYn=Y";
            } else {
                $('#useYn_'+dscntNo).prop('checked', false);
                return false;
            }

        } else {
            if (confirm("사용여부를 미사용으로 변경 하시겠습니까?")) {
                window.location.href = url + "&useYn=N";
            } else {
                $('#useYn_'+dscntNo).prop('checked', true);
                return false;
            }
        }
    }

    function fn_delete() {
        return confirm("삭제하시겠습니까?");
    }

</script>
</body>
</html>
