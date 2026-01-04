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
            <form:form modelAttribute="insttSearchVO" name="insttSearchVO" method="get">
                <fieldset>
                    <legend>운영기관 검색</legend>
                    <form:hidden path="key"/>
                    <form:hidden path="pageUnit"/>
                    <form:hidden path="pageIndex"/>
                    <form:select path="searchPrgSe" cssClass="p-input p-input--auto" title="구분 선택">
                        <form:option value="" label="구분 선택"/>
                        <form:options items="${prgSeList}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <form:input path="searchKrwd" class="p-input p-input--auto" placeholder="기관명 입력"/>
                    <input value="검색" type="submit" class="p-button p-button--small primary">
                </fieldset>
            </form:form>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption>운영기관 목록 - 번호, 구분, 운영기관명, 사용여부 등 제공</caption>
        <colgroup>
            <col style="width:100px">
            <col style="width:200px">
            <col>
            <col style="width:120px">
            <col style="width:150px">
            <col style="width:100px">
            <col style="width:100px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">구분</th>
            <th scope="col">운영기관</th>
            <th scope="col">사용여부</th>
            <th scope="col" colspan="3">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${insttList}">
            <tr>
                <td>${currentPageStartNo}</td>
                <td><c:out value="${prgSeMap[result.prgSe]}"/></td>
                <td><a href="./selectInsttView.do?insttNo=<c:out value="${result.insttNo}"/>&amp;<c:out value="${insttSearchVO.params}"/>"><c:out value="${result.insttNm}"/></a></td>
                <td>
                    <span class="p-switcher p-switcher--single">
                        <input id="useYn_<c:out value="${result.insttNo}"/>" type="checkbox" class="p-switcher__input"<c:if test="${result.useYn eq 'Y'}"> checked</c:if> value="<c:out value="${result.insttNo}"/>" onchange="fn_useYnCheck(<c:out value="${result.insttNo}"/>)">
                        <label for="useYn_<c:out value="${result.insttNo}"/>" class="p-switcher__label"><em class="p-switcher__text blind">운영</em></label>
                    </span>
                </td>
                <td><a href="./selectInsttChargerList.do?insttNo=<c:out value="${result.insttNo}"/>&amp;<c:out value="${insttSearchVO.params}"/>" class="p-button p-button--combine config" return false;">담당자관리</a></td>
                <td><a href="./updateInsttView.do?insttNo=<c:out value="${result.insttNo}"/>&amp;<c:out value="${insttSearchVO.params}"/>" class="p-button p-button--combine edit">수정</a></td>
                <td><a href="./deleteInstt.do?insttNo=<c:out value="${result.insttNo}"/>&amp;<c:out value="${insttSearchVO.params}"/>" class="p-button p-button--combine delete" onclick="return fn_delete();">삭제</a></td>
            </tr>
            <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(insttList) eq 0}">
            <tr>
                <td colspan="7">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="p-pagination">
        <div class="p-page">
            <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectInsttList.do?${insttSearchVO.paramsExclPi}&amp;pageIndex=" />
        </div>
    </div>
    <div class="text_right">
        <a href="./addInsttView.do?<c:out value="${insttSearchVO.params}"/>" class="p-button p-button--combine write">등록</a>
    </div>

    </div>

<script>

    function fn_useYnCheck(insttNo) {
        var para = document.location.href.split("?");
        var url = './updateInsttUseYn.do?' + para[1] + '&insttNo=' + insttNo;
        var chkAt = $('#useYn_' + insttNo).is(":checked");

        if (chkAt) {
            if (confirm("운영여부를 운영으로 변경 하시겠습니까?")) {
                window.location.href = url + "&useYn=Y";
            } else {
                $('#useYn_'+insttNo).prop('checked', false);
                return false;
            }

        } else {
            if (confirm("운영여부를 미운영으로 변경 하시겠습니까?")) {
                window.location.href = url + "&useYn=N";
            } else {
                $('#useYn_'+insttNo).prop('checked', true);
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
